import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/financial_obligation.dart';

final financialObligationsProvider = FutureProvider.autoDispose.family<
    DomainPage<FinancialObligation>, ({String? cursor, bool includeResolved})>(
  (ref, query) {
    ref.watch(sessionGenerationProvider);
    return ref.watch(fundingRepositoryProvider).listFinancialObligations(
      cursor: query.cursor,
      includeResolved: query.includeResolved,
    );
  },
  retry: (_, _) => null,
);
