//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:rwa_api_client/src/model/transfer_action_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'erc20_approval_action.g.dart';

/// Erc20ApprovalAction
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
/// * [tokenContract] 
/// * [spender] 
/// * [approvalAmount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class Erc20ApprovalAction implements Built<Erc20ApprovalAction, Erc20ApprovalActionBuilder> {
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  @BuiltValueField(wireName: r'kind')
  Erc20ApprovalActionKindEnum get kind;
  // enum kindEnum {  erc20_approval,  };

  @BuiltValueField(wireName: r'chain_id')
  Erc20ApprovalActionChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  8453,  42161,  };

  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'data')
  String get data;

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueField(wireName: r'value')
  Erc20ApprovalActionValueEnum get value;
  // enum valueEnum {  0x0,  };

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'status')
  TransferActionStatus get status;
  // enum statusEnum {  planned,  ready,  submitted,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'gas_payment')
  GasPaymentQuote? get gasPayment;

  @BuiltValueField(wireName: r'token_contract')
  String get tokenContract;

  @BuiltValueField(wireName: r'spender')
  String get spender;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'approval_amount')
  String get approvalAmount;

  Erc20ApprovalAction._();

  factory Erc20ApprovalAction([void updates(Erc20ApprovalActionBuilder b)]) = _$Erc20ApprovalAction;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Erc20ApprovalActionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Erc20ApprovalAction> get serializer => _$Erc20ApprovalActionSerializer();
}

class _$Erc20ApprovalActionSerializer implements PrimitiveSerializer<Erc20ApprovalAction> {
  @override
  final Iterable<Type> types = const [Erc20ApprovalAction, _$Erc20ApprovalAction];

  @override
  final String wireName = r'Erc20ApprovalAction';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Erc20ApprovalAction object, {
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
      specifiedType: const FullType(Erc20ApprovalActionKindEnum),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(Erc20ApprovalActionChainIdEnum),
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
      specifiedType: const FullType(Erc20ApprovalActionValueEnum),
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
    if (object.gasPayment != null) {
      yield r'gas_payment';
      yield serializers.serialize(
        object.gasPayment,
        specifiedType: const FullType(GasPaymentQuote),
      );
    }
    yield r'token_contract';
    yield serializers.serialize(
      object.tokenContract,
      specifiedType: const FullType(String),
    );
    yield r'spender';
    yield serializers.serialize(
      object.spender,
      specifiedType: const FullType(String),
    );
    yield r'approval_amount';
    yield serializers.serialize(
      object.approvalAmount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Erc20ApprovalAction object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Erc20ApprovalActionBuilder result,
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
            specifiedType: const FullType(Erc20ApprovalActionKindEnum),
          ) as Erc20ApprovalActionKindEnum;
          result.kind = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Erc20ApprovalActionChainIdEnum),
          ) as Erc20ApprovalActionChainIdEnum;
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
            specifiedType: const FullType(Erc20ApprovalActionValueEnum),
          ) as Erc20ApprovalActionValueEnum;
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
            specifiedType: const FullType.nullable(GasPaymentQuote),
          ) as GasPaymentQuote?;
          if (valueDes == null) continue;
          result.gasPayment.replace(valueDes);
          break;
        case r'token_contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tokenContract = valueDes;
          break;
        case r'spender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.spender = valueDes;
          break;
        case r'approval_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.approvalAmount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Erc20ApprovalAction deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Erc20ApprovalActionBuilder();
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

class Erc20ApprovalActionKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erc20_approval')
  static const Erc20ApprovalActionKindEnum erc20Approval = _$erc20ApprovalActionKindEnum_erc20Approval;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Erc20ApprovalActionKindEnum unknownDefaultOpenApi = _$erc20ApprovalActionKindEnum_unknownDefaultOpenApi;

  static Serializer<Erc20ApprovalActionKindEnum> get serializer => _$erc20ApprovalActionKindEnumSerializer;

  const Erc20ApprovalActionKindEnum._(String name): super(name);

  static BuiltSet<Erc20ApprovalActionKindEnum> get values => _$erc20ApprovalActionKindEnumValues;
  static Erc20ApprovalActionKindEnum valueOf(String name) => _$erc20ApprovalActionKindEnumValueOf(name);
}

class Erc20ApprovalActionChainIdEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 1)
  static const Erc20ApprovalActionChainIdEnum number1 = _$erc20ApprovalActionChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const Erc20ApprovalActionChainIdEnum number56 = _$erc20ApprovalActionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const Erc20ApprovalActionChainIdEnum number8453 = _$erc20ApprovalActionChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const Erc20ApprovalActionChainIdEnum number42161 = _$erc20ApprovalActionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const Erc20ApprovalActionChainIdEnum unknownDefaultOpenApi = _$erc20ApprovalActionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<Erc20ApprovalActionChainIdEnum> get serializer => _$erc20ApprovalActionChainIdEnumSerializer;

  const Erc20ApprovalActionChainIdEnum._(String name): super(name);

  static BuiltSet<Erc20ApprovalActionChainIdEnum> get values => _$erc20ApprovalActionChainIdEnumValues;
  static Erc20ApprovalActionChainIdEnum valueOf(String name) => _$erc20ApprovalActionChainIdEnumValueOf(name);
}

class Erc20ApprovalActionValueEnum extends EnumClass {

  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'0x0')
  static const Erc20ApprovalActionValueEnum n0x0 = _$erc20ApprovalActionValueEnum_n0x0;
  /// Native-value transfer is forbidden; v1 only executes zero-value contract calls.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Erc20ApprovalActionValueEnum unknownDefaultOpenApi = _$erc20ApprovalActionValueEnum_unknownDefaultOpenApi;

  static Serializer<Erc20ApprovalActionValueEnum> get serializer => _$erc20ApprovalActionValueEnumSerializer;

  const Erc20ApprovalActionValueEnum._(String name): super(name);

  static BuiltSet<Erc20ApprovalActionValueEnum> get values => _$erc20ApprovalActionValueEnumValues;
  static Erc20ApprovalActionValueEnum valueOf(String name) => _$erc20ApprovalActionValueEnumValueOf(name);
}

