import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_fill.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_detail_screen.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_history_screen.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_open_orders_panel.dart';

import '../../../../helpers/test_app.dart';
import '../../../../helpers/display_config.dart';

TradingOrderFill fill(
  String id,
  int minute, {
  String feeAsset = 'HYPE',
  FillSide? side,
  String? pnl,
  String? pnlAsset,
  String? effect,
}) => TradingOrderFill(
  fillId: id,
  providerTradeId: 'trade-$id',
  side: side,
  positionEffect: effect,
  closedPnl: pnl == null ? null : DecimalValue(pnl, asset: pnlAsset),
  price: DecimalValue('101.123456789012345678'),
  quantity: DecimalValue('0.000000000000000001', asset: 'TSLA'),
  fee: DecimalValue('-0.000001', asset: feeAsset),
  executedAt: DateTime.utc(2026, 9, 10, 12, minute, 1, 123),
);
TradingOrder order(
  String id, {
  List<TradingOrderFill>? fills,
  bool totals = true,
  MarketProductKind kind = MarketProductKind.perp,
}) => TradingOrder(
  orderId: id,
  symbol: 'TSLA',
  kind: kind,
  side: TradingSide.short,
  type: TradingOrderType.limit,
  status: TradingOrderStatus.filled,
  createdAt: DateTime.utc(2026),
  fills: fills,
  filledQuantity: totals ? DecimalValue('99') : null,
  averageFillPrice: totals ? DecimalValue('150') : null,
  realizedPnl: totals ? DecimalValue('-7', asset: 'USDC') : null,
);

Future<void> reveal(WidgetTester tester, String text) =>
    tester.scrollUntilVisible(
      find.text(text),
      250,
      scrollable: find.byType(Scrollable).first,
      maxScrolls: 30,
    );

void main() {
  for (final entry in {
    'open_long': 'Open long',
    'close_long': 'Close long',
    'open_short': 'Open short',
    'close_short': 'Close short',
    'long_to_short': 'Long to short',
    'short_to_long': 'Short to long',
    'future_value': 'Unknown',
  }.entries) {
    testWidgets(
      'renders provider position effect ${entry.key} without deriving it from buy',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              orderProvider.overrideWith(
                (ref, id) async => ResourceResult(
                  resource: order(
                    id,
                    fills: [
                      fill('effect', 1, side: FillSide.buy, effect: entry.key),
                    ],
                  ),
                ),
              ),
            ],
            child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
          ),
        );
        await tester.pumpAndSettle();
        await reveal(tester, entry.value);
        expect(find.text(entry.value), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets(
    'execution buy and raw pnl currencies are separate from short order and fee',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            orderProvider.overrideWith(
              (ref, id) async => ResourceResult(
                resource: order(
                  id,
                  fills: [
                    fill(
                      'facts',
                      1,
                      side: FillSide.buy,
                      pnl: '-1.25',
                      pnlAsset: 'USDH',
                    ),
                  ],
                ),
              ),
            ),
          ],
          child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Short'), findsOneWidget);
      await reveal(tester, 'Fill 1');
      await reveal(tester, 'trade-facts');
      expect(find.text('Buy'), findsOneWidget);
      expect(find.text('-1.25 USDH'), findsOneWidget);
      expect(find.text('-0.000001 HYPE'), findsOneWidget);
      expect(find.text('Fill closed PnL'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'zero fill pnl remains zero and absent currency stays unavailable',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            orderProvider.overrideWith(
              (ref, id) async => ResourceResult(
                resource: order(
                  id,
                  fills: [fill('zero', 1, side: FillSide.sell, pnl: '0')],
                ),
              ),
            ),
          ],
          child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
        ),
      );
      await tester.pumpAndSettle();
      await reveal(tester, 'trade-zero');
      expect(find.text('Sell'), findsOneWidget);
      expect(find.text('0 (unit unavailable)'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('optional order detail visual capture', (tester) async {
    const output = String.fromEnvironment('HIP3_ORDER_CAPTURE');
    const font = String.fromEnvironment('HIP3_ORDER_FONT');
    if (output.isEmpty || font.isEmpty) return;
    await tester.runAsync(() async {
      final bytes = ByteData.sublistView(File(font).readAsBytesSync());
      for (final name in ['Roboto', 'Ahem']) {
        await (FontLoader(name)..addFont(Future.value(bytes))).load();
      }
      await (FontLoader('MaterialIcons')..addFont(
            Future.value(
              ByteData.sublistView(
                File('${File(font).parent.path}/MaterialIcons-Regular.otf')
                    .readAsBytesSync(),
              ),
            ),
          ))
          .load();
    });
    await configureDisplay(tester, size: const Size(375, 1000));
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      await tester.pumpWidget(
        ProviderScope(
          key: ValueKey(mode),
          overrides: [
            orderProvider.overrideWith(
              (ref, id) async => ResourceResult(
                resource: order(
                  id,
                  fills: [
                    fill(
                      'fill-123',
                      1,
                      side: FillSide.buy,
                      effect: 'close_short',
                      pnl: '-1.25',
                      pnlAsset: 'USDH',
                    ),
                  ],
                ),
              ),
            ),
          ],
          child: RepaintBoundary(
            key: const ValueKey('capture'),
            child: buildTestApp(
              const Hip3OrderDetailScreen(orderId: 'hip3-order-123'),
              themeMode: mode,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      Future<void> capture(String section) async {
        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find.byKey(const ValueKey('capture')),
        );
        final image = await boundary.toImage(pixelRatio: 1);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('$output-${mode.name}-$section.png')
            .writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      }

      await tester.runAsync(() => capture('summary'));
      await reveal(tester, 'trade-fill-123');
      await tester.pumpAndSettle();
      await tester.runAsync(() => capture('fills'));
      expect(tester.takeException(), isNull);
    }
  });
  testWidgets(
    'detail separates server totals from exact per-fill facts; no invented side or PnL',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            orderProvider.overrideWith(
              (ref, id) async => ResourceResult(
                resource: order(
                  id,
                  fills: [fill('older', 0), fill('newer', 1)],
                ),
              ),
            ),
          ],
          child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Order totals'), findsOneWidget);
      expect(find.text('99 TSLA'), findsOneWidget);
      expect(find.text('150 (unit unavailable)'), findsOneWidget);
      expect(find.text('-7 (unit unavailable)'), findsOneWidget);
      expect(find.text('Short'), findsOneWidget);
      await reveal(tester, 'Individual fills');
      expect(
        find.textContaining('This response contains 2 fill records'),
        findsOneWidget,
      );
      expect(
        find.textContaining('completeness is not confirmed'),
        findsOneWidget,
      );
      await reveal(tester, 'Fill 1');
      await reveal(tester, 'trade-newer');
      expect(
        find.text('101.123456789012345678 (unit unavailable)'),
        findsWidgets,
      );
      expect(find.text('0.000000000000000001 TSLA'), findsWidgets);
      expect(find.text('-0.000001 HYPE'), findsWidgets);
      expect(find.text('2026-09-10 12:01:01.123 UTC'), findsWidgets);
      expect(find.text('Fill direction'), findsWidgets);
      expect(find.text('Fill closed PnL'), findsWidgets);
      expect(find.text('Unavailable'), findsWidgets);
      expect(find.text('Sell'), findsNothing);
      await reveal(tester, 'trade-older');
      expect(find.text('trade-older'), findsOneWidget);
      expect(find.text('Cancel'), findsNothing);
      expect(find.text('Sign'), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  for (final omitted in [true, false]) {
    testWidgets(
      'missing aggregates are unavailable and fills ${omitted ? 'omitted' : 'empty'} do not assert no execution',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              orderProvider.overrideWith(
                (ref, id) async => ResourceResult(
                  resource: order(
                    id,
                    totals: false,
                    fills: omitted ? null : [],
                  ),
                ),
              ),
            ],
            child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Unavailable'), findsWidgets);
        expect(find.text('0 USDC'), findsNothing);
        expect(find.text('0 TSLA'), findsNothing);
        final message = omitted
            ? 'Fill details were not provided by the API. This does not mean the order has no executions.'
            : 'No individual fills were returned. This does not prove that no executions occurred.';
        await reveal(tester, message);
        expect(find.text(message), findsOneWidget);
        expect(find.text('Fill 1'), findsNothing);
      },
    );
  }

  testWidgets(
    'initial error can retry via GET and refresh replaces the response',
    (tester) async {
      var calls = 0;
      final repo = _Repository(
        onGet: (id) async {
          if (++calls == 1) throw StateError('offline');
          return ResourceResult(
            resource: order(id, fills: [fill('response-$calls', 1)]),
          );
        },
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [ordersRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(find.text('Order totals'), findsOneWidget);
      await tester.tap(find.text('Refresh orders'));
      await tester.pumpAndSettle();
      await reveal(tester, 'trade-response-3');
      expect(find.text('trade-response-2'), findsNothing);
      expect(calls, 3);
    },
  );

  testWidgets('late old order request cannot overwrite new order details', (
    tester,
  ) async {
    final old = Completer<ResourceResult<TradingOrder>>();
    final repo = _Repository(
      onGet: (id) => id == 'old'
          ? old.future
          : Future.value(ResourceResult(resource: order(id))),
    );
    Widget app(String id) => ProviderScope(
      overrides: [ordersRepositoryProvider.overrideWithValue(repo)],
      child: buildTestApp(Hip3OrderDetailScreen(orderId: id)),
    );
    await tester.pumpWidget(app('old'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpWidget(app('new'));
    await tester.pumpAndSettle();
    old.complete(ResourceResult(resource: order('old')));
    await tester.pumpAndSettle();
    expect(find.text('new'), findsOneWidget);
    expect(find.text('old'), findsNothing);
  });

  testWidgets('bStocks response is not displayed as HIP3', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderProvider.overrideWith(
            (ref, id) async => ResourceResult(
              resource: order(id, kind: MarketProductKind.bstock),
            ),
          ),
        ],
        child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('HIP3 order details are unavailable for this order.'),
      findsOneWidget,
    );
    expect(find.text('Individual fills'), findsNothing);
  });

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('375px large-text detail wraps exact values in $mode', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(375, 812), textScale: 2);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            orderProvider.overrideWith(
              (ref, id) async => ResourceResult(
                resource: order(
                  id,
                  fills: [fill('long-id-12345678901234567890', 1)],
                ),
              ),
            ),
          ],
          child: buildTestApp(
            const Hip3OrderDetailScreen(orderId: 'o1'),
            themeMode: mode,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await reveal(tester, 'trade-long-id-12345678901234567890');
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('HIP3 open order card exposes a read-only details entry', (
    tester,
  ) async {
    final router = AppRouter.create(initialLocation: '/hip3/orders/o1');
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderProvider.overrideWith(
            (ref, id) async => ResourceResult(resource: order(id)),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(Hip3OrderDetailScreen), findsOneWidget);
    await tester.pumpWidget(
      ProviderScope(
        key: const ValueKey('open-card'),
        child: buildTestApp(
          Hip3OpenOrderCard(order: order('o1'), onChanged: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(TextButton, 'HIP3 order details'),
      findsOneWidget,
    );
  });

  testWidgets(
    'history consumes all order cursors, dedupes, retries same failed page and opens filled order',
    (tester) async {
      final requests = <String?>[];
      var failed = false;
      final router = AppRouter.create(initialLocation: '/hip3/orders');
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hip3OrdersProvider.overrideWith((ref, cursor) async {
              requests.add(cursor);
              if (cursor == 'next' && !failed) {
                failed = true;
                throw StateError('offline');
              }
              return DomainPage(
                items: [
                  ResourceResult(resource: order('o1')),
                  if (cursor != null) ResourceResult(resource: order('o2')),
                ],
                hasMore: cursor == null,
                nextCursor: cursor == null ? 'next' : null,
              );
            }),
            orderProvider.overrideWith(
              (ref, id) async =>
                  ResourceResult(resource: order(id, fills: [fill('1', 1)])),
            ),
          ],
          child: buildRouterTestApp(router),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load more orders'));
      await tester.pumpAndSettle();
      expect(find.text('o1'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(requests, [null, 'next', 'next']);
      expect(find.text('Load more orders'), findsNothing);
      expect(find.text('o1'), findsOneWidget);
      await tester.tap(find.text('o2'));
      await tester.pumpAndSettle();
      expect(find.byType(Hip3OrderDetailScreen), findsOneWidget);
      expect(find.text('o2'), findsOneWidget);
      router.pop();
      await tester.pumpAndSettle();
      expect(find.byType(Hip3OrderHistoryScreen), findsOneWidget);
    },
  );

  testWidgets(
    'repeated cursor stops with retry instead of an infinite page loop',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            hip3OrdersProvider.overrideWith(
              (ref, cursor) async => DomainPage(
                items: [ResourceResult(resource: order('o1'))],
                nextCursor: 'same',
                hasMore: true,
              ),
            ),
          ],
          child: buildTestApp(const Hip3OrderHistoryScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load more orders'));
      await tester.pumpAndSettle();
      expect(find.text('Load more orders'), findsNothing);
      expect(find.text('Retry'), findsOneWidget);
    },
  );

  testWidgets('account change hides old fills while fetching new scope', (
    tester,
  ) async {
    var calls = 0;
    final next = Completer<ResourceResult<TradingOrder>>();
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(
          _Repository(
            onGet: (id) async => ++calls == 1
                ? ResourceResult(resource: order(id))
                : next.future,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const Hip3OrderDetailScreen(orderId: 'o1')),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Order totals'), findsOneWidget);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await tester.pump();
    expect(find.text('Order totals'), findsNothing);
    next.completeError(StateError('not authorized'));
    await tester.pumpAndSettle();
    expect(find.text('Retry'), findsOneWidget);
  });
}

class _Repository implements OrdersRepository {
  _Repository({required this.onGet});
  final Future<ResourceResult<TradingOrder>> Function(String) onGet;
  @override
  Future<ResourceResult<TradingOrder>> get(String id) => onGet(id);
  // Every write operation throws, so navigation and refresh tests cannot silently mutate orders.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
