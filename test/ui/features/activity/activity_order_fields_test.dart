import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/repositories/activity_repository.dart';
import 'package:rwa_interface/ui/features/activity/views/activity_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
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

    await tester.tap(find.text('SNDK/SNDK'));
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

    await tester.tap(find.text('AAPL/AAPL'));
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

    await tester.tap(find.text('ETH/ETH'));
    await tester.pumpAndSettle();
    expect(find.text('Side'), findsOneWidget);
    expect(find.text('Long'), findsOneWidget);
  });
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
