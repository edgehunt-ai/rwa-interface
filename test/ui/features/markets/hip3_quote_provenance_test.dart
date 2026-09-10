import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/views/hip3_quote_provenance.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

void main() {
  final observed = DateTime.utc(2026, 9, 10, 12);
  MarketSnapshot quote({bool expiry = true}) => MarketSnapshot(
    price: DecimalValue('120'),
    priceKind: 'mark',
    asOf: observed,
    validUntil: expiry ? observed.add(const Duration(seconds: 5)) : null,
    referencePrice: DecimalValue('119'),
    referenceLabel: 'HIP3 Oracle',
    hip3Market: const Hip3PublicMarket(
      productId: 'hip3:xyz:TSLA',
      venue: 'xyz',
      environment: 'testnet',
      settlementAsset: 'USDC',
      tradable: true,
    ),
  );
  Widget app(Widget child, {bool zh = false}) => MaterialApp(
    theme: AppTheme.light,
    locale: Locale(zh ? 'zh' : 'en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(20), child: child),
      ),
    ),
  );

  testWidgets('captures bounded quote provenance evidence', (tester) async {
    await tester.runAsync(() async {
      final font = FontLoader('QuoteEvidence')
        ..addFont(
          File('/System/Library/Fonts/Supplemental/Arial Unicode.ttf')
              .readAsBytes()
              .then(ByteData.sublistView),
        );
      await font.load();
    });
    await tester.binding.setSurfaceSize(const Size(375, 860));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final key = GlobalKey();
    final snapshot = quote();
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light.copyWith(
            textTheme: AppTheme.light.textTheme.apply(
              fontFamily: 'QuoteEvidence',
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: RepaintBoundary(
            key: key,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TSLA · HIP3',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Hip3QuoteProvenance(
                        snapshot: snapshot,
                        now: () => observed.add(const Duration(seconds: 30)),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Market list quote',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      MarketProductRow(
                        product: MarketProduct(
                          symbol: 'TSLA',
                          name: 'Tesla',
                          kind: MarketProductKind.perp,
                          price: snapshot.price,
                          settlementAsset: 'USDC',
                          network: 'Hyperliquid',
                          tradable: false,
                          hip3Market: snapshot.hip3Market,
                          priceKind: 'mark',
                          updatedAt: observed,
                          isStale: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    await tester.runAsync(() async {
      final picture = await boundary.toImage();
      final bytes = await picture.toByteData(format: ui.ImageByteFormat.png);
      await File('/private/tmp/hip3-quote-evidence.png')
          .writeAsBytes(bytes!.buffer.asUint8List());
      picture.dispose();
    });
  }, skip: Platform.environment['HIP3_CAPTURE_QUOTE'] != '1');

  testWidgets(
    'market list row includes compact observed source and expired state',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 812));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final snapshot = quote();
      await tester.pumpWidget(
        ProviderScope(
          child: app(
            MediaQuery(
              data: const MediaQueryData(
                size: Size(375, 812),
                textScaler: TextScaler.linear(2),
              ),
              child: MarketProductRow(
                product: MarketProduct(
                  symbol: 'TSLA',
                  name: 'Tesla',
                  kind: MarketProductKind.perp,
                  price: snapshot.price,
                  settlementAsset: 'USDC',
                  network: 'Hyperliquid',
                  tradable: false,
                  hip3Market: snapshot.hip3Market,
                  priceKind: 'mark',
                  updatedAt: observed,
                  isStale: true,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.textContaining('xyz/testnet'), findsOneWidget);
      expect(find.textContaining('Expired quote'), findsOneWidget);
      expect(find.textContaining('2026-09-10 12:00:00 UTC'), findsOneWidget);
      expect(find.textContaining('US stock-market reference'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  for (final size in [const Size(375, 812), const Size(812, 375)]) {
    testWidgets('quote provenance wraps at $size with 200% text', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ProviderScope(
          child: app(
            MediaQuery(
              data: MediaQueryData(
                size: size,
                textScaler: const TextScaler.linear(2),
              ),
              child: Hip3QuoteProvenance(
                snapshot: quote(),
                now: () => observed,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Mark price'), findsOneWidget);
      expect(find.text('xyz · testnet · USDC'), findsOneWidget);
      expect(find.textContaining('HIP3 Oracle:'), findsOneWidget);
      expect(find.textContaining('2026-09-10T12:00:00.000Z'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 10));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'quote expires locally, background and offstage resume recheck wall time',
    (tester) async {
      var now = observed;
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final visible = ValueNotifier(true);
      addTearDown(visible.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: app(
            ValueListenableBuilder<bool>(
              valueListenable: visible,
              builder: (_, active, _) => TickerMode(
                enabled: active,
                child: Hip3QuoteProvenance(snapshot: quote(), now: () => now),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(seconds: 5));
      expect(find.textContaining('Quote expired'), findsOneWidget);
      now = observed;
      container.read(hip3ForegroundProvider.notifier).setForeground(false);
      await tester.pump();
      await tester.pump(const Duration(seconds: 20));
      expect(find.textContaining('Quote expired'), findsNothing);
      now = observed.add(const Duration(seconds: 30));
      container.read(hip3ForegroundProvider.notifier).setForeground(true);
      await tester.pump();
      expect(find.textContaining('Quote expired'), findsOneWidget);
      visible.value = false;
      await tester.pump();
      now = observed;
      visible.value = true;
      await tester.pump();
      expect(
        find.textContaining('Within the quote validity window'),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 20));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'missing validity does not claim freshness and Chinese copy is localized',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: app(
            Hip3QuoteProvenance(
              snapshot: quote(expiry: false),
              now: () => observed,
            ),
            zh: true,
          ),
        ),
      );
      await tester.pump();
      expect(find.text('报价时效尚未验证'), findsOneWidget);
      expect(find.text('标记价格（Mark）'), findsOneWidget);
      expect(find.text('Mark 和 HIP3 Oracle 均不是美股市场参考价。'), findsOneWidget);
    },
  );
}
