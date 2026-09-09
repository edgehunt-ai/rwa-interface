// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_funding_source_transaction_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CompletedFundingSourceTransactionObservationStatusEnum
    _$completedFundingSourceTransactionObservationStatusEnum_confirmed =
    const CompletedFundingSourceTransactionObservationStatusEnum._('confirmed');
const CompletedFundingSourceTransactionObservationStatusEnum
    _$completedFundingSourceTransactionObservationStatusEnum_unknownDefaultOpenApi =
    const CompletedFundingSourceTransactionObservationStatusEnum._(
        'unknownDefaultOpenApi');

CompletedFundingSourceTransactionObservationStatusEnum
    _$completedFundingSourceTransactionObservationStatusEnumValueOf(
        String name) {
  switch (name) {
    case 'confirmed':
      return _$completedFundingSourceTransactionObservationStatusEnum_confirmed;
    case 'unknownDefaultOpenApi':
      return _$completedFundingSourceTransactionObservationStatusEnum_unknownDefaultOpenApi;
    default:
      return _$completedFundingSourceTransactionObservationStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CompletedFundingSourceTransactionObservationStatusEnum>
    _$completedFundingSourceTransactionObservationStatusEnumValues = BuiltSet<
        CompletedFundingSourceTransactionObservationStatusEnum>(const <CompletedFundingSourceTransactionObservationStatusEnum>[
  _$completedFundingSourceTransactionObservationStatusEnum_confirmed,
  _$completedFundingSourceTransactionObservationStatusEnum_unknownDefaultOpenApi,
]);

Serializer<CompletedFundingSourceTransactionObservationStatusEnum>
    _$completedFundingSourceTransactionObservationStatusEnumSerializer =
    _$CompletedFundingSourceTransactionObservationStatusEnumSerializer();

class _$CompletedFundingSourceTransactionObservationStatusEnumSerializer
    implements
        PrimitiveSerializer<
            CompletedFundingSourceTransactionObservationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'confirmed': 'confirmed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'confirmed': 'confirmed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CompletedFundingSourceTransactionObservationStatusEnum
  ];
  @override
  final String wireName =
      'CompletedFundingSourceTransactionObservationStatusEnum';

  @override
  Object serialize(Serializers serializers,
          CompletedFundingSourceTransactionObservationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CompletedFundingSourceTransactionObservationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CompletedFundingSourceTransactionObservationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CompletedFundingSourceTransactionObservation
    extends CompletedFundingSourceTransactionObservation {
  @override
  final int chainId;
  @override
  final String txHash;
  @override
  final CompletedFundingSourceTransactionObservationStatusEnum status;
  @override
  final bool receiptSuccess;
  @override
  final int confirmations;
  @override
  final DateTime observedAt;

  factory _$CompletedFundingSourceTransactionObservation(
          [void Function(CompletedFundingSourceTransactionObservationBuilder)?
              updates]) =>
      (CompletedFundingSourceTransactionObservationBuilder()..update(updates))
          ._build();

  _$CompletedFundingSourceTransactionObservation._(
      {required this.chainId,
      required this.txHash,
      required this.status,
      required this.receiptSuccess,
      required this.confirmations,
      required this.observedAt})
      : super._();
  @override
  CompletedFundingSourceTransactionObservation rebuild(
          void Function(CompletedFundingSourceTransactionObservationBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompletedFundingSourceTransactionObservationBuilder toBuilder() =>
      CompletedFundingSourceTransactionObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompletedFundingSourceTransactionObservation &&
        chainId == other.chainId &&
        txHash == other.txHash &&
        status == other.status &&
        receiptSuccess == other.receiptSuccess &&
        confirmations == other.confirmations &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, receiptSuccess.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'CompletedFundingSourceTransactionObservation')
          ..add('chainId', chainId)
          ..add('txHash', txHash)
          ..add('status', status)
          ..add('receiptSuccess', receiptSuccess)
          ..add('confirmations', confirmations)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class CompletedFundingSourceTransactionObservationBuilder
    implements
        Builder<CompletedFundingSourceTransactionObservation,
            CompletedFundingSourceTransactionObservationBuilder> {
  _$CompletedFundingSourceTransactionObservation? _$v;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  CompletedFundingSourceTransactionObservationStatusEnum? _status;
  CompletedFundingSourceTransactionObservationStatusEnum? get status =>
      _$this._status;
  set status(CompletedFundingSourceTransactionObservationStatusEnum? status) =>
      _$this._status = status;

  bool? _receiptSuccess;
  bool? get receiptSuccess => _$this._receiptSuccess;
  set receiptSuccess(bool? receiptSuccess) =>
      _$this._receiptSuccess = receiptSuccess;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  CompletedFundingSourceTransactionObservationBuilder() {
    CompletedFundingSourceTransactionObservation._defaults(this);
  }

  CompletedFundingSourceTransactionObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chainId = $v.chainId;
      _txHash = $v.txHash;
      _status = $v.status;
      _receiptSuccess = $v.receiptSuccess;
      _confirmations = $v.confirmations;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompletedFundingSourceTransactionObservation other) {
    _$v = other as _$CompletedFundingSourceTransactionObservation;
  }

  @override
  void update(
      void Function(CompletedFundingSourceTransactionObservationBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  CompletedFundingSourceTransactionObservation build() => _build();

  _$CompletedFundingSourceTransactionObservation _build() {
    final _$result = _$v ??
        _$CompletedFundingSourceTransactionObservation._(
          chainId: BuiltValueNullFieldError.checkNotNull(chainId,
              r'CompletedFundingSourceTransactionObservation', 'chainId'),
          txHash: BuiltValueNullFieldError.checkNotNull(txHash,
              r'CompletedFundingSourceTransactionObservation', 'txHash'),
          status: BuiltValueNullFieldError.checkNotNull(status,
              r'CompletedFundingSourceTransactionObservation', 'status'),
          receiptSuccess: BuiltValueNullFieldError.checkNotNull(
              receiptSuccess,
              r'CompletedFundingSourceTransactionObservation',
              'receiptSuccess'),
          confirmations: BuiltValueNullFieldError.checkNotNull(confirmations,
              r'CompletedFundingSourceTransactionObservation', 'confirmations'),
          observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
              r'CompletedFundingSourceTransactionObservation', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
