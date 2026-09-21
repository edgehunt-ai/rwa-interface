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

part 'perp_order_preview_request.g.dart';

/// HIP-3 永续订单。只接受 `long` / `short`。 市价单只传 amount（USDC 名义价值），使用 IOC，slippage_percent 默认 1，范围 [0,5]； 限价单只传 quantity（基础资产数量）与 limit_price，使用 GTC。 protection 仅表示本单止盈止损，数量由本次开仓委托冻结，不接受持仓保护的 size_mode。 protection 与旧版 tp_sl 不得同时传入；不支持的能力返回 422，不得静默忽略。 
///
/// Properties:
/// * [contextId] - 可选的 HIP3 trading context；存在时精确绑定账户/产品/环境，过期返回 409。新客户端在请求前读取 context。
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
/// * [marginMode] - 必须显式传入，并与当前 HIP-3 trading context 的保证金模式一致；如需切换模式，先调用账户设置接口。
/// * [reduceOnly] 
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
@BuiltValue()
abstract class PerpOrderPreviewRequest implements Built<PerpOrderPreviewRequest, PerpOrderPreviewRequestBuilder> {
  /// 可选的 HIP3 trading context；存在时精确绑定账户/产品/环境，过期返回 409。新客户端在请求前读取 context。
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
  PerpOrderPreviewRequestKindEnum get kind;
  // enum kindEnum {  perp,  };

  @BuiltValueField(wireName: r'side')
  PerpOrderPreviewRequestSideEnum get side;
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

  /// 必须显式传入，并与当前 HIP-3 trading context 的保证金模式一致；如需切换模式，先调用账户设置接口。
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

  PerpOrderPreviewRequest._();

  factory PerpOrderPreviewRequest([void updates(PerpOrderPreviewRequestBuilder b)]) = _$PerpOrderPreviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpOrderPreviewRequestBuilder b) => b
      ..reduceOnly = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpOrderPreviewRequest> get serializer => _$PerpOrderPreviewRequestSerializer();
}

class _$PerpOrderPreviewRequestSerializer implements PrimitiveSerializer<PerpOrderPreviewRequest> {
  @override
  final Iterable<Type> types = const [PerpOrderPreviewRequest, _$PerpOrderPreviewRequest];

  @override
  final String wireName = r'PerpOrderPreviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpOrderPreviewRequest object, {
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
      specifiedType: const FullType(PerpOrderPreviewRequestKindEnum),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(PerpOrderPreviewRequestSideEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpOrderPreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpOrderPreviewRequestBuilder result,
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
            specifiedType: const FullType(PerpOrderPreviewRequestKindEnum),
          ) as PerpOrderPreviewRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderPreviewRequestSideEnum),
          ) as PerpOrderPreviewRequestSideEnum;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PerpOrderPreviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpOrderPreviewRequestBuilder();
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

class PerpOrderPreviewRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpOrderPreviewRequestKindEnum perp = _$perpOrderPreviewRequestKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewRequestKindEnum unknownDefaultOpenApi = _$perpOrderPreviewRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewRequestKindEnum> get serializer => _$perpOrderPreviewRequestKindEnumSerializer;

  const PerpOrderPreviewRequestKindEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewRequestKindEnum> get values => _$perpOrderPreviewRequestKindEnumValues;
  static PerpOrderPreviewRequestKindEnum valueOf(String name) => _$perpOrderPreviewRequestKindEnumValueOf(name);
}

class PerpOrderPreviewRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const PerpOrderPreviewRequestSideEnum long = _$perpOrderPreviewRequestSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const PerpOrderPreviewRequestSideEnum short = _$perpOrderPreviewRequestSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderPreviewRequestSideEnum unknownDefaultOpenApi = _$perpOrderPreviewRequestSideEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderPreviewRequestSideEnum> get serializer => _$perpOrderPreviewRequestSideEnumSerializer;

  const PerpOrderPreviewRequestSideEnum._(String name): super(name);

  static BuiltSet<PerpOrderPreviewRequestSideEnum> get values => _$perpOrderPreviewRequestSideEnumValues;
  static PerpOrderPreviewRequestSideEnum valueOf(String name) => _$perpOrderPreviewRequestSideEnumValueOf(name);
}

