import 'decimal_value.dart';

final class TradeIntentExecutionPolicy {
  const TradeIntentExecutionPolicy({
    required this.limitPrice,
    required this.executeBefore,
  });

  final DecimalValue limitPrice;
  final DateTime executeBefore;
}

final class TradeIntentCreateInput {
  const TradeIntentCreateInput({
    required this.previewId,
    required this.authorizationId,
    required this.executionPolicy,
  });

  final String previewId;
  final String authorizationId;
  final TradeIntentExecutionPolicy executionPolicy;

  String get fingerprint =>
      '$previewId|$authorizationId|${executionPolicy.limitPrice.value}|'
      '${executionPolicy.executeBefore.toUtc().toIso8601String()}';
}

final class TradeIntentFundingLeg {
  const TradeIntentFundingLeg({
    required this.legId,
    required this.ordinal,
    required this.status,
    this.transferId,
  });

  final String legId;
  final int ordinal;
  final String status;
  final String? transferId;
}

final class TradeIntent {
  const TradeIntent({
    required this.tradeIntentId,
    required this.previewId,
    required this.authorizationId,
    required this.productId,
    required this.status,
    required this.nextAction,
    required this.executionPolicy,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
    this.blocker,
    this.fundingPlanId,
    this.transferId,
    this.fundingLegs = const [],
    this.orderId,
  });

  final String tradeIntentId;
  final String previewId;
  final String authorizationId;
  final String productId;
  final String status;
  final String nextAction;
  final String? blocker;
  final TradeIntentExecutionPolicy executionPolicy;
  final String? fundingPlanId;
  final String? transferId;
  final List<TradeIntentFundingLeg> fundingLegs;
  final String? orderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expiresAt;

  bool get isTerminal => const {
    'order_created',
    'expired',
    'cancelled',
    'failed',
    'manual_review',
  }.contains(status);
}
