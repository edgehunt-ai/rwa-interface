//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_base.dart';
import 'package:rwa_api_client/src/model/deposit_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'arbitrum_confirmed_deposit.g.dart';

/// ArbitrumConfirmedDeposit
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
@BuiltValue()
abstract class ArbitrumConfirmedDeposit
    implements
        DepositBase,
        Built<ArbitrumConfirmedDeposit, ArbitrumConfirmedDepositBuilder> {
  ArbitrumConfirmedDeposit._();

  factory ArbitrumConfirmedDeposit(
          [void updates(ArbitrumConfirmedDepositBuilder b)]) =
      _$ArbitrumConfirmedDeposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArbitrumConfirmedDepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArbitrumConfirmedDeposit> get serializer =>
      _$ArbitrumConfirmedDepositSerializer();
}

class _$ArbitrumConfirmedDepositSerializer
    implements PrimitiveSerializer<ArbitrumConfirmedDeposit> {
  @override
  final Iterable<Type> types = const [
    ArbitrumConfirmedDeposit,
    _$ArbitrumConfirmedDeposit
  ];

  @override
  final String wireName = r'ArbitrumConfirmedDeposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArbitrumConfirmedDeposit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'block_hash';
    yield serializers.serialize(
      object.blockHash,
      specifiedType: const FullType(String),
    );
    yield r'deposit_id';
    yield serializers.serialize(
      object.depositId,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'log_index';
    yield serializers.serialize(
      object.logIndex,
      specifiedType: const FullType(int),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'confirmations';
    yield serializers.serialize(
      object.confirmations,
      specifiedType: const FullType(int),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(DepositBaseTokenEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'sender';
    yield serializers.serialize(
      object.sender,
      specifiedType: const FullType(String),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
    );
    yield r'block_number';
    yield serializers.serialize(
      object.blockNumber,
      specifiedType: const FullType(int),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(String),
    );
    yield r'detected_at';
    yield serializers.serialize(
      object.detectedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'amount_raw';
    yield serializers.serialize(
      object.amountRaw,
      specifiedType: const FullType(String),
    );
    yield r'confirmed_at';
    yield serializers.serialize(
      object.confirmedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(DepositStatus),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ArbitrumConfirmedDeposit object, {
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
    required ArbitrumConfirmedDepositBuilder result,
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
        case r'block_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.blockHash = valueDes;
          break;
        case r'deposit_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.depositId = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.logIndex = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmations = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositBaseTokenEnum),
          ) as DepositBaseTokenEnum;
          result.token = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'sender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sender = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
          break;
        case r'block_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.blockNumber = valueDes;
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipient = valueDes;
          break;
        case r'detected_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.detectedAt = valueDes;
          break;
        case r'amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountRaw = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.confirmedAt = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositStatus),
          ) as DepositStatus;
          result.status = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ArbitrumConfirmedDeposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArbitrumConfirmedDepositBuilder();
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

class ArbitrumConfirmedDepositChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ArbitrumConfirmedDepositChainEnum arbitrum =
      _$arbitrumConfirmedDepositChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumConfirmedDepositChainEnum unknownDefaultOpenApi =
      _$arbitrumConfirmedDepositChainEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumConfirmedDepositChainEnum> get serializer =>
      _$arbitrumConfirmedDepositChainEnumSerializer;

  const ArbitrumConfirmedDepositChainEnum._(String name) : super(name);

  static BuiltSet<ArbitrumConfirmedDepositChainEnum> get values =>
      _$arbitrumConfirmedDepositChainEnumValues;
  static ArbitrumConfirmedDepositChainEnum valueOf(String name) =>
      _$arbitrumConfirmedDepositChainEnumValueOf(name);
}

class ArbitrumConfirmedDepositChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const ArbitrumConfirmedDepositChainIdEnum number42161 =
      _$arbitrumConfirmedDepositChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumConfirmedDepositChainIdEnum unknownDefaultOpenApi =
      _$arbitrumConfirmedDepositChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumConfirmedDepositChainIdEnum> get serializer =>
      _$arbitrumConfirmedDepositChainIdEnumSerializer;

  const ArbitrumConfirmedDepositChainIdEnum._(String name) : super(name);

  static BuiltSet<ArbitrumConfirmedDepositChainIdEnum> get values =>
      _$arbitrumConfirmedDepositChainIdEnumValues;
  static ArbitrumConfirmedDepositChainIdEnum valueOf(String name) =>
      _$arbitrumConfirmedDepositChainIdEnumValueOf(name);
}

class ArbitrumConfirmedDepositTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const ArbitrumConfirmedDepositTokenEnum USDC =
      _$arbitrumConfirmedDepositTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumConfirmedDepositTokenEnum unknownDefaultOpenApi =
      _$arbitrumConfirmedDepositTokenEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumConfirmedDepositTokenEnum> get serializer =>
      _$arbitrumConfirmedDepositTokenEnumSerializer;

  const ArbitrumConfirmedDepositTokenEnum._(String name) : super(name);

  static BuiltSet<ArbitrumConfirmedDepositTokenEnum> get values =>
      _$arbitrumConfirmedDepositTokenEnumValues;
  static ArbitrumConfirmedDepositTokenEnum valueOf(String name) =>
      _$arbitrumConfirmedDepositTokenEnumValueOf(name);
}

class ArbitrumConfirmedDepositTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const ArbitrumConfirmedDepositTokenContractEnum
      n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
      _$arbitrumConfirmedDepositTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumConfirmedDepositTokenContractEnum unknownDefaultOpenApi =
      _$arbitrumConfirmedDepositTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumConfirmedDepositTokenContractEnum> get serializer =>
      _$arbitrumConfirmedDepositTokenContractEnumSerializer;

  const ArbitrumConfirmedDepositTokenContractEnum._(String name) : super(name);

  static BuiltSet<ArbitrumConfirmedDepositTokenContractEnum> get values =>
      _$arbitrumConfirmedDepositTokenContractEnumValues;
  static ArbitrumConfirmedDepositTokenContractEnum valueOf(String name) =>
      _$arbitrumConfirmedDepositTokenContractEnumValueOf(name);
}

class ArbitrumConfirmedDepositTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const ArbitrumConfirmedDepositTokenDecimalsEnum number6 =
      _$arbitrumConfirmedDepositTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumConfirmedDepositTokenDecimalsEnum unknownDefaultOpenApi =
      _$arbitrumConfirmedDepositTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumConfirmedDepositTokenDecimalsEnum> get serializer =>
      _$arbitrumConfirmedDepositTokenDecimalsEnumSerializer;

  const ArbitrumConfirmedDepositTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<ArbitrumConfirmedDepositTokenDecimalsEnum> get values =>
      _$arbitrumConfirmedDepositTokenDecimalsEnumValues;
  static ArbitrumConfirmedDepositTokenDecimalsEnum valueOf(String name) =>
      _$arbitrumConfirmedDepositTokenDecimalsEnumValueOf(name);
}
