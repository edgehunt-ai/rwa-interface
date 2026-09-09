// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_rail_circuit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRailCircuitScopeEnum _$fundingRailCircuitScopeEnum_hip3 =
    const FundingRailCircuitScopeEnum._('hip3');
const FundingRailCircuitScopeEnum _$fundingRailCircuitScopeEnum_bstocks =
    const FundingRailCircuitScopeEnum._('bstocks');
const FundingRailCircuitScopeEnum
    _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi =
    const FundingRailCircuitScopeEnum._('unknownDefaultOpenApi');

FundingRailCircuitScopeEnum _$fundingRailCircuitScopeEnumValueOf(String name) {
  switch (name) {
    case 'hip3':
      return _$fundingRailCircuitScopeEnum_hip3;
    case 'bstocks':
      return _$fundingRailCircuitScopeEnum_bstocks;
    case 'unknownDefaultOpenApi':
      return _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailCircuitScopeEnum>
    _$fundingRailCircuitScopeEnumValues =
    BuiltSet<FundingRailCircuitScopeEnum>(const <FundingRailCircuitScopeEnum>[
  _$fundingRailCircuitScopeEnum_hip3,
  _$fundingRailCircuitScopeEnum_bstocks,
  _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi,
]);

const FundingRailCircuitStateEnum _$fundingRailCircuitStateEnum_open =
    const FundingRailCircuitStateEnum._('open');
const FundingRailCircuitStateEnum
    _$fundingRailCircuitStateEnum_unknownDefaultOpenApi =
    const FundingRailCircuitStateEnum._('unknownDefaultOpenApi');

FundingRailCircuitStateEnum _$fundingRailCircuitStateEnumValueOf(String name) {
  switch (name) {
    case 'open':
      return _$fundingRailCircuitStateEnum_open;
    case 'unknownDefaultOpenApi':
      return _$fundingRailCircuitStateEnum_unknownDefaultOpenApi;
    default:
      return _$fundingRailCircuitStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingRailCircuitStateEnum>
    _$fundingRailCircuitStateEnumValues =
    BuiltSet<FundingRailCircuitStateEnum>(const <FundingRailCircuitStateEnum>[
  _$fundingRailCircuitStateEnum_open,
  _$fundingRailCircuitStateEnum_unknownDefaultOpenApi,
]);

Serializer<FundingRailCircuitScopeEnum>
    _$fundingRailCircuitScopeEnumSerializer =
    _$FundingRailCircuitScopeEnumSerializer();
Serializer<FundingRailCircuitStateEnum>
    _$fundingRailCircuitStateEnumSerializer =
    _$FundingRailCircuitStateEnumSerializer();

class _$FundingRailCircuitScopeEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitScopeEnum> {
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
  final Iterable<Type> types = const <Type>[FundingRailCircuitScopeEnum];
  @override
  final String wireName = 'FundingRailCircuitScopeEnum';

  @override
  Object serialize(Serializers serializers, FundingRailCircuitScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuitStateEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'open': 'open',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'open': 'open',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailCircuitStateEnum];
  @override
  final String wireName = 'FundingRailCircuitStateEnum';

  @override
  Object serialize(Serializers serializers, FundingRailCircuitStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuit extends FundingRailCircuit {
  @override
  final OneOf oneOf;

  factory _$FundingRailCircuit(
          [void Function(FundingRailCircuitBuilder)? updates]) =>
      (FundingRailCircuitBuilder()..update(updates))._build();

  _$FundingRailCircuit._({required this.oneOf}) : super._();
  @override
  FundingRailCircuit rebuild(
          void Function(FundingRailCircuitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRailCircuitBuilder toBuilder() =>
      FundingRailCircuitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRailCircuit && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRailCircuit')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingRailCircuitBuilder
    implements Builder<FundingRailCircuit, FundingRailCircuitBuilder> {
  _$FundingRailCircuit? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingRailCircuitBuilder() {
    FundingRailCircuit._defaults(this);
  }

  FundingRailCircuitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRailCircuit other) {
    _$v = other as _$FundingRailCircuit;
  }

  @override
  void update(void Function(FundingRailCircuitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRailCircuit build() => _build();

  _$FundingRailCircuit _build() {
    final _$result = _$v ??
        _$FundingRailCircuit._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingRailCircuit', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
