//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_fill.g.dart';

/// OrderFill
///
/// Properties:
/// * [side] - 本次逐笔成交的买卖方向，不是持仓多空，也不能据此推断开仓或平仓。历史数据不可确认时为空。
/// * [positionEffect] - 基于已保存的上游 dir 映射：open_long、close_long、open_short、close_short、long_to_short、short_to_long；未知上游值返回 unknown，缺失为 null。不能仅从 side 推断，不使用 startPosition 推导。历史缺失记录不自动回填。
/// * [closedPnl] - 上游原始逐笔 closedPnl 十进制字符串，可正、负或零；缺失为 null。不是分摊的订单盈亏，不承诺为扣除全部手续费及资金费后的净收益，不重复扣费。
/// * [pnlAsset] - 成交采集时通过同一网络的场所 collateralToken 和 token 元数据确认并保存的盈亏计价币种；开仓、平仓和保护单使用同一来源。缺失为 null，不从 fee_asset 推断。
/// * [fillId] 
/// * [providerTradeId] 
/// * [price] - 十进制字符串，避免浮点误差
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [fee] - 十进制字符串，避免浮点误差
/// * [feeAsset] 
/// * [providerHash] 
/// * [executedAt] 
@BuiltValue()
abstract class OrderFill implements Built<OrderFill, OrderFillBuilder> {
  /// 本次逐笔成交的买卖方向，不是持仓多空，也不能据此推断开仓或平仓。历史数据不可确认时为空。
  @BuiltValueField(wireName: r'side')
  OrderFillSideEnum? get side;
  // enum sideEnum {  buy,  sell,  ,  };

  /// 基于已保存的上游 dir 映射：open_long、close_long、open_short、close_short、long_to_short、short_to_long；未知上游值返回 unknown，缺失为 null。不能仅从 side 推断，不使用 startPosition 推导。历史缺失记录不自动回填。
  @BuiltValueField(wireName: r'position_effect')
  String? get positionEffect;

  /// 上游原始逐笔 closedPnl 十进制字符串，可正、负或零；缺失为 null。不是分摊的订单盈亏，不承诺为扣除全部手续费及资金费后的净收益，不重复扣费。
  @BuiltValueField(wireName: r'closed_pnl')
  String? get closedPnl;

  /// 成交采集时通过同一网络的场所 collateralToken 和 token 元数据确认并保存的盈亏计价币种；开仓、平仓和保护单使用同一来源。缺失为 null，不从 fee_asset 推断。
  @BuiltValueField(wireName: r'pnl_asset')
  String? get pnlAsset;

  @BuiltValueField(wireName: r'fill_id')
  String get fillId;

  @BuiltValueField(wireName: r'provider_trade_id')
  String get providerTradeId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'fee')
  String get fee;

  @BuiltValueField(wireName: r'fee_asset')
  String get feeAsset;

  @BuiltValueField(wireName: r'provider_hash')
  String? get providerHash;

  @BuiltValueField(wireName: r'executed_at')
  DateTime get executedAt;

  OrderFill._();

  factory OrderFill([void updates(OrderFillBuilder b)]) = _$OrderFill;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderFillBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderFill> get serializer => _$OrderFillSerializer();
}

class _$OrderFillSerializer implements PrimitiveSerializer<OrderFill> {
  @override
  final Iterable<Type> types = const [OrderFill, _$OrderFill];

  @override
  final String wireName = r'OrderFill';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderFill object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.side != null) {
      yield r'side';
      yield serializers.serialize(
        object.side,
        specifiedType: const FullType.nullable(OrderFillSideEnum),
      );
    }
    if (object.positionEffect != null) {
      yield r'position_effect';
      yield serializers.serialize(
        object.positionEffect,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.closedPnl != null) {
      yield r'closed_pnl';
      yield serializers.serialize(
        object.closedPnl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.pnlAsset != null) {
      yield r'pnl_asset';
      yield serializers.serialize(
        object.pnlAsset,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'fill_id';
    yield serializers.serialize(
      object.fillId,
      specifiedType: const FullType(String),
    );
    yield r'provider_trade_id';
    yield serializers.serialize(
      object.providerTradeId,
      specifiedType: const FullType(String),
    );
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(String),
    );
    yield r'fee_asset';
    yield serializers.serialize(
      object.feeAsset,
      specifiedType: const FullType(String),
    );
    if (object.providerHash != null) {
      yield r'provider_hash';
      yield serializers.serialize(
        object.providerHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'executed_at';
    yield serializers.serialize(
      object.executedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderFill object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderFillBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderFillSideEnum),
          ) as OrderFillSideEnum?;
          if (valueDes == null) continue;
          result.side = valueDes;
          break;
        case r'position_effect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.positionEffect = valueDes;
          break;
        case r'closed_pnl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.closedPnl = valueDes;
          break;
        case r'pnl_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pnlAsset = valueDes;
          break;
        case r'fill_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fillId = valueDes;
          break;
        case r'provider_trade_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerTradeId = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fee = valueDes;
          break;
        case r'fee_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feeAsset = valueDes;
          break;
        case r'provider_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.providerHash = valueDes;
          break;
        case r'executed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.executedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderFill deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderFillBuilder();
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

class OrderFillSideEnum extends EnumClass {

  /// 本次逐笔成交的买卖方向，不是持仓多空，也不能据此推断开仓或平仓。历史数据不可确认时为空。
  @BuiltValueEnumConst(wireName: r'buy')
  static const OrderFillSideEnum buy = _$orderFillSideEnum_buy;
  /// 本次逐笔成交的买卖方向，不是持仓多空，也不能据此推断开仓或平仓。历史数据不可确认时为空。
  @BuiltValueEnumConst(wireName: r'sell')
  static const OrderFillSideEnum sell = _$orderFillSideEnum_sell;
  /// 本次逐笔成交的买卖方向，不是持仓多空，也不能据此推断开仓或平仓。历史数据不可确认时为空。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OrderFillSideEnum unknownDefaultOpenApi = _$orderFillSideEnum_unknownDefaultOpenApi;

  static Serializer<OrderFillSideEnum> get serializer => _$orderFillSideEnumSerializer;

  const OrderFillSideEnum._(String name): super(name);

  static BuiltSet<OrderFillSideEnum> get values => _$orderFillSideEnumValues;
  static OrderFillSideEnum valueOf(String name) => _$orderFillSideEnumValueOf(name);
}

