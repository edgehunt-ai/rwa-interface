// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_paid_wallet_action_execution_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserPaidWalletActionExecutionSubmissionRequest
    extends UserPaidWalletActionExecutionSubmissionRequest {
  @override
  final String txHash;

  factory _$UserPaidWalletActionExecutionSubmissionRequest(
          [void Function(UserPaidWalletActionExecutionSubmissionRequestBuilder)?
              updates]) =>
      (UserPaidWalletActionExecutionSubmissionRequestBuilder()..update(updates))
          ._build();

  _$UserPaidWalletActionExecutionSubmissionRequest._({required this.txHash})
      : super._();
  @override
  UserPaidWalletActionExecutionSubmissionRequest rebuild(
          void Function(UserPaidWalletActionExecutionSubmissionRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPaidWalletActionExecutionSubmissionRequestBuilder toBuilder() =>
      UserPaidWalletActionExecutionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPaidWalletActionExecutionSubmissionRequest &&
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
            r'UserPaidWalletActionExecutionSubmissionRequest')
          ..add('txHash', txHash))
        .toString();
  }
}

class UserPaidWalletActionExecutionSubmissionRequestBuilder
    implements
        Builder<UserPaidWalletActionExecutionSubmissionRequest,
            UserPaidWalletActionExecutionSubmissionRequestBuilder> {
  _$UserPaidWalletActionExecutionSubmissionRequest? _$v;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  UserPaidWalletActionExecutionSubmissionRequestBuilder() {
    UserPaidWalletActionExecutionSubmissionRequest._defaults(this);
  }

  UserPaidWalletActionExecutionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _txHash = $v.txHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPaidWalletActionExecutionSubmissionRequest other) {
    _$v = other as _$UserPaidWalletActionExecutionSubmissionRequest;
  }

  @override
  void update(
      void Function(UserPaidWalletActionExecutionSubmissionRequestBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPaidWalletActionExecutionSubmissionRequest build() => _build();

  _$UserPaidWalletActionExecutionSubmissionRequest _build() {
    final _$result = _$v ??
        _$UserPaidWalletActionExecutionSubmissionRequest._(
          txHash: BuiltValueNullFieldError.checkNotNull(txHash,
              r'UserPaidWalletActionExecutionSubmissionRequest', 'txHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
