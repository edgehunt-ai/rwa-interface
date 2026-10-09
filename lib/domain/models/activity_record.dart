import 'decimal_value.dart';

enum ActivityCategory { orders, cash, funding, unknown }

enum ActivityState { pending, success, failed, cancelled, unknown }

enum ActivityBusinessType { opening, closing, takeProfit, stopLoss, unknown }

final class ActivityReference {
  const ActivityReference({required this.type, required this.id});
  final String type;
  final String id;
}

final class ActivityField {
  const ActivityField({required this.label, required this.value, this.tone});
  final String label;
  final String value;
  final String? tone;
}

final class ActivityContinuation {
  const ActivityContinuation({
    required this.action,
    required this.orderId,
    required this.step,
    required this.requiresNewBusinessObject,
    this.actionId,
  });

  final String action;
  final String orderId;
  final String? actionId;
  final String step;
  final bool requiresNewBusinessObject;
}

final class ActivityExplorer {
  const ActivityExplorer({required this.name, required this.url});

  final String name;
  final String url;
}

final class ActivityRecord {
  const ActivityRecord({
    required this.id,
    required this.category,
    required this.type,
    required this.status,
    required this.title,
    this.businessType,
    this.rawStatus,
    required this.createdAt,
    this.amount,
    this.context,
    this.failureReason,
    this.reference,
    this.fields = const [],
    this.relatedId,
    this.selfCustodialWithdrawalId,
    this.continuation,
    this.chain,
    this.txHash,
    this.explorer,
    this.asset,
    this.symbol,
    this.kind,
    this.updatedAt,
  });
  final String id;
  final ActivityCategory category;
  final String type;
  final ActivityState status;
  final String title;
  final ActivityBusinessType? businessType;

  /// The API status wire value, retained until presentation supports every
  /// server status (including `manual_review`).
  final String? rawStatus;
  final DecimalValue? amount;
  final String? context;
  final String? failureReason;
  final ActivityReference? reference;
  final List<ActivityField> fields;
  final String? relatedId;
  final String? selfCustodialWithdrawalId;
  final ActivityContinuation? continuation;
  final String? chain;
  final String? txHash;
  final ActivityExplorer? explorer;
  final String? asset;
  final String? symbol;
  final String? kind;
  final DateTime createdAt;
  final DateTime? updatedAt;
}
