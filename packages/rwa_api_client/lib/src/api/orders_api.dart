//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/bstocks_wallet_action_submission.dart';
import 'package:rwa_api_client/src/model/bstocks_wallet_action_submission_request.dart';
import 'package:rwa_api_client/src/model/create_order_request.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_execute_request.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_preparation.dart';
import 'package:rwa_api_client/src/model/hip3_account_abstraction_prepare_request.dart';
import 'package:rwa_api_client/src/model/hip3_action.dart';
import 'package:rwa_api_client/src/model/hip3_action_create_request.dart';
import 'package:rwa_api_client/src/model/hip3_action_page.dart';
import 'package:rwa_api_client/src/model/hip3_action_submission_request.dart';
import 'package:rwa_api_client/src/model/hip3_agent.dart';
import 'package:rwa_api_client/src/model/hip3_challenge.dart';
import 'package:rwa_api_client/src/model/hip3_challenge_complete_request.dart';
import 'package:rwa_api_client/src/model/hip3_challenge_request.dart';
import 'package:rwa_api_client/src/model/hip3_close_preview.dart';
import 'package:rwa_api_client/src/model/hip3_close_preview_request.dart';
import 'package:rwa_api_client/src/model/hip3_funding_payment_page.dart';
import 'package:rwa_api_client/src/model/hip3_liquidation_page.dart';
import 'package:rwa_api_client/src/model/hip3_trading_context.dart';
import 'package:rwa_api_client/src/model/order.dart';
import 'package:rwa_api_client/src/model/order_page.dart';
import 'package:rwa_api_client/src/model/order_preview.dart';
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/trade_intent.dart';
import 'package:rwa_api_client/src/model/trade_intent_create_request.dart';
import 'package:rwa_api_client/src/model/wallet_action_complete_request.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution_create_request.dart';

class OrdersApi {

  final Dio _dio;

  final Serializers _serializers;

  const OrdersApi(this._dio, this._serializers);

  /// 放弃尚未广播的 HIP-3 动作
  /// 只允许在所有步骤均未 claim/广播时原子取消并释放该动作的锁和预留。任一步骤已经提交、成功、结果不明或存在副作用时返回 409。取消动作不等于撤销已存在的 Provider 订单，也不能撤销已经改变的杠杆。 
  ///
  /// Parameters:
  /// * [actionId] - 服务端为冻结 HIP-3 动作生成的稳定标识
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Action] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Action>> cancelHip3Action({ 
    required String actionId,
    required String idempotencyKey,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/actions/{action_id}'.replaceAll('{' r'action_id' '}', encodeQueryParameter(_serializers, actionId, const FullType(String)).toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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

    Hip3Action? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Action),
      ) as Hip3Action;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Action>(
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

  /// 请求取消订单
  /// 
  ///
  /// Parameters:
  /// * [orderId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Order] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Order>> cancelOrder({ 
    required String orderId,
    required String idempotencyKey,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/{order_id}'.replaceAll('{' r'order_id' '}', encodeQueryParameter(_serializers, orderId, const FullType(String)).toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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

    Order? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Order),
      ) as Order;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Order>(
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

  /// 取消尚未提交的条件交易意图
  /// Provider 已接受广播或结果未知后不得取消、重播或切换执行条件。
  ///
  /// Parameters:
  /// * [tradeIntentId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TradeIntent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TradeIntent>> cancelTradeIntent({ 
    required String tradeIntentId,
    required String idempotencyKey,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/trade-intents/{trade_intent_id}'.replaceAll('{' r'trade_intent_id' '}', encodeQueryParameter(_serializers, tradeIntentId, const FullType(String)).toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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

    TradeIntent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(TradeIntent),
      ) as TradeIntent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TradeIntent>(
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

  /// 提交 HIP-3 agent challenge 签名
  /// 
  ///
  /// Parameters:
  /// * [challengeId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3ChallengeCompleteRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Challenge] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Challenge>> completeHip3AgentChallenge({ 
    required String challengeId,
    required String idempotencyKey,
    required Hip3ChallengeCompleteRequest hip3ChallengeCompleteRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/agent/challenges/{challenge_id}/complete'.replaceAll('{' r'challenge_id' '}', encodeQueryParameter(_serializers, challengeId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3ChallengeCompleteRequest);
      _bodyData = _serializers.serialize(hip3ChallengeCompleteRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3Challenge? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Challenge),
      ) as Hip3Challenge;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Challenge>(
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

  /// 提交指定钱包动作的签名结果（兼容窗口）
  /// Deprecated compatibility operation for clients pinned to the legacy contract. The server resolves the exact order action from &#x60;order_id&#x60; and &#x60;step_id&#x60;; capability and execution gates remain authoritative and fail closed. New clients must use the execution resource. 
  ///
  /// Parameters:
  /// * [orderId] 
  /// * [stepId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [walletActionCompleteRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Order] as data
  /// Throws [DioException] if API call or serialization fails
  @Deprecated('This operation has been deprecated')
  Future<Response<Order>> completeOrderWalletAction({ 
    required String orderId,
    required String stepId,
    required String idempotencyKey,
    required WalletActionCompleteRequest walletActionCompleteRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/{order_id}/wallet-actions/{step_id}/complete'.replaceAll('{' r'order_id' '}', encodeQueryParameter(_serializers, orderId, const FullType(String)).toString()).replaceAll('{' r'step_id' '}', encodeQueryParameter(_serializers, stepId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(WalletActionCompleteRequest);
      _bodyData = _serializers.serialize(walletActionCompleteRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Order? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Order),
      ) as Order;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Order>(
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

  /// 准备并持久化 HIP-3 客户端签名动作
  /// 根据服务器拥有的订单、平仓预览或仓位创建动作。此调用本身不广播或改变 Provider 仓位；每个步骤都需前端签名。账户和 signer 从已验证身份推导。操作对象必须属于当前账户及同一 environment/product。并发冲突或已有未决动作占用同一业务对象时返回 409；每个步骤必须持久化防重复广播 claim。前端不得提交 raw action、nonce、cloid 或 Provider 状态。 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3ActionCreateRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Action] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Action>> createHip3Action({ 
    required String idempotencyKey,
    required Hip3ActionCreateRequest hip3ActionCreateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/actions';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3ActionCreateRequest);
      _bodyData = _serializers.serialize(hip3ActionCreateRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3Action? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Action),
      ) as Hip3Action;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Action>(
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

  /// 创建 HIP-3 agent 授权 challenge
  /// 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3ChallengeRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Challenge] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Challenge>> createHip3AgentChallenge({ 
    required String idempotencyKey,
    Hip3ChallengeRequest? hip3ChallengeRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/agent/challenges';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3ChallengeRequest);
      _bodyData = hip3ChallengeRequest == null ? null : _serializers.serialize(hip3ChallengeRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3Challenge? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Challenge),
      ) as Hip3Challenge;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Challenge>(
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

  /// 创建订单
  /// 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [createOrderRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Order] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Order>> createOrder({ 
    required String idempotencyKey,
    required CreateOrderRequest createOrderRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(CreateOrderRequest);
      _bodyData = _serializers.serialize(createOrderRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Order? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Order),
      ) as Order;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Order>(
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

  /// 创建订单钱包动作执行
  /// 服务端按 &#x60;order_id&#x60; 与 &#x60;step_id&#x60; 解析已冻结的 EVM 动作，客户端只能选择 gas 支付模式， 不得提交或覆盖 chain、to、data、value、payload hash 或业务资源绑定。HIP-3 EIP-712 动作不通过本端点执行。当前 bStocks order_id 为 bstocks-action:&lt;action UUID&gt;，step_id 必须为同一个 action UUID，动作必须仍 awaiting_signature 且未过期。支持 approval、IOC、 GTC 下单与取消；代付受 Privy/TEE、执行开关、链开关、gas额度及熔断控制，不承诺默认启用。 mode&#x3D;user_paid_native 仅在已启用回退且原代付明确广播前拒绝后允许，不能用于未知结果重试。 
  ///
  /// Parameters:
  /// * [orderId] 
  /// * [stepId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [walletActionExecutionCreateRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [WalletActionExecution] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<WalletActionExecution>> createOrderWalletActionExecution({ 
    required String orderId,
    required String stepId,
    required String idempotencyKey,
    required WalletActionExecutionCreateRequest walletActionExecutionCreateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/{order_id}/wallet-actions/{step_id}/executions'.replaceAll('{' r'order_id' '}', encodeQueryParameter(_serializers, orderId, const FullType(String)).toString()).replaceAll('{' r'step_id' '}', encodeQueryParameter(_serializers, stepId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(WalletActionExecutionCreateRequest);
      _bodyData = _serializers.serialize(walletActionExecutionCreateRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    WalletActionExecution? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(WalletActionExecution),
      ) as WalletActionExecution;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<WalletActionExecution>(
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

  /// 创建条件交易意图
  /// 从不可变订单 Preview 和一次性订单授权创建内部流程资源。服务端推导账户、master wallet、 Agent、产品、方向、数量、杠杆、保证金模式和资金缺口。客户端只能选择规范来源资产并冻结 IOC 最差成交价格与执行期限。交易意图不会进入 Activity；只有真实源链交易或 Provider 已接受/观察到的订单才会生成用户活动记录。 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [tradeIntentCreateRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TradeIntent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TradeIntent>> createTradeIntent({ 
    required String idempotencyKey,
    required TradeIntentCreateRequest tradeIntentCreateRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/trade-intents';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(TradeIntentCreateRequest);
      _bodyData = _serializers.serialize(tradeIntentCreateRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    TradeIntent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(TradeIntent),
      ) as TradeIntent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TradeIntent>(
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

  /// 执行一次性 Unified Account 切换
  /// 服务端重新绑定 nonce、目标模式和 owner；Agent 或用户签名均由服务端校验后提交，完成后重新读取 Provider 状态。
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3AccountAbstractionExecuteRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3AccountAbstraction] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3AccountAbstraction>> executeHip3AccountAbstraction({ 
    required String idempotencyKey,
    required Hip3AccountAbstractionExecuteRequest hip3AccountAbstractionExecuteRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/account-abstraction/execute';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3AccountAbstractionExecuteRequest);
      _bodyData = _serializers.serialize(hip3AccountAbstractionExecuteRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3AccountAbstraction? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3AccountAbstraction),
      ) as Hip3AccountAbstraction;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3AccountAbstraction>(
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

  /// 获取当前活跃条件交易意图
  /// 返回当前账户唯一的非终态 TradeIntent，用于页面重载、网络重连和客户端崩溃后的恢复。 不创建新意图、不推进资金或订单执行；当前没有活跃意图时返回 404。 
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TradeIntent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TradeIntent>> getCurrentTradeIntent({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/trade-intents/current';
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

    TradeIntent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(TradeIntent),
      ) as TradeIntent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TradeIntent>(
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

  /// 获取当前 HIP-3 账户抽象模式
  /// 返回当前主钱包的 Hyperliquid Mainnet 账户模式；仅在 default 模式允许一次性切换到 Unified Account。
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3AccountAbstraction] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3AccountAbstraction>> getHip3AccountAbstraction({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/account-abstraction';
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

    Hip3AccountAbstraction? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3AccountAbstraction),
      ) as Hip3AccountAbstraction;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3AccountAbstraction>(
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

  /// 查询 HIP-3 动作及下一待签步骤
  /// 恢复相同 action_id，返回服务器权威状态和当前唯一可签步骤。不得通过 GET 推进执行。order 和 position 状态独立于动作状态；例如撤单签名期间原订单仍可能成交。 
  ///
  /// Parameters:
  /// * [actionId] - 服务端为冻结 HIP-3 动作生成的稳定标识
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Action] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Action>> getHip3Action({ 
    required String actionId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/actions/{action_id}'.replaceAll('{' r'action_id' '}', encodeQueryParameter(_serializers, actionId, const FullType(String)).toString());
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

    Hip3Action? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Action),
      ) as Hip3Action;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Action>(
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

  /// 获取当前账户的 HIP-3 Agent Wallet
  /// 返回与当前账户和 master wallet 精确绑定的 Mainnet Agent，不暴露 Privy wallet id 或签名凭据。
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Agent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Agent>> getHip3Agent({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/agent';
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

    Hip3Agent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Agent),
      ) as Hip3Agent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Agent>(
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

  /// HIP-3 产品规则与当前账户交易上下文
  /// 只读查询，不创建 action 或调整账户设置。产品由完整 venue:coin 标识。返回当前环境、有效规则、可用保证金和客户端签名能力；未知或过期数据不得当成零余额或默认支持。 
  ///
  /// Parameters:
  /// * [productId] - 完整 HIP-3 产品标识，包含 DEX 名称，例如 xyz:NVDA；不得只用股票 symbol 推断。
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3TradingContext] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3TradingContext>> getHip3TradingContext({ 
    required String productId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/products/{product_id}/trading-context'.replaceAll('{' r'product_id' '}', encodeQueryParameter(_serializers, productId, const FullType(String)).toString());
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

    Hip3TradingContext? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3TradingContext),
      ) as Hip3TradingContext;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3TradingContext>(
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

  /// 订单详情与权威状态
  /// 
  ///
  /// Parameters:
  /// * [orderId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Order] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Order>> getOrder({ 
    required String orderId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/{order_id}'.replaceAll('{' r'order_id' '}', encodeQueryParameter(_serializers, orderId, const FullType(String)).toString());
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

    Order? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Order),
      ) as Order;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Order>(
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

  /// 获取条件交易意图
  /// 
  ///
  /// Parameters:
  /// * [tradeIntentId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TradeIntent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TradeIntent>> getTradeIntent({ 
    required String tradeIntentId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/trade-intents/{trade_intent_id}'.replaceAll('{' r'trade_intent_id' '}', encodeQueryParameter(_serializers, tradeIntentId, const FullType(String)).toString());
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

    TradeIntent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(TradeIntent),
      ) as TradeIntent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TradeIntent>(
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

  /// 恢复当前账户的 HIP-3 动作
  /// 按 created_at 和 action_id 稳定倒序分页。active 组包括 awaiting_signature、submitting、reconciling、ambiguous、manual_review；所有读取都无执行副作用。筛选由服务端在分页前执行。 
  ///
  /// Parameters:
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit] 
  /// * [statusGroup] 
  /// * [orderId] 
  /// * [positionId] 
  /// * [productId] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3ActionPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3ActionPage>> listHip3Actions({ 
    String? cursor,
    int? limit = 20,
    String? statusGroup = 'active',
    String? orderId,
    String? positionId,
    String? productId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/actions';
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
      if (cursor != null) r'cursor': encodeQueryParameter(_serializers, cursor, const FullType(String)),
      if (limit != null) r'limit': encodeQueryParameter(_serializers, limit, const FullType(int)),
      if (statusGroup != null) r'status_group': encodeQueryParameter(_serializers, statusGroup, const FullType(String)),
      if (orderId != null) r'order_id': encodeQueryParameter(_serializers, orderId, const FullType(String)),
      if (positionId != null) r'position_id': encodeQueryParameter(_serializers, positionId, const FullType(String)),
      if (productId != null) r'product_id': encodeQueryParameter(_serializers, productId, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3ActionPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3ActionPage),
      ) as Hip3ActionPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3ActionPage>(
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

  /// 查询当前交易钱包的 HIP-3 资金费结算事实
  /// 只读，不签名、不广播，也不记入 App 内部资金账本。钱包与环境由服务端从当前认证账户解析，客户端不得指定其他钱包。 from/to 必填、包含边界，最多31天且to不得晚于当前时间。source&#x3D;live（默认）首请求采集官方 userFunding并持久化；source&#x3D;archive只读取已保存事实，冻结数据与覆盖，不访问上游。两者后续cursor均读原快照。 必须保留相同source/from/to/product_id；limit可调整。先按完整product_id精确筛选，再按时间、产品、交易哈希降序分页。 has_more只描述当前快照的分页，不代表上游历史完整。上游分页/时间/容量限制或中途故障会返回部分事实及coverage.resume_from，客户端可从该包含边界重新查询并按id去重。 source_exhausted只表示当前请求窗口已耗尽可见来源，不保证上游长期历史保留。禁止从累计资金费快照推算流水。没有事实返回空items，不制造零金额事件。 
  ///
  /// Parameters:
  /// * [from] 
  /// * [to] 
  /// * [source_] - live采集上游；archive只读已保存归档，不访问上游。归档缺口不代表零流水，超量须缩小窗口。后续cursor必须保持相同source。
  /// * [productId] - 完整venue:coin，不能用仅symbol跨场所匹配。
  /// * [limit] 
  /// * [cursor] - 服务端不透明快照游标，绑定账户、钱包、环境及筛选窗口；不存在或不匹配返回422。
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3FundingPaymentPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3FundingPaymentPage>> listHip3FundingPayments({ 
    required DateTime from,
    required DateTime to,
    String? source_ = 'live',
    String? productId,
    int? limit = 100,
    String? cursor,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/funding-payments';
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
      if (source_ != null) r'source': encodeQueryParameter(_serializers, source_, const FullType(String)),
      r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
      if (productId != null) r'product_id': encodeQueryParameter(_serializers, productId, const FullType(String)),
      if (limit != null) r'limit': encodeQueryParameter(_serializers, limit, const FullType(int)),
      if (cursor != null) r'cursor': encodeQueryParameter(_serializers, cursor, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3FundingPaymentPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3FundingPaymentPage),
      ) as Hip3FundingPaymentPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3FundingPaymentPage>(
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

  /// 查询当前交易钱包的 HIP-3 强平账本事件
  /// 只读，不签名、不广播、不记入 App 内部账本。账户、钱包与环境由服务端从认证身份解析，禁止客户端覆盖。 来源为 userNonFundingLedgerUpdates 中明确的 liquidation 事件，不从强平价、撤单、累计资金费或承接他人强平的成交记录推算。 from/to 包含边界，最多31天且to不得晚于当前时间。source&#x3D;live（默认）采集上游；source&#x3D;archive只读归档并冻结事实与覆盖，不访问上游。后续cursor读取同一快照；必须保留source/from/to/product_id，limit可调整。 仅返回包含至少一个HIP3仓位的事件。product_id按完整venue:coin选择事件，不裁掉该事件中其他HIP3仓位，也不改变事件级account_value范围。 结果按事件时间、交易哈希降序分页。has_more仅指快照分页；coverage描述请求窗口来源覆盖，部分结果可从resume_from包含边界重查并按id去重。 不保证上游永久历史保留。不提供来源未证明的成交价、手续费、已实现损益或结算币；provider_account_value不得当成某产品损失。 
  ///
  /// Parameters:
  /// * [from] 
  /// * [to] 
  /// * [source_] - live采集上游；archive只读已保存归档，不访问上游。后续cursor必须保持相同source；缺口与分页独立。
  /// * [productId] - 精确匹配事件包含的HIP3产品，保留事件整体范围。
  /// * [limit] 
  /// * [cursor] - 服务端不透明快照游标，绑定账户、钱包、环境和筛选窗口；不匹配返回422。
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3LiquidationPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3LiquidationPage>> listHip3Liquidations({ 
    required DateTime from,
    required DateTime to,
    String? source_ = 'live',
    String? productId,
    int? limit = 100,
    String? cursor,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/liquidations';
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
      if (source_ != null) r'source': encodeQueryParameter(_serializers, source_, const FullType(String)),
      r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
      if (productId != null) r'product_id': encodeQueryParameter(_serializers, productId, const FullType(String)),
      if (limit != null) r'limit': encodeQueryParameter(_serializers, limit, const FullType(int)),
      if (cursor != null) r'cursor': encodeQueryParameter(_serializers, cursor, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3LiquidationPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3LiquidationPage),
      ) as Hip3LiquidationPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3LiquidationPage>(
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

  /// 订单列表
  /// 筛选在分页前应用；组合条件取交集。按 created_at、order_id 稳定倒序分页。 open 包括 open/partially_filled 和仍有效的未触发条件单（不含已终结的条件单）；pending 包括待签名、提交中、 ambiguous/manual_review；terminal 为 filled/cancelled/failed。all 返回全部。 HIP3 条件单作为独立 Order 返回，可按 order_id 单独撤销。 当前运行时要求显式 kind；省略返回422/order_kind_required，user_action&#x3D;select_order_kind，不可盲目重试。 kind&#x3D;bstock 查询持久化 action、canonical GTC/IOC 历史。未确认 action ID 为 bstocks-action:&lt;UUID&gt;； 链上订单/成交使用服务端返回的规范 ID，不要自行拼接。 
  ///
  /// Parameters:
  /// * [symbol] 
  /// * [kind] 
  /// * [productId] - HIP3 完整 venue:coin；与 symbol 同传但不匹配时返回 422。
  /// * [statusGroup] 
  /// * [conditionalRole] 
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [OrderPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<OrderPage>> listOrders({ 
    String? symbol,
    ProductKind? kind,
    String? productId,
    String? statusGroup = 'all',
    String? conditionalRole,
    String? cursor,
    int? limit = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders';
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
      if (productId != null) r'product_id': encodeQueryParameter(_serializers, productId, const FullType(String)),
      if (statusGroup != null) r'status_group': encodeQueryParameter(_serializers, statusGroup, const FullType(String)),
      if (conditionalRole != null) r'conditional_role': encodeQueryParameter(_serializers, conditionalRole, const FullType(String)),
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

    OrderPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(OrderPage),
      ) as OrderPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<OrderPage>(
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

  /// 准备一次性切换到 Unified Account
  /// 仅接受服务端固定的 unifiedAccount 目标。若当前有可用 HIP-3 Agent，返回 agent 执行方式； 否则返回精确的 userSetAbstraction EIP-712 payload，客户端只能对该 payload 签名。 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3AccountAbstractionPrepareRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3AccountAbstractionPreparation] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3AccountAbstractionPreparation>> prepareHip3AccountAbstraction({ 
    required String idempotencyKey,
    required Hip3AccountAbstractionPrepareRequest hip3AccountAbstractionPrepareRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/account-abstraction/prepare';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3AccountAbstractionPrepareRequest);
      _bodyData = _serializers.serialize(hip3AccountAbstractionPrepareRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3AccountAbstractionPreparation? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3AccountAbstractionPreparation),
      ) as Hip3AccountAbstractionPreparation;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3AccountAbstractionPreparation>(
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

  /// 预览 HIP-3 全部或部分平仓
  /// 从当前账户的权威仓位计算平仓方向、最大可平数量、费用与预计已实现盈亏，冻结 position version 和规范化执行条件。数量和百分比互斥；均不传表示全部平仓。预览不保证成交价格或一定成交；确认时必须重新校验仓位和风险。只生成预览，不广播。 
  ///
  /// Parameters:
  /// * [positionId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3ClosePreviewRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3ClosePreview] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3ClosePreview>> previewHip3ClosePosition({ 
    required String positionId,
    required String idempotencyKey,
    required Hip3ClosePreviewRequest hip3ClosePreviewRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/positions/{position_id}/close/preview'.replaceAll('{' r'position_id' '}', encodeQueryParameter(_serializers, positionId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3ClosePreviewRequest);
      _bodyData = _serializers.serialize(hip3ClosePreviewRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3ClosePreview? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3ClosePreview),
      ) as Hip3ClosePreview;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3ClosePreview>(
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

  /// 预览 bStocks 或 HIP-3 订单
  /// 
  ///
  /// Parameters:
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [orderPreviewRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [OrderPreview] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<OrderPreview>> previewOrder({ 
    required String idempotencyKey,
    required OrderPreviewRequest orderPreviewRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/preview';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(OrderPreviewRequest);
      _bodyData = _serializers.serialize(orderPreviewRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    OrderPreview? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(OrderPreview),
      ) as OrderPreview;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<OrderPreview>(
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

  /// Record a submitted bStocks Router transaction
  /// Accepts only the user wallet&#39;s transaction hash for the exact durable Router action. The server never accepts replacement calldata, target, value, receipt, block, or success claims; canonical confirmation and reorg handling are performed by the Router observer. 
  ///
  /// Parameters:
  /// * [orderId] 
  /// * [stepId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [bstocksWalletActionSubmissionRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BstocksWalletActionSubmission] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BstocksWalletActionSubmission>> submitBstocksWalletAction({ 
    required String orderId,
    required String stepId,
    required String idempotencyKey,
    required BstocksWalletActionSubmissionRequest bstocksWalletActionSubmissionRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/orders/{order_id}/wallet-actions/{step_id}/submissions'.replaceAll('{' r'order_id' '}', encodeQueryParameter(_serializers, orderId, const FullType(String)).toString()).replaceAll('{' r'step_id' '}', encodeQueryParameter(_serializers, stepId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(BstocksWalletActionSubmissionRequest);
      _bodyData = _serializers.serialize(bstocksWalletActionSubmissionRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BstocksWalletActionSubmission? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(BstocksWalletActionSubmission),
      ) as BstocksWalletActionSubmission;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BstocksWalletActionSubmission>(
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

  /// 提交当前 HIP-3 步骤签名并由后端广播
  /// 仅接收 signature。服务端恢复冻结 action/nonce/environment，校验 step 归属、expected signer、签名摘要、有效期、前置步骤及业务状态，然后通过 CAS 持久化 submitting 后广播。相同 key/相同签名返回已有动作；相同 key/不同内容返回 409。超时、5xx、进程崩溃进入 ambiguous 并独立对账；禁止自动重播或给该步骤换 nonce 重试。只有确认上一动作成功后才释放下一待签步骤。 
  ///
  /// Parameters:
  /// * [actionId] - 服务端为冻结 HIP-3 动作生成的稳定标识
  /// * [stepId] 
  /// * [idempotencyKey] - Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
  /// * [hip3ActionSubmissionRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Hip3Action] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Hip3Action>> submitHip3ActionStep({ 
    required String actionId,
    required String stepId,
    required String idempotencyKey,
    required Hip3ActionSubmissionRequest hip3ActionSubmissionRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/hip3/actions/{action_id}/steps/{step_id}/submissions'.replaceAll('{' r'action_id' '}', encodeQueryParameter(_serializers, actionId, const FullType(String)).toString()).replaceAll('{' r'step_id' '}', encodeQueryParameter(_serializers, stepId, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        r'Idempotency-Key': idempotencyKey,
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
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(Hip3ActionSubmissionRequest);
      _bodyData = _serializers.serialize(hip3ActionSubmissionRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Hip3Action? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Hip3Action),
      ) as Hip3Action;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Hip3Action>(
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
