// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SelfCustodialWithdrawal extends SelfCustodialWithdrawal {
  @override
  final String withdrawalId;
  @override
  final String sourceWalletId;
  @override
  final String assetId;
  @override
  final String assetSymbol;
  @override
  final String amount;
  @override
  final String destinationAddress;
  @override
  final SelfCustodialWithdrawalTransaction transaction;
  @override
  final SelfCustodialWithdrawalGasEstimate? gas;
  @override
  final SelfCustodialWithdrawalStatus status;
  @override
  final String? txHash;
  @override
  final int? confirmations;
  @override
  final int requiredConfirmations;
  @override
  final String? failureReason;
  @override
  final String? manualReviewReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? confirmedAt;

  factory _$SelfCustodialWithdrawal(
          [void Function(SelfCustodialWithdrawalBuilder)? updates]) =>
      (SelfCustodialWithdrawalBuilder()..update(updates))._build();

  _$SelfCustodialWithdrawal._(
      {required this.withdrawalId,
      required this.sourceWalletId,
      required this.assetId,
      required this.assetSymbol,
      required this.amount,
      required this.destinationAddress,
      required this.transaction,
      this.gas,
      required this.status,
      this.txHash,
      this.confirmations,
      required this.requiredConfirmations,
      this.failureReason,
      this.manualReviewReason,
      required this.createdAt,
      required this.updatedAt,
      this.submittedAt,
      this.confirmedAt})
      : super._();
  @override
  SelfCustodialWithdrawal rebuild(
          void Function(SelfCustodialWithdrawalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SelfCustodialWithdrawalBuilder toBuilder() =>
      SelfCustodialWithdrawalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SelfCustodialWithdrawal &&
        withdrawalId == other.withdrawalId &&
        sourceWalletId == other.sourceWalletId &&
        assetId == other.assetId &&
        assetSymbol == other.assetSymbol &&
        amount == other.amount &&
        destinationAddress == other.destinationAddress &&
        transaction == other.transaction &&
        gas == other.gas &&
        status == other.status &&
        txHash == other.txHash &&
        confirmations == other.confirmations &&
        requiredConfirmations == other.requiredConfirmations &&
        failureReason == other.failureReason &&
        manualReviewReason == other.manualReviewReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        submittedAt == other.submittedAt &&
        confirmedAt == other.confirmedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, withdrawalId.hashCode);
    _$hash = $jc(_$hash, sourceWalletId.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, assetSymbol.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, destinationAddress.hashCode);
    _$hash = $jc(_$hash, transaction.hashCode);
    _$hash = $jc(_$hash, gas.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, requiredConfirmations.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, manualReviewReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, submittedAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SelfCustodialWithdrawal')
          ..add('withdrawalId', withdrawalId)
          ..add('sourceWalletId', sourceWalletId)
          ..add('assetId', assetId)
          ..add('assetSymbol', assetSymbol)
          ..add('amount', amount)
          ..add('destinationAddress', destinationAddress)
          ..add('transaction', transaction)
          ..add('gas', gas)
          ..add('status', status)
          ..add('txHash', txHash)
          ..add('confirmations', confirmations)
          ..add('requiredConfirmations', requiredConfirmations)
          ..add('failureReason', failureReason)
          ..add('manualReviewReason', manualReviewReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('submittedAt', submittedAt)
          ..add('confirmedAt', confirmedAt))
        .toString();
  }
}

class SelfCustodialWithdrawalBuilder
    implements
        Builder<SelfCustodialWithdrawal, SelfCustodialWithdrawalBuilder> {
  _$SelfCustodialWithdrawal? _$v;

  String? _withdrawalId;
  String? get withdrawalId => _$this._withdrawalId;
  set withdrawalId(String? withdrawalId) => _$this._withdrawalId = withdrawalId;

  String? _sourceWalletId;
  String? get sourceWalletId => _$this._sourceWalletId;
  set sourceWalletId(String? sourceWalletId) =>
      _$this._sourceWalletId = sourceWalletId;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  String? _assetSymbol;
  String? get assetSymbol => _$this._assetSymbol;
  set assetSymbol(String? assetSymbol) => _$this._assetSymbol = assetSymbol;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _destinationAddress;
  String? get destinationAddress => _$this._destinationAddress;
  set destinationAddress(String? destinationAddress) =>
      _$this._destinationAddress = destinationAddress;

  SelfCustodialWithdrawalTransactionBuilder? _transaction;
  SelfCustodialWithdrawalTransactionBuilder get transaction =>
      _$this._transaction ??= SelfCustodialWithdrawalTransactionBuilder();
  set transaction(SelfCustodialWithdrawalTransactionBuilder? transaction) =>
      _$this._transaction = transaction;

  SelfCustodialWithdrawalGasEstimateBuilder? _gas;
  SelfCustodialWithdrawalGasEstimateBuilder get gas =>
      _$this._gas ??= SelfCustodialWithdrawalGasEstimateBuilder();
  set gas(SelfCustodialWithdrawalGasEstimateBuilder? gas) => _$this._gas = gas;

  SelfCustodialWithdrawalStatus? _status;
  SelfCustodialWithdrawalStatus? get status => _$this._status;
  set status(SelfCustodialWithdrawalStatus? status) => _$this._status = status;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  int? _requiredConfirmations;
  int? get requiredConfirmations => _$this._requiredConfirmations;
  set requiredConfirmations(int? requiredConfirmations) =>
      _$this._requiredConfirmations = requiredConfirmations;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  String? _manualReviewReason;
  String? get manualReviewReason => _$this._manualReviewReason;
  set manualReviewReason(String? manualReviewReason) =>
      _$this._manualReviewReason = manualReviewReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _submittedAt;
  DateTime? get submittedAt => _$this._submittedAt;
  set submittedAt(DateTime? submittedAt) => _$this._submittedAt = submittedAt;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(DateTime? confirmedAt) => _$this._confirmedAt = confirmedAt;

  SelfCustodialWithdrawalBuilder() {
    SelfCustodialWithdrawal._defaults(this);
  }

  SelfCustodialWithdrawalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _withdrawalId = $v.withdrawalId;
      _sourceWalletId = $v.sourceWalletId;
      _assetId = $v.assetId;
      _assetSymbol = $v.assetSymbol;
      _amount = $v.amount;
      _destinationAddress = $v.destinationAddress;
      _transaction = $v.transaction.toBuilder();
      _gas = $v.gas?.toBuilder();
      _status = $v.status;
      _txHash = $v.txHash;
      _confirmations = $v.confirmations;
      _requiredConfirmations = $v.requiredConfirmations;
      _failureReason = $v.failureReason;
      _manualReviewReason = $v.manualReviewReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _submittedAt = $v.submittedAt;
      _confirmedAt = $v.confirmedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SelfCustodialWithdrawal other) {
    _$v = other as _$SelfCustodialWithdrawal;
  }

  @override
  void update(void Function(SelfCustodialWithdrawalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SelfCustodialWithdrawal build() => _build();

  _$SelfCustodialWithdrawal _build() {
    _$SelfCustodialWithdrawal _$result;
    try {
      _$result = _$v ??
          _$SelfCustodialWithdrawal._(
            withdrawalId: BuiltValueNullFieldError.checkNotNull(
                withdrawalId, r'SelfCustodialWithdrawal', 'withdrawalId'),
            sourceWalletId: BuiltValueNullFieldError.checkNotNull(
                sourceWalletId, r'SelfCustodialWithdrawal', 'sourceWalletId'),
            assetId: BuiltValueNullFieldError.checkNotNull(
                assetId, r'SelfCustodialWithdrawal', 'assetId'),
            assetSymbol: BuiltValueNullFieldError.checkNotNull(
                assetSymbol, r'SelfCustodialWithdrawal', 'assetSymbol'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'SelfCustodialWithdrawal', 'amount'),
            destinationAddress: BuiltValueNullFieldError.checkNotNull(
                destinationAddress,
                r'SelfCustodialWithdrawal',
                'destinationAddress'),
            transaction: transaction.build(),
            gas: _gas?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'SelfCustodialWithdrawal', 'status'),
            txHash: txHash,
            confirmations: confirmations,
            requiredConfirmations: BuiltValueNullFieldError.checkNotNull(
                requiredConfirmations,
                r'SelfCustodialWithdrawal',
                'requiredConfirmations'),
            failureReason: failureReason,
            manualReviewReason: manualReviewReason,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SelfCustodialWithdrawal', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'SelfCustodialWithdrawal', 'updatedAt'),
            submittedAt: submittedAt,
            confirmedAt: confirmedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transaction';
        transaction.build();
        _$failedField = 'gas';
        _gas?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SelfCustodialWithdrawal', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
