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
import 'package:rwa_api_client/src/model/realtime_event_page.dart';

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

  /// 有界回放账户事件
  /// 为生成客户端和 SSE 恢复提供 bounded JSON replay，使用与 &#x60;/v1/events&#x60; 完全相同的 八个私有频道、trim/lowercase/dedupe/sort canonical tuple、账户授权及 opaque cursor 语义。服务端只能从已认证 bearer 对应的账户取得 account ID；客户端不得在请求中 提供或覆盖 account ID，所有返回事件只能属于该账户。  未传 cursor 时不回放历史：返回 empty &#x60;items&#x60;、绑定当前 high-water 的 &#x60;next_cursor&#x60;、 &#x60;has_more&#x3D;false&#x60;、&#x60;resync_required&#x3D;true&#x60;，客户端必须先建立完整 REST snapshot。传入有效 cursor 时，在同一 repeatable-read snapshot 内固定 high-water H，仅返回 &#x60;cursor.sequence &lt; sequence &lt;&#x3D; H&#x60; 的最多 &#x60;limit&#x60; 条事件。中间页 cursor 只推进到 last returned event；last page 的 cursor 推进到 H，保证随后 SSE 可以从同一边界继续。  Delivery guarantee 为 at-least-once，事件按服务端内部 sequence 升序返回，客户端仅以 完整 opaque event ID 去重。超过 24 小时 retention 的有效 cursor 返回 empty &#x60;items&#x60;、 当前 high-water &#x60;next_cursor&#x60; 和 &#x60;resync_required&#x3D;true&#x60;；损坏、篡改、跨账户、频道不匹配 或协议版本不匹配统一返回 &#x60;400 invalid_event_cursor&#x60;。频道错误返回 &#x60;400 event_subscription_invalid&#x60;；包含未配置公共频道的整个请求返回 &#x60;503 realtime_channel_unconfigured&#x60;，不得部分成功。  JSON replay 与 SSE 都独立于 Firebase/FCM 后台通知；它们不替代 Firebase/FCM，也不以 notification outbox 或 Firebase payload 作为 replay source。 PostgreSQL realtime projection、cursor HMAC key 或 database 不可用时 fail closed，返回 &#x60;503 realtime_service_unavailable&#x60;，不得返回 empty page 冒充成功。 
  ///
  /// Parameters:
  /// * [channels] - Comma-separated subscription。账户 projection 的私有频道为 `orders`、`positions`、`transfers`、 `claims`、`deposits`、`withdrawals`、`balances`、`activity`；省略时订阅全部八个，并按 trim、lowercase、 dedupe、sort 生成绑定 cursor 的 canonical tuple。HIP3 typed realtime 必须显式使用以下命名空间： `hip3:orders`、`hip3:positions`、`hip3:balance`、`hip3:price:<environment>:<product_id>`、 `hip3:candle:<environment>:<interval>:<product_id>`。其中 environment 为 `testnet` 或 `mainnet`， interval 为 `1m`/`5m`/`15m`/`1h`/`4h`/`1d`，product_id 保留完整 `venue:coin`；最多 32 项、8 组市场/环境， ASCII 总长不超过 4096。单次订阅不得混用账户 projection 与 HIP3 命名空间；空项、空字符串、unknown 或 混合频道返回 `400 event_subscription_invalid`。未配置的 `prices:*`、`candles:*`、`sessions` 及不匹配的 HIP3 市场集合返回 `503 realtime_channel_unconfigured`，不得以 partial subscription 冒充成功。 
  /// * [cursor] - 上一页 `next_cursor` 或已确认的 SSE `event_id`；省略时执行 snapshot bootstrap。
  /// * [limit] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RealtimeEventPage] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RealtimeEventPage>> replayEvents({ 
    String? channels = 'activity,balances,claims,deposits,orders,positions,transfers,withdrawals',
    String? cursor,
    int? limit = 50,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/v1/events/replay';
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
      if (channels != null) r'channels': encodeQueryParameter(_serializers, channels, const FullType(String)),
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

    RealtimeEventPage? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(RealtimeEventPage),
      ) as RealtimeEventPage;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RealtimeEventPage>(
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
  /// 当前默认运行时未配置 SSE，必须返回 503；客户端继续使用有界、前台感知的轮询读取行情、订单、持仓与余额。 这是账户隔离、at-least-once 的 UTF-8 Server-Sent Events wire stream。服务端只能从已认证 bearer 对应的账户取得 account ID；客户端不得在请求中提供或覆盖 account ID。浏览器必须以支持 Authorization header 的 streaming &#x60;fetch&#x60; 建立连接，bearer token 不得进入 query、日志或持久化 cursor。  每个 frame 固定为 &#x60;id: &lt;opaque event cursor&gt;&#x60;、 &#x60;event: &lt;RealtimeEvent.event&gt;&#x60;、&#x60;data: &lt;single-line RealtimeEvent JSON&gt;&#x60;，随后以 blank line 结束； payload 内的 &#x60;event_id&#x60; 必须与 SSE &#x60;id:&#x60; 完全相同。heartbeat 仅发送 &#x60;: keep-alive&#x60; comment， 不产生也不推进 cursor；客户端不得解析、比较或自行构造 cursor。  本接口同时承载两类显式订阅：账户 projection 的八个私有频道（&#x60;orders&#x60;、&#x60;positions&#x60;、&#x60;transfers&#x60;、 &#x60;claims&#x60;、&#x60;deposits&#x60;、&#x60;withdrawals&#x60;、&#x60;balances&#x60;、&#x60;activity&#x60;）和 HIP3 typed realtime 频道 （&#x60;hip3:orders&#x60;、&#x60;hip3:positions&#x60;、&#x60;hip3:balance&#x60;、&#x60;hip3:price:&lt;environment&gt;:&lt;product_id&gt;&#x60;、 &#x60;hip3:candle:&lt;environment&gt;:&lt;interval&gt;:&lt;product_id&gt;&#x60;）。频道规范化、上限和 fail-closed 规则见 &#x60;RealtimeChannels&#x60;；单次订阅不得混用两类命名空间，空项、unknown channel 或混合订阅返回 &#x60;400 event_subscription_invalid&#x60;。未配置的频道集合不得部分成功，返回 &#x60;503 realtime_channel_unconfigured&#x60;。  账户 projection 未传 &#x60;Last-Event-ID&#x60; 时先发送绑定当前 high-water 的 &#x60;resync_required&#x60; event 后关闭， 客户端建立完整 REST snapshot 后以该 event ID 重连；有效 cursor 先补发保留事件，再 tail live events。 HIP3 首次无游标订阅发送 &#x60;hip3_snapshot&#x60;，随后发送强类型变化事件。HIP3 会话绑定账户、唯一有效钱包、交易环境和完整频道集合， 钱包/会话失效会终止连接；成员窗口变化可在同一连接发送新的快照。有效 cursor 只在绑定的账户、钱包、环境、 频道集合和协议版本内有效，断线时补发保留窗口内事件；超过保留窗口发送 &#x60;resync_required&#x60; 或当前快照后关闭。 损坏、篡改、跨账户、频道不匹配或协议版本不匹配统一返回 &#x60;400 invalid_event_cursor&#x60;，不得透露账户归属。  SSE 与 Firebase/FCM 后台通知是独立链路，具有独立 payload、cursor、幂等、retry 和 retention；SSE 不替代 Firebase/FCM，也不以 notification outbox 或 Firebase payload 作为 replay source。本接口只通知客户端执行 只读 REST refresh，不触发签名、广播或其他资产命令。 PostgreSQL realtime projection、cursor HMAC key 或数据库不可用时必须 fail closed，返回 &#x60;503 realtime_service_unavailable&#x60;，不得返回 empty stream 冒充成功。 
  ///
  /// Parameters:
  /// * [channels] - Comma-separated subscription。账户 projection 的私有频道为 `orders`、`positions`、`transfers`、 `claims`、`deposits`、`withdrawals`、`balances`、`activity`；省略时订阅全部八个，并按 trim、lowercase、 dedupe、sort 生成绑定 cursor 的 canonical tuple。HIP3 typed realtime 必须显式使用以下命名空间： `hip3:orders`、`hip3:positions`、`hip3:balance`、`hip3:price:<environment>:<product_id>`、 `hip3:candle:<environment>:<interval>:<product_id>`。其中 environment 为 `testnet` 或 `mainnet`， interval 为 `1m`/`5m`/`15m`/`1h`/`4h`/`1d`，product_id 保留完整 `venue:coin`；最多 32 项、8 组市场/环境， ASCII 总长不超过 4096。单次订阅不得混用账户 projection 与 HIP3 命名空间；空项、空字符串、unknown 或 混合频道返回 `400 event_subscription_invalid`。未配置的 `prices:*`、`candles:*`、`sessions` 及不匹配的 HIP3 市场集合返回 `503 realtime_channel_unconfigured`，不得以 partial subscription 冒充成功。 
  /// * [lastEventID] - SSE 断线重连时传入最后成功处理的 opaque `event_id`。cursor 绑定认证账户、完整 canonical channel tuple 和协议版本；客户端不得解析或比较。服务端从该事件之后按 内部 sequence 升序补发，delivery guarantee 为 at-least-once。  损坏、篡改、foreign account、channel mismatch 或 protocol version mismatch 返回 `400 invalid_event_cursor`，且不得透露账户归属。超过 24 小时保留窗口时发送绑定当前 high-water 的 `resync_required` event 后关闭 stream，由客户端重新拉取 REST snapshot。 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [String] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<String>> streamEvents({ 
    String? channels = 'activity,balances,claims,deposits,orders,positions,transfers,withdrawals',
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

    String? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : rawResponse as String;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<String>(
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
