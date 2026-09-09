//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_rail_availability.dart';
import 'package:rwa_api_client/src/model/deposit_rail_base.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bsc_deposit_rail.g.dart';

/// BscDepositRail
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
abstract class BscDepositRail
    implements DepositRailBase, Built<BscDepositRail, BscDepositRailBuilder> {
  BscDepositRail._();

  factory BscDepositRail([void updates(BscDepositRailBuilder b)]) =
      _$BscDepositRail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BscDepositRailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BscDepositRail> get serializer =>
      _$BscDepositRailSerializer();
}

class _$BscDepositRailSerializer
    implements PrimitiveSerializer<BscDepositRail> {
  @override
  final Iterable<Type> types = const [BscDepositRail, _$BscDepositRail];

  @override
  final String wireName = r'BscDepositRail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BscDepositRail object, {
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
    BscDepositRail object, {
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
    required BscDepositRailBuilder result,
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
  BscDepositRail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BscDepositRailBuilder();
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

class BscDepositRailChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BSC')
  static const BscDepositRailChainEnum BSC = _$bscDepositRailChainEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositRailChainEnum unknownDefaultOpenApi =
      _$bscDepositRailChainEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailChainEnum> get serializer =>
      _$bscDepositRailChainEnumSerializer;

  const BscDepositRailChainEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailChainEnum> get values =>
      _$bscDepositRailChainEnumValues;
  static BscDepositRailChainEnum valueOf(String name) =>
      _$bscDepositRailChainEnumValueOf(name);
}

class BscDepositRailChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 56)
  static const BscDepositRailChainIdEnum number56 =
      _$bscDepositRailChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositRailChainIdEnum unknownDefaultOpenApi =
      _$bscDepositRailChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailChainIdEnum> get serializer =>
      _$bscDepositRailChainIdEnumSerializer;

  const BscDepositRailChainIdEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailChainIdEnum> get values =>
      _$bscDepositRailChainIdEnumValues;
  static BscDepositRailChainIdEnum valueOf(String name) =>
      _$bscDepositRailChainIdEnumValueOf(name);
}

class BscDepositRailTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const BscDepositRailTokenEnum USDC = _$bscDepositRailTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositRailTokenEnum unknownDefaultOpenApi =
      _$bscDepositRailTokenEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailTokenEnum> get serializer =>
      _$bscDepositRailTokenEnumSerializer;

  const BscDepositRailTokenEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailTokenEnum> get values =>
      _$bscDepositRailTokenEnumValues;
  static BscDepositRailTokenEnum valueOf(String name) =>
      _$bscDepositRailTokenEnumValueOf(name);
}

class BscDepositRailTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d')
  static const BscDepositRailTokenContractEnum
      n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d =
      _$bscDepositRailTokenContractEnum_n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositRailTokenContractEnum unknownDefaultOpenApi =
      _$bscDepositRailTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailTokenContractEnum> get serializer =>
      _$bscDepositRailTokenContractEnumSerializer;

  const BscDepositRailTokenContractEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailTokenContractEnum> get values =>
      _$bscDepositRailTokenContractEnumValues;
  static BscDepositRailTokenContractEnum valueOf(String name) =>
      _$bscDepositRailTokenContractEnumValueOf(name);
}

class BscDepositRailTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 18)
  static const BscDepositRailTokenDecimalsEnum number18 =
      _$bscDepositRailTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositRailTokenDecimalsEnum unknownDefaultOpenApi =
      _$bscDepositRailTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailTokenDecimalsEnum> get serializer =>
      _$bscDepositRailTokenDecimalsEnumSerializer;

  const BscDepositRailTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailTokenDecimalsEnum> get values =>
      _$bscDepositRailTokenDecimalsEnumValues;
  static BscDepositRailTokenDecimalsEnum valueOf(String name) =>
      _$bscDepositRailTokenDecimalsEnumValueOf(name);
}

class BscDepositRailConfirmationsRequiredEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 15)
  static const BscDepositRailConfirmationsRequiredEnum number15 =
      _$bscDepositRailConfirmationsRequiredEnum_number15;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositRailConfirmationsRequiredEnum unknownDefaultOpenApi =
      _$bscDepositRailConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositRailConfirmationsRequiredEnum> get serializer =>
      _$bscDepositRailConfirmationsRequiredEnumSerializer;

  const BscDepositRailConfirmationsRequiredEnum._(String name) : super(name);

  static BuiltSet<BscDepositRailConfirmationsRequiredEnum> get values =>
      _$bscDepositRailConfirmationsRequiredEnumValues;
  static BscDepositRailConfirmationsRequiredEnum valueOf(String name) =>
      _$bscDepositRailConfirmationsRequiredEnumValueOf(name);
}
