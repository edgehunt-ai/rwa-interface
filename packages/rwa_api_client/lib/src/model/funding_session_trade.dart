//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_order_protection_spec.dart';
import 'package:rwa_api_client/src/model/funding_session_transfer_snapshot.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_session_trade.g.dart';

/// Frozen creation snapshot. Sessions created from `trade` carry an order preview request; sessions created from `transfer` carry an account-transfer snapshot (`kind` = `account_transfer`) and never produce an order continuation. 
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [timeInForce] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [quantity] - 限价单的基础资产数量
/// * [limitPrice] - 限价单的 USDC 价格
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
/// * [contextId] - 可选的 HIP3 trading context；存在时精确绑定账户/产品/环境，过期返回 409。新客户端在请求前读取 context。
/// * [protection] 
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] - 必须显式传入，并与当前 HIP-3 trading context 的保证金模式一致；如需切换模式，先调用账户设置接口。
/// * [reduceOnly] 
/// * [destination] 
@BuiltValue()
abstract class FundingSessionTrade implements Built<FundingSessionTrade, FundingSessionTradeBuilder> {
  /// One Of [FundingSessionTransferSnapshot], [OrderPreviewRequest]
  OneOf get oneOf;

  FundingSessionTrade._();

  factory FundingSessionTrade([void updates(FundingSessionTradeBuilder b)]) = _$FundingSessionTrade;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTradeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTrade> get serializer => _$FundingSessionTradeSerializer();
}

class _$FundingSessionTradeSerializer implements PrimitiveSerializer<FundingSessionTrade> {
  @override
  final Iterable<Type> types = const [FundingSessionTrade, _$FundingSessionTrade];

  @override
  final String wireName = r'FundingSessionTrade';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTrade object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTrade object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingSessionTrade deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTradeBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(OrderPreviewRequest), FullType(FundingSessionTransferSnapshot), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingSessionTradeKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'account_transfer')
  static const FundingSessionTradeKindEnum accountTransfer = _$fundingSessionTradeKindEnum_accountTransfer;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTradeKindEnum unknownDefaultOpenApi = _$fundingSessionTradeKindEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTradeKindEnum> get serializer => _$fundingSessionTradeKindEnumSerializer;

  const FundingSessionTradeKindEnum._(String name): super(name);

  static BuiltSet<FundingSessionTradeKindEnum> get values => _$fundingSessionTradeKindEnumValues;
  static FundingSessionTradeKindEnum valueOf(String name) => _$fundingSessionTradeKindEnumValueOf(name);
}

class FundingSessionTradeSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const FundingSessionTradeSideEnum long = _$fundingSessionTradeSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const FundingSessionTradeSideEnum short = _$fundingSessionTradeSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTradeSideEnum unknownDefaultOpenApi = _$fundingSessionTradeSideEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTradeSideEnum> get serializer => _$fundingSessionTradeSideEnumSerializer;

  const FundingSessionTradeSideEnum._(String name): super(name);

  static BuiltSet<FundingSessionTradeSideEnum> get values => _$fundingSessionTradeSideEnumValues;
  static FundingSessionTradeSideEnum valueOf(String name) => _$fundingSessionTradeSideEnumValueOf(name);
}

class FundingSessionTradeDestinationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_margin')
  static const FundingSessionTradeDestinationEnum hip3Margin = _$fundingSessionTradeDestinationEnum_hip3Margin;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionTradeDestinationEnum unknownDefaultOpenApi = _$fundingSessionTradeDestinationEnum_unknownDefaultOpenApi;

  static Serializer<FundingSessionTradeDestinationEnum> get serializer => _$fundingSessionTradeDestinationEnumSerializer;

  const FundingSessionTradeDestinationEnum._(String name): super(name);

  static BuiltSet<FundingSessionTradeDestinationEnum> get values => _$fundingSessionTradeDestinationEnumValues;
  static FundingSessionTradeDestinationEnum valueOf(String name) => _$fundingSessionTradeDestinationEnumValueOf(name);
}

