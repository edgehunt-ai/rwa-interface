import 'decimal_value.dart';
import 'self_custodial_withdrawal.dart';

final class WithdrawableAsset {
  const WithdrawableAsset({
    required this.symbol,
    required this.chain,
    required this.balance,
    this.valueUsd,
    this.decimals,
    this.assetId,
    this.walletId,
    this.contractAddress,
    this.native = false,
  });

  final String symbol;
  final String chain;
  final DecimalValue balance;
  final DecimalValue? valueUsd;
  final int? decimals;
  final String? assetId;
  final String? walletId;
  final String? contractAddress;
  final bool native;

  String get key => '$symbol|$chain';
  bool get isWithdrawalSupported => symbol == 'USDC' && !native;
}

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

final class SelfCustodialWithdrawalTransaction {
  const SelfCustodialWithdrawalTransaction({
    required this.chainId,
    required this.from,
    required this.to,
    required this.data,
    required this.value,
    required this.payloadHash,
    required this.validUntil,
  });

  final int chainId;
  final String from;
  final String to;
  final String data;
  final String value;
  final String payloadHash;
  final DateTime validUntil;
}

final class PreparedSelfCustodialWithdrawal {
  const PreparedSelfCustodialWithdrawal({
    required this.withdrawalId,
    required this.sourceWalletId,
    required this.assetId,
    required this.assetSymbol,
    required this.chain,
    required this.amount,
    required this.destinationAddress,
    required this.transaction,
    required this.status,
  });

  final String withdrawalId;
  final String sourceWalletId;
  final String assetId;
  final String assetSymbol;
  final String chain;
  final DecimalValue amount;
  final String destinationAddress;
  final SelfCustodialWithdrawalTransaction transaction;
  final SelfCustodialWithdrawalState status;
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
