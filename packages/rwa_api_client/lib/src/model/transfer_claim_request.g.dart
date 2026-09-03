// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_claim_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TransferClaimRequest extends TransferClaimRequest {
  @override
  final String authorizationId;

  factory _$TransferClaimRequest(
          [void Function(TransferClaimRequestBuilder)? updates]) =>
      (TransferClaimRequestBuilder()..update(updates))._build();

  _$TransferClaimRequest._({required this.authorizationId}) : super._();
  @override
  TransferClaimRequest rebuild(
          void Function(TransferClaimRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferClaimRequestBuilder toBuilder() =>
      TransferClaimRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferClaimRequest &&
        authorizationId == other.authorizationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransferClaimRequest')
          ..add('authorizationId', authorizationId))
        .toString();
  }
}

class TransferClaimRequestBuilder
    implements Builder<TransferClaimRequest, TransferClaimRequestBuilder> {
  _$TransferClaimRequest? _$v;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  TransferClaimRequestBuilder() {
    TransferClaimRequest._defaults(this);
  }

  TransferClaimRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorizationId = $v.authorizationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransferClaimRequest other) {
    _$v = other as _$TransferClaimRequest;
  }

  @override
  void update(void Function(TransferClaimRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransferClaimRequest build() => _build();

  _$TransferClaimRequest _build() {
    final _$result = _$v ??
        _$TransferClaimRequest._(
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId, r'TransferClaimRequest', 'authorizationId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
