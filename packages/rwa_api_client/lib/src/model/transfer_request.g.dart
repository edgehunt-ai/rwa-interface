// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferRequest extends TransferRequest {
  @override
  final String planId;
  @override
  final String authorizationId;

  factory _$TransferRequest([void Function(TransferRequestBuilder)? updates]) =>
      (TransferRequestBuilder()..update(updates))._build();

  _$TransferRequest._({required this.planId, required this.authorizationId})
      : super._();
  @override
  TransferRequest rebuild(void Function(TransferRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferRequestBuilder toBuilder() => TransferRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferRequest &&
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
    return (newBuiltValueToStringHelper(r'TransferRequest')
          ..add('planId', planId)
          ..add('authorizationId', authorizationId))
        .toString();
  }
}

class TransferRequestBuilder
    implements Builder<TransferRequest, TransferRequestBuilder> {
  _$TransferRequest? _$v;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  TransferRequestBuilder() {
    TransferRequest._defaults(this);
  }

  TransferRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _authorizationId = $v.authorizationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferRequest other) {
    _$v = other as _$TransferRequest;
  }

  @override
  void update(void Function(TransferRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferRequest build() => _build();

  _$TransferRequest _build() {
    final _$result = _$v ??
        _$TransferRequest._(
          planId: BuiltValueNullFieldError.checkNotNull(
              planId, r'TransferRequest', 'planId'),
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId, r'TransferRequest', 'authorizationId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
