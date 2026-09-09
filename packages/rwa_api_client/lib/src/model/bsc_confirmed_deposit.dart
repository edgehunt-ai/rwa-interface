//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_base.dart';
import 'package:rwa_api_client/src/model/deposit_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bsc_confirmed_deposit.g.dart';

/// BscConfirmedDeposit
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
abstract class BscConfirmedDeposit implements DepositBase, Built<BscConfirmedDeposit, BscConfirmedDepositBuilder> {
  BscConfirmedDeposit._();

  factory BscConfirmedDeposit([void updates(BscConfirmedDepositBuilder b)]) = _$BscConfirmedDeposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BscConfirmedDepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BscConfirmedDeposit> get serializer => _$BscConfirmedDepositSerializer();
}

class _$BscConfirmedDepositSerializer implements PrimitiveSerializer<BscConfirmedDeposit> {
  @override
  final Iterable<Type> types = const [BscConfirmedDeposit, _$BscConfirmedDeposit];

  @override
  final String wireName = r'BscConfirmedDeposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BscConfirmedDeposit object, {
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
    BscConfirmedDeposit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BscConfirmedDepositBuilder result,
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
  BscConfirmedDeposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BscConfirmedDepositBuilder();
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

class BscConfirmedDepositChainEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BscConfirmedDepositChainEnum BSC = _$bscConfirmedDepositChainEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscConfirmedDepositChainEnum unknownDefaultOpenApi = _$bscConfirmedDepositChainEnum_unknownDefaultOpenApi;

  static Serializer<BscConfirmedDepositChainEnum> get serializer => _$bscConfirmedDepositChainEnumSerializer;

  const BscConfirmedDepositChainEnum._(String name): super(name);

  static BuiltSet<BscConfirmedDepositChainEnum> get values => _$bscConfirmedDepositChainEnumValues;
  static BscConfirmedDepositChainEnum valueOf(String name) => _$bscConfirmedDepositChainEnumValueOf(name);
}

class BscConfirmedDepositChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BscConfirmedDepositChainIdEnum number56 = _$bscConfirmedDepositChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscConfirmedDepositChainIdEnum unknownDefaultOpenApi = _$bscConfirmedDepositChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BscConfirmedDepositChainIdEnum> get serializer => _$bscConfirmedDepositChainIdEnumSerializer;

  const BscConfirmedDepositChainIdEnum._(String name): super(name);

  static BuiltSet<BscConfirmedDepositChainIdEnum> get values => _$bscConfirmedDepositChainIdEnumValues;
  static BscConfirmedDepositChainIdEnum valueOf(String name) => _$bscConfirmedDepositChainIdEnumValueOf(name);
}

class BscConfirmedDepositTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const BscConfirmedDepositTokenEnum USDC = _$bscConfirmedDepositTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscConfirmedDepositTokenEnum unknownDefaultOpenApi = _$bscConfirmedDepositTokenEnum_unknownDefaultOpenApi;

  static Serializer<BscConfirmedDepositTokenEnum> get serializer => _$bscConfirmedDepositTokenEnumSerializer;

  const BscConfirmedDepositTokenEnum._(String name): super(name);

  static BuiltSet<BscConfirmedDepositTokenEnum> get values => _$bscConfirmedDepositTokenEnumValues;
  static BscConfirmedDepositTokenEnum valueOf(String name) => _$bscConfirmedDepositTokenEnumValueOf(name);
}

class BscConfirmedDepositTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d')
  static const BscConfirmedDepositTokenContractEnum n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d = _$bscConfirmedDepositTokenContractEnum_n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscConfirmedDepositTokenContractEnum unknownDefaultOpenApi = _$bscConfirmedDepositTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BscConfirmedDepositTokenContractEnum> get serializer => _$bscConfirmedDepositTokenContractEnumSerializer;

  const BscConfirmedDepositTokenContractEnum._(String name): super(name);

  static BuiltSet<BscConfirmedDepositTokenContractEnum> get values => _$bscConfirmedDepositTokenContractEnumValues;
  static BscConfirmedDepositTokenContractEnum valueOf(String name) => _$bscConfirmedDepositTokenContractEnumValueOf(name);
}

class BscConfirmedDepositTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BscConfirmedDepositTokenDecimalsEnum number18 = _$bscConfirmedDepositTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscConfirmedDepositTokenDecimalsEnum unknownDefaultOpenApi = _$bscConfirmedDepositTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BscConfirmedDepositTokenDecimalsEnum> get serializer => _$bscConfirmedDepositTokenDecimalsEnumSerializer;

  const BscConfirmedDepositTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BscConfirmedDepositTokenDecimalsEnum> get values => _$bscConfirmedDepositTokenDecimalsEnumValues;
  static BscConfirmedDepositTokenDecimalsEnum valueOf(String name) => _$bscConfirmedDepositTokenDecimalsEnumValueOf(name);
}

