// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_global_circuit_open.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingGlobalCircuitOpenScopeEnum
    _$fundingGlobalCircuitOpenScopeEnum_global =
    const FundingGlobalCircuitOpenScopeEnum._('global');
const FundingGlobalCircuitOpenScopeEnum
    _$fundingGlobalCircuitOpenScopeEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitOpenScopeEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitOpenScopeEnum _$fundingGlobalCircuitOpenScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'global':
      return _$fundingGlobalCircuitOpenScopeEnum_global;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitOpenScopeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitOpenScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitOpenScopeEnum>
    _$fundingGlobalCircuitOpenScopeEnumValues = BuiltSet<
        FundingGlobalCircuitOpenScopeEnum>(const <FundingGlobalCircuitOpenScopeEnum>[
  _$fundingGlobalCircuitOpenScopeEnum_global,
  _$fundingGlobalCircuitOpenScopeEnum_unknownDefaultOpenApi,
]);

const FundingGlobalCircuitOpenStateEnum
    _$fundingGlobalCircuitOpenStateEnum_open =
    const FundingGlobalCircuitOpenStateEnum._('open');
const FundingGlobalCircuitOpenStateEnum
    _$fundingGlobalCircuitOpenStateEnum_unknownDefaultOpenApi =
    const FundingGlobalCircuitOpenStateEnum._('unknownDefaultOpenApi');

FundingGlobalCircuitOpenStateEnum _$fundingGlobalCircuitOpenStateEnumValueOf(
    String name) {
  switch (name) {
    case 'open':
      return _$fundingGlobalCircuitOpenStateEnum_open;
    case 'unknownDefaultOpenApi':
      return _$fundingGlobalCircuitOpenStateEnum_unknownDefaultOpenApi;
    default:
      return _$fundingGlobalCircuitOpenStateEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingGlobalCircuitOpenStateEnum>
    _$fundingGlobalCircuitOpenStateEnumValues = BuiltSet<
        FundingGlobalCircuitOpenStateEnum>(const <FundingGlobalCircuitOpenStateEnum>[
  _$fundingGlobalCircuitOpenStateEnum_open,
  _$fundingGlobalCircuitOpenStateEnum_unknownDefaultOpenApi,
]);

Serializer<FundingGlobalCircuitOpenScopeEnum>
    _$fundingGlobalCircuitOpenScopeEnumSerializer =
    _$FundingGlobalCircuitOpenScopeEnumSerializer();
Serializer<FundingGlobalCircuitOpenStateEnum>
    _$fundingGlobalCircuitOpenStateEnumSerializer =
    _$FundingGlobalCircuitOpenStateEnumSerializer();

class _$FundingGlobalCircuitOpenScopeEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitOpenScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'global': 'global',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'global': 'global',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingGlobalCircuitOpenScopeEnum];
  @override
  final String wireName = 'FundingGlobalCircuitOpenScopeEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitOpenScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitOpenScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitOpenScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuitOpenStateEnumSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitOpenStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'open': 'open',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'open': 'open',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingGlobalCircuitOpenStateEnum];
  @override
  final String wireName = 'FundingGlobalCircuitOpenStateEnum';

  @override
  Object serialize(
          Serializers serializers, FundingGlobalCircuitOpenStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingGlobalCircuitOpenStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingGlobalCircuitOpenStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingGlobalCircuitOpen extends FundingGlobalCircuitOpen {
  @override
  final FundingGlobalCircuitOpenScopeEnum scope;
  @override
  final FundingGlobalCircuitOpenStateEnum state;
  @override
  final int generation;
  @override
  final String reason;
  @override
  final DateTime trippedAt;

  factory _$FundingGlobalCircuitOpen(
          [void Function(FundingGlobalCircuitOpenBuilder)? updates]) =>
      (FundingGlobalCircuitOpenBuilder()..update(updates))._build();

  _$FundingGlobalCircuitOpen._(
      {required this.scope,
      required this.state,
      required this.generation,
      required this.reason,
      required this.trippedAt})
      : super._();
  @override
  FundingGlobalCircuitOpen rebuild(
          void Function(FundingGlobalCircuitOpenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingGlobalCircuitOpenBuilder toBuilder() =>
      FundingGlobalCircuitOpenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingGlobalCircuitOpen &&
        scope == other.scope &&
        state == other.state &&
        generation == other.generation &&
        reason == other.reason &&
        trippedAt == other.trippedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, generation.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, trippedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingGlobalCircuitOpen')
          ..add('scope', scope)
          ..add('state', state)
          ..add('generation', generation)
          ..add('reason', reason)
          ..add('trippedAt', trippedAt))
        .toString();
  }
}

class FundingGlobalCircuitOpenBuilder
    implements
        Builder<FundingGlobalCircuitOpen, FundingGlobalCircuitOpenBuilder> {
  _$FundingGlobalCircuitOpen? _$v;

  FundingGlobalCircuitOpenScopeEnum? _scope;
  FundingGlobalCircuitOpenScopeEnum? get scope => _$this._scope;
  set scope(FundingGlobalCircuitOpenScopeEnum? scope) => _$this._scope = scope;

  FundingGlobalCircuitOpenStateEnum? _state;
  FundingGlobalCircuitOpenStateEnum? get state => _$this._state;
  set state(FundingGlobalCircuitOpenStateEnum? state) => _$this._state = state;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _trippedAt;
  DateTime? get trippedAt => _$this._trippedAt;
  set trippedAt(DateTime? trippedAt) => _$this._trippedAt = trippedAt;

  FundingGlobalCircuitOpenBuilder() {
    FundingGlobalCircuitOpen._defaults(this);
  }

  FundingGlobalCircuitOpenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _scope = $v.scope;
      _state = $v.state;
      _generation = $v.generation;
      _reason = $v.reason;
      _trippedAt = $v.trippedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingGlobalCircuitOpen other) {
    _$v = other as _$FundingGlobalCircuitOpen;
  }

  @override
  void update(void Function(FundingGlobalCircuitOpenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingGlobalCircuitOpen build() => _build();

  _$FundingGlobalCircuitOpen _build() {
    final _$result = _$v ??
        _$FundingGlobalCircuitOpen._(
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'FundingGlobalCircuitOpen', 'scope'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'FundingGlobalCircuitOpen', 'state'),
          generation: BuiltValueNullFieldError.checkNotNull(
              generation, r'FundingGlobalCircuitOpen', 'generation'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'FundingGlobalCircuitOpen', 'reason'),
          trippedAt: BuiltValueNullFieldError.checkNotNull(
              trippedAt, r'FundingGlobalCircuitOpen', 'trippedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
