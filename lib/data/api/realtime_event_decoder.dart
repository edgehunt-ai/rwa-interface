import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import 'sse_frame.dart';
import 'realtime_replay_guard.dart';

final class RealtimeEventDecoder {
  const RealtimeEventDecoder();

  RealtimeEnvelope decode(SseFrame frame) {
    try {
      final json = jsonDecode(frame.data);
      if (json is! Map<String, dynamic>) throw const FormatException();
      final decoded = standardSerializers.deserializeWith(
        RealtimeEvent.serializer,
        json,
      );
      if (decoded == null) throw const FormatException();
      final eventId = json['event_id'];
      final eventName = json['event'];
      if (eventId is! String ||
          eventId.isEmpty ||
          eventId.contains(RegExp(r'[\r\n\x00]')) ||
          eventName is! String ||
          (frame.id != null && frame.id != eventId) ||
          (frame.event != null && frame.event != eventName)) {
        throw const FormatException();
      }
      if (eventName.startsWith('hip3_')) Hip3EventCursor.parse(eventId);
      return RealtimeEnvelope(
        eventId: eventId,
        eventName: eventName,
        data: Map.unmodifiable(json),
      );
    } catch (_) {
      throw const CompatibilityFailure();
    }
  }
}
