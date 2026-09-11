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
  static const allStocksName = 'allStocks';
  static const allStocksPath = '/markets/stocks';
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

  static String withdrawalLocation({
    required String token,
    required String chain,
  }) => Uri(
    path: withdrawalPath,
    queryParameters: {'token': token, 'chain': chain},
  ).toString();
  static const tradeName = 'trade';
  static const tradePath = '/trade';

  /// Builds a deep-linkable trade detail location. `kind` is optional so
  /// existing `/trade` links retain the bStocks default.
  static String tradeLocation({String? symbol, String? kind}) {
    if (symbol == null || symbol.isEmpty) return tradePath;
    final parameters = <String, String>{'symbol': symbol};
    if (kind != null && kind.isNotEmpty) parameters['kind'] = kind;
    return Uri(path: tradePath, queryParameters: parameters).toString();
  }

  static const settingsName = 'settings';
  static const settingsPath = '/settings';
  static const activityName = 'activity';
  static const activityPath = '/activity';
}
