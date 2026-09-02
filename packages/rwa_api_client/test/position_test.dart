import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for Position
void main() {
  final instance = PositionBuilder();
  // TODO add properties to the builder and call build()

  group(Position, () {
    // String positionId
    test('to test the property `positionId`', () async {
      // TODO
    });

    // String symbol
    test('to test the property `symbol`', () async {
      // TODO
    });

    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // ProductKind kind
    test('to test the property `kind`', () async {
      // TODO
    });

    // 仅 HIP-3
    // String side
    test('to test the property `side`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String quantity
    test('to test the property `quantity`', () async {
      // TODO
    });

    // String quantityUnit
    test('to test the property `quantityUnit`', () async {
      // TODO
    });

    // 现货为持仓市值，合约为仓位权益
    // String valueUsd
    test('to test the property `valueUsd`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String entryPrice
    test('to test the property `entryPrice`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String markPrice
    test('to test the property `markPrice`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String unrealizedPnl
    test('to test the property `unrealizedPnl`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String unrealizedPnlPercent
    test('to test the property `unrealizedPnlPercent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String realizedPnl
    test('to test the property `realizedPnl`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String costBasis
    test('to test the property `costBasis`', () async {
      // TODO
    });

    // Decimal string leverage; allowed range is 1 to 50.
    // String leverage
    test('to test the property `leverage`', () async {
      // TODO
    });

    // MarginMode marginMode
    test('to test the property `marginMode`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String margin
    test('to test the property `margin`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String liquidationPrice
    test('to test the property `liquidationPrice`', () async {
      // TODO
    });

    // 累计资金费；负数为支付，正数为收取
    // String fundingPaid
    test('to test the property `fundingPaid`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String takeProfitPrice
    test('to test the property `takeProfitPrice`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String stopLossPrice
    test('to test the property `stopLossPrice`', () async {
      // TODO
    });

    // 已设置的止损限价；与 `stop_loss_price` 一起用于完整回显 TP / SL
    // String stopLimitPrice
    test('to test the property `stopLimitPrice`', () async {
      // TODO
    });

    // DateTime openedAt
    test('to test the property `openedAt`', () async {
      // TODO
    });

    // DateTime updatedAt
    test('to test the property `updatedAt`', () async {
      // TODO
    });

  });
}
