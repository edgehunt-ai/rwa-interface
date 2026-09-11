import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/hip3_wallet_history.dart';
import 'api_providers.dart';
import 'session_scope.dart';

typedef Hip3HistoryPageQuery = ({Hip3HistoryQuery query, String? cursor});

/// Frozen pages are not polled. Refresh starts a new query window/snapshot.
final hip3FundingHistoryProvider = FutureProvider.autoDispose
    .family<Hip3HistoryPage<Hip3FundingPayment>, Hip3HistoryPageQuery>((
      ref,
      request,
    ) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(hip3WalletHistoryRepositoryProvider)
          .funding(request.query, cursor: request.cursor);
    });

final hip3LiquidationHistoryProvider = FutureProvider.autoDispose
    .family<Hip3HistoryPage<Hip3LiquidationEvent>, Hip3HistoryPageQuery>((
      ref,
      request,
    ) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(hip3WalletHistoryRepositoryProvider)
          .liquidations(request.query, cursor: request.cursor);
    });
