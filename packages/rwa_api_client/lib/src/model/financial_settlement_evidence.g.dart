// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_settlement_evidence.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_sourceDebit =
    const FinancialSettlementEvidenceKindEnum._('sourceDebit');
const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_targetCredit =
    const FinancialSettlementEvidenceKindEnum._('targetCredit');
const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_refund =
    const FinancialSettlementEvidenceKindEnum._('refund');
const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_fee =
    const FinancialSettlementEvidenceKindEnum._('fee');
const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_reservationRelease =
    const FinancialSettlementEvidenceKindEnum._('reservationRelease');
const FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnum_compensation =
    const FinancialSettlementEvidenceKindEnum._('compensation');

FinancialSettlementEvidenceKindEnum
    _$financialSettlementEvidenceKindEnumValueOf(String name) {
  switch (name) {
    case 'sourceDebit':
      return _$financialSettlementEvidenceKindEnum_sourceDebit;
    case 'targetCredit':
      return _$financialSettlementEvidenceKindEnum_targetCredit;
    case 'refund':
      return _$financialSettlementEvidenceKindEnum_refund;
    case 'fee':
      return _$financialSettlementEvidenceKindEnum_fee;
    case 'reservationRelease':
      return _$financialSettlementEvidenceKindEnum_reservationRelease;
    case 'compensation':
      return _$financialSettlementEvidenceKindEnum_compensation;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialSettlementEvidenceKindEnum>
    _$financialSettlementEvidenceKindEnumValues = BuiltSet<
        FinancialSettlementEvidenceKindEnum>(const <FinancialSettlementEvidenceKindEnum>[
  _$financialSettlementEvidenceKindEnum_sourceDebit,
  _$financialSettlementEvidenceKindEnum_targetCredit,
  _$financialSettlementEvidenceKindEnum_refund,
  _$financialSettlementEvidenceKindEnum_fee,
  _$financialSettlementEvidenceKindEnum_reservationRelease,
  _$financialSettlementEvidenceKindEnum_compensation,
]);

const FinancialSettlementEvidenceStatusEnum
    _$financialSettlementEvidenceStatusEnum_observed =
    const FinancialSettlementEvidenceStatusEnum._('observed');
const FinancialSettlementEvidenceStatusEnum
    _$financialSettlementEvidenceStatusEnum_finalized =
    const FinancialSettlementEvidenceStatusEnum._('finalized');
const FinancialSettlementEvidenceStatusEnum
    _$financialSettlementEvidenceStatusEnum_conflicting =
    const FinancialSettlementEvidenceStatusEnum._('conflicting');

FinancialSettlementEvidenceStatusEnum
    _$financialSettlementEvidenceStatusEnumValueOf(String name) {
  switch (name) {
    case 'observed':
      return _$financialSettlementEvidenceStatusEnum_observed;
    case 'finalized':
      return _$financialSettlementEvidenceStatusEnum_finalized;
    case 'conflicting':
      return _$financialSettlementEvidenceStatusEnum_conflicting;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialSettlementEvidenceStatusEnum>
    _$financialSettlementEvidenceStatusEnumValues = BuiltSet<
        FinancialSettlementEvidenceStatusEnum>(const <FinancialSettlementEvidenceStatusEnum>[
  _$financialSettlementEvidenceStatusEnum_observed,
  _$financialSettlementEvidenceStatusEnum_finalized,
  _$financialSettlementEvidenceStatusEnum_conflicting,
]);

Serializer<FinancialSettlementEvidenceKindEnum>
    _$financialSettlementEvidenceKindEnumSerializer =
    _$FinancialSettlementEvidenceKindEnumSerializer();
Serializer<FinancialSettlementEvidenceStatusEnum>
    _$financialSettlementEvidenceStatusEnumSerializer =
    _$FinancialSettlementEvidenceStatusEnumSerializer();

class _$FinancialSettlementEvidenceKindEnumSerializer
    implements PrimitiveSerializer<FinancialSettlementEvidenceKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'sourceDebit': 'source_debit',
    'targetCredit': 'target_credit',
    'refund': 'refund',
    'fee': 'fee',
    'reservationRelease': 'reservation_release',
    'compensation': 'compensation',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'source_debit': 'sourceDebit',
    'target_credit': 'targetCredit',
    'refund': 'refund',
    'fee': 'fee',
    'reservation_release': 'reservationRelease',
    'compensation': 'compensation',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinancialSettlementEvidenceKindEnum
  ];
  @override
  final String wireName = 'FinancialSettlementEvidenceKindEnum';

  @override
  Object serialize(
          Serializers serializers, FinancialSettlementEvidenceKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialSettlementEvidenceKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialSettlementEvidenceKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialSettlementEvidenceStatusEnumSerializer
    implements PrimitiveSerializer<FinancialSettlementEvidenceStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'observed': 'observed',
    'finalized': 'finalized',
    'conflicting': 'conflicting',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'observed': 'observed',
    'finalized': 'finalized',
    'conflicting': 'conflicting',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinancialSettlementEvidenceStatusEnum
  ];
  @override
  final String wireName = 'FinancialSettlementEvidenceStatusEnum';

  @override
  Object serialize(
          Serializers serializers, FinancialSettlementEvidenceStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialSettlementEvidenceStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialSettlementEvidenceStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialSettlementEvidence extends FinancialSettlementEvidence {
  @override
  final String evidenceId;
  @override
  final FinancialSettlementEvidenceKindEnum kind;
  @override
  final FinancialSettlementEvidenceStatusEnum status;
  @override
  final FinancialBusinessReference reference;
  @override
  final DateTime observedAt;
  @override
  final int? chainId;
  @override
  final String? txHash;
  @override
  final int? logIndex;
  @override
  final String? venueReference;
  @override
  final FinancialBusinessReference? commandReference;

  factory _$FinancialSettlementEvidence(
          [void Function(FinancialSettlementEvidenceBuilder)? updates]) =>
      (FinancialSettlementEvidenceBuilder()..update(updates))._build();

  _$FinancialSettlementEvidence._(
      {required this.evidenceId,
      required this.kind,
      required this.status,
      required this.reference,
      required this.observedAt,
      this.chainId,
      this.txHash,
      this.logIndex,
      this.venueReference,
      this.commandReference})
      : super._();
  @override
  FinancialSettlementEvidence rebuild(
          void Function(FinancialSettlementEvidenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialSettlementEvidenceBuilder toBuilder() =>
      FinancialSettlementEvidenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialSettlementEvidence &&
        evidenceId == other.evidenceId &&
        kind == other.kind &&
        status == other.status &&
        reference == other.reference &&
        observedAt == other.observedAt &&
        chainId == other.chainId &&
        txHash == other.txHash &&
        logIndex == other.logIndex &&
        venueReference == other.venueReference &&
        commandReference == other.commandReference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, evidenceId.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, logIndex.hashCode);
    _$hash = $jc(_$hash, venueReference.hashCode);
    _$hash = $jc(_$hash, commandReference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialSettlementEvidence')
          ..add('evidenceId', evidenceId)
          ..add('kind', kind)
          ..add('status', status)
          ..add('reference', reference)
          ..add('observedAt', observedAt)
          ..add('chainId', chainId)
          ..add('txHash', txHash)
          ..add('logIndex', logIndex)
          ..add('venueReference', venueReference)
          ..add('commandReference', commandReference))
        .toString();
  }
}

class FinancialSettlementEvidenceBuilder
    implements
        Builder<FinancialSettlementEvidence,
            FinancialSettlementEvidenceBuilder> {
  _$FinancialSettlementEvidence? _$v;

  String? _evidenceId;
  String? get evidenceId => _$this._evidenceId;
  set evidenceId(String? evidenceId) => _$this._evidenceId = evidenceId;

  FinancialSettlementEvidenceKindEnum? _kind;
  FinancialSettlementEvidenceKindEnum? get kind => _$this._kind;
  set kind(FinancialSettlementEvidenceKindEnum? kind) => _$this._kind = kind;

  FinancialSettlementEvidenceStatusEnum? _status;
  FinancialSettlementEvidenceStatusEnum? get status => _$this._status;
  set status(FinancialSettlementEvidenceStatusEnum? status) =>
      _$this._status = status;

  FinancialBusinessReferenceBuilder? _reference;
  FinancialBusinessReferenceBuilder get reference =>
      _$this._reference ??= FinancialBusinessReferenceBuilder();
  set reference(FinancialBusinessReferenceBuilder? reference) =>
      _$this._reference = reference;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  int? _logIndex;
  int? get logIndex => _$this._logIndex;
  set logIndex(int? logIndex) => _$this._logIndex = logIndex;

  String? _venueReference;
  String? get venueReference => _$this._venueReference;
  set venueReference(String? venueReference) =>
      _$this._venueReference = venueReference;

  FinancialBusinessReferenceBuilder? _commandReference;
  FinancialBusinessReferenceBuilder get commandReference =>
      _$this._commandReference ??= FinancialBusinessReferenceBuilder();
  set commandReference(FinancialBusinessReferenceBuilder? commandReference) =>
      _$this._commandReference = commandReference;

  FinancialSettlementEvidenceBuilder() {
    FinancialSettlementEvidence._defaults(this);
  }

  FinancialSettlementEvidenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _evidenceId = $v.evidenceId;
      _kind = $v.kind;
      _status = $v.status;
      _reference = $v.reference.toBuilder();
      _observedAt = $v.observedAt;
      _chainId = $v.chainId;
      _txHash = $v.txHash;
      _logIndex = $v.logIndex;
      _venueReference = $v.venueReference;
      _commandReference = $v.commandReference?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialSettlementEvidence other) {
    _$v = other as _$FinancialSettlementEvidence;
  }

  @override
  void update(void Function(FinancialSettlementEvidenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialSettlementEvidence build() => _build();

  _$FinancialSettlementEvidence _build() {
    _$FinancialSettlementEvidence _$result;
    try {
      _$result = _$v ??
          _$FinancialSettlementEvidence._(
            evidenceId: BuiltValueNullFieldError.checkNotNull(
                evidenceId, r'FinancialSettlementEvidence', 'evidenceId'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'FinancialSettlementEvidence', 'kind'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FinancialSettlementEvidence', 'status'),
            reference: reference.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FinancialSettlementEvidence', 'observedAt'),
            chainId: chainId,
            txHash: txHash,
            logIndex: logIndex,
            venueReference: venueReference,
            commandReference: _commandReference?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'reference';
        reference.build();

        _$failedField = 'commandReference';
        _commandReference?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinancialSettlementEvidence', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
