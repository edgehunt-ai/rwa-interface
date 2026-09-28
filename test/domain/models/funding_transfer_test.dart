import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';

void main() {
  group('FundingPlan.isExecuting', () {
    test('recognizes executing and partially funded plans', () {
      expect(_plan(FundingPlanState.executing).isExecuting, isTrue);
      expect(_plan(FundingPlanState.partiallyFunded).isExecuting, isTrue);
      expect(_plan(FundingPlanState.ready).isExecuting, isFalse);
    });
  });

  group('FundingLeg.isActionable', () {
    test('allows a planned leg before its transfer is created', () {
      expect(_leg(status: FundingLegState.planned).isActionable, isTrue);
    });

    test('keeps actionReleased compatible before transfer creation', () {
      expect(_leg(status: FundingLegState.actionReleased).isActionable, isTrue);
    });

    test('does not recreate a transfer for a leg with a transfer ID', () {
      expect(
        _leg(
          status: FundingLegState.planned,
          transferId: 'transfer-1',
        ).isActionable,
        isFalse,
      );
    });

    test('does not allow a submitted leg', () {
      expect(_leg(status: FundingLegState.submitted).isActionable, isFalse);
    });
  });
}

FundingPlan _plan(FundingPlanState status) => FundingPlan(
  planId: 'plan-1',
  tradePreviewId: 'preview-1',
  shortfall: DecimalValue('5'),
  status: status,
);

FundingLeg _leg({required FundingLegState status, String? transferId}) =>
    FundingLeg(
      legId: 'leg-1',
      walletId: 'wallet-1',
      asset: 'USDC',
      maximumAmount: DecimalValue('5', asset: 'USDC', unit: 'token'),
      outputAmount: DecimalValue('5', asset: 'USDT', unit: 'token'),
      status: status,
      transferId: transferId,
    );
