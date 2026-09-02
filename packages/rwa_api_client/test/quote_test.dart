import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for Quote
void main() {
  final instance = QuoteBuilder();
  // TODO add properties to the builder and call build()

  group(Quote, () {
    // 报价说明，如 `Last traded · NVDAB/USDC` 或 `Mark price · NVDA-PERP`
    // String label
    test('to test the property `label`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String price
    test('to test the property `price`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String change24h
    test('to test the property `change24h`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String change24hPercent
    test('to test the property `change24hPercent`', () async {
      // TODO
    });

    // DateTime updatedAt
    test('to test the property `updatedAt`', () async {
      // TODO
    });

  });
}
