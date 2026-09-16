//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_category.g.dart';

class ActivityCategory extends EnumClass {

  /// `orders` 订单类 · `cash` 资金流水 · `funding` 资金费。  `orders` 覆盖 market/limit/tpsl/close/liquidation；`cash` 覆盖入金、划转、 提现与 Claim 等资金流水；`funding` 是 venue 无关的资金费 feed，当前包含 HIP-3 资金费，后续场所（如 bStocks）的资金费事件接入后同样归入本类。 资金费明细视图见 `GET /v1/hip3/funding-payments`。 `funds` 与 `signatures` 为已废弃的兼容值，服务端不再接受或产生。 
  @BuiltValueEnumConst(wireName: r'orders')
  static const ActivityCategory orders = _$orders;
  /// `orders` 订单类 · `cash` 资金流水 · `funding` 资金费。  `orders` 覆盖 market/limit/tpsl/close/liquidation；`cash` 覆盖入金、划转、 提现与 Claim 等资金流水；`funding` 是 venue 无关的资金费 feed，当前包含 HIP-3 资金费，后续场所（如 bStocks）的资金费事件接入后同样归入本类。 资金费明细视图见 `GET /v1/hip3/funding-payments`。 `funds` 与 `signatures` 为已废弃的兼容值，服务端不再接受或产生。 
  @BuiltValueEnumConst(wireName: r'cash')
  static const ActivityCategory cash = _$cash;
  /// `orders` 订单类 · `cash` 资金流水 · `funding` 资金费。  `orders` 覆盖 market/limit/tpsl/close/liquidation；`cash` 覆盖入金、划转、 提现与 Claim 等资金流水；`funding` 是 venue 无关的资金费 feed，当前包含 HIP-3 资金费，后续场所（如 bStocks）的资金费事件接入后同样归入本类。 资金费明细视图见 `GET /v1/hip3/funding-payments`。 `funds` 与 `signatures` 为已废弃的兼容值，服务端不再接受或产生。 
  @BuiltValueEnumConst(wireName: r'funding')
  static const ActivityCategory funding = _$funding;
  /// `orders` 订单类 · `cash` 资金流水 · `funding` 资金费。  `orders` 覆盖 market/limit/tpsl/close/liquidation；`cash` 覆盖入金、划转、 提现与 Claim 等资金流水；`funding` 是 venue 无关的资金费 feed，当前包含 HIP-3 资金费，后续场所（如 bStocks）的资金费事件接入后同样归入本类。 资金费明细视图见 `GET /v1/hip3/funding-payments`。 `funds` 与 `signatures` 为已废弃的兼容值，服务端不再接受或产生。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityCategory unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ActivityCategory> get serializer => _$activityCategorySerializer;

  const ActivityCategory._(String name): super(name);

  static BuiltSet<ActivityCategory> get values => _$values;
  static ActivityCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActivityCategoryMixin = Object with _$ActivityCategoryMixin;

