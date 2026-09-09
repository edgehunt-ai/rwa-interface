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
import 'package:rwa_api_client/src/model/api_error.dart';

class ActivityApi {
  final Dio _dio;

  final Serializers _serializers;

  const ActivityApi(this._dio, this._serializers);

  /// 交易与资金活动列表
  /// 返回当前账号已经实际发生且具有外部证据的交易与资金活动。Deposit 只有完成链上独立核验后 才出现；Order 只有被交易场所接受并取得稳定 Provider 订单身份，或具有链上交易证明后才出现。 Session、Intent、Preview、Authorization、等待付款和内部重试不得进入用户 History。
  ///
  /// Parameters:
  /// * [category]
  /// * [status]
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
      if (category != null)
        r'category': encodeQueryParameter(
            _serializers, category, const FullType(ActivityCategory)),
      if (status != null)
        r'status': encodeQueryParameter(
            _serializers, status, const FullType(ActivityStatus)),
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

    ActivityPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null
          ? null
          : _serializers.deserialize(
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
