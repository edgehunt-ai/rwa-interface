//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/financial_obligation_amounts.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/financial_economic_status.dart';
import 'package:rwa_api_client/src/model/financial_responsibility.dart';
import 'package:rwa_api_client/src/model/financial_settlement_evidence.dart';
import 'package:rwa_api_client/src/model/financial_business_reference.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_obligation.g.dart';

/// Projection of existing business records, not a new ledger. Unresolved holds and economic claims remain enumerable without execution, hash, operation or Activity. obligation_id and business_reference stay stable through review and late evidence recovery. unresolved remains true while a hold/outstanding principal is nonzero or unknown or fee reconciliation is unknown; cumulative settled debit/credit/fees need not be zero. Technical terminal status, HTTP success and support case closure cannot settle funds. Corrections preserve original evidence/history. Zero operational reservation for bStocks does not settle an ambiguous execution or restore spent signing authority. Financial outcome, unknown outstanding and fee reconciliation remain independent from wallet availability and continue to drive unresolved status. 
///
/// Properties:
/// * [obligationId] 
/// * [businessReference] 
/// * [relatedReferences] 
/// * [economicStatus] 
/// * [technicalStatus] - Original resource state such as manual_review or submitted, never relabeled economic success.
/// * [unresolved] 
/// * [amounts] 
/// * [evidence] 
/// * [responsibility] 
/// * [reason] 
/// * [lastObservedAt] - Last actual observation; omitted if never observed, never replaced by response time.
/// * [nextObservationAt] - Persisted next reconciliation time when scheduled; omission means unknown schedule, not resolution. Unresolved unscheduled obligations retain support ownership and a reason.
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class FinancialObligation implements Built<FinancialObligation, FinancialObligationBuilder> {
  @BuiltValueField(wireName: r'obligation_id')
  String get obligationId;

  @BuiltValueField(wireName: r'business_reference')
  FinancialBusinessReference get businessReference;

  @BuiltValueField(wireName: r'related_references')
  BuiltList<FinancialBusinessReference> get relatedReferences;

  @BuiltValueField(wireName: r'economic_status')
  FinancialEconomicStatus get economicStatus;
  // enum economicStatusEnum {  reserved,  source_debited,  in_transit,  refund_pending,  partially_settled,  partially_refunded,  credited,  refunded,  compensated,  released,  settled,  unknown,  };

  /// Original resource state such as manual_review or submitted, never relabeled economic success.
  @BuiltValueField(wireName: r'technical_status')
  String get technicalStatus;

  @BuiltValueField(wireName: r'unresolved')
  bool get unresolved;

  @BuiltValueField(wireName: r'amounts')
  BuiltList<FinancialObligationAmounts> get amounts;

  @BuiltValueField(wireName: r'evidence')
  BuiltList<FinancialSettlementEvidence> get evidence;

  @BuiltValueField(wireName: r'responsibility')
  FinancialResponsibility get responsibility;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  /// Last actual observation; omitted if never observed, never replaced by response time.
  @BuiltValueField(wireName: r'last_observed_at')
  DateTime? get lastObservedAt;

  /// Persisted next reconciliation time when scheduled; omission means unknown schedule, not resolution. Unresolved unscheduled obligations retain support ownership and a reason.
  @BuiltValueField(wireName: r'next_observation_at')
  DateTime? get nextObservationAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  FinancialObligation._();

  factory FinancialObligation([void updates(FinancialObligationBuilder b)]) = _$FinancialObligation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialObligationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialObligation> get serializer => _$FinancialObligationSerializer();
}

class _$FinancialObligationSerializer implements PrimitiveSerializer<FinancialObligation> {
  @override
  final Iterable<Type> types = const [FinancialObligation, _$FinancialObligation];

  @override
  final String wireName = r'FinancialObligation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialObligation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'obligation_id';
    yield serializers.serialize(
      object.obligationId,
      specifiedType: const FullType(String),
    );
    yield r'business_reference';
    yield serializers.serialize(
      object.businessReference,
      specifiedType: const FullType(FinancialBusinessReference),
    );
    yield r'related_references';
    yield serializers.serialize(
      object.relatedReferences,
      specifiedType: const FullType(BuiltList, [FullType(FinancialBusinessReference)]),
    );
    yield r'economic_status';
    yield serializers.serialize(
      object.economicStatus,
      specifiedType: const FullType(FinancialEconomicStatus),
    );
    yield r'technical_status';
    yield serializers.serialize(
      object.technicalStatus,
      specifiedType: const FullType(String),
    );
    yield r'unresolved';
    yield serializers.serialize(
      object.unresolved,
      specifiedType: const FullType(bool),
    );
    yield r'amounts';
    yield serializers.serialize(
      object.amounts,
      specifiedType: const FullType(BuiltList, [FullType(FinancialObligationAmounts)]),
    );
    yield r'evidence';
    yield serializers.serialize(
      object.evidence,
      specifiedType: const FullType(BuiltList, [FullType(FinancialSettlementEvidence)]),
    );
    yield r'responsibility';
    yield serializers.serialize(
      object.responsibility,
      specifiedType: const FullType(FinancialResponsibility),
    );
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastObservedAt != null) {
      yield r'last_observed_at';
      yield serializers.serialize(
        object.lastObservedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.nextObservationAt != null) {
      yield r'next_observation_at';
      yield serializers.serialize(
        object.nextObservationAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
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
    FinancialObligation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialObligationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'obligation_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.obligationId = valueDes;
          break;
        case r'business_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialBusinessReference),
          ) as FinancialBusinessReference;
          result.businessReference.replace(valueDes);
          break;
        case r'related_references':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FinancialBusinessReference)]),
          ) as BuiltList<FinancialBusinessReference>;
          result.relatedReferences.replace(valueDes);
          break;
        case r'economic_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialEconomicStatus),
          ) as FinancialEconomicStatus;
          result.economicStatus = valueDes;
          break;
        case r'technical_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.technicalStatus = valueDes;
          break;
        case r'unresolved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.unresolved = valueDes;
          break;
        case r'amounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FinancialObligationAmounts)]),
          ) as BuiltList<FinancialObligationAmounts>;
          result.amounts.replace(valueDes);
          break;
        case r'evidence':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FinancialSettlementEvidence)]),
          ) as BuiltList<FinancialSettlementEvidence>;
          result.evidence.replace(valueDes);
          break;
        case r'responsibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialResponsibility),
          ) as FinancialResponsibility;
          result.responsibility.replace(valueDes);
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'last_observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastObservedAt = valueDes;
          break;
        case r'next_observation_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.nextObservationAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
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
  FinancialObligation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialObligationBuilder();
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

