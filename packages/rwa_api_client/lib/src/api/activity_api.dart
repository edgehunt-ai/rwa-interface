//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/activity_category.dart';
import 'package:rwa_api_client/src/model/activity_page.dart';
import 'package:rwa_api_client/src/model/activity_status.dart';
import 'package:rwa_api_client/src/model/activity_type.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/chain.dart';

class ActivityApi {

  final Dio _dio;

  final Serializers _serializers;

  const ActivityApi(this._dio, this._serializers);

  /// 交易与资金活动列表
  /// 返回当前账号已经实际发生且具有外部证据的交易与资金活动。Deposit 只有完成链上独立核验后 才出现；Order 通常仅在被交易场所接受或具有链上交易证明后出现。例外是已持久化、幂等且仍等待 钱包签名的 bStocks 动作：它以 &#x60;orderSign/pending&#x60; 暴露一个 Continue 入口，提交后原 Activity 行原地 转为实际订单类型，不创建第二个业务对象。Session、Preview、Authorization、等待付款和内部重试 不得进入用户 History。  &#x60;cursor&#x60; 是不透明 continuation token，绑定当前账户、稳定排序快照和完整规范化 filter tuple： &#x60;category,status,type,chain,from,to,product_or_asset&#x60;。客户端使用 cursor 获取后续页时必须提交 与首请求相同的 filters；缺省值也参与绑定。cursor 与 filter 不匹配、过期或属于其他账户时 返回 400，不得跨过滤条件复用或重新解释。时间窗口采用 &#x60;[from,to)&#x60;。 
  ///
  /// Parameters:
  /// * [category] 
  /// * [status] 
  /// * [type] 
  /// * [chain] 
  /// * [from] - Inclusive RFC 3339 UTC lower bound.
  /// * [to] - Exclusive RFC 3339 UTC upper bound; must be later than `from`.
  /// * [productOrAsset] - Exact canonical product ID, asset ID, or symbol selected by the user.
  /// * [cursor] - 上一页返回的 `next_cursor`
  /// * [limit] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ActivityPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ActivityPage>> listActivity({ 
    ActivityCategory? category,
    ActivityStatus? status,
    ActivityType? type,
    Chain? chain,
    DateTime? from,
    DateTime? to,
    String? productOrAsset,
    String? cursor,
    int? limit = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/activity';
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
      if (category != null) r'category': encodeQueryParameter(_serializers, category, const FullType(ActivityCategory)),
      if (status != null) r'status': encodeQueryParameter(_serializers, status, const FullType(ActivityStatus)),
      if (type != null) r'type': encodeQueryParameter(_serializers, type, const FullType(ActivityType)),
      if (chain != null) r'chain': encodeQueryParameter(_serializers, chain, const FullType(Chain)),
      if (from != null) r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      if (to != null) r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
      if (productOrAsset != null) r'product_or_asset': encodeQueryParameter(_serializers, productOrAsset, const FullType(String)),
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

    ActivityPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(ActivityPage),
      ) as ActivityPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ActivityPage>(
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
