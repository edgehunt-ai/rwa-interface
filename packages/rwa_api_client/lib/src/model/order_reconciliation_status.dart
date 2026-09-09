//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_reconciliation_status.g.dart';

class OrderReconciliationStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending')
  static const OrderReconciliationStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'matched')
  static const OrderReconciliationStatus matched = _$matched;
  @BuiltValueEnumConst(wireName: r'conflicting')
  static const OrderReconciliationStatus conflicting = _$conflicting;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const OrderReconciliationStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderReconciliationStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<OrderReconciliationStatus> get serializer =>
      _$orderReconciliationStatusSerializer;

  const OrderReconciliationStatus._(String name) : super(name);

  static BuiltSet<OrderReconciliationStatus> get values => _$values;
  static OrderReconciliationStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class OrderReconciliationStatusMixin = Object
    with _$OrderReconciliationStatusMixin;
