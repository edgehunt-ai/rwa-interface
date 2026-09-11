import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hip3_live_provider.dart';
import 'hip3_live_scope.dart';
import 'hip3_query_refresh.dart';

/// Preserve server filtering, membership and cursors: account pushes invalidate
/// the existing read instead of splicing an unpaged snapshot into a REST page.
/// Reads remain bounded and polling continues independently when push is absent.
/// Use only for known HIP3/account queries. Generic order/position details retain
/// their existing kind-gated polling until a typed detail overlay is available.
Future<T> hip3LiveRefreshingQuery<T>(Ref ref, Future<T> Function() read) async {
  Timer? refresh;
  var active = true;
  var disposed = false;
  var completed = false;
  var dirty = false;
  void cancel() {
    refresh?.cancel();
    refresh = null;
  }

  ref.onDispose(() {
    disposed = true;
    cancel();
  });
  ref.onCancel(() {
    active = false;
    cancel();
  });
  ref.onResume(() {
    active = true;
  });
  void schedule() {
    if (!completed ||
        !dirty ||
        !active ||
        disposed ||
        !ref.mounted ||
        !ref.read(hip3ForegroundProvider)) {
      return;
    }
    refresh ??= Timer(const Duration(seconds: 1), () {
      refresh = null;
      if (active &&
          !disposed &&
          ref.mounted &&
          ref.read(hip3ForegroundProvider)) {
        ref.invalidateSelf();
      }
    });
  }

  void listen() => ref.listen(hip3AccountLiveProvider, (previous, next) {
    if (!active || disposed || !ref.mounted) return;
    final before = previous?.snapshot?.cursor;
    final after = next.snapshot?.cursor;
    final changed = after != null && before != after;
    final lostLive =
        previous?.phase == Hip3LivePhase.live &&
        next.phase != Hip3LivePhase.live;
    if (!changed && !lostLive) return;
    dirty = true;
    // Coalesce a burst and never invalidate a still-running REST read.
    schedule();
  });
  listen();
  try {
    return await hip3RefreshingQuery(ref, read);
  } finally {
    completed = true;
    schedule();
  }
}
