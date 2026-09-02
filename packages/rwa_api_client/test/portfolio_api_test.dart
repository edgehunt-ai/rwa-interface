import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for PortfolioApi
void main() {
  final instance = RwaApiClient().getPortfolioApi();

  group(PortfolioApi, () {
    // 资产总览
    //
    // 资产页顶部：总资产、今日盈亏、可用于交易的金额（Available to trade）、 占用保证金（Margin in use）。 
    //
    //Future<PortfolioSummary> getPortfolioSummary() async
    test('test getPortfolioSummary', () async {
      // TODO
    });

    // 各账户余额
    //
    // App 采用三段式账户结构，前端在资金流程中需要分别展示：  * `app` —— App 可用余额（聚合账户，入金默认到账处）； * `bstocks` —— BSC Wallet，bStocks 现货交易账户； * `hip3` —— HIP-3 交易账户（Hyperliquid 保证金）。 
    //
    //Future<ListAccounts200Response> listAccounts() async
    test('test listAccounts', () async {
      // TODO
    });

    // 按股票分组的持仓
    //
    // 资产页 Stocks 区块：每支股票一组，组内列出该股票下的各产品持仓。
    //
    //Future<ListHoldings200Response> listHoldings({ String cursor, int limit }) async
    test('test listHoldings', () async {
      // TODO
    });

  });
}
