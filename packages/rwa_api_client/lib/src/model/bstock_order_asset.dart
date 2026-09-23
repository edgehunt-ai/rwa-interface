//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_asset.g.dart';

/// BstockOrderAsset
///
/// Properties:
/// * [symbol] - 当前市场实际 token 符号（例如主网 USDT、测试网 TUSDT 或 NVDAB），不能从行情交易对推断。
/// * [chainId] 
/// * [assetId] - 小写合约地址的 CAIP-19 资产身份。
/// * [tokenContract] 
/// * [decimals] 
@BuiltValue()
abstract class BstockOrderAsset implements Built<BstockOrderAsset, BstockOrderAssetBuilder> {
  /// 当前市场实际 token 符号（例如主网 USDT、测试网 TUSDT 或 NVDAB），不能从行情交易对推断。
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  /// 小写合约地址的 CAIP-19 资产身份。
  @BuiltValueField(wireName: r'asset_id')
  String get assetId;

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  BstockOrderAsset._();

  factory BstockOrderAsset([void updates(BstockOrderAssetBuilder b)]) = _$BstockOrderAsset;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderAssetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderAsset> get serializer => _$BstockOrderAssetSerializer();
}

class _$BstockOrderAssetSerializer implements PrimitiveSerializer<BstockOrderAsset> {
  @override
  final Iterable<Type> types = const [BstockOrderAsset, _$BstockOrderAsset];

  @override
  final String wireName = r'BstockOrderAsset';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'asset_id';
    yield serializers.serialize(
      object.assetId,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderAsset object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderAssetBuilder result,
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
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.assetId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.decimals = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrderAsset deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderAssetBuilder();
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

