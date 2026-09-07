import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/realtime_coordinator.dart';
import 'package:rwa_interface/domain/repositories/realtime_repository.dart';

void main() {
  TypedRealtimeEvent event(int sequence, {String? id}) => TypedRealtimeEvent(
    id: id ?? 'event-$sequence',
    kind: 'order.updated',
    entityId: 'order-1',
    sequence: sequence,
    payload: const {},
  );

  test('deduplicates and rejects entity sequence regression', () {
    final coordinator = RealtimeCoordinator();
    expect(coordinator.accept(event(2)), isTrue);
    expect(coordinator.accept(event(2)), isFalse);
    expect(coordinator.accept(event(1)), isFalse);
  });

  test('buffers during refresh and applies in order', () {
    final coordinator = RealtimeCoordinator(maxBufferedEvents: 4)
      ..beginRefresh();
    for (final sequence in [4, 2, 3, 1]) {
      expect(coordinator.accept(event(sequence)), isFalse);
    }
    expect(coordinator.finishRefresh().map((value) => value.sequence), [
      1,
      2,
      3,
      4,
    ]);
  });

  test(
    'snapshot baseline drops older buffered events and preserves newer ones',
    () {
      final coordinator = RealtimeCoordinator()..beginRefresh(generation: 7);
      coordinator.accept(event(4), generation: 7);
      coordinator.accept(event(6), generation: 7);

      expect(
        coordinator
            .finishRefresh(snapshotSequences: {'order-1': 5})
            .map((value) => value.sequence),
        [6],
      );
      expect(
        coordinator.accept(event(5, id: 'late-5'), generation: 7),
        isFalse,
      );
      expect(coordinator.accept(event(7), generation: 6), isFalse);
    },
  );

  test('overflow and explicit resync stop merging until a new snapshot', () {
    final coordinator = RealtimeCoordinator(maxBufferedEvents: 2)
      ..beginRefresh(generation: 1);
    coordinator.accept(event(1), generation: 1);
    coordinator.accept(event(2), generation: 1);
    coordinator.accept(event(3), generation: 1);
    expect(coordinator.requiresResync, isTrue);
    expect(coordinator.finishRefresh(), isEmpty);
    expect(coordinator.accept(event(4), generation: 1), isFalse);

    coordinator.beginRefresh(generation: 1);
    coordinator.accept(event(4), generation: 1);
    expect(
      coordinator
          .finishRefresh(snapshotSequences: {'order-1': 3})
          .single
          .sequence,
      4,
    );
    expect(coordinator.requiresResync, isFalse);

    expect(
      coordinator.accept(
        const TypedRealtimeEvent(
          id: 'resync',
          kind: 'resync_required',
          entityId: null,
          sequence: null,
          payload: {},
        ),
        generation: 1,
      ),
      isFalse,
    );
    expect(coordinator.requiresResync, isTrue);
  });

  test('changing session generation clears event and terminal baselines', () {
    final coordinator = RealtimeCoordinator()..setGeneration(1);
    expect(coordinator.accept(event(10), generation: 1), isTrue);
    expect(coordinator.accept(event(9), generation: 1), isFalse);

    coordinator.setGeneration(2);
    expect(coordinator.accept(event(1), generation: 1), isFalse);
    expect(coordinator.accept(event(1), generation: 2), isTrue);
  });

  test('applies one thousand unique ordered events once', () {
    final coordinator = RealtimeCoordinator();
    final accepted = [
      for (var i = 1; i <= 1000; i++) coordinator.accept(event(i)),
    ];
    expect(accepted.where((value) => value), hasLength(1000));
    expect(coordinator.accept(event(1000)), isFalse);
  });
}
