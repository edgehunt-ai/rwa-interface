import 'dart:convert';

import 'sse_frame.dart';

final class SseParser {
  const SseParser({this.maxFrameCodeUnits = 12 * 1024 * 1024})
    : assert(maxFrameCodeUnits > 0);

  // Includes room for HIP3's bounded 8 MiB snapshot plus its envelope. This
  // bounds retained decoded text, not the size of a transport-delivered chunk.
  final int maxFrameCodeUnits;

  Stream<SseFrame> bind(Stream<List<int>> bytes) async* {
    final buffer = StringBuffer();
    var frameSize = 0;
    var skipLf = false;
    var lineHasCharacters = false;
    var firstCharacter = true;
    await for (final chunk in bytes.cast<List<int>>().transform(utf8.decoder)) {
      for (final character in chunk.codeUnits) {
        if (firstCharacter) {
          firstCharacter = false;
          if (character == 0xfeff) continue;
        }
        if (skipLf) {
          skipLf = false;
          if (character == 10) continue;
        }
        if (character == 13 || character == 10) {
          skipLf = character == 13;
          if (!lineHasCharacters) {
            final frame = _parse(buffer.toString());
            buffer.clear();
            frameSize = 0;
            if (frame != null) yield frame;
            continue;
          }
          lineHasCharacters = false;
          buffer.write('\n');
        } else {
          lineHasCharacters = true;
          buffer.writeCharCode(character);
        }
        if (++frameSize > maxFrameCodeUnits) {
          throw const FormatException('SSE frame exceeds the supported size');
        }
      }
    }
    // EOF is not an event delimiter. Never advance a cursor for a partial frame.
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
