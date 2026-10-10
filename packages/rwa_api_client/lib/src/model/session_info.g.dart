// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionInfo extends SessionInfo {
  @override
  final String id;
  @override
  final String client;
  @override
  final String? userAgent;
  @override
  final String? ip;
  @override
  final String? loginMethod;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime expiresAt;
  @override
  final bool current;

  factory _$SessionInfo([void Function(SessionInfoBuilder)? updates]) =>
      (SessionInfoBuilder()..update(updates))._build();

  _$SessionInfo._(
      {required this.id,
      required this.client,
      this.userAgent,
      this.ip,
      this.loginMethod,
      required this.createdAt,
      this.lastSeenAt,
      required this.expiresAt,
      required this.current})
      : super._();
  @override
  SessionInfo rebuild(void Function(SessionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionInfoBuilder toBuilder() => SessionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionInfo &&
        id == other.id &&
        client == other.client &&
        userAgent == other.userAgent &&
        ip == other.ip &&
        loginMethod == other.loginMethod &&
        createdAt == other.createdAt &&
        lastSeenAt == other.lastSeenAt &&
        expiresAt == other.expiresAt &&
        current == other.current;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, client.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, ip.hashCode);
    _$hash = $jc(_$hash, loginMethod.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, current.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionInfo')
          ..add('id', id)
          ..add('client', client)
          ..add('userAgent', userAgent)
          ..add('ip', ip)
          ..add('loginMethod', loginMethod)
          ..add('createdAt', createdAt)
          ..add('lastSeenAt', lastSeenAt)
          ..add('expiresAt', expiresAt)
          ..add('current', current))
        .toString();
  }
}

class SessionInfoBuilder implements Builder<SessionInfo, SessionInfoBuilder> {
  _$SessionInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _client;
  String? get client => _$this._client;
  set client(String? client) => _$this._client = client;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  String? _ip;
  String? get ip => _$this._ip;
  set ip(String? ip) => _$this._ip = ip;

  String? _loginMethod;
  String? get loginMethod => _$this._loginMethod;
  set loginMethod(String? loginMethod) => _$this._loginMethod = loginMethod;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  bool? _current;
  bool? get current => _$this._current;
  set current(bool? current) => _$this._current = current;

  SessionInfoBuilder() {
    SessionInfo._defaults(this);
  }

  SessionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _client = $v.client;
      _userAgent = $v.userAgent;
      _ip = $v.ip;
      _loginMethod = $v.loginMethod;
      _createdAt = $v.createdAt;
      _lastSeenAt = $v.lastSeenAt;
      _expiresAt = $v.expiresAt;
      _current = $v.current;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionInfo other) {
    _$v = other as _$SessionInfo;
  }

  @override
  void update(void Function(SessionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionInfo build() => _build();

  _$SessionInfo _build() {
    final _$result = _$v ??
        _$SessionInfo._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'SessionInfo', 'id'),
          client: BuiltValueNullFieldError.checkNotNull(
              client, r'SessionInfo', 'client'),
          userAgent: userAgent,
          ip: ip,
          loginMethod: loginMethod,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'SessionInfo', 'createdAt'),
          lastSeenAt: lastSeenAt,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'SessionInfo', 'expiresAt'),
          current: BuiltValueNullFieldError.checkNotNull(
              current, r'SessionInfo', 'current'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
