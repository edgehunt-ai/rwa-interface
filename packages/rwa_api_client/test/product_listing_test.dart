import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for ProductListing
void main() {
  final instance = ProductListingBuilder();
  // TODO add properties to the builder and call build()

  group(ProductListing, () {
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

    // String productType
    test('to test the property `productType`', () async {
      // TODO
    });

    // 展示名，`bStocks` 或 `HIP-3`
    // String label
    test('to test the property `label`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String price
    test('to test the property `price`', () async {
      // TODO
    });

    // 24h 涨跌幅（百分比数值，如 `\"0.47\"`）
    // String change24hPercent
    test('to test the property `change24hPercent`', () async {
      // TODO
    });

    // 相对美股参考价的价差百分比
    // String spreadVsReferencePercent
    test('to test the property `spreadVsReferencePercent`', () async {
      // TODO
    });

    // 24h 成交量（以基础资产计价）
    // String volume24h
    test('to test the property `volume24h`', () async {
      // TODO
    });

    // String volume24hUnit
    test('to test the property `volume24hUnit`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String turnover24hUsd
    test('to test the property `turnover24hUsd`', () async {
      // TODO
    });

    // int hotRank
    test('to test the property `hotRank`', () async {
      // TODO
    });

    // bool isFavorite (default value: false)
    test('to test the property `isFavorite`', () async {
      // TODO
    });

  });
}
