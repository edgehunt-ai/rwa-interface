import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for SystemApi
void main() {
  final instance = RwaApiClient().getSystemApi();

  group(SystemApi, () {
    // 产品说明文案
    //
    // 返回 24×7 交易说明、各交易时段说明、产品风险提示等长文案， 便于不发版调整措辞与多语言。 
    //
    //Future<Disclosures> getDisclosures({ String locale }) async
    test('test getDisclosures', () async {
      // TODO
    });

    // 各平台最新版本
    //
    // 返回所有平台的版本信息。客户端拿自己的版本和对应平台的条目比较：  * `current < min_supported_version` → 强制升级，阻断使用 * `current < latest_version` → 提示有新版本，可跳过  比较放在客户端而不是服务端，是为了避免「查版本」这一个接口出现 「带参数算结果」和「不带参数列数据」两种模式。 
    //
    //Future<ListAppVersions200Response> listAppVersions({ String platform }) async
    test('test listAppVersions', () async {
      // TODO
    });

    // 实时事件流（SSE）
    //
    // Server-Sent Events。推送价格、订单状态、持仓与余额变化， 替代前端轮询。每条事件同时以 SSE 的 `id:` 字段和载荷的 `event_id` 给出可续传 标识；断线重连时客户端带上最近收到的 `Last-Event-ID`，服务端补发其后的事件。 事件名与强类型 `data` 结构见 `RealtimeEvent`。 
    //
    //Future<RealtimeEvent> streamEvents({ String channels, String lastEventID }) async
    test('test streamEvents', () async {
      // TODO
    });

  });
}
