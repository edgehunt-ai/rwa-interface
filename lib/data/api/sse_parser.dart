import 'dart:convert';

import 'sse_frame.dart';

final class SseParser {
  const SseParser();

  Stream<SseFrame> bind(Stream<List<int>> bytes) async* {
    var buffer = '';
    await for (final chunk in bytes.cast<List<int>>().transform(utf8.decoder)) {
      buffer += chunk.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
      while (buffer.contains('\n\n')) {
        final end = buffer.indexOf('\n\n');
        final raw = buffer.substring(0, end);
        buffer = buffer.substring(end + 2);
        final frame = _parse(raw);
        if (frame != null) yield frame;
      }
    }
    final frame = _parse(buffer);
    if (frame != null) yield frame;
  }

  SseFrame? _parse(String raw) {
    String? id;
    String? event;
    Duration? retry;
    final data = <String>[];
    for (final line in raw.split('\n')) {
      if (line.isEmpty || line.startsWith(':')) continue;
      final colon = line.indexOf(':');
      final field = colon < 0 ? line : line.substring(0, colon);
      var value = colon < 0 ? '' : line.substring(colon + 1);
      if (value.startsWith(' ')) value = value.substring(1);
      switch (field) {
        case 'id':
          id = value;
        case 'event':
          event = value;
        case 'data':
          data.add(value);
        case 'retry':
          final milliseconds = int.tryParse(value);
          if (milliseconds != null && milliseconds >= 0) {
            retry = Duration(milliseconds: milliseconds);
          }
      }
    }
    if (data.isEmpty) return null;
    return SseFrame(id: id, event: event, data: data.join('\n'), retry: retry);
  }
}
