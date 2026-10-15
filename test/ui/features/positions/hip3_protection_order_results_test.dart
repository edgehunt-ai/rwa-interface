import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:nobell/ui/features/positions/views/hip3_protection_order_results.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final locale in ['en', 'zh']) {
    testWidgets('batch results preserve mixed per-order outcomes in $locale', (
      tester,
    ) async {
      final parameters = Hip3ProtectionParameters(
        role: 'stopLoss',
        triggerPrice: DecimalValue('90.125000000000000001'),
        quantity: DecimalValue('0.250000000000000001'),
        limitPrice: DecimalValue('89.500000000000000001'),
      );
      await tester.pumpWidget(
        buildTestApp(
          SingleChildScrollView(
            child: Hip3ProtectionOrderResults(
              orders: [
                Hip3ProtectionOrderResult(
                  stepId: 'cancel',
                  changeIndex: 0,
                  orderId: 'old-order',
                  protection: parameters,
                  status: 'confirmed',
                  isCancellation: true,
                ),
                Hip3ProtectionOrderResult(
                  stepId: 'place',
                  changeIndex: 0,
                  orderId: 'new-failed',
                  replacedOrderId: 'old-order',
                  protection: parameters,
                  status: 'rejected',
                  isCancellation: false,
                  failureReason: 'Venue rejected price',
                ),
                Hip3ProtectionOrderResult(
                  stepId: 'place',
                  changeIndex: 1,
                  orderId: 'new-unknown',
                  protection: parameters,
                  status: 'acknowledged',
                  isCancellation: false,
                ),
                Hip3ProtectionOrderResult(
                  stepId: 'place',
                  changeIndex: 2,
                  orderId: 'new-confirmed',
                  protection: parameters,
                  status: 'confirmed',
                  isCancellation: false,
                ),
              ],
            ),
          ),
          locale: Locale(locale),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text(locale == 'zh' ? '已确认取消' : 'Cancellation confirmed'),
        findsOneWidget,
      );
      expect(find.text(locale == 'zh' ? '失败' : 'Failed'), findsOneWidget);
      expect(
        find.text(locale == 'zh' ? '等待确认' : 'Waiting for confirmation'),
        findsOneWidget,
      );
      expect(find.text(locale == 'zh' ? '已确认成功' : 'Confirmed'), findsOneWidget);
      expect(find.text('Venue rejected price'), findsOneWidget);
      expect(find.text('old-order'), findsNWidgets(2));
      expect(find.textContaining('0.250000000000000001'), findsNWidgets(4));
      expect(
        find.textContaining(
          locale == 'zh'
              ? '触发价格：90.125000000000000001'
              : 'Trigger price: 90.125000000000000001',
        ),
        findsNWidgets(4),
      );
      expect(find.textContaining('Closure:'), findsNothing);
      expect(find.textContaining('90.125000000000000001'), findsNWidgets(4));
      expect(find.textContaining('89.500000000000000001'), findsNWidgets(4));
      expect(tester.takeException(), isNull);
    });
  }
}
