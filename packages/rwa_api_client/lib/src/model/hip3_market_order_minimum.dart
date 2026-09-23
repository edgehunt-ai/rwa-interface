//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_market_order_minimum.g.dart';

/// Hip3MarketOrderMinimum
///
/// Properties:
/// * [minimumAmountUsdc] - 按当前盘口、市价保护价和数量步长计算后，前端可提交的最小 amount（USDC）。
/// * [minimumQuantity] - minimum_amount_usdc 对应的最小可执行数量。
/// * [referencePrice] - 计算时使用的买一或卖一价格。
/// * [limitPrice] - 加上市价单滑点保护并按交易所精度取整后的 IOC 限价。
/// * [minimumMarginRequiredUsdc] - 按当前用户杠杆计算的最低保证金与费用预留之和（USDC）。
@BuiltValue()
abstract class Hip3MarketOrderMinimum implements Built<Hip3MarketOrderMinimum, Hip3MarketOrderMinimumBuilder> {
  /// 按当前盘口、市价保护价和数量步长计算后，前端可提交的最小 amount（USDC）。
  @BuiltValueField(wireName: r'minimum_amount_usdc')
  String get minimumAmountUsdc;

  /// minimum_amount_usdc 对应的最小可执行数量。
  @BuiltValueField(wireName: r'minimum_quantity')
  String get minimumQuantity;

  /// 计算时使用的买一或卖一价格。
  @BuiltValueField(wireName: r'reference_price')
  String get referencePrice;

  /// 加上市价单滑点保护并按交易所精度取整后的 IOC 限价。
  @BuiltValueField(wireName: r'limit_price')
  String get limitPrice;

  /// 按当前用户杠杆计算的最低保证金与费用预留之和（USDC）。
  @BuiltValueField(wireName: r'minimum_margin_required_usdc')
  String get minimumMarginRequiredUsdc;

  Hip3MarketOrderMinimum._();

  factory Hip3MarketOrderMinimum([void updates(Hip3MarketOrderMinimumBuilder b)]) = _$Hip3MarketOrderMinimum;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3MarketOrderMinimumBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3MarketOrderMinimum> get serializer => _$Hip3MarketOrderMinimumSerializer();
}

class _$Hip3MarketOrderMinimumSerializer implements PrimitiveSerializer<Hip3MarketOrderMinimum> {
  @override
  final Iterable<Type> types = const [Hip3MarketOrderMinimum, _$Hip3MarketOrderMinimum];

  @override
  final String wireName = r'Hip3MarketOrderMinimum';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3MarketOrderMinimum object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'minimum_amount_usdc';
    yield serializers.serialize(
      object.minimumAmountUsdc,
      specifiedType: const FullType(String),
    );
    yield r'minimum_quantity';
    yield serializers.serialize(
      object.minimumQuantity,
      specifiedType: const FullType(String),
    );
    yield r'reference_price';
    yield serializers.serialize(
      object.referencePrice,
      specifiedType: const FullType(String),
    );
    yield r'limit_price';
    yield serializers.serialize(
      object.limitPrice,
      specifiedType: const FullType(String),
    );
    yield r'minimum_margin_required_usdc';
    yield serializers.serialize(
      object.minimumMarginRequiredUsdc,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3MarketOrderMinimum object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3MarketOrderMinimumBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'minimum_amount_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumAmountUsdc = valueDes;
          break;
        case r'minimum_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumQuantity = valueDes;
          break;
        case r'reference_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.referencePrice = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.limitPrice = valueDes;
          break;
        case r'minimum_margin_required_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumMarginRequiredUsdc = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3MarketOrderMinimum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3MarketOrderMinimumBuilder();
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

