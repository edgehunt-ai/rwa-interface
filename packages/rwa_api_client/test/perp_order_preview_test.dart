import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for PerpOrderPreview
void main() {
  final instance = PerpOrderPreviewBuilder();
  // TODO add properties to the builder and call build()

  group(PerpOrderPreview, () {
    // 本次报价的标识。下单时回传到 `CreateOrderRequest.preview_id` 可锁定价格； 超过 `quote_expires_at` 后失效，需重新预览。 
    // String previewId
    test('to test the property `previewId`', () async {
      // TODO
    });

    // String symbol
    test('to test the property `symbol`', () async {
      // TODO
    });

    // OrderSide side
    test('to test the property `side`', () async {
      // TODO
    });

    // OrderType type
    test('to test the property `type`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String marketPrice
    test('to test the property `marketPrice`', () async {
      // TODO
    });

    // 预计成交价；与 `market_price` 不同时前端提示「价格已更新」
    // String estimatedPrice
    test('to test the property `estimatedPrice`', () async {
      // TODO
    });

    // 报价较用户上次看到的价格是否已变化
    // bool priceUpdated
    test('to test the property `priceUpdated`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String estimatedQuantity
    test('to test the property `estimatedQuantity`', () async {
      // TODO
    });

    // 预计获得数量（扣除滑点后）
    // String estimatedReceive
    test('to test the property `estimatedReceive`', () async {
      // TODO
    });

    // String estimatedReceiveUnit
    test('to test the property `estimatedReceiveUnit`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String orderValue
    test('to test the property `orderValue`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String fee
    test('to test the property `fee`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String feeRate
    test('to test the property `feeRate`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String slippagePercent
    test('to test the property `slippagePercent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String orderBookImpactPercent
    test('to test the property `orderBookImpactPercent`', () async {
      // TODO
    });

    // Network fee as a decimal string. The asset is carried separately in fee_asset.
    // String networkFee
    test('to test the property `networkFee`', () async {
      // TODO
    });

    // 成交后资产的到账账户
    // AccountKind settlementAccount
    test('to test the property `settlementAccount`', () async {
      // TODO
    });

    // String settlementAccountLabel
    test('to test the property `settlementAccountLabel`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String marginRequired
    test('to test the property `marginRequired`', () async {
      // TODO
    });

    // 仅 HIP-3
    // String liquidationPrice
    test('to test the property `liquidationPrice`', () async {
      // TODO
    });

    // DateTime quoteExpiresAt
    test('to test the property `quoteExpiresAt`', () async {
      // TODO
    });

    // 「查看详情」中逐行展示的键值对
    // BuiltList<KeyValue> details
    test('to test the property `details`', () async {
      // TODO
    });

    // Asset used to denominate network_fee, for example BNB or USDC.
    // String feeAsset
    test('to test the property `feeAsset`', () async {
      // TODO
    });

    // Optional localized display note, for example Included.
    // String feeNote
    test('to test the property `feeNote`', () async {
      // TODO
    });

    // String kind
    test('to test the property `kind`', () async {
      // TODO
    });

    // String network
    test('to test the property `network`', () async {
      // TODO
    });

    // String settlementAsset
    test('to test the property `settlementAsset`', () async {
      // TODO
    });

  });
}
