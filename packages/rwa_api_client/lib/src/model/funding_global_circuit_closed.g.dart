// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_global_circuit_closed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingGlobalCircuitClosedScopeEnum
    _$fundingGlobalCircuitClosedScopeEnum_global =
    const FundingGlobalCircuitClosedScopeEnum._('global');
const FundingGlobalCircuitClosedScopeEnum
    _$fundingGlobalCircuitClosedScopeEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitClosedScopeEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitClosedScopeEnum
    _$fundingGlobalCircuitClosedScopeEnumValueOf(String name) {
  switch (name) {
    case 'global':
      return _$fundingGlobalCircuitClosedScopeEnum_global;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitClosedScopeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitClosedScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitClosedScopeEnum>
    _$fundingGlobalCircuitClosedScopeEnumValues = BuiltSet<
        FundingGlobalCircuitClosedScopeEnum>(const <FundingGlobalCircuitClosedScopeEnum>[
  _$fundingGlobalCircuitClosedScopeEnum_global,
  _$fundingGlobalCircuitClosedScopeEnum_unknownDefaultOpenApi,
]);

const FundingGlobalCircuitClosedStateEnum
    _$fundingGlobalCircuitClosedStateEnum_closed =
    const FundingGlobalCircuitClosedStateEnum._('closed');
const FundingGlobalCircuitClosedStateEnum
    _$fundingGlobalCircuitClosedStateEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitClosedStateEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitClosedStateEnum
    _$fundingGlobalCircuitClosedStateEnumValueOf(String name) {
  switch (name) {
    case 'closed':
      return _$fundingGlobalCircuitClosedStateEnum_closed;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitClosedStateEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitClosedStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitClosedStateEnum>
    _$fundingGlobalCircuitClosedStateEnumValues = BuiltSet<
        FundingGlobalCircuitClosedStateEnum>(const <FundingGlobalCircuitClosedStateEnum>[
  _$fundingGlobalCircuitClosedStateEnum_closed,
  _$fundingGlobalCircuitClosedStateEnum_unknownDefaultOpenApi,
]);

Serializer<FundingGlobalCircuitClosedScopeEnum>
    _$fundingGlobalCircuitClosedScopeEnumSerializer =
    _$FundingGlobalCircuitClosedScopeEnumSerializer();
Serializer<FundingGlobalCircuitClosedStateEnum>
    _$fundingGlobalCircuitClosedStateEnumSerializer =
    _$FundingGlobalCircuitClosedStateEnumSerializer();

class _$FundingGlobalCircuitClosedScopeEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitClosedScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'global': 'global',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'global': 'global',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingGlobalCircuitClosedScopeEnum
  ];
  @override
  final String wireName = 'FundingGlobalCircuitClosedScopeEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitClosedScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitClosedScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitClosedScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuitClosedStateEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitClosedStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'closed': 'closed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'closed': 'closed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingGlobalCircuitClosedStateEnum
  ];
  @override
  final String wireName = 'FundingGlobalCircuitClosedStateEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitClosedStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitClosedStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitClosedStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuitClosed extends FundingGlobalCircuitClosed {
  @override
  final FundingGlobalCircuitClosedScopeEnum scope;
  @override
  final FundingGlobalCircuitClosedStateEnum state;
  @override
  final int generation;

  factory _$FundingGlobalCircuitClosed(
          [void Function(FundingGlobalCircuitClosedBuilder)? updates]) =>
      (FundingGlobalCircuitClosedBuilder()..update(updates))._build();

  _$FundingGlobalCircuitClosed._(
      {required this.scope, required this.state, required this.generation})
      : super._();
  @override
  FundingGlobalCircuitClosed rebuild(
          void Function(FundingGlobalCircuitClosedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingGlobalCircuitClosedBuilder toBuilder() =>
      FundingGlobalCircuitClosedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingGlobalCircuitClosed &&
        scope == other.scope &&
        state == other.state &&
        generation == other.generation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingGlobalCircuitClosed')
          ..add('scope', scope)
          ..add('state', state)
          ..add('generation', generation))
        .toString();
  }
}

class FundingGlobalCircuitClosedBuilder
    implements
        Builder<FundingGlobalCircuitClosed, FundingGlobalCircuitClosedBuilder> {
  _$FundingGlobalCircuitClosed? _$v;

  FundingGlobalCircuitClosedScopeEnum? _scope;
  FundingGlobalCircuitClosedScopeEnum? get scope => _$this._scope;
  set scope(FundingGlobalCircuitClosedScopeEnum? scope) =>
      _$this._scope = scope;

  FundingGlobalCircuitClosedStateEnum? _state;
  FundingGlobalCircuitClosedStateEnum? get state => _$this._state;
  set state(FundingGlobalCircuitClosedStateEnum? state) =>
      _$this._state = state;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  FundingGlobalCircuitClosedBuilder() {
    FundingGlobalCircuitClosed._defaults(this);
  }

  FundingGlobalCircuitClosedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _state = $v.state;
      _generation = $v.generation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingGlobalCircuitClosed other) {
    _$v = other as _$FundingGlobalCircuitClosed;
  }

  @override
  void update(void Function(FundingGlobalCircuitClosedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingGlobalCircuitClosed build() => _build();

  _$FundingGlobalCircuitClosed _build() {
    final _$result = _$v ??
        _$FundingGlobalCircuitClosed._(
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'FundingGlobalCircuitClosed', 'scope'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'FundingGlobalCircuitClosed', 'state'),
          generation: BuiltValueNullFieldError.checkNotNull(
              generation, r'FundingGlobalCircuitClosed', 'generation'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
