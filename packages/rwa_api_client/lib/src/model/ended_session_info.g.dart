// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ended_session_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const EndedSessionInfoEndReasonEnum _$endedSessionInfoEndReasonEnum_revoked =
    const EndedSessionInfoEndReasonEnum._('revoked');
const EndedSessionInfoEndReasonEnum _$endedSessionInfoEndReasonEnum_expired =
    const EndedSessionInfoEndReasonEnum._('expired');

EndedSessionInfoEndReasonEnum _$endedSessionInfoEndReasonEnumValueOf(
    String name) {
  switch (name) {
    case 'revoked':
      return _$endedSessionInfoEndReasonEnum_revoked;
    case 'expired':
      return _$endedSessionInfoEndReasonEnum_expired;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<EndedSessionInfoEndReasonEnum>
    _$endedSessionInfoEndReasonEnumValues = BuiltSet<
        EndedSessionInfoEndReasonEnum>(const <EndedSessionInfoEndReasonEnum>[
  _$endedSessionInfoEndReasonEnum_revoked,
  _$endedSessionInfoEndReasonEnum_expired,
]);

Serializer<EndedSessionInfoEndReasonEnum>
    _$endedSessionInfoEndReasonEnumSerializer =
    _$EndedSessionInfoEndReasonEnumSerializer();

class _$EndedSessionInfoEndReasonEnumSerializer
    implements PrimitiveSerializer<EndedSessionInfoEndReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'revoked': 'revoked',
    'expired': 'expired',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'revoked': 'revoked',
    'expired': 'expired',
  };

  @override
  final Iterable<Type> types = const <Type>[EndedSessionInfoEndReasonEnum];
  @override
  final String wireName = 'EndedSessionInfoEndReasonEnum';

  @override
  Object serialize(
          Serializers serializers, EndedSessionInfoEndReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  EndedSessionInfoEndReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EndedSessionInfoEndReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$EndedSessionInfo extends EndedSessionInfo {
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
  final DateTime endedAt;
  @override
  final EndedSessionInfoEndReasonEnum endReason;

  factory _$EndedSessionInfo(
          [void Function(EndedSessionInfoBuilder)? updates]) =>
      (EndedSessionInfoBuilder()..update(updates))._build();

  _$EndedSessionInfo._(
      {required this.id,
      required this.client,
      this.userAgent,
      this.ip,
      this.loginMethod,
      required this.createdAt,
      this.lastSeenAt,
      required this.expiresAt,
      required this.endedAt,
      required this.endReason})
      : super._();
  @override
  EndedSessionInfo rebuild(void Function(EndedSessionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EndedSessionInfoBuilder toBuilder() =>
      EndedSessionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EndedSessionInfo &&
        id == other.id &&
        client == other.client &&
        userAgent == other.userAgent &&
        ip == other.ip &&
        loginMethod == other.loginMethod &&
        createdAt == other.createdAt &&
        lastSeenAt == other.lastSeenAt &&
        expiresAt == other.expiresAt &&
        endedAt == other.endedAt &&
        endReason == other.endReason;
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
    _$hash = $jc(_$hash, endedAt.hashCode);
    _$hash = $jc(_$hash, endReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EndedSessionInfo')
          ..add('id', id)
          ..add('client', client)
          ..add('userAgent', userAgent)
          ..add('ip', ip)
          ..add('loginMethod', loginMethod)
          ..add('createdAt', createdAt)
          ..add('lastSeenAt', lastSeenAt)
          ..add('expiresAt', expiresAt)
          ..add('endedAt', endedAt)
          ..add('endReason', endReason))
        .toString();
  }
}

class EndedSessionInfoBuilder
    implements Builder<EndedSessionInfo, EndedSessionInfoBuilder> {
  _$EndedSessionInfo? _$v;

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

  DateTime? _endedAt;
  DateTime? get endedAt => _$this._endedAt;
  set endedAt(DateTime? endedAt) => _$this._endedAt = endedAt;

  EndedSessionInfoEndReasonEnum? _endReason;
  EndedSessionInfoEndReasonEnum? get endReason => _$this._endReason;
  set endReason(EndedSessionInfoEndReasonEnum? endReason) =>
      _$this._endReason = endReason;

  EndedSessionInfoBuilder() {
    EndedSessionInfo._defaults(this);
  }

  EndedSessionInfoBuilder get _$this {
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
      _endedAt = $v.endedAt;
      _endReason = $v.endReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EndedSessionInfo other) {
    _$v = other as _$EndedSessionInfo;
  }

  @override
  void update(void Function(EndedSessionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EndedSessionInfo build() => _build();

  _$EndedSessionInfo _build() {
    final _$result = _$v ??
        _$EndedSessionInfo._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'EndedSessionInfo', 'id'),
          client: BuiltValueNullFieldError.checkNotNull(
              client, r'EndedSessionInfo', 'client'),
          userAgent: userAgent,
          ip: ip,
          loginMethod: loginMethod,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'EndedSessionInfo', 'createdAt'),
          lastSeenAt: lastSeenAt,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'EndedSessionInfo', 'expiresAt'),
          endedAt: BuiltValueNullFieldError.checkNotNull(
              endedAt, r'EndedSessionInfo', 'endedAt'),
          endReason: BuiltValueNullFieldError.checkNotNull(
              endReason, r'EndedSessionInfo', 'endReason'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
