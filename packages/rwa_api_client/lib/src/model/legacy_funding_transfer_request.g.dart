// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_funding_transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LegacyFundingTransferRequest extends LegacyFundingTransferRequest {
  @override
  final String planId;
  @override
  final String authorizationId;

  factory _$LegacyFundingTransferRequest(
          [void Function(LegacyFundingTransferRequestBuilder)? updates]) =>
      (LegacyFundingTransferRequestBuilder()..update(updates))._build();

  _$LegacyFundingTransferRequest._(
      {required this.planId, required this.authorizationId})
      : super._();
  @override
  LegacyFundingTransferRequest rebuild(
          void Function(LegacyFundingTransferRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyFundingTransferRequestBuilder toBuilder() =>
      LegacyFundingTransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyFundingTransferRequest &&
        planId == other.planId &&
        authorizationId == other.authorizationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LegacyFundingTransferRequest')
          ..add('planId', planId)
          ..add('authorizationId', authorizationId))
        .toString();
  }
}

class LegacyFundingTransferRequestBuilder
    implements
        Builder<LegacyFundingTransferRequest,
            LegacyFundingTransferRequestBuilder> {
  _$LegacyFundingTransferRequest? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  LegacyFundingTransferRequestBuilder() {
    LegacyFundingTransferRequest._defaults(this);
  }

  LegacyFundingTransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _authorizationId = $v.authorizationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LegacyFundingTransferRequest other) {
    _$v = other as _$LegacyFundingTransferRequest;
  }

  @override
  void update(void Function(LegacyFundingTransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyFundingTransferRequest build() => _build();

  _$LegacyFundingTransferRequest _build() {
    final _$result = _$v ??
        _$LegacyFundingTransferRequest._(
          planId: BuiltValueNullFieldError.checkNotNull(
              planId, r'LegacyFundingTransferRequest', 'planId'),
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId,
              r'LegacyFundingTransferRequest',
              'authorizationId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
