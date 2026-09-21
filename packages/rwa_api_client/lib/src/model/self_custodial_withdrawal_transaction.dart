//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/self_custodial_withdrawal_chain_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_transaction.g.dart';

/// Exact immutable server-frozen ERC-20 EVM transaction returned only in the response. The client must submit these exact `chain_id/from/to/data/value` fields to its Privy wallet and cannot override or customize them. `value` is always canonical `0x0`; native-value transfers are forbidden. `payload_hash` binds every executable field and `valid_until`; an expired transaction requires a new intent and must never be replayed. 
///
/// Properties:
/// * [chainId] 
/// * [from] - Exact verified Privy wallet address selected through `wallet_id`.
/// * [to] - Exact allowlisted ERC-20 token contract; not the user-supplied destination address.
/// * [data] - Complete server-encoded ERC-20 transfer calldata for the frozen recipient and amount.
/// * [value] - Canonical zero native value; native-asset transfer is not supported.
/// * [payloadHash] - Versioned canonical SHA-256 digest without a `0x` prefix.
/// * [validUntil] 
@BuiltValue()
abstract class SelfCustodialWithdrawalTransaction implements Built<SelfCustodialWithdrawalTransaction, SelfCustodialWithdrawalTransactionBuilder> {
  @BuiltValueField(wireName: r'chain_id')
  SelfCustodialWithdrawalChainId get chainId;
  // enum chainIdEnum {  1,  42161,  8453,  56,  97,  421614,  };

  /// Exact verified Privy wallet address selected through `wallet_id`.
  @BuiltValueField(wireName: r'from')
  String get from;

  /// Exact allowlisted ERC-20 token contract; not the user-supplied destination address.
  @BuiltValueField(wireName: r'to')
  String get to;

  /// Complete server-encoded ERC-20 transfer calldata for the frozen recipient and amount.
  @BuiltValueField(wireName: r'data')
  String get data;

  /// Canonical zero native value; native-asset transfer is not supported.
  @BuiltValueField(wireName: r'value')
  SelfCustodialWithdrawalTransactionValueEnum get value;
  // enum valueEnum {  0x0,  };

  /// Versioned canonical SHA-256 digest without a `0x` prefix.
  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  SelfCustodialWithdrawalTransaction._();

  factory SelfCustodialWithdrawalTransaction([void updates(SelfCustodialWithdrawalTransactionBuilder b)]) = _$SelfCustodialWithdrawalTransaction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SelfCustodialWithdrawalTransactionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SelfCustodialWithdrawalTransaction> get serializer => _$SelfCustodialWithdrawalTransactionSerializer();
}

class _$SelfCustodialWithdrawalTransactionSerializer implements PrimitiveSerializer<SelfCustodialWithdrawalTransaction> {
  @override
  final Iterable<Type> types = const [SelfCustodialWithdrawalTransaction, _$SelfCustodialWithdrawalTransaction];

  @override
  final String wireName = r'SelfCustodialWithdrawalTransaction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SelfCustodialWithdrawalTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(SelfCustodialWithdrawalChainId),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(SelfCustodialWithdrawalTransactionValueEnum),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SelfCustodialWithdrawalTransaction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SelfCustodialWithdrawalTransactionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SelfCustodialWithdrawalChainId),
          ) as SelfCustodialWithdrawalChainId;
          result.chainId = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.data = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SelfCustodialWithdrawalTransactionValueEnum),
          ) as SelfCustodialWithdrawalTransactionValueEnum;
          result.value = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SelfCustodialWithdrawalTransaction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SelfCustodialWithdrawalTransactionBuilder();
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

class SelfCustodialWithdrawalTransactionValueEnum extends EnumClass {

  /// Canonical zero native value; native-asset transfer is not supported.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const SelfCustodialWithdrawalTransactionValueEnum n0x0 = _$selfCustodialWithdrawalTransactionValueEnum_n0x0;
  /// Canonical zero native value; native-asset transfer is not supported.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SelfCustodialWithdrawalTransactionValueEnum unknownDefaultOpenApi = _$selfCustodialWithdrawalTransactionValueEnum_unknownDefaultOpenApi;

  static Serializer<SelfCustodialWithdrawalTransactionValueEnum> get serializer => _$selfCustodialWithdrawalTransactionValueEnumSerializer;

  const SelfCustodialWithdrawalTransactionValueEnum._(String name): super(name);

  static BuiltSet<SelfCustodialWithdrawalTransactionValueEnum> get values => _$selfCustodialWithdrawalTransactionValueEnumValues;
  static SelfCustodialWithdrawalTransactionValueEnum valueOf(String name) => _$selfCustodialWithdrawalTransactionValueEnumValueOf(name);
}

