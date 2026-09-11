import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/repositories/hip3_live_repository.dart';

Hip3LiveQuery query([
  String signer = '0x1111111111111111111111111111111111111111',
]) => Hip3LiveQuery(
  signer: signer,
  environment: 'testnet',
  channels: {'hip3:orders'},
);
Hip3LiveSnapshot snapshot(Hip3LiveQuery query) => Hip3LiveSnapshot(
  query: query,
  cursor: 'h3.11111111111111111111111111111111.1',
  completedAt: DateTime.utc(2026),
  emittedAt: DateTime.utc(2026),
  orders: {},
  positions: {},
  prices: {},
  candles: {},
);

final class FakeLiveRepository implements Hip3LiveRepository {
  final streams = <StreamController<Hip3LiveUpdate>>[];
  final queries = <Hip3LiveQuery>[];
  int cancelled = 0;
  @override
  Stream<Hip3LiveUpdate> subscribe(Hip3LiveQuery query) {
    queries.add(query);
    final controller = StreamController<Hip3LiveUpdate>(
      onCancel: () {
        cancelled++;
      },
    );
    streams.add(controller);
    return controller.stream;
  }
}

ProviderContainer container(FakeLiveRepository repo, {bool enabled = true}) {
  final value = ProviderContainer(
    overrides: [
      hip3LiveRepositoryProvider.overrideWithValue(repo),
      hip3LiveEnabledProvider.overrideWithValue(enabled),
    ],
  );
  addTearDown(value.dispose);
  return value;
}

void main() {
  test('disabled configuration performs no subscription', () async {
    final repo = FakeLiveRepository();
    final c = container(repo, enabled: false);
    final p = hip3LiveConnectionProvider((query: query(), generation: 0));
    final sub = c.listen(p, (_, _) {});
    addTearDown(sub.close);
    await pumpEventQueue();
    expect(c.read(p).phase, Hip3LivePhase.disabled);
    expect(repo.queries, isEmpty);
  });

  test(
    'snapshot becomes live; resync clears it and creates a fresh subscription',
    () async {
      final repo = FakeLiveRepository();
      final c = container(repo);
      final q = query();
      final p = hip3LiveConnectionProvider((query: q, generation: 0));
      final sub = c.listen(p, (_, _) {});
      addTearDown(sub.close);
      await pumpEventQueue();
      repo.streams[0].add(snapshot(q));
      await pumpEventQueue();
      expect(c.read(p).phase, Hip3LivePhase.live);
      repo.streams[0].add(const Hip3LiveResync());
      await pumpEventQueue();
      expect(c.read(p).phase, Hip3LivePhase.resyncing);
      expect(c.read(p).snapshot, isNull);
      expect(repo.cancelled, 1);
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(repo.queries, [q, q]);
      repo.streams[1].add(snapshot(q));
      await pumpEventQueue();
      expect(c.read(p).phase, Hip3LivePhase.live);
    },
  );

  test(
    'background and session changes drop live state and reject old-scope reuse',
    () async {
      final repo = FakeLiveRepository();
      final c = container(repo);
      final q = query();
      final p = hip3LiveConnectionProvider((query: q, generation: 0));
      final sub = c.listen(p, (_, _) {});
      addTearDown(sub.close);
      await pumpEventQueue();
      repo.streams[0].add(snapshot(q));
      await pumpEventQueue();
      c.read(hip3ForegroundProvider.notifier).setForeground(false);
      await pumpEventQueue();
      expect(c.read(p).phase, Hip3LivePhase.disabled);
      expect(c.read(p).snapshot, isNull);
      expect(repo.cancelled, 1);
      c.read(hip3ForegroundProvider.notifier).setForeground(true);
      await pumpEventQueue();
      expect(repo.queries, hasLength(2));
      expect(c.read(p).snapshot, isNull);
      c.read(sessionGenerationProvider.notifier).clearUserScope();
      await pumpEventQueue();
      expect(c.read(p).phase, Hip3LivePhase.disabled);
      expect(repo.cancelled, 2);
      expect(repo.queries, hasLength(2));
    },
  );

  test(
    'wrong query and authentication errors clear overlays without a retry loop',
    () async {
      for (final wrongScope in [true, false]) {
        final repo = FakeLiveRepository();
        final c = container(repo);
        final q = query();
        final p = hip3LiveConnectionProvider((query: q, generation: 0));
        final sub = c.listen(p, (_, _) {});
        addTearDown(sub.close);
        await pumpEventQueue();
        repo.streams.single.add(snapshot(q));
        await pumpEventQueue();
        if (wrongScope) {
          repo.streams.single.add(
            snapshot(query('0x2222222222222222222222222222222222222222')),
          );
        } else {
          repo.streams.single.addError(const AuthenticationFailure());
        }
        await pumpEventQueue();
        expect(c.read(p).phase, Hip3LivePhase.fallback);
        expect(c.read(p).snapshot, isNull);
        expect(
          c.read(p).failure,
          wrongScope
              ? isA<CompatibilityFailure>()
              : isA<AuthenticationFailure>(),
        );
        expect(repo.cancelled, 1);
        await Future<void>.delayed(const Duration(milliseconds: 300));
        expect(repo.queries, hasLength(1));
      }
    },
  );

  test(
    'repeated resync is bounded and unobserved providers release connections',
    () async {
      final repo = FakeLiveRepository();
      final c = container(repo);
      final p = hip3LiveConnectionProvider((query: query(), generation: 0));
      final sub = c.listen(p, (_, _) {});
      await pumpEventQueue();
      for (var index = 0; index < 3; index++) {
        repo.streams[index].add(const Hip3LiveResync());
        await pumpEventQueue();
        if (index < 2) {
          await Future<void>.delayed(Duration(milliseconds: 300 * (index + 1)));
        }
      }
      expect(c.read(p).phase, Hip3LivePhase.fallback);
      expect(repo.queries, hasLength(3));
      sub.close();
      await pumpEventQueue();
      expect(repo.cancelled, 3);
    },
  );

  test('first snapshot deadline releases connection and falls back', () async {
    void Function()? deadline;
    await runZoned(
      () async {
        final repo = FakeLiveRepository();
        final c = container(repo);
        final p = hip3LiveConnectionProvider((query: query(), generation: 0));
        final sub = c.listen(p, (_, _) {});
        addTearDown(sub.close);
        await pumpEventQueue();
        expect(deadline, isNotNull);
        deadline!();
        await pumpEventQueue();
        expect(c.read(p).phase, Hip3LivePhase.fallback);
        expect(c.read(p).failure, isA<TimeoutFailure>());
        expect(repo.cancelled, 1);
      },
      zoneSpecification: ZoneSpecification(
        createTimer: (self, parent, zone, duration, callback) {
          if (duration == const Duration(seconds: 45)) deadline = callback;
          return parent.createTimer(zone, duration, callback);
        },
      ),
    );
  });
}
