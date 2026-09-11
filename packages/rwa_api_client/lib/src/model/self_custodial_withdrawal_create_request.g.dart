// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SelfCustodialWithdrawalCreateRequest
    extends SelfCustodialWithdrawalCreateRequest {
  @override
  final String walletId;
  @override
  final String assetId;
  @override
  final SelfCustodialWithdrawalChain chain;
  @override
  final String amount;
  @override
  final String destinationAddress;

  factory _$SelfCustodialWithdrawalCreateRequest(
          [void Function(SelfCustodialWithdrawalCreateRequestBuilder)?
              updates]) =>
      (SelfCustodialWithdrawalCreateRequestBuilder()..update(updates))._build();

  _$SelfCustodialWithdrawalCreateRequest._(
      {required this.walletId,
      required this.assetId,
      required this.chain,
      required this.amount,
      required this.destinationAddress})
      : super._();
  @override
  SelfCustodialWithdrawalCreateRequest rebuild(
          void Function(SelfCustodialWithdrawalCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SelfCustodialWithdrawalCreateRequestBuilder toBuilder() =>
      SelfCustodialWithdrawalCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SelfCustodialWithdrawalCreateRequest &&
        walletId == other.walletId &&
        assetId == other.assetId &&
        chain == other.chain &&
        amount == other.amount &&
        destinationAddress == other.destinationAddress;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, destinationAddress.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SelfCustodialWithdrawalCreateRequest')
          ..add('walletId', walletId)
          ..add('assetId', assetId)
          ..add('chain', chain)
          ..add('amount', amount)
          ..add('destinationAddress', destinationAddress))
        .toString();
  }
}

class SelfCustodialWithdrawalCreateRequestBuilder
    implements
        Builder<SelfCustodialWithdrawalCreateRequest,
            SelfCustodialWithdrawalCreateRequestBuilder> {
  _$SelfCustodialWithdrawalCreateRequest? _$v;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  SelfCustodialWithdrawalChain? _chain;
  SelfCustodialWithdrawalChain? get chain => _$this._chain;
  set chain(SelfCustodialWithdrawalChain? chain) => _$this._chain = chain;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _destinationAddress;
  String? get destinationAddress => _$this._destinationAddress;
  set destinationAddress(String? destinationAddress) =>
      _$this._destinationAddress = destinationAddress;

  SelfCustodialWithdrawalCreateRequestBuilder() {
    SelfCustodialWithdrawalCreateRequest._defaults(this);
  }

  SelfCustodialWithdrawalCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletId = $v.walletId;
      _assetId = $v.assetId;
      _chain = $v.chain;
      _amount = $v.amount;
      _destinationAddress = $v.destinationAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SelfCustodialWithdrawalCreateRequest other) {
    _$v = other as _$SelfCustodialWithdrawalCreateRequest;
  }

  @override
  void update(
      void Function(SelfCustodialWithdrawalCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SelfCustodialWithdrawalCreateRequest build() => _build();

  _$SelfCustodialWithdrawalCreateRequest _build() {
    final _$result = _$v ??
        _$SelfCustodialWithdrawalCreateRequest._(
          walletId: BuiltValueNullFieldError.checkNotNull(
              walletId, r'SelfCustodialWithdrawalCreateRequest', 'walletId'),
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'SelfCustodialWithdrawalCreateRequest', 'assetId'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'SelfCustodialWithdrawalCreateRequest', 'chain'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'SelfCustodialWithdrawalCreateRequest', 'amount'),
          destinationAddress: BuiltValueNullFieldError.checkNotNull(
              destinationAddress,
              r'SelfCustodialWithdrawalCreateRequest',
              'destinationAddress'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
