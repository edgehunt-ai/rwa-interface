//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/position.dart';
import 'package:rwa_api_client/src/model/position_page.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';

class PositionsApi {

  final Dio _dio;

  final Serializers _serializers;

  const PositionsApi(this._dio, this._serializers);

  /// 仓位详情
  /// 
  ///
  /// Parameters:
  /// * [positionId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Position] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Position>> getPosition({ 
    required String positionId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/positions/{position_id}'.replaceAll('{' r'position_id' '}', encodeQueryParameter(_serializers, positionId, const FullType(String)).toString());
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

    Position? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Position),
      ) as Position;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Position>(
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

  /// 持仓列表
  /// 当前 HIP3 客户端交易通道读取 Testnet 合约仓位；kind&#x3D;perp，不代表 Mainnet 或全钱包所有轨道。 详情页 symbol 可传完整 product_id（如 frce:US30YFRM），按完整身份在分页前精确过滤； 裸 symbol 保留同名查询，前端已知产品身份时必须传完整 ID，不能与其他环境的公开行情合并。 kind&#x3D;bstock 读取当前 admission 的 BSC 钱包余额，可按 token symbol 或对应 underlying symbol 过滤。 必须有当前完整余额证据，否则503/bstocks_balances_unavailable，不能当作空仓。 total_value_usd 在分页前对整个筛选集合计算；任一正持仓未估值时省略总值，而不是填0。 bStocks 当前只提供本列表查询，不保证 /positions/{position_id} 的 HIP3 详情流程支持该ID。 
  ///
  /// Parameters:
  /// * [symbol] 
  /// * [kind] 
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PositionPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PositionPage>> listPositions({ 
    String? symbol,
    ProductKind? kind,
    String? cursor,
    int? limit = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/positions';
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
      if (symbol != null) r'symbol': encodeQueryParameter(_serializers, symbol, const FullType(String)),
      if (kind != null) r'kind': encodeQueryParameter(_serializers, kind, const FullType(ProductKind)),
      if (cursor != null) r'cursor': encodeQueryParameter(_serializers, cursor, const FullType(String)),
      if (limit != null) r'limit': encodeQueryParameter(_serializers, limit, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PositionPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PositionPage),
      ) as PositionPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PositionPage>(
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
