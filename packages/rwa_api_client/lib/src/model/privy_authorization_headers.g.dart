// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_authorization_headers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivyAuthorizationHeaders extends PrivyAuthorizationHeaders {
  @override
  final String privyAppId;
  @override
  final String privyIdempotencyKey;
  @override
  final String privyRequestExpiry;

  factory _$PrivyAuthorizationHeaders(
          [void Function(PrivyAuthorizationHeadersBuilder)? updates]) =>
      (PrivyAuthorizationHeadersBuilder()..update(updates))._build();

  _$PrivyAuthorizationHeaders._(
      {required this.privyAppId,
      required this.privyIdempotencyKey,
      required this.privyRequestExpiry})
      : super._();
  @override
  PrivyAuthorizationHeaders rebuild(
          void Function(PrivyAuthorizationHeadersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyAuthorizationHeadersBuilder toBuilder() =>
      PrivyAuthorizationHeadersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyAuthorizationHeaders &&
        privyAppId == other.privyAppId &&
        privyIdempotencyKey == other.privyIdempotencyKey &&
        privyRequestExpiry == other.privyRequestExpiry;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, privyAppId.hashCode);
    _$hash = $jc(_$hash, privyIdempotencyKey.hashCode);
    _$hash = $jc(_$hash, privyRequestExpiry.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyAuthorizationHeaders')
          ..add('privyAppId', privyAppId)
          ..add('privyIdempotencyKey', privyIdempotencyKey)
          ..add('privyRequestExpiry', privyRequestExpiry))
        .toString();
  }
}

class PrivyAuthorizationHeadersBuilder
    implements
        Builder<PrivyAuthorizationHeaders, PrivyAuthorizationHeadersBuilder> {
  _$PrivyAuthorizationHeaders? _$v;

  String? _privyAppId;
  String? get privyAppId => _$this._privyAppId;
  set privyAppId(String? privyAppId) => _$this._privyAppId = privyAppId;

  String? _privyIdempotencyKey;
  String? get privyIdempotencyKey => _$this._privyIdempotencyKey;
  set privyIdempotencyKey(String? privyIdempotencyKey) =>
      _$this._privyIdempotencyKey = privyIdempotencyKey;

  String? _privyRequestExpiry;
  String? get privyRequestExpiry => _$this._privyRequestExpiry;
  set privyRequestExpiry(String? privyRequestExpiry) =>
      _$this._privyRequestExpiry = privyRequestExpiry;

  PrivyAuthorizationHeadersBuilder() {
    PrivyAuthorizationHeaders._defaults(this);
  }

  PrivyAuthorizationHeadersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _privyAppId = $v.privyAppId;
      _privyIdempotencyKey = $v.privyIdempotencyKey;
      _privyRequestExpiry = $v.privyRequestExpiry;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyAuthorizationHeaders other) {
    _$v = other as _$PrivyAuthorizationHeaders;
  }

  @override
  void update(void Function(PrivyAuthorizationHeadersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyAuthorizationHeaders build() => _build();

  _$PrivyAuthorizationHeaders _build() {
    final _$result = _$v ??
        _$PrivyAuthorizationHeaders._(
          privyAppId: BuiltValueNullFieldError.checkNotNull(
              privyAppId, r'PrivyAuthorizationHeaders', 'privyAppId'),
          privyIdempotencyKey: BuiltValueNullFieldError.checkNotNull(
              privyIdempotencyKey,
              r'PrivyAuthorizationHeaders',
              'privyIdempotencyKey'),
          privyRequestExpiry: BuiltValueNullFieldError.checkNotNull(
              privyRequestExpiry,
              r'PrivyAuthorizationHeaders',
              'privyRequestExpiry'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
