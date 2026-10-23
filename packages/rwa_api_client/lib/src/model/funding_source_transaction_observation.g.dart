// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_transaction_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSourceTransactionObservationDebitBasisEnum
    _$fundingSourceTransactionObservationDebitBasisEnum_transferLogs =
    const FundingSourceTransactionObservationDebitBasisEnum._('transferLogs');
const FundingSourceTransactionObservationDebitBasisEnum
    _$fundingSourceTransactionObservationDebitBasisEnum_finalizedRevert =
    const FundingSourceTransactionObservationDebitBasisEnum._(
        'finalizedRevert');

FundingSourceTransactionObservationDebitBasisEnum
    _$fundingSourceTransactionObservationDebitBasisEnumValueOf(String name) {
  switch (name) {
    case 'transferLogs':
      return _$fundingSourceTransactionObservationDebitBasisEnum_transferLogs;
    case 'finalizedRevert':
      return _$fundingSourceTransactionObservationDebitBasisEnum_finalizedRevert;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingSourceTransactionObservationDebitBasisEnum>
    _$fundingSourceTransactionObservationDebitBasisEnumValues = BuiltSet<
        FundingSourceTransactionObservationDebitBasisEnum>(const <FundingSourceTransactionObservationDebitBasisEnum>[
  _$fundingSourceTransactionObservationDebitBasisEnum_transferLogs,
  _$fundingSourceTransactionObservationDebitBasisEnum_finalizedRevert,
]);

Serializer<FundingSourceTransactionObservationDebitBasisEnum>
    _$fundingSourceTransactionObservationDebitBasisEnumSerializer =
    _$FundingSourceTransactionObservationDebitBasisEnumSerializer();

class _$FundingSourceTransactionObservationDebitBasisEnumSerializer
    implements
        PrimitiveSerializer<FundingSourceTransactionObservationDebitBasisEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'transferLogs': 'transfer_logs',
    'finalizedRevert': 'finalized_revert',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'transfer_logs': 'transferLogs',
    'finalized_revert': 'finalizedRevert',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSourceTransactionObservationDebitBasisEnum
  ];
  @override
  final String wireName = 'FundingSourceTransactionObservationDebitBasisEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSourceTransactionObservationDebitBasisEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSourceTransactionObservationDebitBasisEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSourceTransactionObservationDebitBasisEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSourceTransactionObservation
    extends FundingSourceTransactionObservation {
  @override
  final int chainId;
  @override
  final String txHash;
  @override
  final TransferSourceExecutionStatus status;
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
  final FundingSourceTransactionObservationDebitBasisEnum? debitBasis;
  @override
  final BuiltSet<int>? debitLogIndices;
  @override
  final String? userOperationHash;
  @override
  final DateTime observedAt;

  factory _$FundingSourceTransactionObservation(
          [void Function(FundingSourceTransactionObservationBuilder)?
              updates]) =>
      (FundingSourceTransactionObservationBuilder()..update(updates))._build();

  _$FundingSourceTransactionObservation._(
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
  FundingSourceTransactionObservation rebuild(
          void Function(FundingSourceTransactionObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceTransactionObservationBuilder toBuilder() =>
      FundingSourceTransactionObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceTransactionObservation &&
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
    return (newBuiltValueToStringHelper(r'FundingSourceTransactionObservation')
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

class FundingSourceTransactionObservationBuilder
    implements
        Builder<FundingSourceTransactionObservation,
            FundingSourceTransactionObservationBuilder> {
  _$FundingSourceTransactionObservation? _$v;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  TransferSourceExecutionStatus? _status;
  TransferSourceExecutionStatus? get status => _$this._status;
  set status(TransferSourceExecutionStatus? status) => _$this._status = status;

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

  FundingSourceTransactionObservationDebitBasisEnum? _debitBasis;
  FundingSourceTransactionObservationDebitBasisEnum? get debitBasis =>
      _$this._debitBasis;
  set debitBasis(
          FundingSourceTransactionObservationDebitBasisEnum? debitBasis) =>
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

  FundingSourceTransactionObservationBuilder() {
    FundingSourceTransactionObservation._defaults(this);
  }

  FundingSourceTransactionObservationBuilder get _$this {
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
  void replace(FundingSourceTransactionObservation other) {
    _$v = other as _$FundingSourceTransactionObservation;
  }

  @override
  void update(
      void Function(FundingSourceTransactionObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceTransactionObservation build() => _build();

  _$FundingSourceTransactionObservation _build() {
    _$FundingSourceTransactionObservation _$result;
    try {
      _$result = _$v ??
          _$FundingSourceTransactionObservation._(
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'FundingSourceTransactionObservation', 'chainId'),
            txHash: BuiltValueNullFieldError.checkNotNull(
                txHash, r'FundingSourceTransactionObservation', 'txHash'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingSourceTransactionObservation', 'status'),
            receiptSuccess: BuiltValueNullFieldError.checkNotNull(
                receiptSuccess,
                r'FundingSourceTransactionObservation',
                'receiptSuccess'),
            confirmations: BuiltValueNullFieldError.checkNotNull(confirmations,
                r'FundingSourceTransactionObservation', 'confirmations'),
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
                r'FundingSourceTransactionObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'debitLogIndices';
        _debitLogIndices?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'FundingSourceTransactionObservation',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
