import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/app/providers/hip3_wallet_history_controller.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/hip3_wallet_history.dart';
import 'package:rwa_interface/domain/repositories/hip3_wallet_history_repository.dart';

final start = DateTime.utc(2026, 9, 1), end = DateTime.utc(2026, 9, 2);
final request = (
  kind: Hip3HistoryKind.funding,
  query: Hip3HistoryQuery(from: start, to: end),
);
Hip3FundingPayment item(String id) => Hip3FundingPayment(
  id: id,
  productId: 'xyz:TSLA',
  amount: DecimalValue('-1'),
  settlementAsset: null,
  collateralToken: null,
  signedPositionSize: DecimalValue('1'),
  fundingRate: DecimalValue('0.01'),
  transactionHash: 'hash',
  occurredAt: start,
);
Hip3HistoryPage<Hip3FundingPayment> page(
  List<String> ids, {
  String snapshot = 'snapshot',
  String? next,
}) => Hip3HistoryPage(
  snapshotId: snapshot,
  environment: 'testnet',
  source: Hip3HistorySource.live,
  observedAt: end,
  items: ids.map(item).toList(),
  hasMore: next != null,
  nextCursor: next,
  coverage: Hip3HistoryCoverage(
    status: Hip3HistoryCoverageStatus.sourceExhausted,
    from: start,
    to: end,
    resumeFrom: null,
    retentionGuaranteed: false,
    coveredRanges: [],
    missingRanges: [],
  ),
  warnings: [],
);

class Repository implements Hip3WalletHistoryRepository {
  final requests =
      <
        ({
          Hip3HistoryQuery query,
          String? cursor,
          Completer<Hip3HistoryPage<Hip3FundingPayment>> result,
        })
      >[];
  @override
  Future<Hip3HistoryPage<Hip3FundingPayment>> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  }) {
    final result = Completer<Hip3HistoryPage<Hip3FundingPayment>>();
    requests.add((query: query, cursor: cursor, result: result));
    return result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late Repository repo;
  late ProviderContainer container;
  final provider = hip3WalletHistoryControllerProvider(request);
  setUp(() {
    repo = Repository();
    container = ProviderContainer(
      overrides: [hip3WalletHistoryRepositoryProvider.overrideWithValue(repo)],
    );
    container.listen(provider, (_, _) {});
  });
  tearDown(() => container.dispose());
  Future<void> first() async {
    repo.requests.first.result.complete(page(['a'], next: 'c1'));
    await container.read(provider.future);
  }

  test('serializes load-more and deduplicates frozen pages', () async {
    await first();
    final pending = container.read(provider.notifier).loadMore();
    await container.read(provider.notifier).loadMore();
    expect(repo.requests.length, 2);
    expect(repo.requests.last.cursor, 'c1');
    expect(repo.requests.last.query, request.query);
    repo.requests.last.result.complete(page(['a', 'b']));
    await pending;
    final state = container.read(provider).requireValue;
    expect(state.items.cast<Hip3FundingPayment>().map((e) => e.id), ['a', 'b']);
    expect(state.page.hasMore, isFalse);
  });
  test(
    'rejects snapshot switch and retries same cursor without losing items',
    () async {
      await first();
      final pending = container.read(provider.notifier).loadMore();
      repo.requests.last.result.complete(page(['bad'], snapshot: 'other'));
      await pending;
      expect(container.read(provider).requireValue.pageError, isNotNull);
      expect(
        container
            .read(provider)
            .requireValue
            .items
            .cast<Hip3FundingPayment>()
            .single
            .id,
        'a',
      );
      final retry = container.read(provider.notifier).loadMore();
      expect(repo.requests.last.cursor, 'c1');
      repo.requests.last.result.complete(page(['b']));
      await retry;
      expect(container.read(provider).requireValue.pageError, isNull);
    },
  );
  test(
    'account change discards pending old page and never reuses its cursor',
    () async {
      await first();
      final pending = container.read(provider.notifier).loadMore();
      final old = repo.requests.last;
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await container.pump();
      expect(repo.requests.last.cursor, isNull);
      repo.requests.last.result.complete(
        page(['new'], snapshot: 'new-account'),
      );
      await container.read(provider.future);
      old.result.complete(page(['old']));
      await pending;
      expect(
        container
            .read(provider)
            .requireValue
            .items
            .cast<Hip3FundingPayment>()
            .map((e) => e.id),
        ['new'],
      );
    },
  );
  test(
    'rejects repeated cursor instead of offering endless pagination',
    () async {
      await first();
      final pending = container.read(provider.notifier).loadMore();
      repo.requests.last.result.complete(page(['b'], next: 'c1'));
      await pending;
      expect(container.read(provider).requireValue.pageError, isNotNull);
      expect(container.read(provider).requireValue.items.length, 1);
    },
  );
}
