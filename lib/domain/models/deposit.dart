import 'decimal_value.dart';

enum DepositState {
  awaiting,
  confirming,
  credited,
  failed,
  ambiguous,
  manualReview,
  unknown,
}

final class DepositInstructions {
  const DepositInstructions({required this.address, this.memo});
  final String address;
  final String? memo;
}

final class DepositInstruction {
  const DepositInstruction({
    required this.chain,
    required this.token,
    required this.tokenContract,
    required this.tokenDecimals,
    required this.address,
    required this.qrPayload,
    required this.minimumAmount,
    required this.confirmationsRequired,
    required this.estimatedArrivalSeconds,
    required this.warning,
    this.memo,
  });

  final String chain;
  final String token;
  final String tokenContract;
  final int tokenDecimals;
  final String address;
  final String? memo;
  final String qrPayload;
  final DecimalValue minimumAmount;
  final int confirmationsRequired;
  final int estimatedArrivalSeconds;
  final String warning;
}

final class Deposit {
  const Deposit({
    required this.depositId,
    required this.chain,
    required this.token,
    required this.status,
    required this.instructions,
    this.amount,
    this.confirmations,
    this.confirmationsRequired,
    this.requiresTransfer = false,
    this.txHash,
    this.createdAt,
  });
  final String depositId;
  final String chain;
  final String token;
  final DecimalValue? amount;
  final DepositState status;
  final DepositInstructions instructions;
  final int? confirmations;
  final int? confirmationsRequired;
  final bool requiresTransfer;
  final String? txHash;
  final DateTime? createdAt;
}
