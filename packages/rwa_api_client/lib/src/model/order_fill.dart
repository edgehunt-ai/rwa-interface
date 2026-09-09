//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_fill.g.dart';

/// OrderFill
///
/// Properties:
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

