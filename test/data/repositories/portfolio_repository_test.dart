import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/portfolio_repository_impl.dart';
import 'package:rwa_interface/data/services/portfolio_service.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/position.dart';

void main() {
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
    expect(
      accounts.single.balances.single.balance.value,
      '0.123456789012345678',
    );
  });
}

final class _Portfolio implements PortfolioService {
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
