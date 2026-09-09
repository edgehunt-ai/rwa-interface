//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_address_base.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bsc_deposit_address.g.dart';

/// BscDepositAddress
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
abstract class BscDepositAddress implements DepositAddressBase, Built<BscDepositAddress, BscDepositAddressBuilder> {
  BscDepositAddress._();

  factory BscDepositAddress([void updates(BscDepositAddressBuilder b)]) = _$BscDepositAddress;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BscDepositAddressBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BscDepositAddress> get serializer => _$BscDepositAddressSerializer();
}

class _$BscDepositAddressSerializer implements PrimitiveSerializer<BscDepositAddress> {
  @override
  final Iterable<Type> types = const [BscDepositAddress, _$BscDepositAddress];

  @override
  final String wireName = r'BscDepositAddress';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BscDepositAddress object, {
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
    yield r'qr_payload';
    yield serializers.serialize(
      object.qrPayload,
      specifiedType: const FullType(String),
    );
    yield r'estimated_arrival_seconds';
    yield serializers.serialize(
      object.estimatedArrivalSeconds,
      specifiedType: const FullType(int),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    if (object.memo != null) {
      yield r'memo';
      yield serializers.serialize(
        object.memo,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(DepositAddressBaseChainIdEnum),
    );
    yield r'token_decimals';
    yield serializers.serialize(
      object.tokenDecimals,
      specifiedType: const FullType(int),
    );
    yield r'credited_to';
    yield serializers.serialize(
      object.creditedTo,
      specifiedType: const FullType(DepositCreditTarget),
    );
    yield r'warning';
    yield serializers.serialize(
      object.warning,
      specifiedType: const FullType(String),
    );
    yield r'min_deposit';
    yield serializers.serialize(
      object.minDeposit,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BscDepositAddress object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BscDepositAddressBuilder result,
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
        case r'qr_payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.qrPayload = valueDes;
          break;
        case r'estimated_arrival_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.estimatedArrivalSeconds = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'memo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.memo = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositAddressBaseChainIdEnum),
          ) as DepositAddressBaseChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'token_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.tokenDecimals = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositCreditTarget),
          ) as DepositCreditTarget;
          result.creditedTo = valueDes;
          break;
        case r'warning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.warning = valueDes;
          break;
        case r'min_deposit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minDeposit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BscDepositAddress deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BscDepositAddressBuilder();
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

class BscDepositAddressChainEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const BscDepositAddressChainEnum BSC = _$bscDepositAddressChainEnum_BSC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositAddressChainEnum unknownDefaultOpenApi = _$bscDepositAddressChainEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressChainEnum> get serializer => _$bscDepositAddressChainEnumSerializer;

  const BscDepositAddressChainEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressChainEnum> get values => _$bscDepositAddressChainEnumValues;
  static BscDepositAddressChainEnum valueOf(String name) => _$bscDepositAddressChainEnumValueOf(name);
}

class BscDepositAddressChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 56)
  static const BscDepositAddressChainIdEnum number56 = _$bscDepositAddressChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositAddressChainIdEnum unknownDefaultOpenApi = _$bscDepositAddressChainIdEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressChainIdEnum> get serializer => _$bscDepositAddressChainIdEnumSerializer;

  const BscDepositAddressChainIdEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressChainIdEnum> get values => _$bscDepositAddressChainIdEnumValues;
  static BscDepositAddressChainIdEnum valueOf(String name) => _$bscDepositAddressChainIdEnumValueOf(name);
}

class BscDepositAddressTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const BscDepositAddressTokenEnum USDC = _$bscDepositAddressTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositAddressTokenEnum unknownDefaultOpenApi = _$bscDepositAddressTokenEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressTokenEnum> get serializer => _$bscDepositAddressTokenEnumSerializer;

  const BscDepositAddressTokenEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressTokenEnum> get values => _$bscDepositAddressTokenEnumValues;
  static BscDepositAddressTokenEnum valueOf(String name) => _$bscDepositAddressTokenEnumValueOf(name);
}

class BscDepositAddressTokenContractEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d')
  static const BscDepositAddressTokenContractEnum n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d = _$bscDepositAddressTokenContractEnum_n0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BscDepositAddressTokenContractEnum unknownDefaultOpenApi = _$bscDepositAddressTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressTokenContractEnum> get serializer => _$bscDepositAddressTokenContractEnumSerializer;

  const BscDepositAddressTokenContractEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressTokenContractEnum> get values => _$bscDepositAddressTokenContractEnumValues;
  static BscDepositAddressTokenContractEnum valueOf(String name) => _$bscDepositAddressTokenContractEnumValueOf(name);
}

class BscDepositAddressTokenDecimalsEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 18)
  static const BscDepositAddressTokenDecimalsEnum number18 = _$bscDepositAddressTokenDecimalsEnum_number18;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositAddressTokenDecimalsEnum unknownDefaultOpenApi = _$bscDepositAddressTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressTokenDecimalsEnum> get serializer => _$bscDepositAddressTokenDecimalsEnumSerializer;

  const BscDepositAddressTokenDecimalsEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressTokenDecimalsEnum> get values => _$bscDepositAddressTokenDecimalsEnumValues;
  static BscDepositAddressTokenDecimalsEnum valueOf(String name) => _$bscDepositAddressTokenDecimalsEnumValueOf(name);
}

class BscDepositAddressConfirmationsRequiredEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 15)
  static const BscDepositAddressConfirmationsRequiredEnum number15 = _$bscDepositAddressConfirmationsRequiredEnum_number15;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const BscDepositAddressConfirmationsRequiredEnum unknownDefaultOpenApi = _$bscDepositAddressConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<BscDepositAddressConfirmationsRequiredEnum> get serializer => _$bscDepositAddressConfirmationsRequiredEnumSerializer;

  const BscDepositAddressConfirmationsRequiredEnum._(String name): super(name);

  static BuiltSet<BscDepositAddressConfirmationsRequiredEnum> get values => _$bscDepositAddressConfirmationsRequiredEnumValues;
  static BscDepositAddressConfirmationsRequiredEnum valueOf(String name) => _$bscDepositAddressConfirmationsRequiredEnumValueOf(name);
}

