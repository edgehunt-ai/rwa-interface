import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_live.dart';
import 'api_providers.dart';
import 'hip3_query_refresh.dart';
import 'session_scope.dart';

/// Explicit rollout flag; REST remains available when push is disabled/fails.
final hip3LiveEnabledProvider = Provider<bool>(
  (ref) =>
      const bool.fromEnvironment('HIP3_REALTIME_ENABLED', defaultValue: false),
);
typedef Hip3LiveRequest = ({Hip3LiveQuery query, int generation});

enum Hip3LivePhase { disabled, connecting, live, resyncing, fallback }

final class Hip3LiveConnection {
  const Hip3LiveConnection(this.phase, {this.snapshot, this.failure});
  final Hip3LivePhase phase;
  final Hip3LiveSnapshot? snapshot;
  final ApiFailure? failure;
}

final hip3LiveConnectionProvider = NotifierProvider.autoDispose
    .family<Hip3LiveController, Hip3LiveConnection, Hip3LiveRequest>(
      Hip3LiveController.new,
    );

/// Read-side only. REST stays independently available. A resync creates a new
/// repository subscription (no old cursor); errors clear the live overlay.
final class Hip3LiveController extends Notifier<Hip3LiveConnection> {
  Hip3LiveController(this.request);
  final Hip3LiveRequest request;

  @override
  Hip3LiveConnection build() {
    final generation = ref.watch(sessionGenerationProvider).value;
    final enabled = ref.watch(hip3LiveEnabledProvider);
    final foreground = ref.watch(hip3ForegroundProvider);
    if (!enabled || !foreground || generation != request.generation) {
      return const Hip3LiveConnection(Hip3LivePhase.disabled);
    }
    final repository = ref.watch(hip3LiveRepositoryProvider);
    StreamSubscription<Hip3LiveUpdate>? subscription;
    Timer? timer;
    var disposed = false;
    var observed = true;
    var run = 0;
    var resyncs = 0;
    bool current(int token) =>
        !disposed && observed && ref.mounted && run == token;

    void stop() {
      run++;
      timer?.cancel();
      timer = null;
      final old = subscription;
      subscription = null;
      if (old != null) unawaited(old.cancel());
    }

    void fail(ApiFailure failure) {
      stop();
      if (!disposed && observed && ref.mounted) {
        state = Hip3LiveConnection(Hip3LivePhase.fallback, failure: failure);
      }
    }

    void start() {
      if (disposed || !observed || !ref.mounted) return;
      final token = ++run;
      var receivedSnapshot = false;
      timer = Timer(const Duration(seconds: 45), () {
        if (current(token)) fail(const TimeoutFailure());
      });
      subscription = repository
          .subscribe(request.query)
          .listen(
            (update) {
              if (!current(token)) return;
              switch (update) {
                case Hip3LiveSnapshot():
                  if (update.query != request.query) {
                    fail(const CompatibilityFailure());
                    return;
                  }
                  timer?.cancel();
                  timer = null;
                  // Initial snapshots alone do not prove recovery from a resync
                  // loop. A subsequent incremental state restores that budget.
                  if (receivedSnapshot) resyncs = 0;
                  receivedSnapshot = true;
                  state = Hip3LiveConnection(
                    Hip3LivePhase.live,
                    snapshot: update,
                  );
                case Hip3LiveResync():
                  stop();
                  if (++resyncs > 2) {
                    fail(const CompatibilityFailure());
                    return;
                  }
                  state = const Hip3LiveConnection(Hip3LivePhase.resyncing);
                  timer = Timer(Duration(milliseconds: 250 * resyncs), start);
              }
            },
            onError: (Object error, StackTrace stack) {
              if (current(token)) {
                fail(
                  error is ApiFailure ? error : const CompatibilityFailure(),
                );
              }
            },
            onDone: () {
              if (current(token)) fail(const NetworkFailure());
            },
          );
    }

    ref.onDispose(() {
      disposed = true;
      stop();
    });
    ref.onCancel(() {
      observed = false;
      stop();
    });
    ref.onResume(() {
      if (!disposed) ref.invalidateSelf();
    });
    scheduleMicrotask(start);
    return const Hip3LiveConnection(Hip3LivePhase.connecting);
  }
}
