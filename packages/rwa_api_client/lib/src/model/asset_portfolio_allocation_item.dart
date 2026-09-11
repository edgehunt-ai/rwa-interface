//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'asset_portfolio_allocation_item.g.dart';

/// AssetPortfolioAllocationItem
///
/// Properties:
/// * [assetId] 
/// * [symbol] 
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class AssetPortfolioAllocationItem implements Built<AssetPortfolioAllocationItem, AssetPortfolioAllocationItemBuilder> {
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String get valueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String get percent;

  AssetPortfolioAllocationItem._();

  factory AssetPortfolioAllocationItem([void updates(AssetPortfolioAllocationItemBuilder b)]) = _$AssetPortfolioAllocationItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssetPortfolioAllocationItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AssetPortfolioAllocationItem> get serializer => _$AssetPortfolioAllocationItemSerializer();
}

class _$AssetPortfolioAllocationItemSerializer implements PrimitiveSerializer<AssetPortfolioAllocationItem> {
  @override
  final Iterable<Type> types = const [AssetPortfolioAllocationItem, _$AssetPortfolioAllocationItem];

  @override
  final String wireName = r'AssetPortfolioAllocationItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AssetPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
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
    AssetPortfolioAllocationItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssetPortfolioAllocationItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
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
  AssetPortfolioAllocationItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssetPortfolioAllocationItemBuilder();
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

