import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/market_product.dart';

void main() {
  const market = Hip3PublicMarket(
    productId: 'xyz:TSLA',
    venue: 'xyz',
    environment: 'mainnet',
    settlementAsset: 'USDH',
    tradable: false,
    unavailableReason: 'mainnet_read_only',
  );
  test('same symbol across environments or venues is not the same market', () {
    expect(
      market.matches(
        productId: 'xyz:TSLA',
        venue: 'xyz',
        environment: 'mainnet',
        settlementAsset: 'USDH',
      ),
      isTrue,
    );
    expect(
      market.matches(
        productId: 'xyz:TSLA',
        venue: 'xyz',
        environment: 'testnet',
        settlementAsset: 'USDH',
      ),
      isFalse,
    );
    expect(
      market.matches(
        productId: 'abc:TSLA',
        venue: 'abc',
        environment: 'mainnet',
        settlementAsset: 'USDH',
      ),
      isFalse,
    );
    expect(
      market.matches(
        productId: 'xyz:TSLA',
        venue: 'xyz',
        environment: 'mainnet',
        settlementAsset: 'USDC',
      ),
      isFalse,
    );
  });
}
