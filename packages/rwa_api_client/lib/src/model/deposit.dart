//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/arbitrum_confirmed_deposit.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/legacy_deposit_status.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/deposit_address.dart';
import 'package:rwa_api_client/src/model/bsc_confirmed_deposit.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:rwa_api_client/src/model/legacy_deposit.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit.g.dart';

/// 已由链上 receipt、精确 Transfer、canonical block 和确认数独立核验的正式入金事实。
///
/// Properties:
/// * [depositId]
/// * [chain]
/// * [chainId]
/// * [token]
/// * [tokenContract]
/// * [tokenDecimals]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [amountRaw] - ERC-20 Transfer log 中的精确原始整数金额。
/// * [status]
/// * [confirmations]
/// * [confirmationsRequired]
/// * [txHash]
/// * [logIndex]
/// * [blockNumber]
/// * [blockHash]
/// * [sender]
/// * [recipient]
/// * [detectedAt]
/// * [confirmedAt]
/// * [updatedAt]
/// * [creditedTo]
/// * [requiresTransfer]
/// * [activityId]
/// * [createdAt]
/// * [creditedAt]
/// * [instructions]
@BuiltValue()
abstract class Deposit implements Built<Deposit, DepositBuilder> {
  /// One Of [ArbitrumConfirmedDeposit], [BscConfirmedDeposit], [LegacyDeposit]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'chain';

  static const Map<String, Type> discriminatorMapping = {
    r'Arbitrum': ArbitrumConfirmedDeposit,
    r'BSC': BscConfirmedDeposit,
  };

  Deposit._();

  factory Deposit([void updates(DepositBuilder b)]) = _$Deposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Deposit> get serializer => _$DepositSerializer();
}

extension DepositDiscriminatorExt on Deposit {
  String? get discriminatorValue {
    if (this is ArbitrumConfirmedDeposit) {
      return r'Arbitrum';
    }
    if (this is BscConfirmedDeposit) {
      return r'BSC';
    }
    return null;
  }
}

extension DepositBuilderDiscriminatorExt on DepositBuilder {
  String? get discriminatorValue {
    if (this is ArbitrumConfirmedDepositBuilder) {
      return r'Arbitrum';
    }
    if (this is BscConfirmedDepositBuilder) {
      return r'BSC';
    }
    return null;
  }
}

class _$DepositSerializer implements PrimitiveSerializer<Deposit> {
  @override
  final Iterable<Type> types = const [Deposit, _$Deposit];

  @override
  final String wireName = r'Deposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Deposit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    Deposit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  Deposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex =
        serializedList.indexOf(Deposit.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      ArbitrumConfirmedDeposit,
      BscConfirmedDeposit,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'Arbitrum':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ArbitrumConfirmedDeposit),
        ) as ArbitrumConfirmedDeposit;
        oneOfType = ArbitrumConfirmedDeposit;
        break;
      case r'BSC':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BscConfirmedDeposit),
        ) as BscConfirmedDeposit;
        oneOfType = BscConfirmedDeposit;
        break;
      default:
        throw UnsupportedError(
            "Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(
        typeIndex: oneOfTypes.indexOf(oneOfType),
        types: oneOfTypes,
        value: oneOfResult);
    return result.build();
  }
}

class DepositChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const DepositChainIdEnum number42161 =
      _$depositChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositChainIdEnum unknownDefaultOpenApi =
      _$depositChainIdEnum_unknownDefaultOpenApi;

  static Serializer<DepositChainIdEnum> get serializer =>
      _$depositChainIdEnumSerializer;

  const DepositChainIdEnum._(String name) : super(name);

  static BuiltSet<DepositChainIdEnum> get values => _$depositChainIdEnumValues;
  static DepositChainIdEnum valueOf(String name) =>
      _$depositChainIdEnumValueOf(name);
}

class DepositTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositTokenEnum USDC = _$depositTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositTokenEnum unknownDefaultOpenApi =
      _$depositTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositTokenEnum> get serializer =>
      _$depositTokenEnumSerializer;

  const DepositTokenEnum._(String name) : super(name);

  static BuiltSet<DepositTokenEnum> get values => _$depositTokenEnumValues;
  static DepositTokenEnum valueOf(String name) =>
      _$depositTokenEnumValueOf(name);
}

class DepositTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const DepositTokenContractEnum
      n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
      _$depositTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositTokenContractEnum unknownDefaultOpenApi =
      _$depositTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<DepositTokenContractEnum> get serializer =>
      _$depositTokenContractEnumSerializer;

  const DepositTokenContractEnum._(String name) : super(name);

  static BuiltSet<DepositTokenContractEnum> get values =>
      _$depositTokenContractEnumValues;
  static DepositTokenContractEnum valueOf(String name) =>
      _$depositTokenContractEnumValueOf(name);
}

class DepositTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const DepositTokenDecimalsEnum number6 =
      _$depositTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositTokenDecimalsEnum unknownDefaultOpenApi =
      _$depositTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<DepositTokenDecimalsEnum> get serializer =>
      _$depositTokenDecimalsEnumSerializer;

  const DepositTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<DepositTokenDecimalsEnum> get values =>
      _$depositTokenDecimalsEnumValues;
  static DepositTokenDecimalsEnum valueOf(String name) =>
      _$depositTokenDecimalsEnumValueOf(name);
}
