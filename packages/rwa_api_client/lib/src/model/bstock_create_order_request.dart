//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_time_in_force.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_create_order_request.g.dart';

/// 当前非 localnet 实现要求有效 preview_id，并严格匹配账户/owner/输入/准入和经济量边界。 字段可选保留旧 wire 兼容，不表示运行时允许省略；缺失/过期/变更需重新预览。 返回 approval action 不代表已创建 swap，确认审批后须使用新 preview 和新创建幂等键。 
///
/// Properties:
/// * [symbol] 
/// * [kind] 
/// * [side] 
/// * [type] 
/// * [timeInForce] 
/// * [amount] - 市价买入的当前准入 quote token 金额，通常主网 USDT / 测试网 TUSDT。
/// * [quantity] - 市价卖出或限价单的基础资产数量
/// * [limitPrice] - 每单位基础资产的 quote token 限价，不默认 USDC 或 USD。
/// * [slippagePercent] - 最大可接受滑点；超出则下单失败
/// * [tpSl] 
/// * [previewId] - 引用账户绑定的有效预览和经济量边界，不锁定成交；审批消费后或过期后重新预览。
@BuiltValue()
abstract class BstockCreateOrderRequest implements Built<BstockCreateOrderRequest, BstockCreateOrderRequestBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  BstockCreateOrderRequestKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'side')
  BstockCreateOrderRequestSideEnum get side;
  // enum sideEnum {  buy,  sell,  };

  @BuiltValueField(wireName: r'type')
  OrderType get type;
  // enum typeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'time_in_force')
  BstocksTimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  };

  /// 市价买入的当前准入 quote token 金额，通常主网 USDT / 测试网 TUSDT。
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// 市价卖出或限价单的基础资产数量
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 每单位基础资产的 quote token 限价，不默认 USDC 或 USD。
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// 最大可接受滑点；超出则下单失败
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'tp_sl')
  TpSlSpec? get tpSl;

  /// 引用账户绑定的有效预览和经济量边界，不锁定成交；审批消费后或过期后重新预览。
  @BuiltValueField(wireName: r'preview_id')
  String? get previewId;

  BstockCreateOrderRequest._();

  factory BstockCreateOrderRequest([void updates(BstockCreateOrderRequestBuilder b)]) = _$BstockCreateOrderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockCreateOrderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockCreateOrderRequest> get serializer => _$BstockCreateOrderRequestSerializer();
}

class _$BstockCreateOrderRequestSerializer implements PrimitiveSerializer<BstockCreateOrderRequest> {
  @override
  final Iterable<Type> types = const [BstockCreateOrderRequest, _$BstockCreateOrderRequest];

  @override
  final String wireName = r'BstockCreateOrderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockCreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockCreateOrderRequestKindEnum),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(BstockCreateOrderRequestSideEnum),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(OrderType),
    );
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(BstocksTimeInForce),
      );
    }
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
    BstockCreateOrderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockCreateOrderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(BstockCreateOrderRequestKindEnum),
          ) as BstockCreateOrderRequestKindEnum;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockCreateOrderRequestSideEnum),
          ) as BstockCreateOrderRequestSideEnum;
          result.side = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderType),
          ) as OrderType;
          result.type = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksTimeInForce),
          ) as BstocksTimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
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
  BstockCreateOrderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockCreateOrderRequestBuilder();
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

class BstockCreateOrderRequestKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockCreateOrderRequestKindEnum bstock = _$bstockCreateOrderRequestKindEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockCreateOrderRequestKindEnum unknownDefaultOpenApi = _$bstockCreateOrderRequestKindEnum_unknownDefaultOpenApi;

  static Serializer<BstockCreateOrderRequestKindEnum> get serializer => _$bstockCreateOrderRequestKindEnumSerializer;

  const BstockCreateOrderRequestKindEnum._(String name): super(name);

  static BuiltSet<BstockCreateOrderRequestKindEnum> get values => _$bstockCreateOrderRequestKindEnumValues;
  static BstockCreateOrderRequestKindEnum valueOf(String name) => _$bstockCreateOrderRequestKindEnumValueOf(name);
}

class BstockCreateOrderRequestSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'buy')
  static const BstockCreateOrderRequestSideEnum buy = _$bstockCreateOrderRequestSideEnum_buy;
  @BuiltValueEnumConst(wireName: r'sell')
  static const BstockCreateOrderRequestSideEnum sell = _$bstockCreateOrderRequestSideEnum_sell;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockCreateOrderRequestSideEnum unknownDefaultOpenApi = _$bstockCreateOrderRequestSideEnum_unknownDefaultOpenApi;

  static Serializer<BstockCreateOrderRequestSideEnum> get serializer => _$bstockCreateOrderRequestSideEnumSerializer;

  const BstockCreateOrderRequestSideEnum._(String name): super(name);

  static BuiltSet<BstockCreateOrderRequestSideEnum> get values => _$bstockCreateOrderRequestSideEnumValues;
  static BstockCreateOrderRequestSideEnum valueOf(String name) => _$bstockCreateOrderRequestSideEnumValueOf(name);
}

