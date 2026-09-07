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
              entityId:
                  event.data['entity_id']?.toString() ??
                  event.data['order_id']?.toString() ??
                  event.data['position_id']?.toString(),
              sequence: int.tryParse(event.data['sequence']?.toString() ?? ''),
              payload: event.data,
            ),
          );
}
