//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_rail.g.dart';

/// BstockFundingRail
///
/// Properties:
/// * [rail] 
/// * [network] 
/// * [settlementAsset] 
/// * [chainId] 
/// * [settlementAssetId] 
/// * [tokenContract] 
/// * [tokenDecimals] 
/// * [provenance] 
/// * [minimumAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class BstockFundingRail implements Built<BstockFundingRail, BstockFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstockFundingRailRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockFundingRailNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'settlement_asset')
  BstockFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDT,  };

  @BuiltValueField(wireName: r'chain_id')
  BstockFundingRailChainIdEnum get chainId;
  // enum chainIdEnum {  56,  };

  @BuiltValueField(wireName: r'settlement_asset_id')
  BstockFundingRailSettlementAssetIdEnum get settlementAssetId;
  // enum settlementAssetIdEnum {  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'token_contract')
  BstockFundingRailTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'token_decimals')
  BstockFundingRailTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  FundingAssetProvenance get provenance;
  // enum provenanceEnum {  circle_native,  tether_native,  tether_usdt0,  l2_standard_bridged,  binance_peg,  hyperliquid_perps,  testnet_mock,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  BstockFundingRail._();

  factory BstockFundingRail([void updates(BstockFundingRailBuilder b)]) = _$BstockFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingRail> get serializer => _$BstockFundingRailSerializer();
}

class _$BstockFundingRailSerializer implements PrimitiveSerializer<BstockFundingRail> {
  @override
  final Iterable<Type> types = const [BstockFundingRail, _$BstockFundingRail];

  @override
  final String wireName = r'BstockFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(BstockFundingRailSettlementAssetEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BstockFundingRailChainIdEnum),
    );
    yield r'settlement_asset_id';
    yield serializers.serialize(
      object.settlementAssetId,
      specifiedType: const FullType(BstockFundingRailSettlementAssetIdEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BstockFundingRailTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BstockFundingRailTokenDecimalsEnum),
    );
    yield r'provenance';
    yield serializers.serialize(
      object.provenance,
      specifiedType: const FullType(FundingAssetProvenance),
    );
    if (object.minimumAmount != null) {
      yield r'minimum_amount';
      yield serializers.serialize(
        object.minimumAmount,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailRailEnum),
          ) as BstockFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailNetworkEnum),
          ) as BstockFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailSettlementAssetEnum),
          ) as BstockFundingRailSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailChainIdEnum),
          ) as BstockFundingRailChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'settlement_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailSettlementAssetIdEnum),
          ) as BstockFundingRailSettlementAssetIdEnum;
          result.settlementAssetId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailTokenContractEnum),
          ) as BstockFundingRailTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingRailTokenDecimalsEnum),
          ) as BstockFundingRailTokenDecimalsEnum;
          result.tokenDecimals = valueDes;
          break;
        case r'provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingAssetProvenance),
          ) as FundingAssetProvenance;
          result.provenance = valueDes;
          break;
        case r'minimum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.minimumAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingRailBuilder();
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

class BstockFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockFundingRailRailEnum bstock = _$bstockFundingRailRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailRailEnum unknownDefaultOpenApi = _$bstockFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailRailEnum> get serializer => _$bstockFundingRailRailEnumSerializer;

  const BstockFundingRailRailEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailRailEnum> get values => _$bstockFundingRailRailEnumValues;
  static BstockFundingRailRailEnum valueOf(String name) => _$bstockFundingRailRailEnumValueOf(name);
}

class BstockFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockFundingRailNetworkEnum BSC = _$bstockFundingRailNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailNetworkEnum unknownDefaultOpenApi = _$bstockFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailNetworkEnum> get serializer => _$bstockFundingRailNetworkEnumSerializer;

  const BstockFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailNetworkEnum> get values => _$bstockFundingRailNetworkEnumValues;
  static BstockFundingRailNetworkEnum valueOf(String name) => _$bstockFundingRailNetworkEnumValueOf(name);
}

class BstockFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDT')
  static const BstockFundingRailSettlementAssetEnum USDT = _$bstockFundingRailSettlementAssetEnum_USDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$bstockFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailSettlementAssetEnum> get serializer => _$bstockFundingRailSettlementAssetEnumSerializer;

  const BstockFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailSettlementAssetEnum> get values => _$bstockFundingRailSettlementAssetEnumValues;
  static BstockFundingRailSettlementAssetEnum valueOf(String name) => _$bstockFundingRailSettlementAssetEnumValueOf(name);
}

class BstockFundingRailChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BstockFundingRailChainIdEnum number56 = _$bstockFundingRailChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockFundingRailChainIdEnum unknownDefaultOpenApi = _$bstockFundingRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailChainIdEnum> get serializer => _$bstockFundingRailChainIdEnumSerializer;

  const BstockFundingRailChainIdEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailChainIdEnum> get values => _$bstockFundingRailChainIdEnumValues;
  static BstockFundingRailChainIdEnum valueOf(String name) => _$bstockFundingRailChainIdEnumValueOf(name);
}

class BstockFundingRailSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955')
  static const BstockFundingRailSettlementAssetIdEnum eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955 = _$bstockFundingRailSettlementAssetIdEnum_eip155Colon56SlashErc20Colon0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailSettlementAssetIdEnum unknownDefaultOpenApi = _$bstockFundingRailSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailSettlementAssetIdEnum> get serializer => _$bstockFundingRailSettlementAssetIdEnumSerializer;

  const BstockFundingRailSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailSettlementAssetIdEnum> get values => _$bstockFundingRailSettlementAssetIdEnumValues;
  static BstockFundingRailSettlementAssetIdEnum valueOf(String name) => _$bstockFundingRailSettlementAssetIdEnumValueOf(name);
}

class BstockFundingRailTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x55d398326f99059ff775485246999027b3197955')
  static const BstockFundingRailTokenContractEnum n0x55d398326f99059ff775485246999027b3197955 = _$bstockFundingRailTokenContractEnum_n0x55d398326f99059ff775485246999027b3197955;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingRailTokenContractEnum unknownDefaultOpenApi = _$bstockFundingRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailTokenContractEnum> get serializer => _$bstockFundingRailTokenContractEnumSerializer;

  const BstockFundingRailTokenContractEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailTokenContractEnum> get values => _$bstockFundingRailTokenContractEnumValues;
  static BstockFundingRailTokenContractEnum valueOf(String name) => _$bstockFundingRailTokenContractEnumValueOf(name);
}

class BstockFundingRailTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BstockFundingRailTokenDecimalsEnum number18 = _$bstockFundingRailTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockFundingRailTokenDecimalsEnum unknownDefaultOpenApi = _$bstockFundingRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingRailTokenDecimalsEnum> get serializer => _$bstockFundingRailTokenDecimalsEnumSerializer;

  const BstockFundingRailTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BstockFundingRailTokenDecimalsEnum> get values => _$bstockFundingRailTokenDecimalsEnumValues;
  static BstockFundingRailTokenDecimalsEnum valueOf(String name) => _$bstockFundingRailTokenDecimalsEnumValueOf(name);
}

