import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('missing logos prefer API text', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const MarketAssetMark(symbol: 'NVDA', logoUrl: ' ', logoText: 'API'),
      ),
    );

    expect(find.text('API'), findsOneWidget);
    expect(find.text('N'), findsNothing);
    expect(find.byType(SvgPicture), findsNothing);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('missing metadata uses a safe generic placeholder', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        const Row(
          children: [
            MarketAssetMark(symbol: 'NVDA'),
            MarketAssetMark(symbol: 'TSLA', logoText: ' '),
            MarketAssetMark(symbol: '', logoText: ' '),
          ],
        ),
      ),
    );

    expect(find.text('N'), findsOneWidget);
    expect(find.text('T'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('failed remote logos prefer API text then the symbol initial', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        const Row(
          children: [
            MarketAssetMark(
              symbol: 'NVDA',
              logoUrl: 'https://cdn.example.com/missing.png',
              logoText: 'API',
            ),
            MarketAssetMark(
              symbol: 'TSLA',
              logoUrl: 'https://cdn.example.com/missing.png',
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('API'), findsOneWidget);
    expect(find.text('T'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('product rows render their own logo without a stock lookup', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MarketProductRow(
          product: _product(logoUrl: 'https://cdn.example.com/product.png'),
        ),
      ),
    );

    final image = tester.widget<Image>(find.byType(Image));
    expect(
      (image.image as NetworkImage).url,
      'https://cdn.example.com/product.png',
    );
    expect(
      tester.widget<MarketAssetMark>(find.byType(MarketAssetMark)).logoText,
      'API',
    );
  });

  testWidgets('product marks load metadata for the exact symbol and kind', (
    tester,
  ) async {
    const product = MarketProductRef(
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketProductProvider(product).overrideWith((_) async => _product()),
        ],
        child: buildTestApp(const MarketProductMark(product: product)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('API'), findsOneWidget);
    expect(
      tester.widget<MarketAssetMark>(find.byType(MarketAssetMark)).logoText,
      'API',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('asset lookup accepts only an exact unambiguous product', (
    tester,
  ) async {
    const query = (query: 'NVDA', cursor: null, group: null, productType: null);
    var items = [_product(symbol: 'NVDAB')];
    final container = ProviderContainer(
      overrides: [
        marketProductLookupProvider(query)
            .overrideWith((_) async => DomainPage(items: items)),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const MarketAssetLookupMark(symbol: 'NVDA')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('N'), findsOneWidget);
    expect(find.text('API'), findsNothing);

    items = [_product()];
    container.invalidate(marketProductLookupProvider(query));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MarketAssetMark>(find.byType(MarketAssetMark)).logoText,
      'API',
    );
    expect(find.text('API'), findsOneWidget);

    items = [_product(), _product(kind: MarketProductKind.bstock)];
    container.invalidate(marketProductLookupProvider(query));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MarketAssetMark>(find.byType(MarketAssetMark)).logoText,
      isNull,
    );
    expect(find.text('API'), findsNothing);
    expect(find.text('N'), findsOneWidget);
  });
}

MarketProduct _product({
  String symbol = 'NVDA',
  MarketProductKind kind = MarketProductKind.perp,
  String? logoUrl,
}) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue('100'),
  settlementAsset: 'USDC',
  network: 'Hyperliquid',
  tradable: true,
  logoUrl: logoUrl,
  logoText: 'API',
);
