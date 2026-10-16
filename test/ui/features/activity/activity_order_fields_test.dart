import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
      AppTheme.light.extension<AppRwaColors>()!.secondaryText,
    );

    await tester.tap(find.text('SNDK'));
    await tester.pumpAndSettle();
    expect(find.text('Close Price'), findsOneWidget);
    expect(find.text('1706.67'), findsOneWidget);
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
    _expectBadgeColor(tester, 'Stop loss', kShortTradeColor);
    _expectBadgeColor(tester, 'Buy / Limit Price', const Color(0xFF04A08B));

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

  testWidgets('long order amounts do not collapse the order summary', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
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
                reference: const ActivityReference(type: 'order', id: 'o-long'),
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
