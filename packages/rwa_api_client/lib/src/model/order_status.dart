//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {

  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'pending_signature')
  static const OrderStatus pendingSignature = _$pendingSignature;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'submitted')
  static const OrderStatus submitted = _$submitted;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'open')
  static const OrderStatus open = _$open;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'partially_filled')
  static const OrderStatus partiallyFilled = _$partiallyFilled;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'filled')
  static const OrderStatus filled = _$filled;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const OrderStatus cancelled = _$cancelled;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'failed')
  static const OrderStatus failed = _$failed;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const OrderStatus ambiguous = _$ambiguous;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const OrderStatus manualReview = _$manualReview;
  /// 订单包含可恢复的 ambiguous 和需人工介入的 manual_review 状态；客户端通过订单 GET 与 SSE 跟踪后续变化。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

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

