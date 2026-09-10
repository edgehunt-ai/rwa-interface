import 'decimal_value.dart';

enum ActivityCategory { orders, funds, signatures, unknown }

enum ActivityState { pending, success, failed, cancelled, unknown }

/// Server-proven HIP3 order purpose, distinct from order type and status.
enum ActivityBusinessType { opening, closing, takeProfit, stopLoss, unknown }

final class ActivityReference {
  const ActivityReference({required this.type, required this.id});
  final String type;
  final String id;
}

final class ActivityRecord {
  const ActivityRecord({
    required this.id,
    required this.category,
    required this.type,
    required this.status,
    required this.title,
    required this.createdAt,
    this.amount,
    this.context,
    this.reference,
    this.updatedAt,
    this.businessType,
  });
  final String id;
  final ActivityCategory category;
  final String type;
  final ActivityState status;
  final String title;
  final DecimalValue? amount;
  final String? context;
  final ActivityReference? reference;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final ActivityBusinessType? businessType;
}
