import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_scope.dart';

/// Read-side refresh only. Never used by previews, signatures or submissions.
final hip3QueryRevisionProvider = NotifierProvider<Hip3QueryRevision, int>(
  Hip3QueryRevision.new,
);

final class Hip3QueryRevision extends Notifier<int> {
  @override
  int build() {
    ref.watch(sessionGenerationProvider);
    return 0;
  }

  void refresh() => state++;
}

final hip3ForegroundProvider = NotifierProvider<Hip3Foreground, bool>(
  Hip3Foreground.new,
);

final class Hip3Foreground extends Notifier<bool> {
  @override
  bool build() => true;
  void setForeground(bool foreground) => state = foreground;
}

/// Schedules the next read after completion, not at a fixed wall-clock cadence.
/// Each watched query owns one timer; an unobserved/paused query owns none.
Future<T> hip3RefreshingQuery<T>(
  Ref ref,
  Future<T> Function() read, {
  Duration interval = const Duration(seconds: 10),
  bool Function(T value)? shouldPoll,
}) async {
  ref.watch(sessionGenerationProvider);
  ref.watch(hip3QueryRevisionProvider);
  Timer? timer;
  var disposed = false;
  var subscribed = true;
  var completed = false;
  var eligible = true;
  var foreground = ref.read(hip3ForegroundProvider);

  void cancel() {
    timer?.cancel();
    timer = null;
  }

  void schedule() {
    cancel();
    if (disposed || !subscribed || !foreground || !completed || !eligible) {
      return;
    }
    timer = Timer(interval, () {
      if (!disposed && subscribed && foreground && ref.mounted) {
        ref.invalidateSelf();
      }
    });
  }

  ref.onDispose(() {
    disposed = true;
    cancel();
  });
  ref.onCancel(() {
    subscribed = false;
    cancel();
  });
  ref.onResume(() {
    subscribed = true;
    schedule();
  });
  ref.listen(hip3ForegroundProvider, (_, next) {
    foreground = next;
    cancel();
    if (next && completed && subscribed && !disposed) {
      ref.invalidateSelf();
    }
  });

  try {
    final value = await read();
    eligible = shouldPoll?.call(value) ?? true;
    return value;
  } finally {
    completed = true;
    schedule();
  }
}
