// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_wallet_action_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksWalletActionSubmissionRequest
    extends BstocksWalletActionSubmissionRequest {
  @override
  final String txHash;

  factory _$BstocksWalletActionSubmissionRequest(
          [void Function(BstocksWalletActionSubmissionRequestBuilder)?
              updates]) =>
      (BstocksWalletActionSubmissionRequestBuilder()..update(updates))._build();

  _$BstocksWalletActionSubmissionRequest._({required this.txHash}) : super._();
  @override
  BstocksWalletActionSubmissionRequest rebuild(
          void Function(BstocksWalletActionSubmissionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksWalletActionSubmissionRequestBuilder toBuilder() =>
      BstocksWalletActionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksWalletActionSubmissionRequest &&
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
    return (newBuiltValueToStringHelper(r'BstocksWalletActionSubmissionRequest')
          ..add('txHash', txHash))
        .toString();
  }
}

class BstocksWalletActionSubmissionRequestBuilder
    implements
        Builder<BstocksWalletActionSubmissionRequest,
            BstocksWalletActionSubmissionRequestBuilder> {
  _$BstocksWalletActionSubmissionRequest? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  BstocksWalletActionSubmissionRequestBuilder() {
    BstocksWalletActionSubmissionRequest._defaults(this);
  }

  BstocksWalletActionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksWalletActionSubmissionRequest other) {
    _$v = other as _$BstocksWalletActionSubmissionRequest;
  }

  @override
  void update(
      void Function(BstocksWalletActionSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksWalletActionSubmissionRequest build() => _build();

  _$BstocksWalletActionSubmissionRequest _build() {
    final _$result = _$v ??
        _$BstocksWalletActionSubmissionRequest._(
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'BstocksWalletActionSubmissionRequest', 'txHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
