abstract final class AppRoutes {
  static const homeName = 'home';
  static const homePath = '/';
  static const loginName = 'login';
  static const loginPath = '/login';
  static const detailsName = 'details';
  static const detailsPath = '/details';
  static const marketsName = 'markets';
  static const marketsPath = '/markets';
  static const assetsName = 'assets';
  static const assetsPath = '/assets';
  static const marketSearchName = 'marketSearch';
  static const marketSearchPath = '/markets/search';
  static const depositName = 'deposit';
  static const depositPath = '/funding/deposit';
  static const depositSelectName = 'depositSelect';
  static const depositSelectPath = '/funding/deposit/select';
  static const withdrawalName = 'withdrawal';
  static const withdrawalPath = '/funding/withdraw';
  static const withdrawalSelectName = 'withdrawalSelect';
  static const withdrawalSelectPath = '/funding/withdraw/select';
  static const withdrawalAssetSelectName = 'withdrawalAssetSelect';
  static const withdrawalAssetSelectPath = '/funding/withdraw/spot/select';
  static const transferName = 'transfer';
  static const transferPath = '/funding/transfer';

  static String withdrawalLocation({
    required String token,
    required String chain,
    String source = 'spot',
  }) => Uri(
    path: withdrawalPath,
    queryParameters: {'token': token, 'chain': chain, 'source': source},
  ).toString();

  static String get perpsWithdrawalLocation => Uri(
    path: withdrawalPath,
    queryParameters: const {'source': 'perps'},
  ).toString();
  static const tradeName = 'trade';
  static const tradePath = '/trade';

  /// Builds a deep-linkable trade detail location for a specific product.
  static String tradeLocation({required String symbol, String? kind}) {
    final normalizedSymbol = symbol.trim();
    if (normalizedSymbol.isEmpty) {
      throw ArgumentError.value(symbol, 'symbol', 'must not be empty');
    }
    final parameters = <String, String>{'symbol': normalizedSymbol};
    if (kind != null && kind.isNotEmpty) parameters['kind'] = kind;
    return Uri(path: tradePath, queryParameters: parameters).toString();
  }

  static const settingsName = 'settings';
  static const settingsPath = '/settings';
  static const activityName = 'activity';
  static const activityPath = '/activity';
}
