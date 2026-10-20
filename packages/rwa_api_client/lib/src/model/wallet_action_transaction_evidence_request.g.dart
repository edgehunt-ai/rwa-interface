// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_transaction_evidence_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletActionTransactionEvidenceRequest
    extends WalletActionTransactionEvidenceRequest {
  @override
  final String txHash;

  factory _$WalletActionTransactionEvidenceRequest(
          [void Function(WalletActionTransactionEvidenceRequestBuilder)?
              updates]) =>
      (WalletActionTransactionEvidenceRequestBuilder()..update(updates))
          ._build();

  _$WalletActionTransactionEvidenceRequest._({required this.txHash})
      : super._();
  @override
  WalletActionTransactionEvidenceRequest rebuild(
          void Function(WalletActionTransactionEvidenceRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionTransactionEvidenceRequestBuilder toBuilder() =>
      WalletActionTransactionEvidenceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionTransactionEvidenceRequest &&
        txHash == other.txHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WalletActionTransactionEvidenceRequest')
          ..add('txHash', txHash))
        .toString();
  }
}

class WalletActionTransactionEvidenceRequestBuilder
    implements
        Builder<WalletActionTransactionEvidenceRequest,
            WalletActionTransactionEvidenceRequestBuilder> {
  _$WalletActionTransactionEvidenceRequest? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  WalletActionTransactionEvidenceRequestBuilder() {
    WalletActionTransactionEvidenceRequest._defaults(this);
  }

  WalletActionTransactionEvidenceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionTransactionEvidenceRequest other) {
    _$v = other as _$WalletActionTransactionEvidenceRequest;
  }

  @override
  void update(
      void Function(WalletActionTransactionEvidenceRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionTransactionEvidenceRequest build() => _build();

  _$WalletActionTransactionEvidenceRequest _build() {
    final _$result = _$v ??
        _$WalletActionTransactionEvidenceRequest._(
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'WalletActionTransactionEvidenceRequest', 'txHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
