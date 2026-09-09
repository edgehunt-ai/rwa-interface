//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_credit_target.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_address_base.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'arbitrum_deposit_address.g.dart';

/// ArbitrumDepositAddress
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
abstract class ArbitrumDepositAddress
    implements
        DepositAddressBase,
        Built<ArbitrumDepositAddress, ArbitrumDepositAddressBuilder> {
  ArbitrumDepositAddress._();

  factory ArbitrumDepositAddress(
          [void updates(ArbitrumDepositAddressBuilder b)]) =
      _$ArbitrumDepositAddress;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArbitrumDepositAddressBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArbitrumDepositAddress> get serializer =>
      _$ArbitrumDepositAddressSerializer();
}

class _$ArbitrumDepositAddressSerializer
    implements PrimitiveSerializer<ArbitrumDepositAddress> {
  @override
  final Iterable<Type> types = const [
    ArbitrumDepositAddress,
    _$ArbitrumDepositAddress
  ];

  @override
  final String wireName = r'ArbitrumDepositAddress';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArbitrumDepositAddress object, {
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
    ArbitrumDepositAddress object, {
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
    required ArbitrumDepositAddressBuilder result,
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
  ArbitrumDepositAddress deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArbitrumDepositAddressBuilder();
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

class ArbitrumDepositAddressChainEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ArbitrumDepositAddressChainEnum arbitrum =
      _$arbitrumDepositAddressChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositAddressChainEnum unknownDefaultOpenApi =
      _$arbitrumDepositAddressChainEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressChainEnum> get serializer =>
      _$arbitrumDepositAddressChainEnumSerializer;

  const ArbitrumDepositAddressChainEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositAddressChainEnum> get values =>
      _$arbitrumDepositAddressChainEnumValues;
  static ArbitrumDepositAddressChainEnum valueOf(String name) =>
      _$arbitrumDepositAddressChainEnumValueOf(name);
}

class ArbitrumDepositAddressChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 42161)
  static const ArbitrumDepositAddressChainIdEnum number42161 =
      _$arbitrumDepositAddressChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositAddressChainIdEnum unknownDefaultOpenApi =
      _$arbitrumDepositAddressChainIdEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressChainIdEnum> get serializer =>
      _$arbitrumDepositAddressChainIdEnumSerializer;

  const ArbitrumDepositAddressChainIdEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositAddressChainIdEnum> get values =>
      _$arbitrumDepositAddressChainIdEnumValues;
  static ArbitrumDepositAddressChainIdEnum valueOf(String name) =>
      _$arbitrumDepositAddressChainIdEnumValueOf(name);
}

class ArbitrumDepositAddressTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const ArbitrumDepositAddressTokenEnum USDC =
      _$arbitrumDepositAddressTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositAddressTokenEnum unknownDefaultOpenApi =
      _$arbitrumDepositAddressTokenEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressTokenEnum> get serializer =>
      _$arbitrumDepositAddressTokenEnumSerializer;

  const ArbitrumDepositAddressTokenEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositAddressTokenEnum> get values =>
      _$arbitrumDepositAddressTokenEnumValues;
  static ArbitrumDepositAddressTokenEnum valueOf(String name) =>
      _$arbitrumDepositAddressTokenEnumValueOf(name);
}

class ArbitrumDepositAddressTokenContractEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'0xaf88d065e77c8cc2239327c5edb3a432268e5831')
  static const ArbitrumDepositAddressTokenContractEnum
      n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
      _$arbitrumDepositAddressTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ArbitrumDepositAddressTokenContractEnum unknownDefaultOpenApi =
      _$arbitrumDepositAddressTokenContractEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressTokenContractEnum> get serializer =>
      _$arbitrumDepositAddressTokenContractEnumSerializer;

  const ArbitrumDepositAddressTokenContractEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositAddressTokenContractEnum> get values =>
      _$arbitrumDepositAddressTokenContractEnumValues;
  static ArbitrumDepositAddressTokenContractEnum valueOf(String name) =>
      _$arbitrumDepositAddressTokenContractEnumValueOf(name);
}

class ArbitrumDepositAddressTokenDecimalsEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 6)
  static const ArbitrumDepositAddressTokenDecimalsEnum number6 =
      _$arbitrumDepositAddressTokenDecimalsEnum_number6;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositAddressTokenDecimalsEnum unknownDefaultOpenApi =
      _$arbitrumDepositAddressTokenDecimalsEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressTokenDecimalsEnum> get serializer =>
      _$arbitrumDepositAddressTokenDecimalsEnumSerializer;

  const ArbitrumDepositAddressTokenDecimalsEnum._(String name) : super(name);

  static BuiltSet<ArbitrumDepositAddressTokenDecimalsEnum> get values =>
      _$arbitrumDepositAddressTokenDecimalsEnumValues;
  static ArbitrumDepositAddressTokenDecimalsEnum valueOf(String name) =>
      _$arbitrumDepositAddressTokenDecimalsEnumValueOf(name);
}

class ArbitrumDepositAddressConfirmationsRequiredEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 20)
  static const ArbitrumDepositAddressConfirmationsRequiredEnum number20 =
      _$arbitrumDepositAddressConfirmationsRequiredEnum_number20;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const ArbitrumDepositAddressConfirmationsRequiredEnum
      unknownDefaultOpenApi =
      _$arbitrumDepositAddressConfirmationsRequiredEnum_unknownDefaultOpenApi;

  static Serializer<ArbitrumDepositAddressConfirmationsRequiredEnum>
      get serializer =>
          _$arbitrumDepositAddressConfirmationsRequiredEnumSerializer;

  const ArbitrumDepositAddressConfirmationsRequiredEnum._(String name)
      : super(name);

  static BuiltSet<ArbitrumDepositAddressConfirmationsRequiredEnum> get values =>
      _$arbitrumDepositAddressConfirmationsRequiredEnumValues;
  static ArbitrumDepositAddressConfirmationsRequiredEnum valueOf(String name) =>
      _$arbitrumDepositAddressConfirmationsRequiredEnumValueOf(name);
}
