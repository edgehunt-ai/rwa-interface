//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/arbitrum_deposit_address.dart';
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_instruction_wallet.dart';
import 'package:rwa_api_client/src/model/bsc_deposit_address.dart';
import 'package:rwa_api_client/src/model/deposit_instruction_item.dart';
import 'package:rwa_api_client/src/model/deposit_instructions_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit_instruction.g.dart';

/// Parameterless calls return the aggregate instruction directory. Calls that supply both deprecated legacy `chain` and `token` query parameters retain the original BSC or Arbitrum single-rail response. Reading, copying or displaying any variant must not create an intent, operation or user activity. 
///
/// Properties:
/// * [catalogVersion] 
/// * [wallet] - Null when no unique active verified Embedded EVM Wallet is available. In that state every item must be unavailable and therefore omit `qr_payload`. 
/// * [items] - Runtime invariant: exactly one item for each canonical Ethereum/Arbitrum/Base/BSC USDC/USDT identity, with every identity appearing exactly once. OpenAPI 3.0 cannot express uniqueness by nested identity, so the server must enforce this invariant before serialization. Items are ordered by numeric `chain_id` ascending, then by `token_contract` lexicographic ascending within the same chain. 
/// * [updatedAt] 
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
abstract class DepositInstruction implements Built<DepositInstruction, DepositInstructionBuilder> {
  /// One Of [ArbitrumDepositAddress], [BscDepositAddress], [DepositInstructionsResponse]
  OneOf get oneOf;

  DepositInstruction._();

  factory DepositInstruction([void updates(DepositInstructionBuilder b)]) = _$DepositInstruction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstruction> get serializer => _$DepositInstructionSerializer();
}

class _$DepositInstructionSerializer implements PrimitiveSerializer<DepositInstruction> {
  @override
  final Iterable<Type> types = const [DepositInstruction, _$DepositInstruction];

  @override
  final String wireName = r'DepositInstruction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstruction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositInstruction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
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
    if (serializedList.length.isOdd) {
      throw UnsupportedError('Malformed DepositInstruction key-value list');
    }
    final topLevel = <String, Object?>{};
    for (var index = 0; index < serializedList.length; index += 2) {
      final key = serializedList[index];
      if (key is! String) {
        throw UnsupportedError('DepositInstruction key must be a String');
      }
      if (topLevel.containsKey(key)) {
        throw UnsupportedError('Duplicate DepositInstruction key');
      }
      topLevel[key] = serializedList[index + 1];
    }

    final hasCatalogVersion = topLevel.containsKey(r'catalog_version');
    final hasItems = topLevel.containsKey(r'items');
    final hasChain = topLevel.containsKey(r'chain');
    final hasChainId = topLevel.containsKey(r'chain_id');
    final hasToken = topLevel.containsKey(r'token');
    final hasTokenContract = topLevel.containsKey(r'token_contract');
    final hasLegacyTupleKey = hasChain || hasChainId || hasToken || hasTokenContract;
    final chain = topLevel[r'chain'];
    final oneOfTypes = [DepositInstructionsResponse, BscDepositAddress, ArbitrumDepositAddress];
    late final Type oneOfType;
    if (hasCatalogVersion || hasItems) {
      if (!hasCatalogVersion || !hasItems || hasLegacyTupleKey) {
        throw UnsupportedError('Unsupported or ambiguous DepositInstruction aggregate payload');
      }
      oneOfType = DepositInstructionsResponse;
    } else {
      switch (chain) {
        case r'BSC':
          if (topLevel[r'chain_id'] != 56 ||
              topLevel[r'token'] != r'USDC' ||
              topLevel[r'token_contract'] != r'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d') {
            throw UnsupportedError('Unsupported or ambiguous BSC DepositInstruction tuple');
          }
          oneOfType = BscDepositAddress;
          break;
        case r'Arbitrum':
          if (topLevel[r'chain_id'] != 42161 ||
              topLevel[r'token'] != r'USDC' ||
              topLevel[r'token_contract'] != r'0xaf88d065e77c8cc2239327c5edb3a432268e5831') {
            throw UnsupportedError('Unsupported or ambiguous Arbitrum DepositInstruction tuple');
          }
          oneOfType = ArbitrumDepositAddress;
          break;
        default:
          throw UnsupportedError('Unsupported or ambiguous DepositInstruction payload');
      }
    }
    oneOfDataSrc = serialized;
    final oneOfResult = serializers.deserialize(
      oneOfDataSrc,
      specifiedType: FullType(oneOfType),
    );
    if (oneOfResult == null) {
      throw UnsupportedError('DepositInstruction variant deserialized to null');
    }
    result.oneOf = OneOfDynamic(
      typeIndex: oneOfTypes.indexOf(oneOfType),
      types: oneOfTypes,
      value: oneOfResult,
    );
    return result.build();
  }
}

class DepositInstructionChainEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const DepositInstructionChainEnum arbitrum = _$depositInstructionChainEnum_arbitrum;

  static Serializer<DepositInstructionChainEnum> get serializer => _$depositInstructionChainEnumSerializer;

  const DepositInstructionChainEnum._(String name): super(name);

  static BuiltSet<DepositInstructionChainEnum> get values => _$depositInstructionChainEnumValues;
  static DepositInstructionChainEnum valueOf(String name) => _$depositInstructionChainEnumValueOf(name);
}

class DepositInstructionChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 42161)
  static const DepositInstructionChainIdEnum number42161 = _$depositInstructionChainIdEnum_number42161;

  static Serializer<DepositInstructionChainIdEnum> get serializer => _$depositInstructionChainIdEnumSerializer;

  const DepositInstructionChainIdEnum._(String name): super(name);

  static BuiltSet<DepositInstructionChainIdEnum> get values => _$depositInstructionChainIdEnumValues;
  static DepositInstructionChainIdEnum valueOf(String name) => _$depositInstructionChainIdEnumValueOf(name);
}

class DepositInstructionTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositInstructionTokenEnum USDC = _$depositInstructionTokenEnum_USDC;

  static Serializer<DepositInstructionTokenEnum> get serializer => _$depositInstructionTokenEnumSerializer;

  const DepositInstructionTokenEnum._(String name): super(name);

  static BuiltSet<DepositInstructionTokenEnum> get values => _$depositInstructionTokenEnumValues;
  static DepositInstructionTokenEnum valueOf(String name) => _$depositInstructionTokenEnumValueOf(name);
}

class DepositInstructionTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const DepositInstructionTokenContractEnum n0xaf88d065e77c8cc2239327c5edb3a432268e5831 = _$depositInstructionTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;

  static Serializer<DepositInstructionTokenContractEnum> get serializer => _$depositInstructionTokenContractEnumSerializer;

  const DepositInstructionTokenContractEnum._(String name): super(name);

  static BuiltSet<DepositInstructionTokenContractEnum> get values => _$depositInstructionTokenContractEnumValues;
  static DepositInstructionTokenContractEnum valueOf(String name) => _$depositInstructionTokenContractEnumValueOf(name);
}

class DepositInstructionTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 6)
  static const DepositInstructionTokenDecimalsEnum number6 = _$depositInstructionTokenDecimalsEnum_number6;

  static Serializer<DepositInstructionTokenDecimalsEnum> get serializer => _$depositInstructionTokenDecimalsEnumSerializer;

  const DepositInstructionTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<DepositInstructionTokenDecimalsEnum> get values => _$depositInstructionTokenDecimalsEnumValues;
  static DepositInstructionTokenDecimalsEnum valueOf(String name) => _$depositInstructionTokenDecimalsEnumValueOf(name);
}

class DepositInstructionConfirmationsRequiredEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 20)
  static const DepositInstructionConfirmationsRequiredEnum number20 = _$depositInstructionConfirmationsRequiredEnum_number20;

  static Serializer<DepositInstructionConfirmationsRequiredEnum> get serializer => _$depositInstructionConfirmationsRequiredEnumSerializer;

  const DepositInstructionConfirmationsRequiredEnum._(String name): super(name);

  static BuiltSet<DepositInstructionConfirmationsRequiredEnum> get values => _$depositInstructionConfirmationsRequiredEnumValues;
  static DepositInstructionConfirmationsRequiredEnum valueOf(String name) => _$depositInstructionConfirmationsRequiredEnumValueOf(name);
}

