import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'markets_service.dart';

final class GeneratedMarketsService implements MarketsService {
  GeneratedMarketsService(this._api, {this._mapper = const ApiFailureMapper()});
  final MarketsApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<StockPage> listStocks() async {
    try {
      final response = await _api.listStocks();
      final data = response.data;
      if (data == null) {
        throw _mapper.fromMissingBody(
          response,
          apiOperation: 'markets.list_stocks',
          responseModel: 'StockPage',
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(
        error,
        apiOperation: 'markets.list_stocks',
        responseModel: 'StockPage',
      );
    }
  }

  @override
  Future<BstocksSupportedTokenPage> listBstocksSupportedTokens() => _body(
    () => _api.listBstocksSupportedTokens(),
    apiOperation: 'markets.list_bstocks_supported_tokens',
    responseModel: 'BstocksSupportedTokenPage',
  );

  @override
  Future<ProductPage> listProducts({
    String? query,
    String? cursor,
    String? group,
    ProductType? productType,
  }) => _body(
    () => _api.listProducts(
      group: group == null ? null : MarketProductGroup.valueOf(group),
      productType: productType,
      q: query,
      cursor: cursor,
    ),
    apiOperation: 'markets.list_products',
    responseModel: 'ProductPage',
  );

  @override
  Future<ProductDetail> getProduct(String symbol, ProductKind kind) => _body(
    () => _api.getProduct(symbol: symbol, kind: kind),
    apiOperation: 'markets.get_product',
    responseModel: 'ProductDetail',
  );

  @override
  Future<MarketStats> getProductStats(String symbol, ProductKind kind) => _body(
    () => _api.getProductStats(symbol: symbol, kind: kind),
    apiOperation: 'markets.get_product_stats',
    responseModel: 'MarketStats',
  );

  @override
  Future<OrderBook> getOrderBook(String symbol, ProductKind kind) => _body(
    () => _api.getOrderBook(symbol: symbol, kind: kind),
    apiOperation: 'markets.get_order_book',
    responseModel: 'OrderBook',
  );

  @override
  Future<void> addFavorite(String symbol, ProductKind kind) =>
      _empty(() => _api.addFavorite(symbol: symbol, kind: kind));

  @override
  Future<void> removeFavorite(String symbol, ProductKind kind) =>
      _empty(() => _api.removeFavorite(symbol: symbol, kind: kind));

  @override
  Future<void> replaceFavorites(List<ProductRef> items) => _empty(
    () => _api.replaceFavorites(
      replaceFavoritesRequest: ReplaceFavoritesRequest(
        (builder) => builder.items.replace(items),
      ),
    ),
  );

  Future<T> _body<T>(
    Future<Response<T>> Function() request, {
    required String apiOperation,
    required String responseModel,
  }) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) {
        throw _mapper.fromMissingBody(
          response,
          apiOperation: apiOperation,
          responseModel: responseModel,
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(
        error,
        apiOperation: apiOperation,
        responseModel: responseModel,
      );
    }
  }

  Future<void> _empty(Future<Response<void>> Function() request) async {
    try {
      await request();
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
