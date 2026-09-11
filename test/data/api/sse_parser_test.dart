import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/sse_parser.dart';

void main() {
  test(
    'frame bounds span chunks and reset after each complete frame',
    () async {
      final parser = SseParser(maxFrameCodeUnits: 16);
      await expectLater(
        parser
            .bind(
              Stream.fromIterable([
                utf8.encode('data: 123456'),
                utf8.encode('78901234567890'),
              ]),
            )
            .toList(),
        throwsFormatException,
      );
      final frames = await parser
          .bind(
            Stream.fromIterable(
              List.generate(1000, (_) => utf8.encode('data: ok\n\n')),
            ),
          )
          .toList();
      expect(frames, hasLength(1000));
    },
  );

  test('bare CR, LF, BOM and empty data frames are preserved', () async {
    final frames = await const SseParser()
        .bind(Stream.value(utf8.encode('\ufeffdata:\r\rdata: second\n\n')))
        .toList();
    expect(frames.map((frame) => frame.data), ['', 'second']);
  });
  test('CRLF split at every byte preserves one multiline HIP3 event', () async {
    final bytes = utf8.encode(
      'id: h3.test.1\r\nevent: hip3_price\r\ndata: 第一行\r\ndata: second\r\n\r\n',
    );
    final frames = await const SseParser()
        .bind(Stream.fromIterable(bytes.map((b) => [b])))
        .toList();
    expect(frames, hasLength(1));
    expect(frames.single.id, 'h3.test.1');
    expect(frames.single.event, 'hip3_price');
    expect(frames.single.data, '第一行\nsecond');
  });

  test('EOF discards a frame not terminated by an empty line', () async {
    for (final suffix in ['', '\n', '\r', '\r\n']) {
      final frames = await const SseParser()
          .bind(
            Stream.value(
              utf8.encode(
                'data: {"completeJsonButIncompleteFrame":true}$suffix',
              ),
            ),
          )
          .toList();
      expect(frames, isEmpty);
    }
  });
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
