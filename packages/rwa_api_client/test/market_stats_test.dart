import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for MarketStats
void main() {
  final instance = MarketStatsBuilder();
  // TODO add properties to the builder and call build()

  group(MarketStats, () {
    // 十进制字符串，避免浮点误差
    // String high24h
    test('to test the property `high24h`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String low24h
    test('to test the property `low24h`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String turnover24hUsd
    test('to test the property `turnover24hUsd`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String volume24h
    test('to test the property `volume24h`', () async {
      // TODO
    });

    // String volume24hUnit
    test('to test the property `volume24hUnit`', () async {
      // TODO
    });

    // bStocks 为 `US Stock Reference`；HIP-3 为 `Spot / Reference Price`
    // String referenceLabel
    test('to test the property `referenceLabel`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String referencePrice
    test('to test the property `referencePrice`', () async {
      // TODO
    });

    // bStocks 为 `Premium`；HIP-3 为 `Basis`
    // String relativeLabel
    test('to test the property `relativeLabel`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String relativePercent
    test('to test the property `relativePercent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String spreadPercent
    test('to test the property `spreadPercent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String bestBid
    test('to test the property `bestBid`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String bestAsk
    test('to test the property `bestAsk`', () async {
      // TODO
    });

    // 仅 HIP-3。正费率多头付空头，负费率反向。
    // String fundingRate
    test('to test the property `fundingRate`', () async {
      // TODO
    });

    // DateTime nextFundingAt
    test('to test the property `nextFundingAt`', () async {
      // TODO
    });

    // 仅 HIP-3
    // String openInterestUsd
    test('to test the property `openInterestUsd`', () async {
      // TODO
    });

  });
}
