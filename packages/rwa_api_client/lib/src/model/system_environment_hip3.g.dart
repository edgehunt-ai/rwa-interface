// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_environment_hip3.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SystemEnvironmentHip3EnvironmentEnum
    _$systemEnvironmentHip3EnvironmentEnum_testnet =
    const SystemEnvironmentHip3EnvironmentEnum._('testnet');
const SystemEnvironmentHip3EnvironmentEnum
    _$systemEnvironmentHip3EnvironmentEnum_mainnet =
    const SystemEnvironmentHip3EnvironmentEnum._('mainnet');
const SystemEnvironmentHip3EnvironmentEnum
    _$systemEnvironmentHip3EnvironmentEnum_unknownDefaultOpenApi =
    const SystemEnvironmentHip3EnvironmentEnum._('unknownDefaultOpenApi');

SystemEnvironmentHip3EnvironmentEnum
    _$systemEnvironmentHip3EnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'testnet':
      return _$systemEnvironmentHip3EnvironmentEnum_testnet;
    case 'mainnet':
      return _$systemEnvironmentHip3EnvironmentEnum_mainnet;
    case 'unknownDefaultOpenApi':
      return _$systemEnvironmentHip3EnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$systemEnvironmentHip3EnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SystemEnvironmentHip3EnvironmentEnum>
    _$systemEnvironmentHip3EnvironmentEnumValues = BuiltSet<
        SystemEnvironmentHip3EnvironmentEnum>(const <SystemEnvironmentHip3EnvironmentEnum>[
  _$systemEnvironmentHip3EnvironmentEnum_testnet,
  _$systemEnvironmentHip3EnvironmentEnum_mainnet,
  _$systemEnvironmentHip3EnvironmentEnum_unknownDefaultOpenApi,
]);

Serializer<SystemEnvironmentHip3EnvironmentEnum>
    _$systemEnvironmentHip3EnvironmentEnumSerializer =
    _$SystemEnvironmentHip3EnvironmentEnumSerializer();

class _$SystemEnvironmentHip3EnvironmentEnumSerializer
    implements PrimitiveSerializer<SystemEnvironmentHip3EnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'testnet': 'testnet',
    'mainnet': 'mainnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'testnet': 'testnet',
    'mainnet': 'mainnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    SystemEnvironmentHip3EnvironmentEnum
  ];
  @override
  final String wireName = 'SystemEnvironmentHip3EnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, SystemEnvironmentHip3EnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SystemEnvironmentHip3EnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SystemEnvironmentHip3EnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$SystemEnvironmentHip3 extends SystemEnvironmentHip3 {
  @override
  final SystemEnvironmentHip3EnvironmentEnum environment;

  factory _$SystemEnvironmentHip3(
          [void Function(SystemEnvironmentHip3Builder)? updates]) =>
      (SystemEnvironmentHip3Builder()..update(updates))._build();

  _$SystemEnvironmentHip3._({required this.environment}) : super._();
  @override
  SystemEnvironmentHip3 rebuild(
          void Function(SystemEnvironmentHip3Builder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SystemEnvironmentHip3Builder toBuilder() =>
      SystemEnvironmentHip3Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SystemEnvironmentHip3 && environment == other.environment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SystemEnvironmentHip3')
          ..add('environment', environment))
        .toString();
  }
}

class SystemEnvironmentHip3Builder
    implements Builder<SystemEnvironmentHip3, SystemEnvironmentHip3Builder> {
  _$SystemEnvironmentHip3? _$v;

  SystemEnvironmentHip3EnvironmentEnum? _environment;
  SystemEnvironmentHip3EnvironmentEnum? get environment => _$this._environment;
  set environment(SystemEnvironmentHip3EnvironmentEnum? environment) =>
      _$this._environment = environment;

  SystemEnvironmentHip3Builder() {
    SystemEnvironmentHip3._defaults(this);
  }

  SystemEnvironmentHip3Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _environment = $v.environment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SystemEnvironmentHip3 other) {
    _$v = other as _$SystemEnvironmentHip3;
  }

  @override
  void update(void Function(SystemEnvironmentHip3Builder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SystemEnvironmentHip3 build() => _build();

  _$SystemEnvironmentHip3 _build() {
    final _$result = _$v ??
        _$SystemEnvironmentHip3._(
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'SystemEnvironmentHip3', 'environment'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
