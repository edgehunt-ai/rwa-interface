import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/repositories/activity_repository.dart';
import 'package:nobell/ui/features/activity/views/activity_screen.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets(
    'cash summaries show tokens and numeric amounts, keeping details',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            activityRepositoryProvider.overrideWithValue(
              _OrderActivityRepository([
                ActivityRecord(
                  id: 'deposit',
                  category: ActivityCategory.cash,
                  type: 'deposit',
                  status: ActivityState.success,
                  title: 'Deposit',
                  asset: 'USDT',
                  amount: DecimalValue('1000', asset: 'USDT'),
                  txHash: '0xdeposit',
                  createdAt: DateTime.utc(2026),
                ),
                ActivityRecord(
                  id: 'transfer',
                  category: ActivityCategory.cash,
                  type: 'bridge',
                  status: ActivityState.pending,
                  title: 'Transfer',
                  asset: 'USDT',
                  amount: DecimalValue('1.607487', asset: 'USDT'),
                  fields: const [
                    ActivityField(label: 'Send Token', value: 'ETH'),
                    ActivityField(label: 'Receive Token', value: 'USDT'),
                    ActivityField(label: 'Send Amount', value: '0.01 ETH'),
                  ],
                  createdAt: DateTime.utc(2026),
                ),
                ActivityRecord(
                  id: 'address-transfer',
                  category: ActivityCategory.cash,
                  type: 'bridge',
                  status: ActivityState.success,
                  title: 'Transfer',
                  asset: 'USDC',
                  amount: DecimalValue('2.305068', asset: 'USDC'),
                  fields: const [
                    ActivityField(label: 'Send Token', value: '0x1234567890'),
                    ActivityField(label: 'Send Amount', value: '2.4 USDT'),
                    ActivityField(
                      label: 'Receive Amount',
                      value: '2.305068 USDC',
                    ),
                  ],
                  createdAt: DateTime.utc(2026),
                ),
              ]),
            ),
          ],
          child: buildTestApp(
            const ActivityScreen(initialCategory: ActivityCategory.cash),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('USDT'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('activity-title-transfer')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('activity-title-address-transfer')),
        findsOneWidget,
      );
      expect(find.text('1,000'), findsOneWidget);
      expect(find.text('1.607487'), findsOneWidget);
      expect(find.text('1,000 USDT'), findsNothing);
      expect(find.text('1.607487 USDT'), findsNothing);
      // Each operation appears only in its type badge, not again as a title.
      expect(find.text('Deposit'), findsOneWidget);
      expect(find.text('Transfer'), findsNWidgets(2));
      await tester.tap(find.text('USDT'));
      await tester.pumpAndSettle();
      expect(find.text('Tx Hash'), findsOneWidget);
      expect(find.text('1,000 USDT'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  for (final (
        source,
        sourceId,
        destination,
        destinationId,
        sourceLabel,
        destinationLabel,
      )
      in [
        ('BSC', '56', 'Hyperliquid', null, 'BNB Smart Chain', 'Hyperliquid'),
        ('Hyperliquid', null, 'Arbitrum', '42161', 'Hyperliquid', 'Arbitrum'),
        ('BSC', '97', 'Arbitrum', '421614', 'BSC Testnet', 'Arbitrum Sepolia'),
      ]) {
    testWidgets('cash flow $source to $destination uses endpoints on mobile', (
      tester,
    ) async {
      await configureDisplay(tester, size: const Size(393, 852));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            activityRepositoryProvider.overrideWithValue(
              _OrderActivityRepository([
                ActivityRecord(
                  id: 'flow',
                  category: ActivityCategory.cash,
                  type: 'bridge',
                  status: ActivityState.success,
                  title: 'Transfer',
                  asset: 'USDT',
                  chain: 'Ethereum',
                  context: 'Ethereum → Polygon',
                  amount: DecimalValue('4.95', asset: 'USDC'),
                  cashFlow: ActivityCashFlow(
                    source: ActivityCashFlowEndpoint(
                      asset: 'USDT',
                      chain: source,
                      chainId: sourceId,
                    ),
                    destination: ActivityCashFlowEndpoint(
                      asset: 'USDC',
                      chain: destination,
                      chainId: destinationId,
                    ),
                  ),
                  createdAt: DateTime.utc(2026),
                ),
              ]),
            ),
          ],
          child: buildTestApp(
            const ActivityScreen(initialCategory: ActivityCategory.cash),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('activity-title-flow')), findsOneWidget);
      final titleParagraph = tester.renderObject<RenderParagraph>(
        find
            .descendant(
              of: find.byKey(const ValueKey('activity-title-flow')),
              matching: find.byType(RichText),
            )
            .first,
      );
      // Use the room left by the amount and badge, including with the wider
      // synthetic font used by widget tests.
      final amountBounds = tester.getRect(find.text('4.95'));
      final titleBounds = tester.getRect(
        find.byKey(const ValueKey('activity-title-flow')),
      );
      final badgeBounds = tester.getRect(
        find
            .ancestor(
              of: find.text('Transfer'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(
        titleParagraph.constraints.maxWidth,
        closeTo(
          amountBounds.left - 8 - titleBounds.left - badgeBounds.width - 4,
          1,
        ),
      );
      expect(find.text(sourceLabel), findsNothing);
      expect(find.text(destinationLabel), findsNothing);
      final arrow = find.byIcon(Icons.arrow_forward);
      expect(arrow, findsNWidgets(2));
      final icons = find.descendant(
        of: find.byTooltip(sourceLabel),
        matching: find.byType(SvgPicture),
      );
      final pathArrow = tester.getCenter(arrow.last);
      expect(pathArrow.dy, closeTo(tester.getCenter(icons.first).dy, 0.01));
      await tester.tap(find.byKey(const ValueKey('activity-title-flow')));
      await tester.pumpAndSettle();
      expect(find.text('From'), findsOneWidget);
      expect(find.text('To'), findsOneWidget);
      expect(find.text('Details'), findsNothing);
      expect(find.text(sourceLabel), findsOneWidget);
      expect(find.text(destinationLabel), findsOneWidget);
      expect(find.text('Ethereum'), findsNothing);
      expect(find.text('Polygon'), findsNothing);
      expect(find.text('4.95'), findsOneWidget);
      expect(find.text('4.95 USDT'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('activity-title-flow')));
      await tester.pumpAndSettle();
      expect(find.text(sourceLabel), findsNothing);
      expect(find.text(destinationLabel), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('legacy cash keeps server title and only its evidence network', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityRepositoryProvider.overrideWithValue(
            _OrderActivityRepository([
              ActivityRecord(
                id: 'legacy',
                category: ActivityCategory.cash,
                type: 'bridge',
                status: ActivityState.success,
                title: 'USDT → USDC',
                asset: 'USDT',
                chain: 'Arbitrum',
                context: 'BSC → Hyperliquid',
                createdAt: DateTime.utc(2026),
              ),
            ]),
          ),
        ],
        child: buildTestApp(
          const ActivityScreen(initialCategory: ActivityCategory.cash),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('activity-title-legacy')), findsOneWidget);
    expect(find.text('Arbitrum'), findsNothing);
    expect(find.byTooltip('Arbitrum'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('activity-title-legacy')));
    await tester.pumpAndSettle();
    expect(find.text('Arbitrum'), findsOneWidget);
    expect(find.text('From'), findsNothing);
    expect(find.text('To'), findsNothing);
    expect(find.text('BNB Smart Chain'), findsNothing);
    expect(find.text('Hyperliquid'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final category in [ActivityCategory.cash, ActivityCategory.orders]) {
    for (final url in <String?>[
      'https://arbiscan.io/tx/0x1234567890abcdef',
      'http://arbiscan.io/tx/0x1234567890abcdef',
      'https://arbiscan.io/tx/failed',
      'https://arbiscan.io/tx/sdk-error',
      null,
      '',
      'javascript:alert(1)',
      'https:invalid',
    ]) {
      testWidgets(
        '$category transaction hash opens valid explorer or copies ($url)',
        (tester) async {
          await configureDisplay(tester, size: const Size(393, 852));
          final launches = <MethodCall>[];
          final clipboard = <MethodCall>[];
          const launcher = MethodChannel('plugins.flutter.io/url_launcher');
          tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            launcher,
            (call) async {
              launches.add(call);
              if (url?.endsWith('sdk-error') == true) {
                throw PlatformException(
                  code: 'open_failed',
                  message: 'No browser is available',
                );
              }
              return url?.endsWith('failed') != true;
            },
          );
          tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            SystemChannels.platform,
            (call) async {
              if (call.method == 'Clipboard.setData') clipboard.add(call);
              return null;
            },
          );
          addTearDown(() {
            tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
              launcher,
              null,
            );
            tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
              SystemChannels.platform,
              null,
            );
          });
          const hash = '0x1234567890abcdef';
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                authenticatedStateOverride,
                activityRepositoryProvider.overrideWithValue(
                  _OrderActivityRepository([
                    ActivityRecord(
                      id: 'explorer',
                      category: category,
                      type: 'transfer',
                      status: ActivityState.success,
                      title: 'USDC',
                      fields: const [
                        ActivityField(label: 'Transaction Hash', value: hash),
                      ],
                      txHash: hash,
                      explorer: url == null
                          ? null
                          : ActivityExplorer(name: 'Arbiscan', url: url),
                      createdAt: DateTime.utc(2026),
                    ),
                  ]),
                ),
              ],
              child: buildTestApp(ActivityScreen(initialCategory: category)),
            ),
          );
          await tester.pumpAndSettle();
          await tester.tap(
            find.byKey(const ValueKey('activity-title-explorer')),
          );
          await tester.pumpAndSettle();
          expect(find.text('Tx Hash'), findsOneWidget);
          if (url?.startsWith('https://') == true) {
            final link = find.byWidgetPredicate(
              (widget) =>
                  widget is Semantics &&
                  widget.properties.link == true &&
                  widget.properties.value == hash,
            );
            expect(link, findsOneWidget);
            expect(find.byIcon(Icons.copy_outlined), findsNothing);
            final icon = find.descendant(
              of: link,
              matching: find.byType(SvgPicture),
            );
            expect(tester.getSize(icon), const Size(14, 14));
            await tester.tap(link);
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));
            expect(launches.single.arguments['url'], url);
            expect(clipboard, isEmpty);
            if (url!.endsWith('failed')) {
              expect(
                find.text('Unable to open the transaction explorer.'),
                findsOneWidget,
              );
            }
            if (url.endsWith('sdk-error')) {
              expect(find.text('No browser is available'), findsOneWidget);
            }
          } else {
            expect(find.byIcon(Icons.copy_outlined), findsOneWidget);
            await tester.tap(find.byIcon(Icons.copy_outlined));
            await tester.pumpAndSettle();
            expect(clipboard.single.arguments['text'], hash);
            expect(launches, isEmpty);
          }
          expect(find.text('Tx Hash'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('activity numeric details follow shared decimal display rules', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    const cases = [
      ('Quantity', '0.002658915204319923', '0.00265892'),
      ('Filled quantity', '0.002658915204319923', '0.00265892'),
      ('Average price', '357.07554062055937712335', '357.075541'),
      ('Limit price', '1234567.123456789123456789', '1,234,567.123457'),
      ('Trigger price', '0.00000012345678912345', '0.000000123457'),
      ('Close price', '357.07554062055937712335', '357.075541'),
      ('Order amount', '0.002658915204319923 TSLAB', '0.00265892 TSLAB'),
      (
        'Filled',
        '0.002658915204319923 / 1.123456789 TSLAB',
        '0.00265892 / 1.123457 TSLAB',
      ),
      ('Fee', '0.00000012345678912345 USDC', '0.000000123457 USDC'),
    ];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityRepositoryProvider.overrideWithValue(
            _OrderActivityRepository([
              ActivityRecord(
                id: 'decimals',
                category: ActivityCategory.orders,
                type: 'market',
                status: ActivityState.success,
                title: 'TSLAB',
                fields: [
                  for (final entry in cases)
                    ActivityField(label: entry.$1, value: entry.$2),
                ],
                createdAt: DateTime.utc(2026),
              ),
            ]),
          ),
        ],
        child: buildTestApp(const ActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('activity-title-decimals')));
    await tester.pumpAndSettle();
    for (final entry in cases) {
      expect(find.text(entry.$3), findsWidgets);
      expect(find.text(entry.$2), findsNothing);
    }
    expect(find.byIcon(Icons.copy_outlined), findsNothing);
    expect(tester.takeException(), isNull);
  });

  for (final language in ['zh', 'en']) {
    for (final (side, chinese) in [
      ('Long', '做多'),
      ('Short', '做空'),
      ('Buy', '买入'),
      ('Sell', '卖出'),
    ]) {
      testWidgets('$side detail follows $language locale', (tester) async {
        await configureDisplay(tester, size: const Size(393, 852));
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authenticatedStateOverride,
              activityRepositoryProvider.overrideWithValue(
                _OrderActivityRepository([
                  ActivityRecord(
                    id: 'direction-order',
                    category: ActivityCategory.orders,
                    type: 'tpsl',
                    businessType: ActivityBusinessType.stopLoss,
                    status: ActivityState.pending,
                    title: 'Stop loss NVDA',
                    symbol: 'NVDA',
                    fields: [ActivityField(label: 'Side', value: side)],
                    createdAt: DateTime.utc(2026),
                  ),
                ]),
              ),
            ],
            child: buildTestApp(
              const ActivityScreen(),
              locale: Locale(language),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('NVDA'));
        await tester.pumpAndSettle();

        expect(find.text(language == 'zh' ? chinese : side), findsOneWidget);
        expect(find.text(language == 'zh' ? '方向' : 'Side'), findsOneWidget);
        if (language == 'zh') expect(find.text(side), findsNothing);
        expect(tester.takeException(), isNull);
      });
    }
  }

  for (final language in ['zh', 'en']) {
    testWidgets('order detail labels follow $language locale', (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      const labels = [
        ('Tx Hash', '交易哈希'),
        ('Quantity', '数量'),
        ('Limit price', '限价'),
        ('Filled quantity', '成交数量'),
        ('Average price', '成交均价'),
        ('Amount', '金额'),
        ('Status', '状态'),
      ];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            activityRepositoryProvider.overrideWithValue(
              _OrderActivityRepository([
                ActivityRecord(
                  id: 'localized-order',
                  category: ActivityCategory.orders,
                  type: 'limit',
                  status: ActivityState.success,
                  title: 'Sell AAPLB',
                  symbol: 'AAPLB',
                  fields: [
                    for (final pair in labels)
                      ActivityField(
                        label: pair.$1,
                        value: pair.$1 == 'Tx Hash'
                            ? '0x1234567890abcdef'
                            : '1',
                      ),
                    const ActivityField(label: 'Custom detail', value: '2'),
                  ],
                  createdAt: DateTime.utc(2026),
                ),
              ]),
            ),
          ],
          child: buildTestApp(const ActivityScreen(), locale: Locale(language)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('AAPLB'));
      await tester.pumpAndSettle();

      for (final (english, chinese) in labels) {
        // The existing English resource capitalizes Limit Price.
        final expected = language == 'zh'
            ? chinese
            : english == 'Limit price'
            ? 'Limit Price'
            : english;
        expect(find.text(expected), findsWidgets);
        if (language == 'zh') expect(find.text(english), findsNothing);
      }
      expect(find.text('Custom detail'), findsOneWidget);
      final copyLabel = find.byWidgetPredicate(
        (widget) =>
            widget is Semantics &&
            widget.properties.label ==
                (language == 'zh' ? '交易哈希' : 'Tx Hash') &&
            widget.properties.button == true,
      );
      expect(copyLabel, findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('manual close is labelled Close and shows close price and fee', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityRepositoryProvider.overrideWithValue(
            _OrderActivityRepository([
              ActivityRecord(
                id: 'close-1',
                category: ActivityCategory.orders,
                type: 'close',
                status: ActivityState.success,
                title: 'Close SNDK',
                businessType: ActivityBusinessType.closing,
                kind: 'perp',
                symbol: 'SNDK',
                asset: 'SNDK',
                amount: DecimalValue('0.006'),
                fields: const [
                  ActivityField(label: 'Side', value: 'Long'),
                  ActivityField(label: 'Close Price', value: '1706.67'),
                  ActivityField(label: 'Filled', value: '0.006 / 0.006 SNDK'),
                  ActivityField(label: 'Fee', value: '0.011862 USDC'),
                ],
                reference: const ActivityReference(type: 'order', id: 'o-1'),
                createdAt: DateTime.utc(2026),
              ),
            ]),
          ),
        ],
        child: buildTestApp(const ActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    // The badge must say Close — manual closes are not stop-losses.
    expect(find.text('Close'), findsWidgets);
    expect(find.text('Stop loss'), findsNothing);
    _expectBadgeColor(
      tester,
      'Close',
      AppTheme.light.extension<AppRwaColors>()!.textSecondary,
    );

    await tester.tap(find.text('SNDK'));
    await tester.pumpAndSettle();
    expect(find.text('Close Price'), findsOneWidget);
    expect(find.text('1,706.67'), findsOneWidget);
    expect(find.text('Fee'), findsOneWidget);
    expect(find.text('0.011862 USDC'), findsOneWidget);
    expect(find.text('Filled'), findsOneWidget);
    // Close does not include direction, so the detail row remains visible.
    expect(find.text('Side'), findsOneWidget);
    expect(find.text('Long'), findsOneWidget);
  });

  testWidgets('stop-loss legs still show Stop loss and bStocks orders show '
      'order fields without a Side row', (tester) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityRepositoryProvider.overrideWithValue(
            _OrderActivityRepository([
              ActivityRecord(
                id: 'sl-1',
                category: ActivityCategory.orders,
                type: 'tpsl',
                status: ActivityState.pending,
                title: 'Stop loss NVDA',
                businessType: ActivityBusinessType.stopLoss,
                kind: 'perp',
                symbol: 'NVDA',
                asset: 'NVDA',
                fields: const [
                  ActivityField(label: 'Side', value: 'Long'),
                  ActivityField(label: 'Trigger Price', value: '220'),
                ],
                reference: const ActivityReference(type: 'order', id: 'o-2'),
                createdAt: DateTime.utc(2026),
              ),
              ActivityRecord(
                id: 'bstocks-1',
                category: ActivityCategory.orders,
                type: 'limit',
                status: ActivityState.pending,
                title: 'Place bStocks limit order',
                kind: 'bstock',
                symbol: 'AAPL',
                asset: 'AAPL',
                fields: const [
                  ActivityField(label: 'Side', value: 'Buy'),
                  ActivityField(label: 'Limit Price', value: '50'),
                  ActivityField(label: 'Order Amount', value: '0.5 TUSDT'),
                  ActivityField(label: 'Filled', value: '0 / 0.01 AAPL'),
                ],
                reference: const ActivityReference(type: 'order', id: 'o-3'),
                createdAt: DateTime.utc(2026),
              ),
            ]),
          ),
        ],
        child: buildTestApp(const ActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Stop loss'), findsOneWidget);
    expect(find.text('Buy / Limit Price'), findsOneWidget);
    _expectBadgeColor(
      tester,
      'Stop loss',
      AppTheme.light.extension<AppSemanticColors>()!.danger,
    );
    _expectBadgeColor(
      tester,
      'Buy / Limit Price',
      AppTheme.light.extension<AppSemanticColors>()!.success,
    );

    await tester.tap(find.text('AAPL'));
    await tester.pumpAndSettle();
    expect(find.text('Limit Price'), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text('Order Amount'), findsOneWidget);
    expect(find.text('0.5 TUSDT'), findsOneWidget);
    expect(find.text('Filled'), findsWidgets);
    expect(find.text('Side'), findsNothing);
  });

  testWidgets('market and liquidation orders use accurate badges and keep '
      'Side when the badge has no direction', (tester) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          activityRepositoryProvider.overrideWithValue(
            _OrderActivityRepository([
              ActivityRecord(
                id: 'market-1',
                category: ActivityCategory.orders,
                type: 'market',
                status: ActivityState.success,
                title: 'Sell BTC',
                kind: 'perp',
                symbol: 'BTC',
                asset: 'BTC',
                fields: const [ActivityField(label: 'Side', value: 'Sell')],
                reference: const ActivityReference(type: 'order', id: 'o-4'),
                createdAt: DateTime.utc(2026, 1, 2),
              ),
              ActivityRecord(
                id: 'liquidation-1',
                category: ActivityCategory.orders,
                type: 'liquidation',
                status: ActivityState.success,
                title: 'Liquidation ETH',
                kind: 'perp',
                symbol: 'ETH',
                asset: 'ETH',
                fields: const [ActivityField(label: 'Side', value: 'Long')],
                reference: const ActivityReference(type: 'order', id: 'o-5'),
                createdAt: DateTime.utc(2026),
              ),
            ]),
          ),
        ],
        child: buildTestApp(const ActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sell / Market'), findsOneWidget);
    expect(find.text('Liquidation'), findsOneWidget);

    await tester.tap(find.text('ETH'));
    await tester.pumpAndSettle();
    expect(find.text('Side'), findsOneWidget);
    expect(find.text('Long'), findsOneWidget);
  });

  for (final width in [393.0, 700.0]) {
    testWidgets('long order amounts use remaining summary width ($width)', (
      tester,
    ) async {
      await configureDisplay(tester, size: Size(width, 852));
      const exactAmount = '0.001599537496322869';
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticatedStateOverride,
            activityRepositoryProvider.overrideWithValue(
              _OrderActivityRepository([
                ActivityRecord(
                  id: 'long-amount-1',
                  category: ActivityCategory.orders,
                  type: 'market',
                  status: ActivityState.success,
                  title: 'Buy NVDAB',
                  kind: 'bstock',
                  symbol: 'NVDAB',
                  asset: 'NVDAB',
                  amount: DecimalValue(
                    exactAmount,
                    asset: 'NVDAB',
                    unit: 'token',
                  ),
                  fields: const [ActivityField(label: 'Side', value: 'Buy')],
                  reference: const ActivityReference(
                    type: 'order',
                    id: 'o-long',
                  ),
                  createdAt: DateTime.utc(2026),
                ),
              ]),
            ),
          ],
          child: buildTestApp(const ActivityScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('NVDAB'), findsOneWidget);
      expect(find.text('NVDAB/NVDAB'), findsNothing);
      expect(find.text('Buy / Market'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('0.00159954 NVDAB'), findsOneWidget);
      expect(
        tester.getRect(find.text('Buy / Market')).right,
        lessThanOrEqualTo(tester.getRect(find.text('0.00159954 NVDAB')).left),
      );
      if (width == 700) {
        final paragraph = tester.renderObject<RenderParagraph>(
          find.descendant(
            of: find.text('0.00159954 NVDAB'),
            matching: find.byType(RichText),
          ),
        );
        expect(paragraph.didExceedMaxLines, isFalse);
        expect(paragraph.constraints.maxWidth, greaterThan((width - 32) * 0.4));
      }
      final activityCard = find.ancestor(
        of: find.text('0.00159954 NVDAB'),
        matching: find.byType(Card),
      );
      expect(
        tester.getRect(find.text('0.00159954 NVDAB')).right,
        closeTo(tester.getRect(activityCard).right - 16, 0.01),
      );
    });
  }
}

void _expectBadgeColor(WidgetTester tester, String label, Color color) {
  final badge = find.byWidgetPredicate(
    (widget) =>
        widget is Text && widget.data == label && widget.style?.fontSize == 12,
  );
  expect(badge, findsOneWidget);
  expect(tester.widget<Text>(badge).style?.color, color);
  final container = tester.widget<Container>(
    find.ancestor(of: badge, matching: find.byType(Container)).first,
  );
  expect(
    (container.decoration! as BoxDecoration).color,
    color.withValues(alpha: .12),
  );
}

final class _OrderActivityRepository implements ActivityRepository {
  _OrderActivityRepository(this.records);
  final List<ActivityRecord> records;

  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    return DomainPage(items: records);
  }
}
