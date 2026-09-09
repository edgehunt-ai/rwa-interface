// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_global_circuit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingGlobalCircuitScopeEnum _$fundingGlobalCircuitScopeEnum_global =
    const FundingGlobalCircuitScopeEnum._('global');
const FundingGlobalCircuitScopeEnum
    _$fundingGlobalCircuitScopeEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitScopeEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitScopeEnum _$fundingGlobalCircuitScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'global':
      return _$fundingGlobalCircuitScopeEnum_global;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitScopeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitScopeEnum>
    _$fundingGlobalCircuitScopeEnumValues = BuiltSet<
        FundingGlobalCircuitScopeEnum>(const <FundingGlobalCircuitScopeEnum>[
  _$fundingGlobalCircuitScopeEnum_global,
  _$fundingGlobalCircuitScopeEnum_unknownDefaultOpenApi,
]);

const FundingGlobalCircuitStateEnum _$fundingGlobalCircuitStateEnum_open =
    const FundingGlobalCircuitStateEnum._('open');
const FundingGlobalCircuitStateEnum
    _$fundingGlobalCircuitStateEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitStateEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitStateEnum _$fundingGlobalCircuitStateEnumValueOf(
    String name) {
  switch (name) {
    case 'open':
      return _$fundingGlobalCircuitStateEnum_open;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitStateEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitStateEnum>
    _$fundingGlobalCircuitStateEnumValues = BuiltSet<
        FundingGlobalCircuitStateEnum>(const <FundingGlobalCircuitStateEnum>[
  _$fundingGlobalCircuitStateEnum_open,
  _$fundingGlobalCircuitStateEnum_unknownDefaultOpenApi,
]);

Serializer<FundingGlobalCircuitScopeEnum>
    _$fundingGlobalCircuitScopeEnumSerializer =
    _$FundingGlobalCircuitScopeEnumSerializer();
Serializer<FundingGlobalCircuitStateEnum>
    _$fundingGlobalCircuitStateEnumSerializer =
    _$FundingGlobalCircuitStateEnumSerializer();

class _$FundingGlobalCircuitScopeEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'global': 'global',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'global': 'global',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingGlobalCircuitScopeEnum];
  @override
  final String wireName = 'FundingGlobalCircuitScopeEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuitStateEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'open': 'open',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'open': 'open',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingGlobalCircuitStateEnum];
  @override
  final String wireName = 'FundingGlobalCircuitStateEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuit extends FundingGlobalCircuit {
  @override
  final OneOf oneOf;

  factory _$FundingGlobalCircuit(
          [void Function(FundingGlobalCircuitBuilder)? updates]) =>
      (FundingGlobalCircuitBuilder()..update(updates))._build();

  _$FundingGlobalCircuit._({required this.oneOf}) : super._();
  @override
  FundingGlobalCircuit rebuild(
          void Function(FundingGlobalCircuitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingGlobalCircuitBuilder toBuilder() =>
      FundingGlobalCircuitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingGlobalCircuit && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FundingGlobalCircuit')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingGlobalCircuitBuilder
    implements Builder<FundingGlobalCircuit, FundingGlobalCircuitBuilder> {
  _$FundingGlobalCircuit? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingGlobalCircuitBuilder() {
    FundingGlobalCircuit._defaults(this);
  }

  FundingGlobalCircuitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingGlobalCircuit other) {
    _$v = other as _$FundingGlobalCircuit;
  }

  @override
  void update(void Function(FundingGlobalCircuitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingGlobalCircuit build() => _build();

  _$FundingGlobalCircuit _build() {
    final _$result = _$v ??
        _$FundingGlobalCircuit._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingGlobalCircuit', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
