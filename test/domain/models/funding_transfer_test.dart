import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/funding_session.dart';

void main() {
  for (final state in [
    FundingPlanState.failed,
    FundingPlanState.manualReview,
    FundingPlanState.cancelled,
    FundingPlanState.expired,
  ]) {
    test('$state retaining transfer identity never waits for arrival', () {
      final plan = FundingPlan(
        planId: 'plan-1',
        tradePreviewId: 'preview-1',
        shortfall: DecimalValue('5'),
        status: state,
        legs: [
          _leg(status: FundingLegState.submitted, transferId: 'transfer-1'),
        ],
      );
      expect(plan.shouldPoll, isFalse);
      expect(plan.isActionable, isFalse);
      expect(plan.legs.single.transferId, 'transfer-1');
    });
  }

  test(
    'partial funding without an active leg remains partial, not in transit',
    () {
      final plan = FundingPlan(
        planId: 'partial-plan',
        tradePreviewId: 'preview-1',
        shortfall: DecimalValue('0.000000000000000001'),
        status: FundingPlanState.partiallyFunded,
        legs: [
          _leg(status: FundingLegState.completed, transferId: 'settled-leg'),
        ],
      );
      expect(plan.shouldPoll, isFalse);
      expect(plan.status, FundingPlanState.partiallyFunded);
      expect(plan.shortfall.value, '0.000000000000000001');
    },
  );

  for (final state in FundingTransferState.values) {
    test('$state does not confuse source acceptance with settlement', () {
      final transfer = FundingTransfer(
        transferId: 'transfer-1',
        planId: 'plan-1',
        amount: DecimalValue('5'),
        status: state,
        nextActionId: 'action-1',
        providerStatus: 'succeeded',
      );
      expect(transfer.isCompleted, state == FundingTransferState.completed);
      expect(
        transfer.canExecuteNextAction,
        [
          FundingTransferState.awaitingAuthorization,
          FundingTransferState.awaitingWallet,
          FundingTransferState.originConfirmed,
          FundingTransferState.filling,
        ].contains(state),
      );
    });
  }

  test('manual review overrides a stale confirmation capability', () {
    final session = FundingSessionSummary(
      sessionId: 'session-1',
      status: 'manualReview',
      version: 2,
      canConfirmTransfer: true,
      expiresAt: DateTime.utc(2027),
    );
    expect(session.requiresReview, isTrue);
    expect(session.canSubmit, isFalse);
  });
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
