//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'financial_responsibility.g.dart';

/// Public support ownership, not operator personal data or internal case notes. Case review/closure does not settle money or stop evidence recovery.
///
/// Properties:
/// * [queue] 
/// * [escalationStatus] 
/// * [allowedActions] - Currently permitted account actions. observe refreshes read-only evidence; contact_support uses the obligation/case reference; view_details opens an existing resource. Never permission to re-sign, release holds or issue an unaudited payout.
/// * [caseId] 
/// * [owner] - Public responsible team/role, not an employee identity.
@BuiltValue()
abstract class FinancialResponsibility implements Built<FinancialResponsibility, FinancialResponsibilityBuilder> {
  @BuiltValueField(wireName: r'queue')
  String get queue;

  @BuiltValueField(wireName: r'escalation_status')
  FinancialResponsibilityEscalationStatusEnum get escalationStatus;
  // enum escalationStatusEnum {  none,  queued,  escalated,  reviewed,  };

  /// Currently permitted account actions. observe refreshes read-only evidence; contact_support uses the obligation/case reference; view_details opens an existing resource. Never permission to re-sign, release holds or issue an unaudited payout.
  @BuiltValueField(wireName: r'allowed_actions')
  BuiltSet<FinancialResponsibilityAllowedActionsEnum> get allowedActions;
  // enum allowedActionsEnum {  observe,  contact_support,  view_details,  };

  @BuiltValueField(wireName: r'case_id')
  String? get caseId;

  /// Public responsible team/role, not an employee identity.
  @BuiltValueField(wireName: r'owner')
  String? get owner;

  FinancialResponsibility._();

  factory FinancialResponsibility([void updates(FinancialResponsibilityBuilder b)]) = _$FinancialResponsibility;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinancialResponsibilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinancialResponsibility> get serializer => _$FinancialResponsibilitySerializer();
}

class _$FinancialResponsibilitySerializer implements PrimitiveSerializer<FinancialResponsibility> {
  @override
  final Iterable<Type> types = const [FinancialResponsibility, _$FinancialResponsibility];

  @override
  final String wireName = r'FinancialResponsibility';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinancialResponsibility object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'queue';
    yield serializers.serialize(
      object.queue,
      specifiedType: const FullType(String),
    );
    yield r'escalation_status';
    yield serializers.serialize(
      object.escalationStatus,
      specifiedType: const FullType(FinancialResponsibilityEscalationStatusEnum),
    );
    yield r'allowed_actions';
    yield serializers.serialize(
      object.allowedActions,
      specifiedType: const FullType(BuiltSet, [FullType(FinancialResponsibilityAllowedActionsEnum)]),
    );
    if (object.caseId != null) {
      yield r'case_id';
      yield serializers.serialize(
        object.caseId,
        specifiedType: const FullType(String),
      );
    }
    if (object.owner != null) {
      yield r'owner';
      yield serializers.serialize(
        object.owner,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinancialResponsibility object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinancialResponsibilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'queue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.queue = valueDes;
          break;
        case r'escalation_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinancialResponsibilityEscalationStatusEnum),
          ) as FinancialResponsibilityEscalationStatusEnum;
          result.escalationStatus = valueDes;
          break;
        case r'allowed_actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(FinancialResponsibilityAllowedActionsEnum)]),
          ) as BuiltSet<FinancialResponsibilityAllowedActionsEnum>;
          result.allowedActions.replace(valueDes);
          break;
        case r'case_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.caseId = valueDes;
          break;
        case r'owner':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.owner = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinancialResponsibility deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinancialResponsibilityBuilder();
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

class FinancialResponsibilityEscalationStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'none')
  static const FinancialResponsibilityEscalationStatusEnum none = _$financialResponsibilityEscalationStatusEnum_none;
  @BuiltValueEnumConst(wireName: r'queued')
  static const FinancialResponsibilityEscalationStatusEnum queued = _$financialResponsibilityEscalationStatusEnum_queued;
  @BuiltValueEnumConst(wireName: r'escalated')
  static const FinancialResponsibilityEscalationStatusEnum escalated = _$financialResponsibilityEscalationStatusEnum_escalated;
  @BuiltValueEnumConst(wireName: r'reviewed')
  static const FinancialResponsibilityEscalationStatusEnum reviewed = _$financialResponsibilityEscalationStatusEnum_reviewed;

  static Serializer<FinancialResponsibilityEscalationStatusEnum> get serializer => _$financialResponsibilityEscalationStatusEnumSerializer;

  const FinancialResponsibilityEscalationStatusEnum._(String name): super(name);

  static BuiltSet<FinancialResponsibilityEscalationStatusEnum> get values => _$financialResponsibilityEscalationStatusEnumValues;
  static FinancialResponsibilityEscalationStatusEnum valueOf(String name) => _$financialResponsibilityEscalationStatusEnumValueOf(name);
}

class FinancialResponsibilityAllowedActionsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'observe')
  static const FinancialResponsibilityAllowedActionsEnum observe = _$financialResponsibilityAllowedActionsEnum_observe;
  @BuiltValueEnumConst(wireName: r'contact_support')
  static const FinancialResponsibilityAllowedActionsEnum contactSupport = _$financialResponsibilityAllowedActionsEnum_contactSupport;
  @BuiltValueEnumConst(wireName: r'view_details')
  static const FinancialResponsibilityAllowedActionsEnum viewDetails = _$financialResponsibilityAllowedActionsEnum_viewDetails;

  static Serializer<FinancialResponsibilityAllowedActionsEnum> get serializer => _$financialResponsibilityAllowedActionsEnumSerializer;

  const FinancialResponsibilityAllowedActionsEnum._(String name): super(name);

  static BuiltSet<FinancialResponsibilityAllowedActionsEnum> get values => _$financialResponsibilityAllowedActionsEnumValues;
  static FinancialResponsibilityAllowedActionsEnum valueOf(String name) => _$financialResponsibilityAllowedActionsEnumValueOf(name);
}

