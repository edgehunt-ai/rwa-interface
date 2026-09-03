import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/sse_parser.dart';

void main() {
  test(
    'parses fragmented CRLF frames, multiline data, and ignores comments',
    () async {
      final chunks = Stream.fromIterable(
        [
          ': heartbeat\r\nid: 1\r\nevent: price\r\ndata: {"a":',
          '1}\r\ndata: second\r\n\r\nid: 2\ndata: {}\n\n',
        ].map((value) => value.codeUnits),
      );
      final frames = await const SseParser().bind(chunks).toList();
      expect(frames, hasLength(2));
      expect(frames.first.id, '1');
      expect(frames.first.event, 'price');
      expect(frames.first.data, '{"a":1}\nsecond');
      expect(frames.last.id, '2');
    },
  );

  test('1,000 个任意分片 frame 保持完整顺序', () async {
    final source = List.generate(
      1000,
      (index) => 'id: $index\nevent: price\ndata: {"event_id":"$index"}\n\n',
    ).join();
    final bytes = utf8.encode(source);
    final chunks = <List<int>>[];
    for (var offset = 0; offset < bytes.length; offset += 7) {
      chunks.add(bytes.sublist(offset, (offset + 7).clamp(0, bytes.length)));
    }
    final frames = await const SseParser()
        .bind(Stream.fromIterable(chunks))
        .toList();
    expect(frames, hasLength(1000));
    expect(frames.map((frame) => frame.id), List.generate(1000, (i) => '$i'));
  });
}
