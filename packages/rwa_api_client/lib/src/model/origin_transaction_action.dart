//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:rwa_api_client/src/model/transfer_action_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'origin_transaction_action.g.dart';

/// OriginTransactionAction
///
/// Properties:
/// * [actionId]
/// * [ordinal]
/// * [kind]
/// * [chainId]
/// * [from]
/// * [to]
/// * [data]
/// * [value] - Native-value transfer is forbidden; v1 only executes zero-value contract calls.
/// * [payloadHash]
/// * [validUntil]
/// * [status]
/// * [gasPayment]
/// * [recipient]
/// * [refundAddress]
@BuiltValue()
abstract class OriginTransactionAction
    implements Built<OriginTransactionAction, OriginTransactionActionBuilder> {
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  @BuiltValueField(wireName: r'kind')
  OriginTransactionActionKindEnum get kind;
  // enum kindEnum {  origin_transaction,  };

  @BuiltValueField(wireName: r'chain_id')
  OriginTransactionActionChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  8453,  42161,  };

  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueField(wireName: r'value')
  OriginTransactionActionValueEnum get value;
  // enum valueEnum {  0x0,  };

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'status')
  TransferActionStatus get status;
  // enum statusEnum {  planned,  ready,  submitted,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'gas_payment')
  GasPaymentQuote get gasPayment;

  @BuiltValueField(wireName: r'recipient')
  String get recipient;

  @BuiltValueField(wireName: r'refund_address')
  String get refundAddress;

  OriginTransactionAction._();

  factory OriginTransactionAction(
          [void updates(OriginTransactionActionBuilder b)]) =
      _$OriginTransactionAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OriginTransactionActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OriginTransactionAction> get serializer =>
      _$OriginTransactionActionSerializer();
}

class _$OriginTransactionActionSerializer
    implements PrimitiveSerializer<OriginTransactionAction> {
  @override
  final Iterable<Type> types = const [
    OriginTransactionAction,
    _$OriginTransactionAction
  ];

  @override
  final String wireName = r'OriginTransactionAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OriginTransactionAction object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'ordinal';
    yield serializers.serialize(
      object.ordinal,
      specifiedType: const FullType(int),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(OriginTransactionActionKindEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(OriginTransactionActionChainIdEnum),
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
      specifiedType: const FullType(OriginTransactionActionValueEnum),
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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferActionStatus),
    );
    yield r'gas_payment';
    yield serializers.serialize(
      object.gasPayment,
      specifiedType: const FullType(GasPaymentQuote),
    );
    yield r'recipient';
    yield serializers.serialize(
      object.recipient,
      specifiedType: const FullType(String),
    );
    yield r'refund_address';
    yield serializers.serialize(
      object.refundAddress,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OriginTransactionAction object, {
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
    required OriginTransactionActionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'ordinal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordinal = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OriginTransactionActionKindEnum),
          ) as OriginTransactionActionKindEnum;
          result.kind = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OriginTransactionActionChainIdEnum),
          ) as OriginTransactionActionChainIdEnum;
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
            specifiedType: const FullType(OriginTransactionActionValueEnum),
          ) as OriginTransactionActionValueEnum;
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferActionStatus),
          ) as TransferActionStatus;
          result.status = valueDes;
          break;
        case r'gas_payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GasPaymentQuote),
          ) as GasPaymentQuote;
          result.gasPayment.replace(valueDes);
          break;
        case r'recipient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipient = valueDes;
          break;
        case r'refund_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refundAddress = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OriginTransactionAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OriginTransactionActionBuilder();
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

class OriginTransactionActionKindEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'origin_transaction')
  static const OriginTransactionActionKindEnum originTransaction =
      _$originTransactionActionKindEnum_originTransaction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OriginTransactionActionKindEnum unknownDefaultOpenApi =
      _$originTransactionActionKindEnum_unknownDefaultOpenApi;

  static Serializer<OriginTransactionActionKindEnum> get serializer =>
      _$originTransactionActionKindEnumSerializer;

  const OriginTransactionActionKindEnum._(String name) : super(name);

  static BuiltSet<OriginTransactionActionKindEnum> get values =>
      _$originTransactionActionKindEnumValues;
  static OriginTransactionActionKindEnum valueOf(String name) =>
      _$originTransactionActionKindEnumValueOf(name);
}

class OriginTransactionActionChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1)
  static const OriginTransactionActionChainIdEnum number1 =
      _$originTransactionActionChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const OriginTransactionActionChainIdEnum number56 =
      _$originTransactionActionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const OriginTransactionActionChainIdEnum number8453 =
      _$originTransactionActionChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const OriginTransactionActionChainIdEnum number42161 =
      _$originTransactionActionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const OriginTransactionActionChainIdEnum unknownDefaultOpenApi =
      _$originTransactionActionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<OriginTransactionActionChainIdEnum> get serializer =>
      _$originTransactionActionChainIdEnumSerializer;

  const OriginTransactionActionChainIdEnum._(String name) : super(name);

  static BuiltSet<OriginTransactionActionChainIdEnum> get values =>
      _$originTransactionActionChainIdEnumValues;
  static OriginTransactionActionChainIdEnum valueOf(String name) =>
      _$originTransactionActionChainIdEnumValueOf(name);
}

class OriginTransactionActionValueEnum extends EnumClass {
  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const OriginTransactionActionValueEnum n0x0 =
      _$originTransactionActionValueEnum_n0x0;

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OriginTransactionActionValueEnum unknownDefaultOpenApi =
      _$originTransactionActionValueEnum_unknownDefaultOpenApi;

  static Serializer<OriginTransactionActionValueEnum> get serializer =>
      _$originTransactionActionValueEnumSerializer;

  const OriginTransactionActionValueEnum._(String name) : super(name);

  static BuiltSet<OriginTransactionActionValueEnum> get values =>
      _$originTransactionActionValueEnumValues;
  static OriginTransactionActionValueEnum valueOf(String name) =>
      _$originTransactionActionValueEnumValueOf(name);
}
