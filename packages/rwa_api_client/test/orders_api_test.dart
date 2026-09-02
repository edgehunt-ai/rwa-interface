import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for OrdersApi
void main() {
  final instance = RwaApiClient().getOrdersApi();

  group(OrdersApi, () {
    // 请求取消订单
    //
    //Future<Order> cancelOrder(String orderId, String idempotencyKey) async
    test('test cancelOrder', () async {
      // TODO
    });

    // 提交 HIP-3 agent challenge 签名
    //
    //Future<Hip3Challenge> completeHip3AgentChallenge(String challengeId, String idempotencyKey, Hip3ChallengeCompleteRequest hip3ChallengeCompleteRequest) async
    test('test completeHip3AgentChallenge', () async {
      // TODO
    });

    // 提交指定钱包动作的签名结果
    //
    //Future<Order> completeOrderWalletAction(String orderId, String stepId, String idempotencyKey, WalletActionCompleteRequest walletActionCompleteRequest) async
    test('test completeOrderWalletAction', () async {
      // TODO
    });

    // 创建 HIP-3 agent 授权 challenge
    //
    //Future<Hip3Challenge> createHip3AgentChallenge(String idempotencyKey, { Hip3ChallengeRequest hip3ChallengeRequest }) async
    test('test createHip3AgentChallenge', () async {
      // TODO
    });

    // 创建订单
    //
    //Future<Order> createOrder(String idempotencyKey, CreateOrderRequest createOrderRequest) async
    test('test createOrder', () async {
      // TODO
    });

    // 订单详情与权威状态
    //
    //Future<Order> getOrder(String orderId) async
    test('test getOrder', () async {
      // TODO
    });

    // 订单列表
    //
    //Future<ListOrders200Response> listOrders({ String cursor, int limit }) async
    test('test listOrders', () async {
      // TODO
    });

    // 预览 bStocks 或 HIP-3 订单
    //
    //Future<OrderPreview> previewOrder(String idempotencyKey, OrderPreviewRequest orderPreviewRequest) async
    test('test previewOrder', () async {
      // TODO
    });

  });
}
