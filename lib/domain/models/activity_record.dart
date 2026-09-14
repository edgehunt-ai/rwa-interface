import 'decimal_value.dart';

enum ActivityCategory { orders, funds, signatures, unknown }

enum ActivityState { pending, success, failed, cancelled, unknown }

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
    this.fields = const [],
    this.chain,
    this.txHash,
    this.asset,
    this.updatedAt,
  });
  final String id;
  final ActivityCategory category;
  final String type;
  final ActivityState status;
  final String title;
  final DecimalValue? amount;
  final String? context;
  final ActivityReference? reference;
  final List<ActivityField> fields;
  final String? chain;
  final String? txHash;
  final String? asset;
  final DateTime createdAt;
  final DateTime? updatedAt;
}
