import 'decimal_value.dart';

final class WithdrawalIntent {
  const WithdrawalIntent({
    required this.chain,
    required this.amount,
    required this.address,
    this.memo,
  });
  final String chain;
  final DecimalValue amount;
  final String address;
  final String? memo;
  String get fingerprint => '$chain|${amount.value}|$address|$memo';
}

final class WithdrawalQuote {
  const WithdrawalQuote({
    required this.quoteId,
    required this.intent,
    required this.totalFee,
    required this.estimatedReceive,
    required this.sufficient,
  });
  final String quoteId;
  final WithdrawalIntent intent;
  final DecimalValue totalFee;
  final DecimalValue estimatedReceive;
  final bool sufficient;
}

enum WalletAuthorizationState {
  pending,
  authorized,
  consumed,
  expired,
  failed,
  unknown,
}

final class WalletAuthorization {
  const WalletAuthorization({
    required this.authorizationId,
    required this.walletId,
    required this.status,
    required this.expiresAt,
  });
  final String authorizationId;
  final String walletId;
  final WalletAuthorizationState status;
  final DateTime expiresAt;
  bool get isUsable =>
      status == WalletAuthorizationState.authorized &&
      expiresAt.isAfter(DateTime.now().toUtc());
}

enum WithdrawalState {
  pendingSignature,
  processing,
  sent,
  completed,
  failed,
  ambiguous,
  manualReview,
  unknown,
}

final class Withdrawal {
  const Withdrawal({
    required this.withdrawalId,
    required this.chain,
    required this.amount,
    required this.status,
    this.receivedAmount,
    this.totalFee,
    this.address,
    this.txHash,
    this.failureReason,
    this.createdAt,
  });
  final String withdrawalId;
  final String chain;
  final DecimalValue amount;
  final DecimalValue? receivedAmount;
  final DecimalValue? totalFee;
  final String? address;
  final WithdrawalState status;
  final String? txHash;
  final String? failureReason;
  final DateTime? createdAt;
}
