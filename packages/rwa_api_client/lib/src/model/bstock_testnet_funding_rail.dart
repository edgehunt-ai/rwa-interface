//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_testnet_funding_rail.g.dart';

/// bStocks 结算 rail 的 testnet 变体：TUSDT@chain 97，由平台垫付池 （platform_float）结算；仅出现在 testnet catalog，mainnet 永不返回。 
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
abstract class BstockTestnetFundingRail implements Built<BstockTestnetFundingRail, BstockTestnetFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  BstockTestnetFundingRailRailEnum get rail;
  // enum railEnum {  bstock,  };

  @BuiltValueField(wireName: r'network')
  BstockTestnetFundingRailNetworkEnum get network;
  // enum networkEnum {  BSC,  };

  @BuiltValueField(wireName: r'settlement_asset')
  BstockTestnetFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  TUSDT,  };

  @BuiltValueField(wireName: r'chain_id')
  BstockTestnetFundingRailChainIdEnum get chainId;
  // enum chainIdEnum {  97,  };

  @BuiltValueField(wireName: r'settlement_asset_id')
  BstockTestnetFundingRailSettlementAssetIdEnum get settlementAssetId;
  // enum settlementAssetIdEnum {  eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0,  };

  @BuiltValueField(wireName: r'token_contract')
  BstockTestnetFundingRailTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0xd7beebb53879df47b5cca32b3680e70c13f093a0,  };

  @BuiltValueField(wireName: r'token_decimals')
  BstockTestnetFundingRailTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  18,  };

  @BuiltValueField(wireName: r'provenance')
  FundingAssetProvenance get provenance;
  // enum provenanceEnum {  circle_native,  tether_native,  tether_usdt0,  l2_standard_bridged,  binance_peg,  hyperliquid_perps,  testnet_mock,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  BstockTestnetFundingRail._();

  factory BstockTestnetFundingRail([void updates(BstockTestnetFundingRailBuilder b)]) = _$BstockTestnetFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockTestnetFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockTestnetFundingRail> get serializer => _$BstockTestnetFundingRailSerializer();
}

class _$BstockTestnetFundingRailSerializer implements PrimitiveSerializer<BstockTestnetFundingRail> {
  @override
  final Iterable<Type> types = const [BstockTestnetFundingRail, _$BstockTestnetFundingRail];

  @override
  final String wireName = r'BstockTestnetFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockTestnetFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(BstockTestnetFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(BstockTestnetFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(BstockTestnetFundingRailSettlementAssetEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(BstockTestnetFundingRailChainIdEnum),
    );
    yield r'settlement_asset_id';
    yield serializers.serialize(
      object.settlementAssetId,
      specifiedType: const FullType(BstockTestnetFundingRailSettlementAssetIdEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(BstockTestnetFundingRailTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(BstockTestnetFundingRailTokenDecimalsEnum),
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
    BstockTestnetFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockTestnetFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailRailEnum),
          ) as BstockTestnetFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailNetworkEnum),
          ) as BstockTestnetFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailSettlementAssetEnum),
          ) as BstockTestnetFundingRailSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailChainIdEnum),
          ) as BstockTestnetFundingRailChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'settlement_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailSettlementAssetIdEnum),
          ) as BstockTestnetFundingRailSettlementAssetIdEnum;
          result.settlementAssetId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailTokenContractEnum),
          ) as BstockTestnetFundingRailTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockTestnetFundingRailTokenDecimalsEnum),
          ) as BstockTestnetFundingRailTokenDecimalsEnum;
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
  BstockTestnetFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockTestnetFundingRailBuilder();
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

class BstockTestnetFundingRailRailEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockTestnetFundingRailRailEnum bstock = _$bstockTestnetFundingRailRailEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockTestnetFundingRailRailEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailRailEnum> get serializer => _$bstockTestnetFundingRailRailEnumSerializer;

  const BstockTestnetFundingRailRailEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailRailEnum> get values => _$bstockTestnetFundingRailRailEnumValues;
  static BstockTestnetFundingRailRailEnum valueOf(String name) => _$bstockTestnetFundingRailRailEnumValueOf(name);
}

class BstockTestnetFundingRailNetworkEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BstockTestnetFundingRailNetworkEnum BSC = _$bstockTestnetFundingRailNetworkEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockTestnetFundingRailNetworkEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailNetworkEnum> get serializer => _$bstockTestnetFundingRailNetworkEnumSerializer;

  const BstockTestnetFundingRailNetworkEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailNetworkEnum> get values => _$bstockTestnetFundingRailNetworkEnumValues;
  static BstockTestnetFundingRailNetworkEnum valueOf(String name) => _$bstockTestnetFundingRailNetworkEnumValueOf(name);
}

class BstockTestnetFundingRailSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TUSDT')
  static const BstockTestnetFundingRailSettlementAssetEnum TUSDT = _$bstockTestnetFundingRailSettlementAssetEnum_TUSDT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockTestnetFundingRailSettlementAssetEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailSettlementAssetEnum> get serializer => _$bstockTestnetFundingRailSettlementAssetEnumSerializer;

  const BstockTestnetFundingRailSettlementAssetEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailSettlementAssetEnum> get values => _$bstockTestnetFundingRailSettlementAssetEnumValues;
  static BstockTestnetFundingRailSettlementAssetEnum valueOf(String name) => _$bstockTestnetFundingRailSettlementAssetEnumValueOf(name);
}

class BstockTestnetFundingRailChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 97)
  static const BstockTestnetFundingRailChainIdEnum number97 = _$bstockTestnetFundingRailChainIdEnum_number97;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockTestnetFundingRailChainIdEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailChainIdEnum> get serializer => _$bstockTestnetFundingRailChainIdEnumSerializer;

  const BstockTestnetFundingRailChainIdEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailChainIdEnum> get values => _$bstockTestnetFundingRailChainIdEnumValues;
  static BstockTestnetFundingRailChainIdEnum valueOf(String name) => _$bstockTestnetFundingRailChainIdEnumValueOf(name);
}

class BstockTestnetFundingRailSettlementAssetIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const BstockTestnetFundingRailSettlementAssetIdEnum eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$bstockTestnetFundingRailSettlementAssetIdEnum_eip155Colon97SlashErc20Colon0xd7beebb53879df47b5cca32b3680e70c13f093a0;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockTestnetFundingRailSettlementAssetIdEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailSettlementAssetIdEnum> get serializer => _$bstockTestnetFundingRailSettlementAssetIdEnumSerializer;

  const BstockTestnetFundingRailSettlementAssetIdEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailSettlementAssetIdEnum> get values => _$bstockTestnetFundingRailSettlementAssetIdEnumValues;
  static BstockTestnetFundingRailSettlementAssetIdEnum valueOf(String name) => _$bstockTestnetFundingRailSettlementAssetIdEnumValueOf(name);
}

class BstockTestnetFundingRailTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xd7beebb53879df47b5cca32b3680e70c13f093a0')
  static const BstockTestnetFundingRailTokenContractEnum n0xd7beebb53879df47b5cca32b3680e70c13f093a0 = _$bstockTestnetFundingRailTokenContractEnum_n0xd7beebb53879df47b5cca32b3680e70c13f093a0;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockTestnetFundingRailTokenContractEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailTokenContractEnum> get serializer => _$bstockTestnetFundingRailTokenContractEnumSerializer;

  const BstockTestnetFundingRailTokenContractEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailTokenContractEnum> get values => _$bstockTestnetFundingRailTokenContractEnumValues;
  static BstockTestnetFundingRailTokenContractEnum valueOf(String name) => _$bstockTestnetFundingRailTokenContractEnumValueOf(name);
}

class BstockTestnetFundingRailTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BstockTestnetFundingRailTokenDecimalsEnum number18 = _$bstockTestnetFundingRailTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BstockTestnetFundingRailTokenDecimalsEnum unknownDefaultOpenApi = _$bstockTestnetFundingRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BstockTestnetFundingRailTokenDecimalsEnum> get serializer => _$bstockTestnetFundingRailTokenDecimalsEnumSerializer;

  const BstockTestnetFundingRailTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BstockTestnetFundingRailTokenDecimalsEnum> get values => _$bstockTestnetFundingRailTokenDecimalsEnumValues;
  static BstockTestnetFundingRailTokenDecimalsEnum valueOf(String name) => _$bstockTestnetFundingRailTokenDecimalsEnumValueOf(name);
}

