// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_obligation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialObligation extends FinancialObligation {
  @override
  final String obligationId;
  @override
  final FinancialBusinessReference businessReference;
  @override
  final BuiltList<FinancialBusinessReference> relatedReferences;
  @override
  final FinancialEconomicStatus economicStatus;
  @override
  final String technicalStatus;
  @override
  final bool unresolved;
  @override
  final BuiltList<FinancialObligationAmounts> amounts;
  @override
  final BuiltList<FinancialSettlementEvidence> evidence;
  @override
  final FinancialResponsibility responsibility;
  @override
  final String? reason;
  @override
  final DateTime? lastObservedAt;
  @override
  final DateTime? nextObservationAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$FinancialObligation(
          [void Function(FinancialObligationBuilder)? updates]) =>
      (FinancialObligationBuilder()..update(updates))._build();

  _$FinancialObligation._(
      {required this.obligationId,
      required this.businessReference,
      required this.relatedReferences,
      required this.economicStatus,
      required this.technicalStatus,
      required this.unresolved,
      required this.amounts,
      required this.evidence,
      required this.responsibility,
      this.reason,
      this.lastObservedAt,
      this.nextObservationAt,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  FinancialObligation rebuild(
          void Function(FinancialObligationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialObligationBuilder toBuilder() =>
      FinancialObligationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialObligation &&
        obligationId == other.obligationId &&
        businessReference == other.businessReference &&
        relatedReferences == other.relatedReferences &&
        economicStatus == other.economicStatus &&
        technicalStatus == other.technicalStatus &&
        unresolved == other.unresolved &&
        amounts == other.amounts &&
        evidence == other.evidence &&
        responsibility == other.responsibility &&
        reason == other.reason &&
        lastObservedAt == other.lastObservedAt &&
        nextObservationAt == other.nextObservationAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, obligationId.hashCode);
    _$hash = $jc(_$hash, businessReference.hashCode);
    _$hash = $jc(_$hash, relatedReferences.hashCode);
    _$hash = $jc(_$hash, economicStatus.hashCode);
    _$hash = $jc(_$hash, technicalStatus.hashCode);
    _$hash = $jc(_$hash, unresolved.hashCode);
    _$hash = $jc(_$hash, amounts.hashCode);
    _$hash = $jc(_$hash, evidence.hashCode);
    _$hash = $jc(_$hash, responsibility.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, lastObservedAt.hashCode);
    _$hash = $jc(_$hash, nextObservationAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialObligation')
          ..add('obligationId', obligationId)
          ..add('businessReference', businessReference)
          ..add('relatedReferences', relatedReferences)
          ..add('economicStatus', economicStatus)
          ..add('technicalStatus', technicalStatus)
          ..add('unresolved', unresolved)
          ..add('amounts', amounts)
          ..add('evidence', evidence)
          ..add('responsibility', responsibility)
          ..add('reason', reason)
          ..add('lastObservedAt', lastObservedAt)
          ..add('nextObservationAt', nextObservationAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class FinancialObligationBuilder
    implements Builder<FinancialObligation, FinancialObligationBuilder> {
  _$FinancialObligation? _$v;

  String? _obligationId;
  String? get obligationId => _$this._obligationId;
  set obligationId(String? obligationId) => _$this._obligationId = obligationId;

  FinancialBusinessReferenceBuilder? _businessReference;
  FinancialBusinessReferenceBuilder get businessReference =>
      _$this._businessReference ??= FinancialBusinessReferenceBuilder();
  set businessReference(FinancialBusinessReferenceBuilder? businessReference) =>
      _$this._businessReference = businessReference;

  ListBuilder<FinancialBusinessReference>? _relatedReferences;
  ListBuilder<FinancialBusinessReference> get relatedReferences =>
      _$this._relatedReferences ??= ListBuilder<FinancialBusinessReference>();
  set relatedReferences(
          ListBuilder<FinancialBusinessReference>? relatedReferences) =>
      _$this._relatedReferences = relatedReferences;

  FinancialEconomicStatus? _economicStatus;
  FinancialEconomicStatus? get economicStatus => _$this._economicStatus;
  set economicStatus(FinancialEconomicStatus? economicStatus) =>
      _$this._economicStatus = economicStatus;

  String? _technicalStatus;
  String? get technicalStatus => _$this._technicalStatus;
  set technicalStatus(String? technicalStatus) =>
      _$this._technicalStatus = technicalStatus;

  bool? _unresolved;
  bool? get unresolved => _$this._unresolved;
  set unresolved(bool? unresolved) => _$this._unresolved = unresolved;

  ListBuilder<FinancialObligationAmounts>? _amounts;
  ListBuilder<FinancialObligationAmounts> get amounts =>
      _$this._amounts ??= ListBuilder<FinancialObligationAmounts>();
  set amounts(ListBuilder<FinancialObligationAmounts>? amounts) =>
      _$this._amounts = amounts;

  ListBuilder<FinancialSettlementEvidence>? _evidence;
  ListBuilder<FinancialSettlementEvidence> get evidence =>
      _$this._evidence ??= ListBuilder<FinancialSettlementEvidence>();
  set evidence(ListBuilder<FinancialSettlementEvidence>? evidence) =>
      _$this._evidence = evidence;

  FinancialResponsibilityBuilder? _responsibility;
  FinancialResponsibilityBuilder get responsibility =>
      _$this._responsibility ??= FinancialResponsibilityBuilder();
  set responsibility(FinancialResponsibilityBuilder? responsibility) =>
      _$this._responsibility = responsibility;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _lastObservedAt;
  DateTime? get lastObservedAt => _$this._lastObservedAt;
  set lastObservedAt(DateTime? lastObservedAt) =>
      _$this._lastObservedAt = lastObservedAt;

  DateTime? _nextObservationAt;
  DateTime? get nextObservationAt => _$this._nextObservationAt;
  set nextObservationAt(DateTime? nextObservationAt) =>
      _$this._nextObservationAt = nextObservationAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  FinancialObligationBuilder() {
    FinancialObligation._defaults(this);
  }

  FinancialObligationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _obligationId = $v.obligationId;
      _businessReference = $v.businessReference.toBuilder();
      _relatedReferences = $v.relatedReferences.toBuilder();
      _economicStatus = $v.economicStatus;
      _technicalStatus = $v.technicalStatus;
      _unresolved = $v.unresolved;
      _amounts = $v.amounts.toBuilder();
      _evidence = $v.evidence.toBuilder();
      _responsibility = $v.responsibility.toBuilder();
      _reason = $v.reason;
      _lastObservedAt = $v.lastObservedAt;
      _nextObservationAt = $v.nextObservationAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialObligation other) {
    _$v = other as _$FinancialObligation;
  }

  @override
  void update(void Function(FinancialObligationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialObligation build() => _build();

  _$FinancialObligation _build() {
    _$FinancialObligation _$result;
    try {
      _$result = _$v ??
          _$FinancialObligation._(
            obligationId: BuiltValueNullFieldError.checkNotNull(
                obligationId, r'FinancialObligation', 'obligationId'),
            businessReference: businessReference.build(),
            relatedReferences: relatedReferences.build(),
            economicStatus: BuiltValueNullFieldError.checkNotNull(
                economicStatus, r'FinancialObligation', 'economicStatus'),
            technicalStatus: BuiltValueNullFieldError.checkNotNull(
                technicalStatus, r'FinancialObligation', 'technicalStatus'),
            unresolved: BuiltValueNullFieldError.checkNotNull(
                unresolved, r'FinancialObligation', 'unresolved'),
            amounts: amounts.build(),
            evidence: evidence.build(),
            responsibility: responsibility.build(),
            reason: reason,
            lastObservedAt: lastObservedAt,
            nextObservationAt: nextObservationAt,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'FinancialObligation', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'FinancialObligation', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'businessReference';
        businessReference.build();
        _$failedField = 'relatedReferences';
        relatedReferences.build();

        _$failedField = 'amounts';
        amounts.build();
        _$failedField = 'evidence';
        evidence.build();
        _$failedField = 'responsibility';
        responsibility.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinancialObligation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
