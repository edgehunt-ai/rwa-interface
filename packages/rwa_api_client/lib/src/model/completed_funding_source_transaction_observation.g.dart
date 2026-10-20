// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_funding_source_transaction_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CompletedFundingSourceTransactionObservationStatusEnum
    _$completedFundingSourceTransactionObservationStatusEnum_confirmed =
    const CompletedFundingSourceTransactionObservationStatusEnum._('confirmed');

CompletedFundingSourceTransactionObservationStatusEnum
    _$completedFundingSourceTransactionObservationStatusEnumValueOf(
        String name) {
  switch (name) {
    case 'confirmed':
      return _$completedFundingSourceTransactionObservationStatusEnum_confirmed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CompletedFundingSourceTransactionObservationStatusEnum>
    _$completedFundingSourceTransactionObservationStatusEnumValues = BuiltSet<
        CompletedFundingSourceTransactionObservationStatusEnum>(const <CompletedFundingSourceTransactionObservationStatusEnum>[
  _$completedFundingSourceTransactionObservationStatusEnum_confirmed,
]);

const CompletedFundingSourceTransactionObservationDebitBasisEnum
    _$completedFundingSourceTransactionObservationDebitBasisEnum_transferLogs =
    const CompletedFundingSourceTransactionObservationDebitBasisEnum._(
        'transferLogs');

CompletedFundingSourceTransactionObservationDebitBasisEnum
    _$completedFundingSourceTransactionObservationDebitBasisEnumValueOf(
        String name) {
  switch (name) {
    case 'transferLogs':
      return _$completedFundingSourceTransactionObservationDebitBasisEnum_transferLogs;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CompletedFundingSourceTransactionObservationDebitBasisEnum>
    _$completedFundingSourceTransactionObservationDebitBasisEnumValues =
    BuiltSet<
        CompletedFundingSourceTransactionObservationDebitBasisEnum>(const <CompletedFundingSourceTransactionObservationDebitBasisEnum>[
  _$completedFundingSourceTransactionObservationDebitBasisEnum_transferLogs,
]);

Serializer<CompletedFundingSourceTransactionObservationStatusEnum>
    _$completedFundingSourceTransactionObservationStatusEnumSerializer =
    _$CompletedFundingSourceTransactionObservationStatusEnumSerializer();
Serializer<CompletedFundingSourceTransactionObservationDebitBasisEnum>
    _$completedFundingSourceTransactionObservationDebitBasisEnumSerializer =
    _$CompletedFundingSourceTransactionObservationDebitBasisEnumSerializer();

class _$CompletedFundingSourceTransactionObservationStatusEnumSerializer
    implements
        PrimitiveSerializer<
            CompletedFundingSourceTransactionObservationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'confirmed': 'confirmed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'confirmed': 'confirmed',
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

class _$CompletedFundingSourceTransactionObservationDebitBasisEnumSerializer
    implements
        PrimitiveSerializer<
            CompletedFundingSourceTransactionObservationDebitBasisEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'transferLogs': 'transfer_logs',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'transfer_logs': 'transferLogs',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CompletedFundingSourceTransactionObservationDebitBasisEnum
  ];
  @override
  final String wireName =
      'CompletedFundingSourceTransactionObservationDebitBasisEnum';

  @override
  Object serialize(Serializers serializers,
          CompletedFundingSourceTransactionObservationDebitBasisEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CompletedFundingSourceTransactionObservationDebitBasisEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CompletedFundingSourceTransactionObservationDebitBasisEnum.valueOf(
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
  final int? requiredConfirmations;
  @override
  final int? blockNumber;
  @override
  final String? blockHash;
  @override
  final int? transactionIndex;
  @override
  final bool? canonical;
  @override
  final bool? finalitySatisfied;
  @override
  final String? actualDebitedAmount;
  @override
  final CompletedFundingSourceTransactionObservationDebitBasisEnum? debitBasis;
  @override
  final BuiltSet<int>? debitLogIndices;
  @override
  final String? userOperationHash;
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
      this.requiredConfirmations,
      this.blockNumber,
      this.blockHash,
      this.transactionIndex,
      this.canonical,
      this.finalitySatisfied,
      this.actualDebitedAmount,
      this.debitBasis,
      this.debitLogIndices,
      this.userOperationHash,
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
        requiredConfirmations == other.requiredConfirmations &&
        blockNumber == other.blockNumber &&
        blockHash == other.blockHash &&
        transactionIndex == other.transactionIndex &&
        canonical == other.canonical &&
        finalitySatisfied == other.finalitySatisfied &&
        actualDebitedAmount == other.actualDebitedAmount &&
        debitBasis == other.debitBasis &&
        debitLogIndices == other.debitLogIndices &&
        userOperationHash == other.userOperationHash &&
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
    _$hash = $jc(_$hash, requiredConfirmations.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, transactionIndex.hashCode);
    _$hash = $jc(_$hash, canonical.hashCode);
    _$hash = $jc(_$hash, finalitySatisfied.hashCode);
    _$hash = $jc(_$hash, actualDebitedAmount.hashCode);
    _$hash = $jc(_$hash, debitBasis.hashCode);
    _$hash = $jc(_$hash, debitLogIndices.hashCode);
    _$hash = $jc(_$hash, userOperationHash.hashCode);
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
          ..add('requiredConfirmations', requiredConfirmations)
          ..add('blockNumber', blockNumber)
          ..add('blockHash', blockHash)
          ..add('transactionIndex', transactionIndex)
          ..add('canonical', canonical)
          ..add('finalitySatisfied', finalitySatisfied)
          ..add('actualDebitedAmount', actualDebitedAmount)
          ..add('debitBasis', debitBasis)
          ..add('debitLogIndices', debitLogIndices)
          ..add('userOperationHash', userOperationHash)
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

  int? _requiredConfirmations;
  int? get requiredConfirmations => _$this._requiredConfirmations;
  set requiredConfirmations(int? requiredConfirmations) =>
      _$this._requiredConfirmations = requiredConfirmations;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(String? blockHash) => _$this._blockHash = blockHash;

  int? _transactionIndex;
  int? get transactionIndex => _$this._transactionIndex;
  set transactionIndex(int? transactionIndex) =>
      _$this._transactionIndex = transactionIndex;

  bool? _canonical;
  bool? get canonical => _$this._canonical;
  set canonical(bool? canonical) => _$this._canonical = canonical;

  bool? _finalitySatisfied;
  bool? get finalitySatisfied => _$this._finalitySatisfied;
  set finalitySatisfied(bool? finalitySatisfied) =>
      _$this._finalitySatisfied = finalitySatisfied;

  String? _actualDebitedAmount;
  String? get actualDebitedAmount => _$this._actualDebitedAmount;
  set actualDebitedAmount(String? actualDebitedAmount) =>
      _$this._actualDebitedAmount = actualDebitedAmount;

  CompletedFundingSourceTransactionObservationDebitBasisEnum? _debitBasis;
  CompletedFundingSourceTransactionObservationDebitBasisEnum? get debitBasis =>
      _$this._debitBasis;
  set debitBasis(
          CompletedFundingSourceTransactionObservationDebitBasisEnum?
              debitBasis) =>
      _$this._debitBasis = debitBasis;

  SetBuilder<int>? _debitLogIndices;
  SetBuilder<int> get debitLogIndices =>
      _$this._debitLogIndices ??= SetBuilder<int>();
  set debitLogIndices(SetBuilder<int>? debitLogIndices) =>
      _$this._debitLogIndices = debitLogIndices;

  String? _userOperationHash;
  String? get userOperationHash => _$this._userOperationHash;
  set userOperationHash(String? userOperationHash) =>
      _$this._userOperationHash = userOperationHash;

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
      _requiredConfirmations = $v.requiredConfirmations;
      _blockNumber = $v.blockNumber;
      _blockHash = $v.blockHash;
      _transactionIndex = $v.transactionIndex;
      _canonical = $v.canonical;
      _finalitySatisfied = $v.finalitySatisfied;
      _actualDebitedAmount = $v.actualDebitedAmount;
      _debitBasis = $v.debitBasis;
      _debitLogIndices = $v.debitLogIndices?.toBuilder();
      _userOperationHash = $v.userOperationHash;
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
    _$CompletedFundingSourceTransactionObservation _$result;
    try {
      _$result = _$v ??
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
            confirmations: BuiltValueNullFieldError.checkNotNull(
                confirmations,
                r'CompletedFundingSourceTransactionObservation',
                'confirmations'),
            requiredConfirmations: requiredConfirmations,
            blockNumber: blockNumber,
            blockHash: blockHash,
            transactionIndex: transactionIndex,
            canonical: canonical,
            finalitySatisfied: finalitySatisfied,
            actualDebitedAmount: actualDebitedAmount,
            debitBasis: debitBasis,
            debitLogIndices: _debitLogIndices?.build(),
            userOperationHash: userOperationHash,
            observedAt: BuiltValueNullFieldError.checkNotNull(observedAt,
                r'CompletedFundingSourceTransactionObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'debitLogIndices';
        _debitLogIndices?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CompletedFundingSourceTransactionObservation',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
