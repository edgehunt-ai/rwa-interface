import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/limit_price_loss.dart';
import 'package:nobell/ui/features/orders/views/limit_price_loss_notice.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('large losses render as plain decimal amounts', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const LimitPriceLossNotice(
          loss: LimitPriceLoss(
            direction: LimitPriceLossDirection.aboveMarket,
            deviationPercent: 1,
            estimatedLoss: 1e21,
          ),
          settlementAsset: 'USDT',
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(
      find.textContaining('~1,000,000,000,000,000,000,000 USDT'),
      findsOneWidget,
    );
  });

  test('large signed deviations preserve their sign', () {
    expect(formatLimitPriceDeviation(1e21), '+1,000,000,000,000,000,000,000%');
    expect(formatLimitPriceDeviation(-1e21), '-1,000,000,000,000,000,000,000%');
    expect(formatLimitPriceDeviation(0.01), '+0.01%');
  });
}
