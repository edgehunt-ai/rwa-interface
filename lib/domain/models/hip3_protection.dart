import 'decimal_value.dart';

enum ProtectionChangeOperation { create, modify, cancel }

/// Complete parameters for one TP or SL; an omitted quantity means native full
/// position coverage, rather than a snapshot of the current position size.
final class Hip3ProtectionParameters {
  const Hip3ProtectionParameters({
    required this.role,
    required this.triggerPrice,
    this.quantity,
    this.percent,
    this.limitPrice,
    this.triggerReference = 'mark',
  });

  final String role;
  final DecimalValue triggerPrice;
  final DecimalValue? quantity;
  final DecimalValue? percent;
  final DecimalValue? limitPrice;
  final String triggerReference;
  String get sizeMode => quantity != null
      ? 'quantity'
      : percent != null
      ? 'percent'
      : 'entirePosition';
  String get executionType => limitPrice == null ? 'market' : 'limit';
}

final class Hip3ProtectionChange {
  const Hip3ProtectionChange.create(Hip3ProtectionParameters parameters)
    : operation = ProtectionChangeOperation.create,
      orderId = null,
      protection = parameters;
  const Hip3ProtectionChange.modify({
    required this.orderId,
    required this.protection,
  }) : operation = ProtectionChangeOperation.modify;
  const Hip3ProtectionChange.cancel(this.orderId)
    : operation = ProtectionChangeOperation.cancel,
      protection = null;

  final ProtectionChangeOperation operation;
  final String? orderId;
  final Hip3ProtectionParameters? protection;
}

final class Hip3PositionProtectionOrder {
  const Hip3PositionProtectionOrder({
    required this.orderId,
    required this.protection,
  });
  final String orderId;
  final Hip3ProtectionParameters protection;
}

/// A step can confirm cancellation while a later replacement fails. Preserve
/// each step's outcome instead of collapsing it into an action-wide success.
final class Hip3ProtectionOrderResult {
  const Hip3ProtectionOrderResult({
    required this.stepId,
    required this.changeIndex,
    required this.orderId,
    required this.protection,
    required this.status,
    required this.isCancellation,
    this.replacedOrderId,
    this.failureReason,
  });
  final String stepId;
  final int changeIndex;
  final String orderId;
  final String? replacedOrderId;
  final Hip3ProtectionParameters protection;
  final String status;
  final bool isCancellation;
  final String? failureReason;

  bool get isConfirmed => status == 'confirmed';
  bool get isFailed =>
      const {'rejected', 'cancelled', 'expired'}.contains(status);
}
