import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import 'sse_frame.dart';

final class RealtimeEventDecoder {
  const RealtimeEventDecoder();

  RealtimeEnvelope decode(SseFrame frame) {
    try {
      final json = jsonDecode(frame.data);
      if (json is! Map<String, dynamic>) throw const FormatException();
      if (frame.data.contains('\n')) throw const FormatException();
      final decoded = standardSerializers.deserializeWith(
        RealtimeEvent.serializer,
        json,
      );
      if (decoded == null) throw const FormatException();
      final payloadEventId = json['event_id']?.toString();
      final payloadEventName = json['event']?.toString();
      if (frame.id != null && frame.id != payloadEventId) {
        throw const FormatException();
      }
      if (frame.event != null && frame.event != payloadEventName) {
        throw const FormatException();
      }
      final eventId = frame.id ?? payloadEventId;
      final eventName = frame.event ?? payloadEventName;
      if (eventId == null || eventName == null) throw const FormatException();
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
