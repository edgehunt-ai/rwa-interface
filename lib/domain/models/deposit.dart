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
