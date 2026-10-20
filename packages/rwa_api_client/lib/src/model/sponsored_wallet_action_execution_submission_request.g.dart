// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsored_wallet_action_execution_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SponsoredWalletActionExecutionSubmissionRequest
    extends SponsoredWalletActionExecutionSubmissionRequest {
  @override
  final String privyAuthorizationSignature;

  factory _$SponsoredWalletActionExecutionSubmissionRequest(
          [void Function(
                  SponsoredWalletActionExecutionSubmissionRequestBuilder)?
              updates]) =>
      (SponsoredWalletActionExecutionSubmissionRequestBuilder()
            ..update(updates))
          ._build();

  _$SponsoredWalletActionExecutionSubmissionRequest._(
      {required this.privyAuthorizationSignature})
      : super._();
  @override
  SponsoredWalletActionExecutionSubmissionRequest rebuild(
          void Function(SponsoredWalletActionExecutionSubmissionRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SponsoredWalletActionExecutionSubmissionRequestBuilder toBuilder() =>
      SponsoredWalletActionExecutionSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SponsoredWalletActionExecutionSubmissionRequest &&
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
            r'SponsoredWalletActionExecutionSubmissionRequest')
          ..add('privyAuthorizationSignature', privyAuthorizationSignature))
        .toString();
  }
}

class SponsoredWalletActionExecutionSubmissionRequestBuilder
    implements
        Builder<SponsoredWalletActionExecutionSubmissionRequest,
            SponsoredWalletActionExecutionSubmissionRequestBuilder> {
  _$SponsoredWalletActionExecutionSubmissionRequest? _$v;

  String? _privyAuthorizationSignature;
  String? get privyAuthorizationSignature =>
      _$this._privyAuthorizationSignature;
  set privyAuthorizationSignature(String? privyAuthorizationSignature) =>
      _$this._privyAuthorizationSignature = privyAuthorizationSignature;

  SponsoredWalletActionExecutionSubmissionRequestBuilder() {
    SponsoredWalletActionExecutionSubmissionRequest._defaults(this);
  }

  SponsoredWalletActionExecutionSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _privyAuthorizationSignature = $v.privyAuthorizationSignature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SponsoredWalletActionExecutionSubmissionRequest other) {
    _$v = other as _$SponsoredWalletActionExecutionSubmissionRequest;
  }

  @override
  void update(
      void Function(SponsoredWalletActionExecutionSubmissionRequestBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  SponsoredWalletActionExecutionSubmissionRequest build() => _build();

  _$SponsoredWalletActionExecutionSubmissionRequest _build() {
    final _$result = _$v ??
        _$SponsoredWalletActionExecutionSubmissionRequest._(
          privyAuthorizationSignature: BuiltValueNullFieldError.checkNotNull(
              privyAuthorizationSignature,
              r'SponsoredWalletActionExecutionSubmissionRequest',
              'privyAuthorizationSignature'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
