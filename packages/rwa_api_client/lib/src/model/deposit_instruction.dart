//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/arbitrum_deposit_address.dart';
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bsc_deposit_address.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit_instruction.g.dart';

/// 当前账号的只读入金指引。读取、复制地址或展示二维码不得创建入金意图、操作或用户历史记录。
///
/// Properties:
/// * [chain]
/// * [chainId]
/// * [token]
/// * [tokenContract]
/// * [tokenDecimals]
/// * [address] - 当前账号唯一、active 且已验证的 Privy EVM 钱包地址。
/// * [memo] - 部分链需要的备注 / tag
/// * [qrPayload]
/// * [minDeposit] - 必须大于零；服务端按精确十进制语义校验。
/// * [confirmationsRequired]
/// * [estimatedArrivalSeconds] - 达到当前 rail 确认门槛的保守预计时间；不是结算保证。
/// * [creditedTo]
/// * [warning]
@BuiltValue()
abstract class DepositInstruction
    implements Built<DepositInstruction, DepositInstructionBuilder> {
  /// One Of [ArbitrumDepositAddress], [BscDepositAddress]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'chain';

  static const Map<String, Type> discriminatorMapping = {
    r'Arbitrum': ArbitrumDepositAddress,
    r'BSC': BscDepositAddress,
  };

  DepositInstruction._();

  factory DepositInstruction([void updates(DepositInstructionBuilder b)]) =
      _$DepositInstruction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstruction> get serializer =>
      _$DepositInstructionSerializer();
}

extension DepositInstructionDiscriminatorExt on DepositInstruction {
  String? get discriminatorValue {
    if (this is ArbitrumDepositAddress) {
      return r'Arbitrum';
    }
    if (this is BscDepositAddress) {
      return r'BSC';
    }
    return null;
  }
}

extension DepositInstructionBuilderDiscriminatorExt
    on DepositInstructionBuilder {
  String? get discriminatorValue {
    if (this is ArbitrumDepositAddressBuilder) {
      return r'Arbitrum';
    }
    if (this is BscDepositAddressBuilder) {
      return r'BSC';
    }
    return null;
  }
}

class _$DepositInstructionSerializer
    implements PrimitiveSerializer<DepositInstruction> {
  @override
  final Iterable<Type> types = const [DepositInstruction, _$DepositInstruction];

  @override
  final String wireName = r'DepositInstruction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstruction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    DepositInstruction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  DepositInstruction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex =
        serializedList.indexOf(DepositInstruction.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      ArbitrumDepositAddress,
      BscDepositAddress,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'Arbitrum':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(ArbitrumDepositAddress),
        ) as ArbitrumDepositAddress;
        oneOfType = ArbitrumDepositAddress;
        break;
      case r'BSC':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BscDepositAddress),
        ) as BscDepositAddress;
        oneOfType = BscDepositAddress;
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

class DepositInstructionChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const DepositInstructionChainEnum arbitrum =
      _$depositInstructionChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositInstructionChainEnum unknownDefaultOpenApi =
      _$depositInstructionChainEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionChainEnum> get serializer =>
      _$depositInstructionChainEnumSerializer;

  const DepositInstructionChainEnum._(String name) : super(name);

  static BuiltSet<DepositInstructionChainEnum> get values =>
      _$depositInstructionChainEnumValues;
  static DepositInstructionChainEnum valueOf(String name) =>
      _$depositInstructionChainEnumValueOf(name);
}

class DepositInstructionChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const DepositInstructionChainIdEnum number42161 =
      _$depositInstructionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositInstructionChainIdEnum unknownDefaultOpenApi =
      _$depositInstructionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionChainIdEnum> get serializer =>
      _$depositInstructionChainIdEnumSerializer;

  const DepositInstructionChainIdEnum._(String name) : super(name);

  static BuiltSet<DepositInstructionChainIdEnum> get values =>
      _$depositInstructionChainIdEnumValues;
  static DepositInstructionChainIdEnum valueOf(String name) =>
      _$depositInstructionChainIdEnumValueOf(name);
}

class DepositInstructionTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositInstructionTokenEnum USDC =
      _$depositInstructionTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositInstructionTokenEnum unknownDefaultOpenApi =
      _$depositInstructionTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionTokenEnum> get serializer =>
      _$depositInstructionTokenEnumSerializer;

  const DepositInstructionTokenEnum._(String name) : super(name);

  static BuiltSet<DepositInstructionTokenEnum> get values =>
      _$depositInstructionTokenEnumValues;
  static DepositInstructionTokenEnum valueOf(String name) =>
      _$depositInstructionTokenEnumValueOf(name);
}

class DepositInstructionTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const DepositInstructionTokenContractEnum
      n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
      _$depositInstructionTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositInstructionTokenContractEnum unknownDefaultOpenApi =
      _$depositInstructionTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionTokenContractEnum> get serializer =>
      _$depositInstructionTokenContractEnumSerializer;

  const DepositInstructionTokenContractEnum._(String name) : super(name);

  static BuiltSet<DepositInstructionTokenContractEnum> get values =>
      _$depositInstructionTokenContractEnumValues;
  static DepositInstructionTokenContractEnum valueOf(String name) =>
      _$depositInstructionTokenContractEnumValueOf(name);
}

class DepositInstructionTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const DepositInstructionTokenDecimalsEnum number6 =
      _$depositInstructionTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositInstructionTokenDecimalsEnum unknownDefaultOpenApi =
      _$depositInstructionTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionTokenDecimalsEnum> get serializer =>
      _$depositInstructionTokenDecimalsEnumSerializer;

  const DepositInstructionTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<DepositInstructionTokenDecimalsEnum> get values =>
      _$depositInstructionTokenDecimalsEnumValues;
  static DepositInstructionTokenDecimalsEnum valueOf(String name) =>
      _$depositInstructionTokenDecimalsEnumValueOf(name);
}

class DepositInstructionConfirmationsRequiredEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 20)
  static const DepositInstructionConfirmationsRequiredEnum number20 =
      _$depositInstructionConfirmationsRequiredEnum_number20;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const DepositInstructionConfirmationsRequiredEnum
      unknownDefaultOpenApi =
      _$depositInstructionConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<DepositInstructionConfirmationsRequiredEnum>
      get serializer => _$depositInstructionConfirmationsRequiredEnumSerializer;

  const DepositInstructionConfirmationsRequiredEnum._(String name)
      : super(name);

  static BuiltSet<DepositInstructionConfirmationsRequiredEnum> get values =>
      _$depositInstructionConfirmationsRequiredEnumValues;
  static DepositInstructionConfirmationsRequiredEnum valueOf(String name) =>
      _$depositInstructionConfirmationsRequiredEnumValueOf(name);
}
