import 'order_preview.dart';

final class Hip3WithdrawalFeeDetail {
  const Hip3WithdrawalFeeDetail({
    required this.type,
    required this.amount,
    required this.currency,
    required this.payer,
  });

  final String type;
  final String? amount;
  final String currency;
  final String payer;
}

final class Hip3WithdrawalPreview {
  const Hip3WithdrawalPreview({
    required this.amount,
    required this.fee,
    required this.minimumReceived,
    required this.rail,
    required this.destinationAddress,
    required this.chainId,
    required this.maximumTransferable,
    required this.blockers,
    required this.estimatedArrivalSeconds,
    required this.feeDetails,
    required this.crossLiquidationImpacts,
    required this.riskStatus,
    this.riskValidUntil,
    this.riskUnavailableReason,
  });

  final String amount;
  final String fee;
  final String minimumReceived;
  final String rail;
  final String destinationAddress;
  final String chainId;
  final String maximumTransferable;
  final List<String> blockers;
  final int estimatedArrivalSeconds;
  final List<Hip3WithdrawalFeeDetail> feeDetails;
  final List<Hip3CrossLiquidationImpact> crossLiquidationImpacts;
  final String riskStatus;
  final DateTime? riskValidUntil;
  final String? riskUnavailableReason;

  bool get canProceed => blockers.isEmpty;
}
