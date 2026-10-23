//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/financial_business_reference.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_settlement_evidence.g.dart';

/// References immutable observations on the existing owning resource; its detailed receipt, refund and venue observations remain authoritative. observed is not finalized payment. Finalized effects require verified identity, finality/canonicality and unique attribution. EVM transfers include chain_id/tx_hash/log_index; -1 is only for admitted eventless proof, never a missing-log fallback. Venue effects include venue_reference. Compensation includes command_reference to an approved real payout command plus actual payment evidence; review or command acceptance is never compensation evidence. No hash is required for an unspent hold. 
///
/// Properties:
/// * [evidenceId] 
/// * [kind] 
/// * [status] 
/// * [reference] 
/// * [observedAt] 
/// * [chainId] 
/// * [txHash] 
/// * [logIndex] 
/// * [venueReference] 
/// * [commandReference] 
@BuiltValue()
abstract class FinancialSettlementEvidence implements Built<FinancialSettlementEvidence, FinancialSettlementEvidenceBuilder> {
  @BuiltValueField(wireName: r'evidence_id')
  String get evidenceId;

  @BuiltValueField(wireName: r'kind')
  FinancialSettlementEvidenceKindEnum get kind;
  // enum kindEnum {  source_debit,  target_credit,  refund,  fee,  reservation_release,  compensation,  };

  @BuiltValueField(wireName: r'status')
  FinancialSettlementEvidenceStatusEnum get status;
  // enum statusEnum {  observed,  finalized,  conflicting,  };

  @BuiltValueField(wireName: r'reference')
  FinancialBusinessReference get reference;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'chain_id')
  int? get chainId;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'log_index')
  int? get logIndex;

  @BuiltValueField(wireName: r'venue_reference')
  String? get venueReference;

  @BuiltValueField(wireName: r'command_reference')
  FinancialBusinessReference? get commandReference;

  FinancialSettlementEvidence._();

  factory FinancialSettlementEvidence([void updates(FinancialSettlementEvidenceBuilder b)]) = _$FinancialSettlementEvidence;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialSettlementEvidenceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialSettlementEvidence> get serializer => _$FinancialSettlementEvidenceSerializer();
}

class _$FinancialSettlementEvidenceSerializer implements PrimitiveSerializer<FinancialSettlementEvidence> {
  @override
  final Iterable<Type> types = const [FinancialSettlementEvidence, _$FinancialSettlementEvidence];

  @override
  final String wireName = r'FinancialSettlementEvidence';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialSettlementEvidence object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'evidence_id';
    yield serializers.serialize(
      object.evidenceId,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(FinancialSettlementEvidenceKindEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FinancialSettlementEvidenceStatusEnum),
    );
    yield r'reference';
    yield serializers.serialize(
      object.reference,
      specifiedType: const FullType(FinancialBusinessReference),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(int),
      );
    }
    if (object.txHash != null) {
      yield r'tx_hash';
      yield serializers.serialize(
        object.txHash,
        specifiedType: const FullType(String),
      );
    }
    if (object.logIndex != null) {
      yield r'log_index';
      yield serializers.serialize(
        object.logIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.venueReference != null) {
      yield r'venue_reference';
      yield serializers.serialize(
        object.venueReference,
        specifiedType: const FullType(String),
      );
    }
    if (object.commandReference != null) {
      yield r'command_reference';
      yield serializers.serialize(
        object.commandReference,
        specifiedType: const FullType(FinancialBusinessReference),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialSettlementEvidence object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialSettlementEvidenceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'evidence_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.evidenceId = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialSettlementEvidenceKindEnum),
          ) as FinancialSettlementEvidenceKindEnum;
          result.kind = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialSettlementEvidenceStatusEnum),
          ) as FinancialSettlementEvidenceStatusEnum;
          result.status = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialBusinessReference),
          ) as FinancialBusinessReference;
          result.reference.replace(valueDes);
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.logIndex = valueDes;
          break;
        case r'venue_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.venueReference = valueDes;
          break;
        case r'command_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FinancialBusinessReference),
          ) as FinancialBusinessReference?;
          if (valueDes == null) continue;
          result.commandReference.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialSettlementEvidence deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialSettlementEvidenceBuilder();
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

class FinancialSettlementEvidenceKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'source_debit')
  static const FinancialSettlementEvidenceKindEnum sourceDebit = _$financialSettlementEvidenceKindEnum_sourceDebit;
  @BuiltValueEnumConst(wireName: r'target_credit')
  static const FinancialSettlementEvidenceKindEnum targetCredit = _$financialSettlementEvidenceKindEnum_targetCredit;
  @BuiltValueEnumConst(wireName: r'refund')
  static const FinancialSettlementEvidenceKindEnum refund = _$financialSettlementEvidenceKindEnum_refund;
  @BuiltValueEnumConst(wireName: r'fee')
  static const FinancialSettlementEvidenceKindEnum fee = _$financialSettlementEvidenceKindEnum_fee;
  @BuiltValueEnumConst(wireName: r'reservation_release')
  static const FinancialSettlementEvidenceKindEnum reservationRelease = _$financialSettlementEvidenceKindEnum_reservationRelease;
  @BuiltValueEnumConst(wireName: r'compensation')
  static const FinancialSettlementEvidenceKindEnum compensation = _$financialSettlementEvidenceKindEnum_compensation;

  static Serializer<FinancialSettlementEvidenceKindEnum> get serializer => _$financialSettlementEvidenceKindEnumSerializer;

  const FinancialSettlementEvidenceKindEnum._(String name): super(name);

  static BuiltSet<FinancialSettlementEvidenceKindEnum> get values => _$financialSettlementEvidenceKindEnumValues;
  static FinancialSettlementEvidenceKindEnum valueOf(String name) => _$financialSettlementEvidenceKindEnumValueOf(name);
}

class FinancialSettlementEvidenceStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'observed')
  static const FinancialSettlementEvidenceStatusEnum observed = _$financialSettlementEvidenceStatusEnum_observed;
  @BuiltValueEnumConst(wireName: r'finalized')
  static const FinancialSettlementEvidenceStatusEnum finalized = _$financialSettlementEvidenceStatusEnum_finalized;
  @BuiltValueEnumConst(wireName: r'conflicting')
  static const FinancialSettlementEvidenceStatusEnum conflicting = _$financialSettlementEvidenceStatusEnum_conflicting;

  static Serializer<FinancialSettlementEvidenceStatusEnum> get serializer => _$financialSettlementEvidenceStatusEnumSerializer;

  const FinancialSettlementEvidenceStatusEnum._(String name): super(name);

  static BuiltSet<FinancialSettlementEvidenceStatusEnum> get values => _$financialSettlementEvidenceStatusEnumValues;
  static FinancialSettlementEvidenceStatusEnum valueOf(String name) => _$financialSettlementEvidenceStatusEnumValueOf(name);
}

