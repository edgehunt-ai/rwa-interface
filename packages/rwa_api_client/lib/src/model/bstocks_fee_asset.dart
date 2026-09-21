//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_fee_asset.g.dart';

/// BstocksFeeAsset
///
/// Properties:
/// * [chainId] 
/// * [symbol] 
/// * [tokenContract] 
/// * [decimals] 
/// * [native_] 
@BuiltValue()
abstract class BstocksFeeAsset implements Built<BstocksFeeAsset, BstocksFeeAssetBuilder> {
  @BuiltValueField(wireName: r'chain_id')
  BstocksFeeAssetChainIdEnum get chainId;
  // enum chainIdEnum {  56,  97,  31337,  };

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'token_contract')
  String? get tokenContract;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  @BuiltValueField(wireName: r'native')
  bool get native_;

  BstocksFeeAsset._();

  factory BstocksFeeAsset([void updates(BstocksFeeAssetBuilder b)]) = _$BstocksFeeAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksFeeAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksFeeAsset> get serializer => _$BstocksFeeAssetSerializer();
}

class _$BstocksFeeAssetSerializer implements PrimitiveSerializer<BstocksFeeAsset> {
  @override
  final Iterable<Type> types = const [BstocksFeeAsset, _$BstocksFeeAsset];

  @override
  final String wireName = r'BstocksFeeAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksFeeAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BstocksFeeAssetChainIdEnum),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield object.tokenContract == null ? null : serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType.nullable(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
    yield r'native';
    yield serializers.serialize(
      object.native_,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksFeeAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksFeeAssetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksFeeAssetChainIdEnum),
          ) as BstocksFeeAssetChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.tokenContract = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.decimals = valueDes;
          break;
        case r'native':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.native_ = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksFeeAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksFeeAssetBuilder();
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

class BstocksFeeAssetChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstocksFeeAssetChainIdEnum number56 = _$bstocksFeeAssetChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 97)
  static const BstocksFeeAssetChainIdEnum number97 = _$bstocksFeeAssetChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 31337)
  static const BstocksFeeAssetChainIdEnum number31337 = _$bstocksFeeAssetChainIdEnum_number31337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstocksFeeAssetChainIdEnum unknownDefaultOpenApi = _$bstocksFeeAssetChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstocksFeeAssetChainIdEnum> get serializer => _$bstocksFeeAssetChainIdEnumSerializer;

  const BstocksFeeAssetChainIdEnum._(String name): super(name);

  static BuiltSet<BstocksFeeAssetChainIdEnum> get values => _$bstocksFeeAssetChainIdEnumValues;
  static BstocksFeeAssetChainIdEnum valueOf(String name) => _$bstocksFeeAssetChainIdEnumValueOf(name);
}

