// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_responsibility.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinancialResponsibilityEscalationStatusEnum
    _$financialResponsibilityEscalationStatusEnum_none =
    const FinancialResponsibilityEscalationStatusEnum._('none');
const FinancialResponsibilityEscalationStatusEnum
    _$financialResponsibilityEscalationStatusEnum_queued =
    const FinancialResponsibilityEscalationStatusEnum._('queued');
const FinancialResponsibilityEscalationStatusEnum
    _$financialResponsibilityEscalationStatusEnum_escalated =
    const FinancialResponsibilityEscalationStatusEnum._('escalated');
const FinancialResponsibilityEscalationStatusEnum
    _$financialResponsibilityEscalationStatusEnum_reviewed =
    const FinancialResponsibilityEscalationStatusEnum._('reviewed');

FinancialResponsibilityEscalationStatusEnum
    _$financialResponsibilityEscalationStatusEnumValueOf(String name) {
  switch (name) {
    case 'none':
      return _$financialResponsibilityEscalationStatusEnum_none;
    case 'queued':
      return _$financialResponsibilityEscalationStatusEnum_queued;
    case 'escalated':
      return _$financialResponsibilityEscalationStatusEnum_escalated;
    case 'reviewed':
      return _$financialResponsibilityEscalationStatusEnum_reviewed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialResponsibilityEscalationStatusEnum>
    _$financialResponsibilityEscalationStatusEnumValues = BuiltSet<
        FinancialResponsibilityEscalationStatusEnum>(const <FinancialResponsibilityEscalationStatusEnum>[
  _$financialResponsibilityEscalationStatusEnum_none,
  _$financialResponsibilityEscalationStatusEnum_queued,
  _$financialResponsibilityEscalationStatusEnum_escalated,
  _$financialResponsibilityEscalationStatusEnum_reviewed,
]);

const FinancialResponsibilityAllowedActionsEnum
    _$financialResponsibilityAllowedActionsEnum_observe =
    const FinancialResponsibilityAllowedActionsEnum._('observe');
const FinancialResponsibilityAllowedActionsEnum
    _$financialResponsibilityAllowedActionsEnum_contactSupport =
    const FinancialResponsibilityAllowedActionsEnum._('contactSupport');
const FinancialResponsibilityAllowedActionsEnum
    _$financialResponsibilityAllowedActionsEnum_viewDetails =
    const FinancialResponsibilityAllowedActionsEnum._('viewDetails');

FinancialResponsibilityAllowedActionsEnum
    _$financialResponsibilityAllowedActionsEnumValueOf(String name) {
  switch (name) {
    case 'observe':
      return _$financialResponsibilityAllowedActionsEnum_observe;
    case 'contactSupport':
      return _$financialResponsibilityAllowedActionsEnum_contactSupport;
    case 'viewDetails':
      return _$financialResponsibilityAllowedActionsEnum_viewDetails;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialResponsibilityAllowedActionsEnum>
    _$financialResponsibilityAllowedActionsEnumValues = BuiltSet<
        FinancialResponsibilityAllowedActionsEnum>(const <FinancialResponsibilityAllowedActionsEnum>[
  _$financialResponsibilityAllowedActionsEnum_observe,
  _$financialResponsibilityAllowedActionsEnum_contactSupport,
  _$financialResponsibilityAllowedActionsEnum_viewDetails,
]);

Serializer<FinancialResponsibilityEscalationStatusEnum>
    _$financialResponsibilityEscalationStatusEnumSerializer =
    _$FinancialResponsibilityEscalationStatusEnumSerializer();
Serializer<FinancialResponsibilityAllowedActionsEnum>
    _$financialResponsibilityAllowedActionsEnumSerializer =
    _$FinancialResponsibilityAllowedActionsEnumSerializer();

class _$FinancialResponsibilityEscalationStatusEnumSerializer
    implements
        PrimitiveSerializer<FinancialResponsibilityEscalationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'none',
    'queued': 'queued',
    'escalated': 'escalated',
    'reviewed': 'reviewed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'none': 'none',
    'queued': 'queued',
    'escalated': 'escalated',
    'reviewed': 'reviewed',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinancialResponsibilityEscalationStatusEnum
  ];
  @override
  final String wireName = 'FinancialResponsibilityEscalationStatusEnum';

  @override
  Object serialize(Serializers serializers,
          FinancialResponsibilityEscalationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialResponsibilityEscalationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialResponsibilityEscalationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialResponsibilityAllowedActionsEnumSerializer
    implements PrimitiveSerializer<FinancialResponsibilityAllowedActionsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'observe': 'observe',
    'contactSupport': 'contact_support',
    'viewDetails': 'view_details',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'observe': 'observe',
    'contact_support': 'contactSupport',
    'view_details': 'viewDetails',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinancialResponsibilityAllowedActionsEnum
  ];
  @override
  final String wireName = 'FinancialResponsibilityAllowedActionsEnum';

  @override
  Object serialize(Serializers serializers,
          FinancialResponsibilityAllowedActionsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialResponsibilityAllowedActionsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialResponsibilityAllowedActionsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialResponsibility extends FinancialResponsibility {
  @override
  final String queue;
  @override
  final FinancialResponsibilityEscalationStatusEnum escalationStatus;
  @override
  final BuiltSet<FinancialResponsibilityAllowedActionsEnum> allowedActions;
  @override
  final String? caseId;
  @override
  final String? owner;

  factory _$FinancialResponsibility(
          [void Function(FinancialResponsibilityBuilder)? updates]) =>
      (FinancialResponsibilityBuilder()..update(updates))._build();

  _$FinancialResponsibility._(
      {required this.queue,
      required this.escalationStatus,
      required this.allowedActions,
      this.caseId,
      this.owner})
      : super._();
  @override
  FinancialResponsibility rebuild(
          void Function(FinancialResponsibilityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialResponsibilityBuilder toBuilder() =>
      FinancialResponsibilityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialResponsibility &&
        queue == other.queue &&
        escalationStatus == other.escalationStatus &&
        allowedActions == other.allowedActions &&
        caseId == other.caseId &&
        owner == other.owner;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, queue.hashCode);
    _$hash = $jc(_$hash, escalationStatus.hashCode);
    _$hash = $jc(_$hash, allowedActions.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, owner.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialResponsibility')
          ..add('queue', queue)
          ..add('escalationStatus', escalationStatus)
          ..add('allowedActions', allowedActions)
          ..add('caseId', caseId)
          ..add('owner', owner))
        .toString();
  }
}

class FinancialResponsibilityBuilder
    implements
        Builder<FinancialResponsibility, FinancialResponsibilityBuilder> {
  _$FinancialResponsibility? _$v;

  String? _queue;
  String? get queue => _$this._queue;
  set queue(String? queue) => _$this._queue = queue;

  FinancialResponsibilityEscalationStatusEnum? _escalationStatus;
  FinancialResponsibilityEscalationStatusEnum? get escalationStatus =>
      _$this._escalationStatus;
  set escalationStatus(
          FinancialResponsibilityEscalationStatusEnum? escalationStatus) =>
      _$this._escalationStatus = escalationStatus;

  SetBuilder<FinancialResponsibilityAllowedActionsEnum>? _allowedActions;
  SetBuilder<FinancialResponsibilityAllowedActionsEnum> get allowedActions =>
      _$this._allowedActions ??=
          SetBuilder<FinancialResponsibilityAllowedActionsEnum>();
  set allowedActions(
          SetBuilder<FinancialResponsibilityAllowedActionsEnum>?
              allowedActions) =>
      _$this._allowedActions = allowedActions;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _owner;
  String? get owner => _$this._owner;
  set owner(String? owner) => _$this._owner = owner;

  FinancialResponsibilityBuilder() {
    FinancialResponsibility._defaults(this);
  }

  FinancialResponsibilityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _queue = $v.queue;
      _escalationStatus = $v.escalationStatus;
      _allowedActions = $v.allowedActions.toBuilder();
      _caseId = $v.caseId;
      _owner = $v.owner;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialResponsibility other) {
    _$v = other as _$FinancialResponsibility;
  }

  @override
  void update(void Function(FinancialResponsibilityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialResponsibility build() => _build();

  _$FinancialResponsibility _build() {
    _$FinancialResponsibility _$result;
    try {
      _$result = _$v ??
          _$FinancialResponsibility._(
            queue: BuiltValueNullFieldError.checkNotNull(
                queue, r'FinancialResponsibility', 'queue'),
            escalationStatus: BuiltValueNullFieldError.checkNotNull(
                escalationStatus,
                r'FinancialResponsibility',
                'escalationStatus'),
            allowedActions: allowedActions.build(),
            caseId: caseId,
            owner: owner,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'allowedActions';
        allowedActions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinancialResponsibility', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
