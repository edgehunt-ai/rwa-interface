//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rail_portfolio_allocation_item.g.dart';

/// RailPortfolioAllocationItem
///
/// Properties:
/// * [rail] 
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class RailPortfolioAllocationItem implements Built<RailPortfolioAllocationItem, RailPortfolioAllocationItemBuilder> {
  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String get valueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String get percent;

  RailPortfolioAllocationItem._();

  factory RailPortfolioAllocationItem([void updates(RailPortfolioAllocationItemBuilder b)]) = _$RailPortfolioAllocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RailPortfolioAllocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RailPortfolioAllocationItem> get serializer => _$RailPortfolioAllocationItemSerializer();
}

class _$RailPortfolioAllocationItemSerializer implements PrimitiveSerializer<RailPortfolioAllocationItem> {
  @override
  final Iterable<Type> types = const [RailPortfolioAllocationItem, _$RailPortfolioAllocationItem];

  @override
  final String wireName = r'RailPortfolioAllocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RailPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(ProductKind),
    );
    yield r'value_usd';
    yield serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType(String),
    );
    yield r'percent';
    yield serializers.serialize(
      object.percent,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RailPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RailPortfolioAllocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.rail = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valueUsd = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.percent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RailPortfolioAllocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RailPortfolioAllocationItemBuilder();
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

