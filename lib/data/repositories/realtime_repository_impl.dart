import '../../domain/repositories/realtime_repository.dart';
import '../services/realtime_service.dart';

final class RealtimeRepositoryImpl implements RealtimeRepository {
  RealtimeRepositoryImpl(this._service);
  final RealtimeService _service;
  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) =>
      _service
          .subscribe(channels: channels)
          .map(
            (event) => TypedRealtimeEvent(
              id: event.eventId,
              kind: event.eventName,
              entityId: event.entityId,
              // HIP3 replay ordering is an exact stream-wide cursor, not an
              // entity business version; the transport already guards it.
              sequence: event.eventName.startsWith('hip3_')
                  ? null
                  : int.tryParse(
                      event.resourceData['sequence']?.toString() ?? '',
                    ),
              payload: event.data,
            ),
          );
}
