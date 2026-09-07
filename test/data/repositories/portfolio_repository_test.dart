import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/portfolio_repository_impl.dart';
import 'package:rwa_interface/data/services/portfolio_service.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';

void main() {
  test('maps account kind and preserves token precision', () async {
    final accounts = await PortfolioRepositoryImpl(_Portfolio()).listAccounts();
    expect(accounts.single.kind, TradingAccountKind.hip3);
    expect(accounts.single.balances.single.balance.value, '0.123456789012345678');
  });
}

final class _Portfolio implements PortfolioService {
  @override
  Future<api.ListAccounts200Response> listAccounts() async => api.ListAccounts200Response(
    (response) => response.items.add(api.AccountBalance(
      (account) => account
        ..account = api.AccountKind.hip3
        ..balances.add(api.TokenBalance(
          (balance) => balance
            ..symbol = 'USDC'
            ..balance = '0.123456789012345678',
        )),
    )),
  );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
