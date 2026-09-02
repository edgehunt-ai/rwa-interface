import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for MarketsApi
void main() {
  final instance = RwaApiClient().getMarketsApi();

  group(MarketsApi, () {
    // 加入自选
    //
    // 幂等操作。路径放在产品资源下，避免与产品详情路由产生模板歧义。
    //
    //Future addFavorite(String symbol, ProductKind kind) async
    test('test addFavorite', () async {
      // TODO
    });

    // 资产详情与权益
    //
    // 「资产详情与权益」弹窗的内容。bStocks 说明发行方、1:1 股票支持、公司行动、 股息再投资、投票权；HIP-3 说明合约形态、无股东权益、保证金模式、资金费率方向。 
    //
    //Future<AssetInfo> getAssetInfo(String symbol, ProductKind kind) async
    test('test getAssetInfo', () async {
      // TODO
    });

    // 订单簿深度
    //
    //Future<OrderBook> getOrderBook(String symbol, ProductKind kind, { int depth }) async
    test('test getOrderBook', () async {
      // TODO
    });

    // 产品详情
    //
    // 详情页顶部报价、产品说明、资产权益与行情统计的聚合接口。
    //
    //Future<ProductDetail> getProduct(String symbol, ProductKind kind) async
    test('test getProduct', () async {
      // TODO
    });

    // 24h 行情统计
    //
    // 24h 高 / 低、成交额、成交量、参考价与相对偏离（bStocks 为 Premium，HIP-3 为 Basis）、 价差、买一卖一；HIP-3 额外返回资金费率与未平仓合约量。 
    //
    //Future<MarketStats> getProductStats(String symbol, ProductKind kind) async
    test('test getProductStats', () async {
      // TODO
    });

    // 产品列表 / 分组
    //
    // 首页和市场页的扁平产品列表统一数据源。用 `group` 区分「热门 / 涨幅 / 跌幅 / 成交量 / 自选」；`favorites` 仅返回当前登录用户的自选产品。 `product_type` 对应首页一级筛选（全部 / 现货 / 合约）。每项仍带 `is_favorite`，用于渲染收藏状态。 
    //
    //Future<ListProducts200Response> listProducts({ MarketProductGroup group, ProductType productType, String q, String cursor, int limit }) async
    test('test listProducts', () async {
      // TODO
    });

    // 股票分组列表
    //
    // 市场页「股票」Tab。每支股票包含美股参考价与其支持的产品（bStocks / HIP-3）， 每个产品带自己的链上价格与相对参考价的价差。 
    //
    //Future<ListStocks200Response> listStocks({ String q, String cursor, int limit }) async
    test('test listStocks', () async {
      // TODO
    });

    // 取消自选
    //
    // 幂等操作。
    //
    //Future removeFavorite(String symbol, ProductKind kind) async
    test('test removeFavorite', () async {
      // TODO
    });

    // 覆盖自选列表（用于排序）
    //
    // 仅用于将当前用户已有自选产品整体重新排序。读取自选列表统一使用 `GET /v1/markets/products?group=favorites`。 
    //
    //Future replaceFavorites(ReplaceFavoritesRequest replaceFavoritesRequest) async
    test('test replaceFavorites', () async {
      // TODO
    });

  });
}
