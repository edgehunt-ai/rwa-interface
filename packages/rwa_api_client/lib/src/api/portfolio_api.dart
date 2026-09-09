//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/portfolio_account_page.dart';
import 'package:rwa_api_client/src/model/portfolio_asset_page.dart';
import 'package:rwa_api_client/src/model/portfolio_holding_page.dart';
import 'package:rwa_api_client/src/model/portfolio_summary.dart';

class PortfolioApi {
  final Dio _dio;

  final Serializers _serializers;

  const PortfolioApi(this._dio, this._serializers);

  /// 资产总览
  /// 已验证身份下的只读资产总览，不接受 wallet address、account ID 或 network 作为资产所有权输入。总资产仅统计已成功估值且去重后的余额；普通钱包余额不会 自动计入可交易金额。  用户没有已验证钱包时返回 &#x60;200 empty&#x60;；部分余额来源或价格失败时返回 &#x60;200 partial&#x60;，使用合格的 PostgreSQL last-good snapshot 时 freshness 为 &#x60;stale&#x60;。只有所有必要 balance source 均不可用且没有合格 last-good 时才 返回 &#x60;503&#x60;。禁止 Mock fallback，也不得把来源错误转换为零余额。
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PortfolioSummary] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PortfolioSummary>> getPortfolioSummary({
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/portfolio/summary';
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

    PortfolioSummary? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(PortfolioSummary),
            ) as PortfolioSummary;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PortfolioSummary>(
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

  /// 内部账本账户余额
  /// 仅返回 &#x60;internal_ledger&#x60; scope 下的三段式内部账户结构：  * &#x60;app&#x60; —— App 可用余额（聚合账户，入金默认到账处）； * &#x60;bstocks&#x60; —— BSC Wallet，bStocks 现货交易账户； * &#x60;hip3&#x60; —— HIP-3 交易账户（Hyperliquid 保证金）。  内部 ledger 可能是外部资产的业务镜像，不能与链上或 venue 余额双计。 ledger 不可用时不得回退到 Mock，也不得把错误转换为零余额。
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PortfolioAccountPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PortfolioAccountPage>> listAccounts({
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/portfolio/accounts';
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

    PortfolioAccountPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(PortfolioAccountPage),
            ) as PortfolioAccountPage;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PortfolioAccountPage>(
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

  /// 按股票分组的持仓
  /// 已验证身份下的只读 Hyperliquid HIP-3 持仓，每支股票一组。position notional 仅用于展示，不再累加进 summary；总资产采用 Hyperliquid account equity。 该接口不接受 wallet address、account ID 或 network 作为资产所有权输入。  用户没有已验证钱包时返回 &#x60;200 empty&#x60;；部分来源失败时返回 &#x60;200 partial&#x60;， 使用合格的 PostgreSQL last-good snapshot 时 freshness 为 &#x60;stale&#x60;。只有所有 必要 balance source 均不可用且没有合格 last-good 时才返回 &#x60;503&#x60;。禁止 Mock fallback，也不得把来源错误转换为零余额。
  ///
  /// Parameters:
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PortfolioHoldingPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PortfolioHoldingPage>> listHoldings({
    String? cursor,
    int? limit = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/portfolio/holdings';
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
      if (cursor != null)
        r'cursor':
            encodeQueryParameter(_serializers, cursor, const FullType(String)),
      if (limit != null)
        r'limit':
            encodeQueryParameter(_serializers, limit, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PortfolioHoldingPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(PortfolioHoldingPage),
            ) as PortfolioHoldingPage;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PortfolioHoldingPage>(
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

  /// 分页列出真实用户资产
  /// 已验证身份下的只读资产列表，聚合 BSC、Arbitrum、Base、Ethereum 四条 allowlisted EVM 网络以及 Hyperliquid Mainnet Info 的余额事实。USDC/USDT 采用 &#x60;fixed_peg&#x3D;1&#x60;，其他资产使用 DODOEX 价格；价格不可用时保留真实余额并 返回未估值状态。  该接口不接受 wallet address、account ID 或 network 作为资产所有权输入。 用户没有已验证钱包时返回 &#x60;200 empty&#x60;；部分来源或价格失败时返回 &#x60;200 partial&#x60;，使用合格的 PostgreSQL last-good snapshot 时 freshness 为 &#x60;stale&#x60;。只有所有必要 balance source 均不可用且没有合格 last-good 时才 返回 &#x60;503&#x60;。禁止 Mock fallback，也不得把来源错误转换为零余额。
  ///
  /// Parameters:
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PortfolioAssetPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PortfolioAssetPage>> listPortfolioAssets({
    String? cursor,
    int? limit = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/portfolio/assets';
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
      if (cursor != null)
        r'cursor':
            encodeQueryParameter(_serializers, cursor, const FullType(String)),
      if (limit != null)
        r'limit':
            encodeQueryParameter(_serializers, limit, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PortfolioAssetPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
              rawResponse,
              specifiedType: const FullType(PortfolioAssetPage),
            ) as PortfolioAssetPage;
    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PortfolioAssetPage>(
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
