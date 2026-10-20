import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/hip3_withdrawal.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/withdrawal.dart';

void main() {
  test('only actual completed withdrawal states establish success', () {
    for (final state in WithdrawalState.values) {
      final withdrawal = Withdrawal(
        withdrawalId: 'id', chain: 'Arbitrum', amount: DecimalValue('1'),
        status: state, txHash: '0xsubmitted',
      );
      expect(withdrawal.isCompleted, state == WithdrawalState.completed);
    }
    for (final state in SelfCustodialWithdrawalState.values) {
      final withdrawal = _self(state);
      expect(withdrawal.isCompleted, state == SelfCustodialWithdrawalState.confirmed);
      expect(withdrawal.shouldPoll, [
        SelfCustodialWithdrawalState.submitted,
        SelfCustodialWithdrawalState.confirming,
      ].contains(state));
    }
  });

  test('HIP submitted, payout, review, refund and partial are not success', () {
    for (final status in [
      'awaiting_signature', 'submitting', 'submitted', 'payout',
      'manual_review', 'ambiguous', 'unknown', 'unresolved', 'recovering',
      'refund_pending', 'refunded', 'credited', 'partial', 'failed', 'expired',
    ]) {
      final withdrawal = _hip(status);
      expect(withdrawal.isCompleted, isFalse, reason: status);
      expect(withdrawal.status, status);
    }
    expect(_hip('completed').isCompleted, isTrue);
  });

  test('manual review stops polling even with retained payout evidence', () {
    for (final status in ['payout', 'failed', 'completed', 'manual_review']) {
      final withdrawal = _hip(status, reason: 'requires_manual_review');
      expect(withdrawal.requiresManualReview, isTrue);
      expect(withdrawal.isCompleted, isFalse);
      expect(withdrawal.shouldPoll, isFalse);
      expect(withdrawal.payoutTxHash, '0xpayout');
    }
    expect(_hip('manual_review').requiresManualReview, isTrue);
    expect(_self(SelfCustodialWithdrawalState.submitted,
      reason: 'reconciliation_required').shouldPoll, isFalse);
    expect(_self(SelfCustodialWithdrawalState.confirmed,
      reason: 'reconciliation_required').isCompleted, isFalse);
  });

  test('unresolved requests stay pending but do not poll forever', () {
    for (final status in ['ambiguous', 'partial', 'unknown', 'manual_review']) {
      expect(_hip(status).isPending, isTrue);
      expect(_hip(status).shouldPoll, isFalse);
    }
    expect(_hip('refund_pending').shouldPoll, isTrue);
    expect(_hip('refunded').shouldPoll, isFalse);
    expect(_hip('credited').shouldPoll, isFalse);
  });
}

Hip3Withdrawal _hip(String status, {String? reason}) => Hip3Withdrawal(
  id: 'immutable-id', ownerAddress: 'owner', destinationAddress: 'owner',
  amount: '9007199254740993.123456', fee: '0.000001',
  minimumReceived: '9007199254740993.123455', status: status, rail: 'float',
  expiresAt: DateTime.utc(2026), payoutTxHash: '0xpayout',
  confirmedAt: DateTime.utc(2026), failureReason: reason,
);

SelfCustodialWithdrawalSummary _self(SelfCustodialWithdrawalState status,
  {String? reason}) => SelfCustodialWithdrawalSummary(
  withdrawalId: 'immutable-id', assetSymbol: 'USDC',
  amount: DecimalValue('1.000001'), destinationAddress: 'destination',
  status: status, txHash: '0xsubmitted', confirmations: 100,
  requiredConfirmations: 10, manualReviewReason: reason,
);
