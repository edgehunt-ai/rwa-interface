//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_rail_availability.dart';
import 'package:rwa_api_client/src/model/deposit_rail_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'arbitrum_deposit_rail.g.dart';

/// ArbitrumDepositRail
///
/// Properties:
/// * [chain]
/// * [chainId]
/// * [token]
/// * [tokenContract]
/// * [tokenDecimals]
/// * [minimumAmount] - 必须大于零；服务端按精确十进制语义校验。
/// * [confirmationsRequired]
/// * [availability]
@BuiltValue()
abstract class ArbitrumDepositRail
    implements
        DepositRailBase,
        Built<ArbitrumDepositRail, ArbitrumDepositRailBuilder> {
  ArbitrumDepositRail._();

  factory ArbitrumDepositRail([void updates(ArbitrumDepositRailBuilder b)]) =
      _$ArbitrumDepositRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArbitrumDepositRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArbitrumDepositRail> get serializer =>
      _$ArbitrumDepositRailSerializer();
}

class _$ArbitrumDepositRailSerializer
    implements PrimitiveSerializer<ArbitrumDepositRail> {
  @override
  final Iterable<Type> types = const [
    ArbitrumDepositRail,
    _$ArbitrumDepositRail
  ];

  @override
  final String wireName = r'ArbitrumDepositRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArbitrumDepositRail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
    );
    yield r'minimum_amount';
    yield serializers.serialize(
      object.minimumAmount,
      specifiedType: const FullType(String),
    );
    yield r'availability';
    yield serializers.serialize(
      object.availability,
      specifiedType: const FullType(DepositRailAvailability),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ArbitrumDepositRail object, {
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
    required ArbitrumDepositRailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chain = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
          break;
        case r'minimum_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumAmount = valueDes;
          break;
        case r'availability':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositRailAvailability),
          ) as DepositRailAvailability;
          result.availability.replace(valueDes);
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ArbitrumDepositRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArbitrumDepositRailBuilder();
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

class ArbitrumDepositRailChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ArbitrumDepositRailChainEnum arbitrum =
      _$arbitrumDepositRailChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositRailChainEnum unknownDefaultOpenApi =
      _$arbitrumDepositRailChainEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailChainEnum> get serializer =>
      _$arbitrumDepositRailChainEnumSerializer;

  const ArbitrumDepositRailChainEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositRailChainEnum> get values =>
      _$arbitrumDepositRailChainEnumValues;
  static ArbitrumDepositRailChainEnum valueOf(String name) =>
      _$arbitrumDepositRailChainEnumValueOf(name);
}

class ArbitrumDepositRailChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const ArbitrumDepositRailChainIdEnum number42161 =
      _$arbitrumDepositRailChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositRailChainIdEnum unknownDefaultOpenApi =
      _$arbitrumDepositRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailChainIdEnum> get serializer =>
      _$arbitrumDepositRailChainIdEnumSerializer;

  const ArbitrumDepositRailChainIdEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositRailChainIdEnum> get values =>
      _$arbitrumDepositRailChainIdEnumValues;
  static ArbitrumDepositRailChainIdEnum valueOf(String name) =>
      _$arbitrumDepositRailChainIdEnumValueOf(name);
}

class ArbitrumDepositRailTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const ArbitrumDepositRailTokenEnum USDC =
      _$arbitrumDepositRailTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositRailTokenEnum unknownDefaultOpenApi =
      _$arbitrumDepositRailTokenEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailTokenEnum> get serializer =>
      _$arbitrumDepositRailTokenEnumSerializer;

  const ArbitrumDepositRailTokenEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositRailTokenEnum> get values =>
      _$arbitrumDepositRailTokenEnumValues;
  static ArbitrumDepositRailTokenEnum valueOf(String name) =>
      _$arbitrumDepositRailTokenEnumValueOf(name);
}

class ArbitrumDepositRailTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const ArbitrumDepositRailTokenContractEnum
      n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
      _$arbitrumDepositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositRailTokenContractEnum unknownDefaultOpenApi =
      _$arbitrumDepositRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailTokenContractEnum> get serializer =>
      _$arbitrumDepositRailTokenContractEnumSerializer;

  const ArbitrumDepositRailTokenContractEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositRailTokenContractEnum> get values =>
      _$arbitrumDepositRailTokenContractEnumValues;
  static ArbitrumDepositRailTokenContractEnum valueOf(String name) =>
      _$arbitrumDepositRailTokenContractEnumValueOf(name);
}

class ArbitrumDepositRailTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const ArbitrumDepositRailTokenDecimalsEnum number6 =
      _$arbitrumDepositRailTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositRailTokenDecimalsEnum unknownDefaultOpenApi =
      _$arbitrumDepositRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailTokenDecimalsEnum> get serializer =>
      _$arbitrumDepositRailTokenDecimalsEnumSerializer;

  const ArbitrumDepositRailTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositRailTokenDecimalsEnum> get values =>
      _$arbitrumDepositRailTokenDecimalsEnumValues;
  static ArbitrumDepositRailTokenDecimalsEnum valueOf(String name) =>
      _$arbitrumDepositRailTokenDecimalsEnumValueOf(name);
}

class ArbitrumDepositRailConfirmationsRequiredEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 20)
  static const ArbitrumDepositRailConfirmationsRequiredEnum number20 =
      _$arbitrumDepositRailConfirmationsRequiredEnum_number20;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositRailConfirmationsRequiredEnum
      unknownDefaultOpenApi =
      _$arbitrumDepositRailConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositRailConfirmationsRequiredEnum>
      get serializer =>
          _$arbitrumDepositRailConfirmationsRequiredEnumSerializer;

  const ArbitrumDepositRailConfirmationsRequiredEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumDepositRailConfirmationsRequiredEnum> get values =>
      _$arbitrumDepositRailConfirmationsRequiredEnumValues;
  static ArbitrumDepositRailConfirmationsRequiredEnum valueOf(String name) =>
      _$arbitrumDepositRailConfirmationsRequiredEnumValueOf(name);
}
