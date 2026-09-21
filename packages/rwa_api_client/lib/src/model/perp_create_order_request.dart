//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_order_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_create_order_request.g.dart';

/// 市价单只传 amount（USDC 名义价值）；限价单只传 quantity（基础资产数量）与 limit_price。 protection 表示本单止盈止损，与旧版 tp_sl 不得同时传入。引用 preview 时必须匹配其冻结的规范化委托、保护和 context； context 的 symbol 必须一致。不支持的能力返回 422，不得静默忽略或降低订单约束。 
///
/// Properties:
/// * [contextId] - 必须与所引用 preview 的 context 相同；账户/环境不由客户端决定。
/// * [timeInForce] 
/// * [protection] 
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [amount] - 市价单的 USDC 名义价值
/// * [quantity] - 限价单的基础资产数量
/// * [limitPrice] - 限价单的 USDC 价格
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] - 必须显式传入，并与当前 HIP-3 trading context 及所引用 preview 冻结的保证金模式一致。
/// * [reduceOnly] 
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
/// * [previewId] - 传入预览返回的报价 id 可锁定价格；过期后需重新预览
@BuiltValue()
abstract class PerpCreateOrderRequest implements Built<PerpCreateOrderRequest, PerpCreateOrderRequestBuilder> {
  /// 必须与所引用 preview 的 context 相同；账户/环境不由客户端决定。
  @BuiltValueField(wireName: r'context_id')
  String? get contextId;

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  @BuiltValueField(wireName: r'protection')
  Hip3OrderProtectionSpec? get protection;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  PerpCreateOrderRequestKindEnum get kind;
  // enum kindEnum {  perp,  };

  @BuiltValueField(wireName: r'side')
  PerpCreateOrderRequestSideEnum get side;
  // enum sideEnum {  long,  short,  };

  @BuiltValueField(wireName: r'type')
  OrderType get type;
  // enum typeEnum {  market,  limit,  };

  /// 市价单的 USDC 名义价值
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// 限价单的基础资产数量
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 限价单的 USDC 价格
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// Decimal string leverage; allowed range is 1 to 50.
  @BuiltValueField(wireName: r'leverage')
  String? get leverage;

  /// 必须显式传入，并与当前 HIP-3 trading context 及所引用 preview 冻结的保证金模式一致。
  @BuiltValueField(wireName: r'margin_mode')
  MarginMode get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  @BuiltValueField(wireName: r'reduce_only')
  bool? get reduceOnly;

  /// 最大可接受滑点；超出则下单失败
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'tp_sl')
  TpSlSpec? get tpSl;

  /// 传入预览返回的报价 id 可锁定价格；过期后需重新预览
  @BuiltValueField(wireName: r'preview_id')
  String? get previewId;

  PerpCreateOrderRequest._();

  factory PerpCreateOrderRequest([void updates(PerpCreateOrderRequestBuilder b)]) = _$PerpCreateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpCreateOrderRequestBuilder b) => b
      ..reduceOnly = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpCreateOrderRequest> get serializer => _$PerpCreateOrderRequestSerializer();
}

class _$PerpCreateOrderRequestSerializer implements PrimitiveSerializer<PerpCreateOrderRequest> {
  @override
  final Iterable<Type> types = const [PerpCreateOrderRequest, _$PerpCreateOrderRequest];

  @override
  final String wireName = r'PerpCreateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpCreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.contextId != null) {
      yield r'context_id';
      yield serializers.serialize(
        object.contextId,
        specifiedType: const FullType(String),
      );
    }
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
      );
    }
    if (object.protection != null) {
      yield r'protection';
      yield serializers.serialize(
        object.protection,
        specifiedType: const FullType.nullable(Hip3OrderProtectionSpec),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(PerpCreateOrderRequestKindEnum),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(PerpCreateOrderRequestSideEnum),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(String),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.leverage != null) {
      yield r'leverage';
      yield serializers.serialize(
        object.leverage,
        specifiedType: const FullType(String),
      );
    }
    yield r'margin_mode';
    yield serializers.serialize(
      object.marginMode,
      specifiedType: const FullType(MarginMode),
    );
    if (object.reduceOnly != null) {
      yield r'reduce_only';
      yield serializers.serialize(
        object.reduceOnly,
        specifiedType: const FullType(bool),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.tpSl != null) {
      yield r'tp_sl';
      yield serializers.serialize(
        object.tpSl,
        specifiedType: const FullType(TpSlSpec),
      );
    }
    if (object.previewId != null) {
      yield r'preview_id';
      yield serializers.serialize(
        object.previewId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpCreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpCreateOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'context_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contextId = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3OrderProtectionSpec),
          ) as Hip3OrderProtectionSpec?;
          if (valueDes == null) continue;
          result.protection.replace(valueDes);
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpCreateOrderRequestKindEnum),
          ) as PerpCreateOrderRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpCreateOrderRequestSideEnum),
          ) as PerpCreateOrderRequestSideEnum;
          result.side = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MarginMode),
          ) as MarginMode;
          result.marginMode = valueDes;
          break;
        case r'reduce_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.reduceOnly = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'tp_sl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TpSlSpec),
          ) as TpSlSpec?;
          if (valueDes == null) continue;
          result.tpSl.replace(valueDes);
          break;
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previewId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PerpCreateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpCreateOrderRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class PerpCreateOrderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpCreateOrderRequestKindEnum perp = _$perpCreateOrderRequestKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpCreateOrderRequestKindEnum unknownDefaultOpenApi = _$perpCreateOrderRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<PerpCreateOrderRequestKindEnum> get serializer => _$perpCreateOrderRequestKindEnumSerializer;

  const PerpCreateOrderRequestKindEnum._(String name): super(name);

  static BuiltSet<PerpCreateOrderRequestKindEnum> get values => _$perpCreateOrderRequestKindEnumValues;
  static PerpCreateOrderRequestKindEnum valueOf(String name) => _$perpCreateOrderRequestKindEnumValueOf(name);
}

class PerpCreateOrderRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const PerpCreateOrderRequestSideEnum long = _$perpCreateOrderRequestSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const PerpCreateOrderRequestSideEnum short = _$perpCreateOrderRequestSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpCreateOrderRequestSideEnum unknownDefaultOpenApi = _$perpCreateOrderRequestSideEnum_unknownDefaultOpenApi;

  static Serializer<PerpCreateOrderRequestSideEnum> get serializer => _$perpCreateOrderRequestSideEnumSerializer;

  const PerpCreateOrderRequestSideEnum._(String name): super(name);

  static BuiltSet<PerpCreateOrderRequestSideEnum> get values => _$perpCreateOrderRequestSideEnumValues;
  static PerpCreateOrderRequestSideEnum valueOf(String name) => _$perpCreateOrderRequestSideEnumValueOf(name);
}

