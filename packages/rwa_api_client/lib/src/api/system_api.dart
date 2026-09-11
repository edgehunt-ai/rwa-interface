//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:rwa_api_client/src/api_util.dart';
import 'package:rwa_api_client/src/model/api_error.dart';
import 'package:rwa_api_client/src/model/disclosures.dart';
import 'package:rwa_api_client/src/model/list_app_versions200_response.dart';
import 'package:rwa_api_client/src/model/realtime_event.dart';

class SystemApi {

  final Dio _dio;

  final Serializers _serializers;

  const SystemApi(this._dio, this._serializers);

  /// 产品说明文案
  /// 返回 24×7 交易说明、各交易时段说明、产品风险提示等长文案， 便于不发版调整措辞与多语言。 
  ///
  /// Parameters:
  /// * [locale] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [Disclosures] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<Disclosures>> getDisclosures({ 
    String? locale,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/system/disclosures';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (locale != null) r'locale': encodeQueryParameter(_serializers, locale, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    Disclosures? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(Disclosures),
      ) as Disclosures;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<Disclosures>(
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

  /// 各平台最新版本
  /// 返回所有平台的版本信息。客户端拿自己的版本和对应平台的条目比较：  * &#x60;current &lt; min_supported_version&#x60; → 强制升级，阻断使用 * &#x60;current &lt; latest_version&#x60; → 提示有新版本，可跳过  比较放在客户端而不是服务端，是为了避免「查版本」这一个接口出现 「带参数算结果」和「不带参数列数据」两种模式。 
  ///
  /// Parameters:
  /// * [platform] - 只取某个平台；不传则返回全部
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ListAppVersions200Response] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ListAppVersions200Response>> listAppVersions({ 
    String? platform,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/system/app-version';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (platform != null) r'platform': encodeQueryParameter(_serializers, platform, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ListAppVersions200Response? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(ListAppVersions200Response),
      ) as ListAppVersions200Response;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ListAppVersions200Response>(
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

  /// 实时事件流（SSE）
  /// 当前默认运行时未配置 SSE，返回 503；客户端继续使用有界、前台感知的轮询读取行情、订单、持仓与余额。 HIP3显式配置候选实现使用以下hip3_*事件；新增协议不表示已部署或启用，其他通用频道仍为预留。 HIP3首次无游标订阅发送hip3_snapshot，然后发送变化事件；订阅绑定已登录账户、当前唯一有效钱包、 账户交易环境与完整频道集合。频道顺序不改变绑定。会话失效或钱包变化会终止连接。 实时成员窗口变化时，同一连接可再次发送带新游标的hip3_snapshot；客户端原子替换该订阅缓存， 不应因此重新签名或重连。断线游标跨过窗口变化边界时，也可返回当前快照代替旧窗口增量。 客户端应只保存成功处理后的游标，按会话和订阅隔离；resync_required后丢弃旧游标重取快照。 保留窗口有界且不保证固定时长；不支持无限离线补发。HTTP建流失败或断流须退回读取API，不得重新签名或广播。 Server-Sent Events。推送价格、订单状态、持仓与余额变化， 替代前端轮询。每条事件同时以 SSE 的 &#x60;id:&#x60; 字段和载荷的 &#x60;event_id&#x60; 给出可续传 标识；断线重连时客户端带上最近收到的 &#x60;Last-Event-ID&#x60;，服务端补发其后的事件。 事件名与强类型 &#x60;data&#x60; 结构见 &#x60;RealtimeEvent&#x60;。 
  ///
  /// Parameters:
  /// * [channels] - HIP3候选实现要求逗号分隔的非空、无重复频道，最多32项、8组市场/环境，ASCII总长不超过4096。 支持hip3:orders、hip3:positions、hip3:balance、hip3:price:<environment>:<product_id>、 hip3:candle:<environment>:<interval>:<product_id>；product_id保留完整venue:coin。 environment为testnet或mainnet；interval为1m/5m/15m/1h/4h/1d。市场须与服务端目录环境匹配。 不按symbol推断身份。旧prices:NVDA:perp,orders,positions为未启用的通用预留频道，不自动映射到HIP3。 
  /// * [lastEventID] - SSE 断线重连时传入最后成功处理的 `event_id`。服务端应从该事件之后补发； 若保留窗口已过期，则发送一条 `resync_required` 事件并由客户端重新拉取快照。 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RealtimeEvent] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RealtimeEvent>> streamEvents({ 
    String? channels,
    String? lastEventID,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/events';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        if (lastEventID != null) r'Last-Event-ID': lastEventID,
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
      if (channels != null) r'channels': encodeQueryParameter(_serializers, channels, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    RealtimeEvent? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(RealtimeEvent),
      ) as RealtimeEvent;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RealtimeEvent>(
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
