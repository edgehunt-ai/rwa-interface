//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstock_order_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_assets.g.dart';

/// 仅 bStock 详情返回；buy 是买入时花费的报价资产，sell 是卖出时花费的 bStock。来自当前市场准入/展示目录，不是锁定报价或余额保证；tradable=false 时不可下单。
///
/// Properties:
/// * [buy] 
/// * [sell] 
@BuiltValue()
abstract class BstockOrderAssets implements Built<BstockOrderAssets, BstockOrderAssetsBuilder> {
  @BuiltValueField(wireName: r'buy')
  BstockOrderAsset get buy;

  @BuiltValueField(wireName: r'sell')
  BstockOrderAsset get sell;

  BstockOrderAssets._();

  factory BstockOrderAssets([void updates(BstockOrderAssetsBuilder b)]) = _$BstockOrderAssets;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderAssetsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderAssets> get serializer => _$BstockOrderAssetsSerializer();
}

class _$BstockOrderAssetsSerializer implements PrimitiveSerializer<BstockOrderAssets> {
  @override
  final Iterable<Type> types = const [BstockOrderAssets, _$BstockOrderAssets];

  @override
  final String wireName = r'BstockOrderAssets';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderAssets object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'buy';
    yield serializers.serialize(
      object.buy,
      specifiedType: const FullType(BstockOrderAsset),
    );
    yield r'sell';
    yield serializers.serialize(
      object.sell,
      specifiedType: const FullType(BstockOrderAsset),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderAssets object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderAssetsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'buy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderAsset),
          ) as BstockOrderAsset;
          result.buy.replace(valueDes);
          break;
        case r'sell':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderAsset),
          ) as BstockOrderAsset;
          result.sell.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrderAssets deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderAssetsBuilder();
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

