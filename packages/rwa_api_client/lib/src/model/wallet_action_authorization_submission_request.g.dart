// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action_authorization_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletActionAuthorizationSubmissionRequest
    extends WalletActionAuthorizationSubmissionRequest {
  @override
  final String privyAuthorizationSignature;

  factory _$WalletActionAuthorizationSubmissionRequest(
          [void Function(WalletActionAuthorizationSubmissionRequestBuilder)?
              updates]) =>
      (WalletActionAuthorizationSubmissionRequestBuilder()..update(updates))
          ._build();

  _$WalletActionAuthorizationSubmissionRequest._(
      {required this.privyAuthorizationSignature})
      : super._();
  @override
  WalletActionAuthorizationSubmissionRequest rebuild(
          void Function(WalletActionAuthorizationSubmissionRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletActionAuthorizationSubmissionRequestBuilder toBuilder() =>
      WalletActionAuthorizationSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletActionAuthorizationSubmissionRequest &&
        privyAuthorizationSignature == other.privyAuthorizationSignature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, privyAuthorizationSignature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WalletActionAuthorizationSubmissionRequest')
          ..add('privyAuthorizationSignature', privyAuthorizationSignature))
        .toString();
  }
}

class WalletActionAuthorizationSubmissionRequestBuilder
    implements
        Builder<WalletActionAuthorizationSubmissionRequest,
            WalletActionAuthorizationSubmissionRequestBuilder> {
  _$WalletActionAuthorizationSubmissionRequest? _$v;

  String? _privyAuthorizationSignature;
  String? get privyAuthorizationSignature =>
      _$this._privyAuthorizationSignature;
  set privyAuthorizationSignature(String? privyAuthorizationSignature) =>
      _$this._privyAuthorizationSignature = privyAuthorizationSignature;

  WalletActionAuthorizationSubmissionRequestBuilder() {
    WalletActionAuthorizationSubmissionRequest._defaults(this);
  }

  WalletActionAuthorizationSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _privyAuthorizationSignature = $v.privyAuthorizationSignature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletActionAuthorizationSubmissionRequest other) {
    _$v = other as _$WalletActionAuthorizationSubmissionRequest;
  }

  @override
  void update(
      void Function(WalletActionAuthorizationSubmissionRequestBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletActionAuthorizationSubmissionRequest build() => _build();

  _$WalletActionAuthorizationSubmissionRequest _build() {
    final _$result = _$v ??
        _$WalletActionAuthorizationSubmissionRequest._(
          privyAuthorizationSignature: BuiltValueNullFieldError.checkNotNull(
              privyAuthorizationSignature,
              r'WalletActionAuthorizationSubmissionRequest',
              'privyAuthorizationSignature'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
