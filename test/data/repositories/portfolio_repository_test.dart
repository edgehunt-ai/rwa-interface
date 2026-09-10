import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/portfolio_repository_impl.dart';
import 'package:rwa_interface/data/services/portfolio_service.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/portfolio_read_status.dart';

void main() {
  test(
    'preserves partial and stale asset evidence without inventing completeness',
    () async {
      final repo = PortfolioRepositoryImpl(_Portfolio());
      final summary = await repo.getSummary();
      expect(summary.readStatus.completeness, PortfolioCompleteness.partial);
      expect(summary.readStatus.freshness, PortfolioFreshness.stale);
      expect(summary.readStatus.reliable, isFalse);
      expect(summary.readStatus.warnings, ['usingLastGood']);
      expect(
        () => summary.readStatus.warnings.add('fake'),
        throwsUnsupportedError,
      );
      final holdings = await repo.listHoldings();
      expect(holdings.portfolioStatus?.reliable, isFalse);
      expect(
        holdings.portfolioStatus?.completeness,
        PortfolioCompleteness.partial,
      );
      expect(holdings.portfolioStatus?.freshness, PortfolioFreshness.stale);
    },
  );
  test(
    'preserves HIP3 return and signed funding without deriving missing data',
    () {
      final wire = api.Position(
        (b) => b
          ..positionId = 'p1'
          ..symbol = 'TSLA'
          ..kind = api.ProductKind.perp
          ..quantity = '1'
          ..valueUsd = '100'
          ..unrealizedPnlPercent = '-12.3456'
          ..fundingPaid = '-0.000123',
      );
      final value = mapPosition(wire);
      expect(value.unrealizedPnlPercent?.value, '-12.3456');
      expect(value.fundingPaid?.value, '-0.000123');
      final missing = mapPosition(
        wire.rebuild(
          (b) => b
            ..unrealizedPnlPercent = null
            ..fundingPaid = null
            ..realizedPnl = '7',
        ),
      );
      expect(missing.unrealizedPnlPercent, isNull);
      expect(missing.fundingPaid, isNull);
      expect(missing.unrealizedPnl, isNull);
    },
  );
  test(
    'preserves HIP3 action binding and confirmed protection identifiers',
    () {
      final position = mapPosition(
        api.Position(
          (b) => b
            ..positionId = 'position-1'
            ..productId = 'xyz:TSLA'
            ..positionVersion = 'version-2'
            ..hip3ActionId = 'action-3'
            ..protectionOrderIds.addAll(['tp-1', 'sl-2'])
            ..marginMode = api.MarginMode.cross
            ..symbol = 'TSLA'
            ..kind = api.ProductKind.perp
            ..quantity = '0.099'
            ..valueUsd = '36.357',
        ),
      );
      expect(position.productId, 'xyz:TSLA');
      expect(position.positionVersion, 'version-2');
      expect(position.hip3ActionId, 'action-3');
      expect(position.protectionOrderIds, ['tp-1', 'sl-2']);
      expect(position.marginMode, PositionMarginMode.cross);
      expect(
        () => position.protectionOrderIds.add('fake'),
        throwsUnsupportedError,
      );
    },
  );

  test('does not invent HIP3 metadata for non-HIP3 holdings', () {
    final position = mapPosition(
      api.Position(
        (b) => b
          ..positionId = 'holding-1'
          ..symbol = 'TSLA'
          ..kind = api.ProductKind.bstock
          ..quantity = '1'
          ..valueUsd = '367',
      ),
    );
    expect(position.productId, isNull);
    expect(position.positionVersion, isNull);
    expect(position.hip3ActionId, isNull);
    expect(position.marginMode, isNull);
    expect(position.protectionOrderIds, isEmpty);
  });

  test('maps account kind and preserves token precision', () async {
    final accounts = await PortfolioRepositoryImpl(_Portfolio()).listAccounts();
    expect(accounts.single.kind, TradingAccountKind.hip3);
    expect(accounts.single.internalLedger, isTrue);
    expect(accounts.single.reconciled, isTrue);
    expect(accounts.single.readStatus.reliable, isTrue);
    expect(
      accounts.single.balances.single.balance.value,
      '0.123456789012345678',
    );
  });
}

final class _Portfolio implements PortfolioService {
  @override
  Future<api.PortfolioSummary> getSummary() async => api.PortfolioSummary(
    (b) => b
      ..totalValueUsd = '100'
      ..availableToTradeUsd = '0'
      ..marginInUseUsd = '20'
      ..unvaluedAssetCount = 1
      ..dataStatus = api.PortfolioDataStatus.partial
      ..freshness = api.PortfolioFreshness.stale
      ..calculatedAt = DateTime.utc(2026, 9, 10)
      ..warnings.add(
        api.PortfolioNotice(
          (n) => n
            ..code = api.PortfolioWarningCode.usingLastGood
            ..severity = api.PortfolioNoticeSeverity.warning
            ..message = 'cached',
        ),
      ),
  );

  @override
  Future<api.PortfolioHoldingPage> listHoldings({String? cursor}) async =>
      api.PortfolioHoldingPage(
        (b) => b
          ..totalEquityUsd = '100'
          ..dataStatus = api.PortfolioDataStatus.partial
          ..freshness = api.PortfolioFreshness.stale
          ..calculatedAt = DateTime.utc(2026, 9, 10)
          ..hasMore = false,
      );
  @override
  Future<api.PortfolioAccountPage> listAccounts() async =>
      api.PortfolioAccountPage((response) {
        response
          ..scope = api.PortfolioAccountPageScopeEnum.internalLedger
          ..reconciled = true
          ..freshness = api.PortfolioFreshness.live;
        response.items.add(
          api.AccountBalance(
            (account) => account
              ..account = api.AccountKind.hip3
              ..balances.add(
                api.TokenBalance(
                  (balance) => balance
                    ..symbol = 'USDC'
                    ..balance = '0.123456789012345678',
                ),
              ),
          ),
        );
      });
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
