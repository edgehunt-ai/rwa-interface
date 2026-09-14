//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/candle_series.dart';
import 'package:rwa_api_client/src/model/chart_range.dart';
import 'package:rwa_api_client/src/model/market_session_info.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/reference_price.dart';

class ChartsApi {

  final Dio _dio;

  final Serializers _serializers;

  const ChartsApi(this._dio, this._serializers);

  /// K 线 / 价格序列
  /// 详情页图表数据。同时返回链上产品价格序列与美股参考价序列 —— 参考价仅在 美股有报价的时段（盘前 / 开盘 / 盘后）存在，其余时段为空洞，前端据此画虚线。 HIP-3 的 points 来自该产品所属 Hyperliquid 网络及 builder DEX 的 candleSnapshot， 不得复用同 symbol 的 bStocks 或其他场所数据。网络由服务端产品配置确定，不由客户端自由改写。 上游不可用或无法确认数据新鲜度时返回错误，不返回样例曲线；成功但没有成交数据时 points 为空。 缺少参考序列时 reference_points 为空，不得用 mark/oracle 伪造美股历史。 HIP-3 请求窗口必须在当前时间以内且少于 5000 个采样间隔；最后一根可能仍在形成。 设计稿按钮 1h/4h/1d/1w 的 &#x60;range&#x60; 请求值分别为 1h/4h/24h/1w；&#x60;1d&#x60; 仅为 前端展示名称，不是接口值。各窗口也可分别传显式 from/to，推荐 interval 为 1m/5m/15m/1h。 range 是预设窗口标识，interval 是单根 K 线粒度；显式窗口的权威边界为响应 from/to，不能仅用 range 推断。 
  ///
  /// Parameters:
  /// * [symbol] - 股票代码
  /// * [kind] 
  /// * [range] - 预设区间；与 `from` / `to` 二选一。设计稿的 1d 按钮传 `24h`；`1d` 不是合法接口值。 `15m` 仅为向后兼容保留，新页面不应使用。 
  /// * [from] 
  /// * [to] 
  /// * [interval] - 采样粒度，缺省由 `range` 推导
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [CandleSeries] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<CandleSeries>> getCandles({ 
    required String symbol,
    required ProductKind kind,
    ChartRange? range,
    DateTime? from,
    DateTime? to,
    String? interval,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/markets/{symbol}/products/{kind}/candles'.replaceAll('{' r'symbol' '}', encodeQueryParameter(_serializers, symbol, const FullType(String)).toString()).replaceAll('{' r'kind' '}', encodeQueryParameter(_serializers, kind, const FullType(ProductKind)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (range != null) r'range': encodeQueryParameter(_serializers, range, const FullType(ChartRange)),
      if (from != null) r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      if (to != null) r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
      if (interval != null) r'interval': encodeQueryParameter(_serializers, interval, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    CandleSeries? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(CandleSeries),
      ) as CandleSeries;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<CandleSeries>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// 美股交易时段
  /// 返回当前时段（盘前 / 开盘 / 盘后 / 隔夜 / 休市）、距下一次切换的倒计时， 以及给定区间内的时段分段（用于图表底部的时段色带与轴标签）。 该时段仅表示美股市场日历，不区分平台上的产品或交易类型，客户端无需传入 kind。 
  ///
  /// Parameters:
  /// * [from] 
  /// * [to] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [MarketSessionInfo] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<MarketSessionInfo>> getMarketSessions({ 
    DateTime? from,
    DateTime? to,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/markets/sessions';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (from != null) r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      if (to != null) r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    MarketSessionInfo? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(MarketSessionInfo),
      ) as MarketSessionInfo;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<MarketSessionInfo>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// 美股参考价
  /// 最近一次美股参考报价及其时段与新鲜度。参考价属于美股标的， 不区分平台上的产品或交易类型，客户端无需传入 kind。 当缺少获准的美股参考数据源时，返回 503 us_equity_market_data， 不能以 HIP3 mark/oracle 或固定价格代替。 
  ///
  /// Parameters:
  /// * [symbol] - 股票代码
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ReferencePrice] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ReferencePrice>> getReferencePrice({ 
    required String symbol,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/markets/{symbol}/reference-price'.replaceAll('{' r'symbol' '}', encodeQueryParameter(_serializers, symbol, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'bearerAuth',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ReferencePrice? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(ReferencePrice),
      ) as ReferencePrice;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ReferencePrice>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
