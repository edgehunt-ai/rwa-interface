import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Keeps an auto-dispose provider cached for [duration] after its last
/// listener is removed.
void cacheAfterLastListener(Ref ref, Duration duration) {
  final link = ref.keepAlive();
  Timer? expiryTimer;
  var disposed = false;

  ref.onCancel(() {
    if (disposed) return;
    expiryTimer?.cancel();
    expiryTimer = Timer(duration, link.close);
  });
  ref.onResume(() {
    if (disposed) return;
    expiryTimer?.cancel();
    expiryTimer = null;
  });
  ref.onDispose(() {
    disposed = true;
    expiryTimer?.cancel();
  });
}

/// Runs [refresh] periodically while the provider is observed and the app is
/// in the foreground.
void refreshWhileActive(
  Ref ref, {
  required Duration interval,
  required void Function() refresh,
}) {
  Timer? timer;
  var observed = true;

  void stop() {
    timer?.cancel();
    timer = null;
  }

  void start() {
    if (!observed || timer != null) return;
    final lifecycleState = WidgetsBinding.instance.lifecycleState;
    if (lifecycleState != null && lifecycleState != AppLifecycleState.resumed) {
      return;
    }
    timer = Timer.periodic(interval, (_) => refresh());
  }

  final observer = _RefreshLifecycleObserver(
    onStateChanged: (state) {
      if (state == AppLifecycleState.resumed) {
        start();
      } else {
        stop();
      }
    },
  );
  WidgetsBinding.instance.addObserver(observer);
  start();

  ref.onCancel(() {
    observed = false;
    stop();
  });
  ref.onResume(() {
    observed = true;
    start();
  });
  ref.onDispose(() {
    stop();
    WidgetsBinding.instance.removeObserver(observer);
  });
}

final class _RefreshLifecycleObserver with WidgetsBindingObserver {
  _RefreshLifecycleObserver({required this.onStateChanged});

  final ValueChanged<AppLifecycleState> onStateChanged;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    onStateChanged(state);
  }
}
