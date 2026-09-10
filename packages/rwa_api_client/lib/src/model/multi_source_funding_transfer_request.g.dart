// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_source_funding_transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MultiSourceFundingTransferRequest
    extends MultiSourceFundingTransferRequest {
  @override
  final String planId;
  @override
  final String legId;
  @override
  final String authorizationId;

  factory _$MultiSourceFundingTransferRequest(
          [void Function(MultiSourceFundingTransferRequestBuilder)? updates]) =>
      (MultiSourceFundingTransferRequestBuilder()..update(updates))._build();

  _$MultiSourceFundingTransferRequest._(
      {required this.planId,
      required this.legId,
      required this.authorizationId})
      : super._();
  @override
  MultiSourceFundingTransferRequest rebuild(
          void Function(MultiSourceFundingTransferRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MultiSourceFundingTransferRequestBuilder toBuilder() =>
      MultiSourceFundingTransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MultiSourceFundingTransferRequest &&
        planId == other.planId &&
        legId == other.legId &&
        authorizationId == other.authorizationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, legId.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MultiSourceFundingTransferRequest')
          ..add('planId', planId)
          ..add('legId', legId)
          ..add('authorizationId', authorizationId))
        .toString();
  }
}

class MultiSourceFundingTransferRequestBuilder
    implements
        Builder<MultiSourceFundingTransferRequest,
            MultiSourceFundingTransferRequestBuilder> {
  _$MultiSourceFundingTransferRequest? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _legId;
  String? get legId => _$this._legId;
  set legId(String? legId) => _$this._legId = legId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  MultiSourceFundingTransferRequestBuilder() {
    MultiSourceFundingTransferRequest._defaults(this);
  }

  MultiSourceFundingTransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _legId = $v.legId;
      _authorizationId = $v.authorizationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MultiSourceFundingTransferRequest other) {
    _$v = other as _$MultiSourceFundingTransferRequest;
  }

  @override
  void update(
      void Function(MultiSourceFundingTransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MultiSourceFundingTransferRequest build() => _build();

  _$MultiSourceFundingTransferRequest _build() {
    final _$result = _$v ??
        _$MultiSourceFundingTransferRequest._(
          planId: BuiltValueNullFieldError.checkNotNull(
              planId, r'MultiSourceFundingTransferRequest', 'planId'),
          legId: BuiltValueNullFieldError.checkNotNull(
              legId, r'MultiSourceFundingTransferRequest', 'legId'),
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId,
              r'MultiSourceFundingTransferRequest',
              'authorizationId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
