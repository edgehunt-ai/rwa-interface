import 'decimal_value.dart';

enum DepositObservationState {
  detected,
  confirming,
  confirmed,
  manualReview,
  unknown,
}

final class DepositObservation {
  const DepositObservation({
    required this.observationId,
    required this.chain,
    required this.asset,
    required this.amount,
    required this.status,
    required this.confirmations,
    required this.confirmationsRequired,
    required this.txHash,
    required this.detectedAt,
    required this.updatedAt,
    this.confirmedAt,
    this.depositId,
  });
  final String observationId;
  final String chain;
  final String asset;
  final DecimalValue amount;
  final DepositObservationState status;
  final int confirmations;
  final int confirmationsRequired;
  final String txHash;
  final DateTime detectedAt;
  final DateTime updatedAt;
  final DateTime? confirmedAt;
  final String? depositId;
}
