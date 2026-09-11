// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SelfCustodialWithdrawalSubmissionRequest
    extends SelfCustodialWithdrawalSubmissionRequest {
  @override
  final String txHash;

  factory _$SelfCustodialWithdrawalSubmissionRequest(
          [void Function(SelfCustodialWithdrawalSubmissionRequestBuilder)?
              updates]) =>
      (SelfCustodialWithdrawalSubmissionRequestBuilder()..update(updates))
          ._build();

  _$SelfCustodialWithdrawalSubmissionRequest._({required this.txHash})
      : super._();
  @override
  SelfCustodialWithdrawalSubmissionRequest rebuild(
          void Function(SelfCustodialWithdrawalSubmissionRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SelfCustodialWithdrawalSubmissionRequestBuilder toBuilder() =>
      SelfCustodialWithdrawalSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SelfCustodialWithdrawalSubmissionRequest &&
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
            r'SelfCustodialWithdrawalSubmissionRequest')
          ..add('txHash', txHash))
        .toString();
  }
}

class SelfCustodialWithdrawalSubmissionRequestBuilder
    implements
        Builder<SelfCustodialWithdrawalSubmissionRequest,
            SelfCustodialWithdrawalSubmissionRequestBuilder> {
  _$SelfCustodialWithdrawalSubmissionRequest? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  SelfCustodialWithdrawalSubmissionRequestBuilder() {
    SelfCustodialWithdrawalSubmissionRequest._defaults(this);
  }

  SelfCustodialWithdrawalSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SelfCustodialWithdrawalSubmissionRequest other) {
    _$v = other as _$SelfCustodialWithdrawalSubmissionRequest;
  }

  @override
  void update(
      void Function(SelfCustodialWithdrawalSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SelfCustodialWithdrawalSubmissionRequest build() => _build();

  _$SelfCustodialWithdrawalSubmissionRequest _build() {
    final _$result = _$v ??
        _$SelfCustodialWithdrawalSubmissionRequest._(
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'SelfCustodialWithdrawalSubmissionRequest', 'txHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
