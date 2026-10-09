//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {

  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'pending_signature')
  static const OrderStatus pendingSignature = _$pendingSignature;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'submitted')
  static const OrderStatus submitted = _$submitted;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'open')
  static const OrderStatus open = _$open;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'partially_filled')
  static const OrderStatus partiallyFilled = _$partiallyFilled;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'filled')
  static const OrderStatus filled = _$filled;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const OrderStatus cancelled = _$cancelled;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'failed')
  static const OrderStatus failed = _$failed;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const OrderStatus ambiguous = _$ambiguous;
  /// HIP3 业务订单状态保持原协议；bStocks 使用独立 BstockOrderStatus，动作状态另查 OrderAction。
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const OrderStatus manualReview = _$manualReview;

  static Serializer<OrderStatus> get serializer => _$orderStatusSerializer;

  const OrderStatus._(String name): super(name);

  static BuiltSet<OrderStatus> get values => _$values;
  static OrderStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class OrderStatusMixin = Object with _$OrderStatusMixin;

