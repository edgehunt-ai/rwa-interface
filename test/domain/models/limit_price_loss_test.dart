import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/limit_price_loss.dart';

void main() {
  group('assessLimitPriceLoss', () {
    test('warns for any buy price above market', () {
      final loss = assessLimitPriceLoss(
        isBuy: true,
        limitPrice: 100.01,
        marketPrice: 100,
        quantity: 2,
      );

      expect(loss, isNotNull);
      expect(loss!.direction, LimitPriceLossDirection.aboveMarket);
      expect(loss.deviationPercent, closeTo(0.01, 1e-10));
      expect(loss.estimatedLoss, closeTo(0.02, 1e-10));
    });

    test('does not warn at the market price', () {
      expect(
        assessLimitPriceLoss(
          isBuy: true,
          limitPrice: 100,
          marketPrice: 100,
          quantity: 2,
        ),
        isNull,
      );
    });

    test('warns for any sell price below market', () {
      final loss = assessLimitPriceLoss(
        isBuy: false,
        limitPrice: 99.99,
        marketPrice: 100,
        quantity: 3,
      );

      expect(loss, isNotNull);
      expect(loss!.direction, LimitPriceLossDirection.belowMarket);
      expect(loss.deviationPercent, closeTo(0.01, 1e-10));
      expect(loss.estimatedLoss, closeTo(0.03, 1e-10));
    });

    test('ignores favorable prices and invalid inputs', () {
      expect(
        assessLimitPriceLoss(
          isBuy: true,
          limitPrice: 90,
          marketPrice: 100,
          quantity: 1,
        ),
        isNull,
      );
      expect(
        assessLimitPriceLoss(
          isBuy: false,
          limitPrice: 110,
          marketPrice: 100,
          quantity: 1,
        ),
        isNull,
      );
      expect(
        assessLimitPriceLoss(
          isBuy: true,
          limitPrice: 105,
          marketPrice: 0,
          quantity: 1,
        ),
        isNull,
      );
    });
  });
}
