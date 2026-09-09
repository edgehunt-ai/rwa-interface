import 'decimal_value.dart';
import 'order_intent.dart';

final class OrderPreview {
  const OrderPreview({
    required this.previewId,
    required this.intent,
    required this.orderValue,
    this.marketPrice,
    this.estimatedPrice,
    this.estimatedQuantity,
    this.estimatedReceive,
    this.fee,
    this.marginRequired,
    this.liquidationPrice,
    this.settlementAsset,
    this.priceUpdated = false,
    this.expiresAt,
  });
  final String previewId;
  final OrderIntent intent;
  final DecimalValue orderValue;
  final DecimalValue? marketPrice;
  final DecimalValue? estimatedPrice;
  final DecimalValue? estimatedQuantity;
  final DecimalValue? estimatedReceive;
  final DecimalValue? fee;
  final DecimalValue? marginRequired;
  final DecimalValue? liquidationPrice;
  final String? settlementAsset;
  final bool priceUpdated;
  final DateTime? expiresAt;
  bool get isExpired => expiresAt?.isBefore(DateTime.now().toUtc()) ?? false;
}
