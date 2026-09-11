import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/hip3_live_provider.dart';
import '../../../../app/providers/hip3_live_scope.dart';
import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/market_product.dart';
import 'order_providers.dart';

/// Page-lifetime listener: HTTP refreshes must not recreate the account stream.
/// The ordinary order query remains authoritative and retains polling/retries.
final hip3OrderDetailRefreshProvider = Provider.autoDispose
    .family<void, String>((ref, id) {
      ref.watch(sessionGenerationProvider);
      final query = orderProvider(id);
      Timer? timer;
      void Function()? closeStream;
      var active = true;
      var eligible = false;
      var loading = true;
      var dirty = false;
      void cancel() {
        timer?.cancel();
        timer = null;
      }

      void schedule() {
        if (!active ||
            !eligible ||
            loading ||
            !dirty ||
            !ref.mounted ||
            !ref.read(hip3ForegroundProvider)) {
          return;
        }
        timer ??= Timer(const Duration(seconds: 1), () {
          timer = null;
          if (!active ||
              !eligible ||
              loading ||
              !ref.mounted ||
              !ref.read(hip3ForegroundProvider)) {
            return;
          }
          dirty = false;
          ref.invalidate(query);
        });
      }

      ref.onDispose(() {
        active = false;
        cancel();
      });
      ref.onCancel(() {
        active = false;
        cancel();
      });
      ref.onResume(() {
        active = true;
        schedule();
      });
      ref.listen(hip3ForegroundProvider, (_, foreground) {
        if (!foreground) {
          cancel();
        } else {
          schedule();
        }
      });
      ref.listen(query, (_, next) {
        loading = next.isLoading;
        if (!next.isLoading && !next.hasError && next.hasValue) {
          final order = next.requireValue.resource;
          eligible =
              order.kind == MarketProductKind.perp && order.orderId == id;
          if (!eligible) {
            cancel();
            dirty = false;
            closeStream?.call();
            closeStream = null;
          } else if (closeStream == null) {
            final sub = ref.listen(hip3AccountLiveProvider, (
              previous,
              current,
            ) {
              final cursor = current.snapshot?.cursor;
              final changed =
                  cursor != null && cursor != previous?.snapshot?.cursor;
              final lost =
                  previous?.phase == Hip3LivePhase.live &&
                  current.phase != Hip3LivePhase.live;
              if (changed || lost) {
                dirty = true;
                schedule();
              }
            }, fireImmediately: true);
            closeStream = sub.close;
          }
        }
        schedule();
      }, fireImmediately: true);
    });
