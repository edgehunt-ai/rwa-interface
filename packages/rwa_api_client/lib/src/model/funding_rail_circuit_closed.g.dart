// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_rail_circuit_closed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRailCircuitClosedScopeEnum
    _$fundingRailCircuitClosedScopeEnum_hip3 =
    const FundingRailCircuitClosedScopeEnum._('hip3');
const FundingRailCircuitClosedScopeEnum
    _$fundingRailCircuitClosedScopeEnum_bstocks =
    const FundingRailCircuitClosedScopeEnum._('bstocks');
const FundingRailCircuitClosedScopeEnum
    _$fundingRailCircuitClosedScopeEnum_unknownDefaultOpenApi =
    const FundingRailCircuitClosedScopeEnum._('unknownDefaultOpenApi');

FundingRailCircuitClosedScopeEnum _$fundingRailCircuitClosedScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3':
      return _$fundingRailCircuitClosedScopeEnum_hip3;
    case 'bstocks':
      return _$fundingRailCircuitClosedScopeEnum_bstocks;
    case 'unknownDefaultOpenApi':
      return _$fundingRailCircuitClosedScopeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailCircuitClosedScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailCircuitClosedScopeEnum>
    _$fundingRailCircuitClosedScopeEnumValues = BuiltSet<
        FundingRailCircuitClosedScopeEnum>(const <FundingRailCircuitClosedScopeEnum>[
  _$fundingRailCircuitClosedScopeEnum_hip3,
  _$fundingRailCircuitClosedScopeEnum_bstocks,
  _$fundingRailCircuitClosedScopeEnum_unknownDefaultOpenApi,
]);

const FundingRailCircuitClosedStateEnum
    _$fundingRailCircuitClosedStateEnum_closed =
    const FundingRailCircuitClosedStateEnum._('closed');
const FundingRailCircuitClosedStateEnum
    _$fundingRailCircuitClosedStateEnum_unknownDefaultOpenApi =
    const FundingRailCircuitClosedStateEnum._('unknownDefaultOpenApi');

FundingRailCircuitClosedStateEnum _$fundingRailCircuitClosedStateEnumValueOf(
    String name) {
  switch (name) {
    case 'closed':
      return _$fundingRailCircuitClosedStateEnum_closed;
    case 'unknownDefaultOpenApi':
      return _$fundingRailCircuitClosedStateEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailCircuitClosedStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailCircuitClosedStateEnum>
    _$fundingRailCircuitClosedStateEnumValues = BuiltSet<
        FundingRailCircuitClosedStateEnum>(const <FundingRailCircuitClosedStateEnum>[
  _$fundingRailCircuitClosedStateEnum_closed,
  _$fundingRailCircuitClosedStateEnum_unknownDefaultOpenApi,
]);

Serializer<FundingRailCircuitClosedScopeEnum>
    _$fundingRailCircuitClosedScopeEnumSerializer =
    _$FundingRailCircuitClosedScopeEnumSerializer();
Serializer<FundingRailCircuitClosedStateEnum>
    _$fundingRailCircuitClosedStateEnumSerializer =
    _$FundingRailCircuitClosedStateEnumSerializer();

class _$FundingRailCircuitClosedScopeEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitClosedScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3': 'hip3',
    'bstocks': 'bstocks',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3': 'hip3',
    'bstocks': 'bstocks',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailCircuitClosedScopeEnum];
  @override
  final String wireName = 'FundingRailCircuitClosedScopeEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRailCircuitClosedScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitClosedScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitClosedScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuitClosedStateEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitClosedStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'closed': 'closed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'closed': 'closed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailCircuitClosedStateEnum];
  @override
  final String wireName = 'FundingRailCircuitClosedStateEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRailCircuitClosedStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitClosedStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitClosedStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuitClosed extends FundingRailCircuitClosed {
  @override
  final FundingRailCircuitClosedScopeEnum scope;
  @override
  final FundingRailCircuitClosedStateEnum state;
  @override
  final int generation;

  factory _$FundingRailCircuitClosed(
          [void Function(FundingRailCircuitClosedBuilder)? updates]) =>
      (FundingRailCircuitClosedBuilder()..update(updates))._build();

  _$FundingRailCircuitClosed._(
      {required this.scope, required this.state, required this.generation})
      : super._();
  @override
  FundingRailCircuitClosed rebuild(
          void Function(FundingRailCircuitClosedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRailCircuitClosedBuilder toBuilder() =>
      FundingRailCircuitClosedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRailCircuitClosed &&
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
    return (newBuiltValueToStringHelper(r'FundingRailCircuitClosed')
          ..add('scope', scope)
          ..add('state', state)
          ..add('generation', generation))
        .toString();
  }
}

class FundingRailCircuitClosedBuilder
    implements
        Builder<FundingRailCircuitClosed, FundingRailCircuitClosedBuilder> {
  _$FundingRailCircuitClosed? _$v;

  FundingRailCircuitClosedScopeEnum? _scope;
  FundingRailCircuitClosedScopeEnum? get scope => _$this._scope;
  set scope(FundingRailCircuitClosedScopeEnum? scope) => _$this._scope = scope;

  FundingRailCircuitClosedStateEnum? _state;
  FundingRailCircuitClosedStateEnum? get state => _$this._state;
  set state(FundingRailCircuitClosedStateEnum? state) => _$this._state = state;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  FundingRailCircuitClosedBuilder() {
    FundingRailCircuitClosed._defaults(this);
  }

  FundingRailCircuitClosedBuilder get _$this {
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
  void replace(FundingRailCircuitClosed other) {
    _$v = other as _$FundingRailCircuitClosed;
  }

  @override
  void update(void Function(FundingRailCircuitClosedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRailCircuitClosed build() => _build();

  _$FundingRailCircuitClosed _build() {
    final _$result = _$v ??
        _$FundingRailCircuitClosed._(
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'FundingRailCircuitClosed', 'scope'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'FundingRailCircuitClosed', 'state'),
          generation: BuiltValueNullFieldError.checkNotNull(
              generation, r'FundingRailCircuitClosed', 'generation'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
