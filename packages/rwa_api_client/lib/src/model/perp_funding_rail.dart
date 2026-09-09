//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_asset_provenance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_funding_rail.g.dart';

/// PerpFundingRail
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
abstract class PerpFundingRail
    implements Built<PerpFundingRail, PerpFundingRailBuilder> {
  @BuiltValueField(wireName: r'rail')
  PerpFundingRailRailEnum get rail;
  // enum railEnum {  perp,  };

  @BuiltValueField(wireName: r'network')
  PerpFundingRailNetworkEnum get network;
  // enum networkEnum {  Hyperliquid,  };

  @BuiltValueField(wireName: r'settlement_asset')
  PerpFundingRailSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  @BuiltValueField(wireName: r'chain_id')
  PerpFundingRailChainIdEnum get chainId;
  // enum chainIdEnum {  1337,  };

  @BuiltValueField(wireName: r'settlement_asset_id')
  PerpFundingRailSettlementAssetIdEnum get settlementAssetId;
  // enum settlementAssetIdEnum {  hyperliquid:1337/perps:USDC-PERPS,  };

  @BuiltValueField(wireName: r'token_contract')
  PerpFundingRailTokenContractEnum get tokenContract;
  // enum tokenContractEnum {  0x2100000000000000000000000000000000000000,  };

  @BuiltValueField(wireName: r'token_decimals')
  PerpFundingRailTokenDecimalsEnum get tokenDecimals;
  // enum tokenDecimalsEnum {  8,  };

  @BuiltValueField(wireName: r'provenance')
  FundingAssetProvenance get provenance;
  // enum provenanceEnum {  circle_native,  tether_native,  tether_usdt0,  l2_standard_bridged,  binance_peg,  hyperliquid_perps,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_amount')
  String? get minimumAmount;

  PerpFundingRail._();

  factory PerpFundingRail([void updates(PerpFundingRailBuilder b)]) =
      _$PerpFundingRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpFundingRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpFundingRail> get serializer =>
      _$PerpFundingRailSerializer();
}

class _$PerpFundingRailSerializer
    implements PrimitiveSerializer<PerpFundingRail> {
  @override
  final Iterable<Type> types = const [PerpFundingRail, _$PerpFundingRail];

  @override
  final String wireName = r'PerpFundingRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(PerpFundingRailRailEnum),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(PerpFundingRailNetworkEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(PerpFundingRailSettlementAssetEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(PerpFundingRailChainIdEnum),
    );
    yield r'settlement_asset_id';
    yield serializers.serialize(
      object.settlementAssetId,
      specifiedType: const FullType(PerpFundingRailSettlementAssetIdEnum),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(PerpFundingRailTokenContractEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(PerpFundingRailTokenDecimalsEnum),
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
    PerpFundingRail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpFundingRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailRailEnum),
          ) as PerpFundingRailRailEnum;
          result.rail = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailNetworkEnum),
          ) as PerpFundingRailNetworkEnum;
          result.network = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailSettlementAssetEnum),
          ) as PerpFundingRailSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailChainIdEnum),
          ) as PerpFundingRailChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'settlement_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailSettlementAssetIdEnum),
          ) as PerpFundingRailSettlementAssetIdEnum;
          result.settlementAssetId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailTokenContractEnum),
          ) as PerpFundingRailTokenContractEnum;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpFundingRailTokenDecimalsEnum),
          ) as PerpFundingRailTokenDecimalsEnum;
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
  PerpFundingRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpFundingRailBuilder();
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

class PerpFundingRailRailEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpFundingRailRailEnum perp = _$perpFundingRailRailEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailRailEnum unknownDefaultOpenApi =
      _$perpFundingRailRailEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailRailEnum> get serializer =>
      _$perpFundingRailRailEnumSerializer;

  const PerpFundingRailRailEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailRailEnum> get values =>
      _$perpFundingRailRailEnumValues;
  static PerpFundingRailRailEnum valueOf(String name) =>
      _$perpFundingRailRailEnumValueOf(name);
}

class PerpFundingRailNetworkEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const PerpFundingRailNetworkEnum hyperliquid =
      _$perpFundingRailNetworkEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailNetworkEnum unknownDefaultOpenApi =
      _$perpFundingRailNetworkEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailNetworkEnum> get serializer =>
      _$perpFundingRailNetworkEnumSerializer;

  const PerpFundingRailNetworkEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailNetworkEnum> get values =>
      _$perpFundingRailNetworkEnumValues;
  static PerpFundingRailNetworkEnum valueOf(String name) =>
      _$perpFundingRailNetworkEnumValueOf(name);
}

class PerpFundingRailSettlementAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const PerpFundingRailSettlementAssetEnum USDC =
      _$perpFundingRailSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailSettlementAssetEnum unknownDefaultOpenApi =
      _$perpFundingRailSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailSettlementAssetEnum> get serializer =>
      _$perpFundingRailSettlementAssetEnumSerializer;

  const PerpFundingRailSettlementAssetEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailSettlementAssetEnum> get values =>
      _$perpFundingRailSettlementAssetEnumValues;
  static PerpFundingRailSettlementAssetEnum valueOf(String name) =>
      _$perpFundingRailSettlementAssetEnumValueOf(name);
}

class PerpFundingRailChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1337)
  static const PerpFundingRailChainIdEnum number1337 =
      _$perpFundingRailChainIdEnum_number1337;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpFundingRailChainIdEnum unknownDefaultOpenApi =
      _$perpFundingRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailChainIdEnum> get serializer =>
      _$perpFundingRailChainIdEnumSerializer;

  const PerpFundingRailChainIdEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailChainIdEnum> get values =>
      _$perpFundingRailChainIdEnumValues;
  static PerpFundingRailChainIdEnum valueOf(String name) =>
      _$perpFundingRailChainIdEnumValueOf(name);
}

class PerpFundingRailSettlementAssetIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hyperliquid:1337/perps:USDC-PERPS')
  static const PerpFundingRailSettlementAssetIdEnum
      hyperliquidColon1337SlashPerpsColonUSDCPERPS =
      _$perpFundingRailSettlementAssetIdEnum_hyperliquidColon1337SlashPerpsColonUSDCPERPS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailSettlementAssetIdEnum unknownDefaultOpenApi =
      _$perpFundingRailSettlementAssetIdEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailSettlementAssetIdEnum> get serializer =>
      _$perpFundingRailSettlementAssetIdEnumSerializer;

  const PerpFundingRailSettlementAssetIdEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailSettlementAssetIdEnum> get values =>
      _$perpFundingRailSettlementAssetIdEnumValues;
  static PerpFundingRailSettlementAssetIdEnum valueOf(String name) =>
      _$perpFundingRailSettlementAssetIdEnumValueOf(name);
}

class PerpFundingRailTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x2100000000000000000000000000000000000000')
  static const PerpFundingRailTokenContractEnum
      n0x2100000000000000000000000000000000000000 =
      _$perpFundingRailTokenContractEnum_n0x2100000000000000000000000000000000000000;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpFundingRailTokenContractEnum unknownDefaultOpenApi =
      _$perpFundingRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailTokenContractEnum> get serializer =>
      _$perpFundingRailTokenContractEnumSerializer;

  const PerpFundingRailTokenContractEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailTokenContractEnum> get values =>
      _$perpFundingRailTokenContractEnumValues;
  static PerpFundingRailTokenContractEnum valueOf(String name) =>
      _$perpFundingRailTokenContractEnumValueOf(name);
}

class PerpFundingRailTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 8)
  static const PerpFundingRailTokenDecimalsEnum number8 =
      _$perpFundingRailTokenDecimalsEnum_number8;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const PerpFundingRailTokenDecimalsEnum unknownDefaultOpenApi =
      _$perpFundingRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<PerpFundingRailTokenDecimalsEnum> get serializer =>
      _$perpFundingRailTokenDecimalsEnumSerializer;

  const PerpFundingRailTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<PerpFundingRailTokenDecimalsEnum> get values =>
      _$perpFundingRailTokenDecimalsEnumValues;
  static PerpFundingRailTokenDecimalsEnum valueOf(String name) =>
      _$perpFundingRailTokenDecimalsEnumValueOf(name);
}
