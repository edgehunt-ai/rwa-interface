//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/transfer_action_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_wallet_action_summary.g.dart';

/// Frozen action metadata without executable to/data/value; executable payload is released only as Transfer.next_action after route lock.
///
/// Properties:
/// * [actionId] 
/// * [ordinal] 
/// * [kind] 
/// * [payloadHash] 
/// * [validUntil] 
/// * [status] 
@BuiltValue()
abstract class FundingWalletActionSummary implements Built<FundingWalletActionSummary, FundingWalletActionSummaryBuilder> {
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'ordinal')
  int get ordinal;

  @BuiltValueField(wireName: r'kind')
  FundingWalletActionSummaryKindEnum get kind;
  // enum kindEnum {  erc20_approval,  origin_transaction,  };

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'status')
  TransferActionStatus get status;
  // enum statusEnum {  planned,  ready,  submitted,  confirmed,  failed,  ambiguous,  manual_review,  };

  FundingWalletActionSummary._();

  factory FundingWalletActionSummary([void updates(FundingWalletActionSummaryBuilder b)]) = _$FundingWalletActionSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingWalletActionSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingWalletActionSummary> get serializer => _$FundingWalletActionSummarySerializer();
}

class _$FundingWalletActionSummarySerializer implements PrimitiveSerializer<FundingWalletActionSummary> {
  @override
  final Iterable<Type> types = const [FundingWalletActionSummary, _$FundingWalletActionSummary];

  @override
  final String wireName = r'FundingWalletActionSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingWalletActionSummary object, {
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
      specifiedType: const FullType(FundingWalletActionSummaryKindEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingWalletActionSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingWalletActionSummaryBuilder result,
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
            specifiedType: const FullType(FundingWalletActionSummaryKindEnum),
          ) as FundingWalletActionSummaryKindEnum;
          result.kind = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingWalletActionSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingWalletActionSummaryBuilder();
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

class FundingWalletActionSummaryKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'erc20_approval')
  static const FundingWalletActionSummaryKindEnum erc20Approval = _$fundingWalletActionSummaryKindEnum_erc20Approval;
  @BuiltValueEnumConst(wireName: r'origin_transaction')
  static const FundingWalletActionSummaryKindEnum originTransaction = _$fundingWalletActionSummaryKindEnum_originTransaction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingWalletActionSummaryKindEnum unknownDefaultOpenApi = _$fundingWalletActionSummaryKindEnum_unknownDefaultOpenApi;

  static Serializer<FundingWalletActionSummaryKindEnum> get serializer => _$fundingWalletActionSummaryKindEnumSerializer;

  const FundingWalletActionSummaryKindEnum._(String name): super(name);

  static BuiltSet<FundingWalletActionSummaryKindEnum> get values => _$fundingWalletActionSummaryKindEnumValues;
  static FundingWalletActionSummaryKindEnum valueOf(String name) => _$fundingWalletActionSummaryKindEnumValueOf(name);
}

