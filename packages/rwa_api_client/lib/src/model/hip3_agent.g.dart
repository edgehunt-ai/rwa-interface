// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_agent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AgentEnvironmentEnum _$hip3AgentEnvironmentEnum_mainnet =
    const Hip3AgentEnvironmentEnum._('mainnet');
const Hip3AgentEnvironmentEnum
    _$hip3AgentEnvironmentEnum_unknownDefaultOpenApi =
    const Hip3AgentEnvironmentEnum._('unknownDefaultOpenApi');

Hip3AgentEnvironmentEnum _$hip3AgentEnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$hip3AgentEnvironmentEnum_mainnet;
    case 'unknownDefaultOpenApi':
      return _$hip3AgentEnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$hip3AgentEnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AgentEnvironmentEnum> _$hip3AgentEnvironmentEnumValues =
    BuiltSet<Hip3AgentEnvironmentEnum>(const <Hip3AgentEnvironmentEnum>[
  _$hip3AgentEnvironmentEnum_mainnet,
  _$hip3AgentEnvironmentEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3AgentEnvironmentEnum> _$hip3AgentEnvironmentEnumSerializer =
    _$Hip3AgentEnvironmentEnumSerializer();

class _$Hip3AgentEnvironmentEnumSerializer
    implements PrimitiveSerializer<Hip3AgentEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3AgentEnvironmentEnum];
  @override
  final String wireName = 'Hip3AgentEnvironmentEnum';

  @override
  Object serialize(Serializers serializers, Hip3AgentEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AgentEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AgentEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Agent extends Hip3Agent {
  @override
  final String agentId;
  @override
  final String ownerAddress;
  @override
  final String agentAddress;
  @override
  final String agentName;
  @override
  final Hip3AgentEnvironmentEnum environment;
  @override
  final Hip3AgentStatus status;
  @override
  final DateTime validUntil;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$Hip3Agent([void Function(Hip3AgentBuilder)? updates]) =>
      (Hip3AgentBuilder()..update(updates))._build();

  _$Hip3Agent._(
      {required this.agentId,
      required this.ownerAddress,
      required this.agentAddress,
      required this.agentName,
      required this.environment,
      required this.status,
      required this.validUntil,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  Hip3Agent rebuild(void Function(Hip3AgentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3AgentBuilder toBuilder() => Hip3AgentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Agent &&
        agentId == other.agentId &&
        ownerAddress == other.ownerAddress &&
        agentAddress == other.agentAddress &&
        agentName == other.agentName &&
        environment == other.environment &&
        status == other.status &&
        validUntil == other.validUntil &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, ownerAddress.hashCode);
    _$hash = $jc(_$hash, agentAddress.hashCode);
    _$hash = $jc(_$hash, agentName.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Agent')
          ..add('agentId', agentId)
          ..add('ownerAddress', ownerAddress)
          ..add('agentAddress', agentAddress)
          ..add('agentName', agentName)
          ..add('environment', environment)
          ..add('status', status)
          ..add('validUntil', validUntil)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class Hip3AgentBuilder implements Builder<Hip3Agent, Hip3AgentBuilder> {
  _$Hip3Agent? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  String? _ownerAddress;
  String? get ownerAddress => _$this._ownerAddress;
  set ownerAddress(String? ownerAddress) => _$this._ownerAddress = ownerAddress;

  String? _agentAddress;
  String? get agentAddress => _$this._agentAddress;
  set agentAddress(String? agentAddress) => _$this._agentAddress = agentAddress;

  String? _agentName;
  String? get agentName => _$this._agentName;
  set agentName(String? agentName) => _$this._agentName = agentName;

  Hip3AgentEnvironmentEnum? _environment;
  Hip3AgentEnvironmentEnum? get environment => _$this._environment;
  set environment(Hip3AgentEnvironmentEnum? environment) =>
      _$this._environment = environment;

  Hip3AgentStatus? _status;
  Hip3AgentStatus? get status => _$this._status;
  set status(Hip3AgentStatus? status) => _$this._status = status;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  Hip3AgentBuilder() {
    Hip3Agent._defaults(this);
  }

  Hip3AgentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _ownerAddress = $v.ownerAddress;
      _agentAddress = $v.agentAddress;
      _agentName = $v.agentName;
      _environment = $v.environment;
      _status = $v.status;
      _validUntil = $v.validUntil;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Agent other) {
    _$v = other as _$Hip3Agent;
  }

  @override
  void update(void Function(Hip3AgentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Agent build() => _build();

  _$Hip3Agent _build() {
    final _$result = _$v ??
        _$Hip3Agent._(
          agentId: BuiltValueNullFieldError.checkNotNull(
              agentId, r'Hip3Agent', 'agentId'),
          ownerAddress: BuiltValueNullFieldError.checkNotNull(
              ownerAddress, r'Hip3Agent', 'ownerAddress'),
          agentAddress: BuiltValueNullFieldError.checkNotNull(
              agentAddress, r'Hip3Agent', 'agentAddress'),
          agentName: BuiltValueNullFieldError.checkNotNull(
              agentName, r'Hip3Agent', 'agentName'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'Hip3Agent', 'environment'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Hip3Agent', 'status'),
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'Hip3Agent', 'validUntil'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Hip3Agent', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Hip3Agent', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
