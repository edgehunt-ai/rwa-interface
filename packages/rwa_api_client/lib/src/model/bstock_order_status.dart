//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_status.g.dart';

class BstockOrderStatus extends EnumClass {

  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'pending')
  static const BstockOrderStatus pending = _$pending;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'awaiting_confirmation')
  static const BstockOrderStatus awaitingConfirmation = _$awaitingConfirmation;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'submitted')
  static const BstockOrderStatus submitted = _$submitted;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'open')
  static const BstockOrderStatus open = _$open;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'partially_filled')
  static const BstockOrderStatus partiallyFilled = _$partiallyFilled;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'filled')
  static const BstockOrderStatus filled = _$filled;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const BstockOrderStatus cancelled = _$cancelled;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'failed')
  static const BstockOrderStatus failed = _$failed;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const BstockOrderStatus ambiguous = _$ambiguous;
  /// bStocks 业务订单状态；授权确认后等待原订单的新预览，open/filled/cancelled 必须来自链上订单证据。
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const BstockOrderStatus manualReview = _$manualReview;

  static Serializer<BstockOrderStatus> get serializer => _$bstockOrderStatusSerializer;

  const BstockOrderStatus._(String name): super(name);

  static BuiltSet<BstockOrderStatus> get values => _$values;
  static BstockOrderStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BstockOrderStatusMixin = Object with _$BstockOrderStatusMixin;

