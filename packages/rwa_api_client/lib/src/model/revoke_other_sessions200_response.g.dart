// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revoke_other_sessions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RevokeOtherSessions200Response extends RevokeOtherSessions200Response {
  @override
  final int revoked;

  factory _$RevokeOtherSessions200Response(
          [void Function(RevokeOtherSessions200ResponseBuilder)? updates]) =>
      (RevokeOtherSessions200ResponseBuilder()..update(updates))._build();

  _$RevokeOtherSessions200Response._({required this.revoked}) : super._();
  @override
  RevokeOtherSessions200Response rebuild(
          void Function(RevokeOtherSessions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RevokeOtherSessions200ResponseBuilder toBuilder() =>
      RevokeOtherSessions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RevokeOtherSessions200Response && revoked == other.revoked;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, revoked.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RevokeOtherSessions200Response')
          ..add('revoked', revoked))
        .toString();
  }
}

class RevokeOtherSessions200ResponseBuilder
    implements
        Builder<RevokeOtherSessions200Response,
            RevokeOtherSessions200ResponseBuilder> {
  _$RevokeOtherSessions200Response? _$v;

  int? _revoked;
  int? get revoked => _$this._revoked;
  set revoked(int? revoked) => _$this._revoked = revoked;

  RevokeOtherSessions200ResponseBuilder() {
    RevokeOtherSessions200Response._defaults(this);
  }

  RevokeOtherSessions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _revoked = $v.revoked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RevokeOtherSessions200Response other) {
    _$v = other as _$RevokeOtherSessions200Response;
  }

  @override
  void update(void Function(RevokeOtherSessions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RevokeOtherSessions200Response build() => _build();

  _$RevokeOtherSessions200Response _build() {
    final _$result = _$v ??
        _$RevokeOtherSessions200Response._(
          revoked: BuiltValueNullFieldError.checkNotNull(
              revoked, r'RevokeOtherSessions200Response', 'revoked'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
