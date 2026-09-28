// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_rail_circuit_open.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingRailCircuitOpenScopeEnum _$fundingRailCircuitOpenScopeEnum_hip3 =
    const FundingRailCircuitOpenScopeEnum._('hip3');
const FundingRailCircuitOpenScopeEnum
    _$fundingRailCircuitOpenScopeEnum_bstocks =
    const FundingRailCircuitOpenScopeEnum._('bstocks');

FundingRailCircuitOpenScopeEnum _$fundingRailCircuitOpenScopeEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3':
      return _$fundingRailCircuitOpenScopeEnum_hip3;
    case 'bstocks':
      return _$fundingRailCircuitOpenScopeEnum_bstocks;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingRailCircuitOpenScopeEnum>
    _$fundingRailCircuitOpenScopeEnumValues = BuiltSet<
        FundingRailCircuitOpenScopeEnum>(const <FundingRailCircuitOpenScopeEnum>[
  _$fundingRailCircuitOpenScopeEnum_hip3,
  _$fundingRailCircuitOpenScopeEnum_bstocks,
]);

const FundingRailCircuitOpenStateEnum _$fundingRailCircuitOpenStateEnum_open =
    const FundingRailCircuitOpenStateEnum._('open');

FundingRailCircuitOpenStateEnum _$fundingRailCircuitOpenStateEnumValueOf(
    String name) {
  switch (name) {
    case 'open':
      return _$fundingRailCircuitOpenStateEnum_open;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FundingRailCircuitOpenStateEnum>
    _$fundingRailCircuitOpenStateEnumValues = BuiltSet<
        FundingRailCircuitOpenStateEnum>(const <FundingRailCircuitOpenStateEnum>[
  _$fundingRailCircuitOpenStateEnum_open,
]);

Serializer<FundingRailCircuitOpenScopeEnum>
    _$fundingRailCircuitOpenScopeEnumSerializer =
    _$FundingRailCircuitOpenScopeEnumSerializer();
Serializer<FundingRailCircuitOpenStateEnum>
    _$fundingRailCircuitOpenStateEnumSerializer =
    _$FundingRailCircuitOpenStateEnumSerializer();

class _$FundingRailCircuitOpenScopeEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitOpenScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3': 'hip3',
    'bstocks': 'bstocks',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3': 'hip3',
    'bstocks': 'bstocks',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailCircuitOpenScopeEnum];
  @override
  final String wireName = 'FundingRailCircuitOpenScopeEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRailCircuitOpenScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitOpenScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitOpenScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuitOpenStateEnumSerializer
    implements PrimitiveSerializer<FundingRailCircuitOpenStateEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'open': 'open',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'open': 'open',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingRailCircuitOpenStateEnum];
  @override
  final String wireName = 'FundingRailCircuitOpenStateEnum';

  @override
  Object serialize(
          Serializers serializers, FundingRailCircuitOpenStateEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingRailCircuitOpenStateEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingRailCircuitOpenStateEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingRailCircuitOpen extends FundingRailCircuitOpen {
  @override
  final FundingRailCircuitOpenScopeEnum scope;
  @override
  final FundingRailCircuitOpenStateEnum state;
  @override
  final int generation;
  @override
  final String reason;
  @override
  final DateTime trippedAt;

  factory _$FundingRailCircuitOpen(
          [void Function(FundingRailCircuitOpenBuilder)? updates]) =>
      (FundingRailCircuitOpenBuilder()..update(updates))._build();

  _$FundingRailCircuitOpen._(
      {required this.scope,
      required this.state,
      required this.generation,
      required this.reason,
      required this.trippedAt})
      : super._();
  @override
  FundingRailCircuitOpen rebuild(
          void Function(FundingRailCircuitOpenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRailCircuitOpenBuilder toBuilder() =>
      FundingRailCircuitOpenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRailCircuitOpen &&
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
    return (newBuiltValueToStringHelper(r'FundingRailCircuitOpen')
          ..add('scope', scope)
          ..add('state', state)
          ..add('generation', generation)
          ..add('reason', reason)
          ..add('trippedAt', trippedAt))
        .toString();
  }
}

class FundingRailCircuitOpenBuilder
    implements Builder<FundingRailCircuitOpen, FundingRailCircuitOpenBuilder> {
  _$FundingRailCircuitOpen? _$v;

  FundingRailCircuitOpenScopeEnum? _scope;
  FundingRailCircuitOpenScopeEnum? get scope => _$this._scope;
  set scope(FundingRailCircuitOpenScopeEnum? scope) => _$this._scope = scope;

  FundingRailCircuitOpenStateEnum? _state;
  FundingRailCircuitOpenStateEnum? get state => _$this._state;
  set state(FundingRailCircuitOpenStateEnum? state) => _$this._state = state;

  int? _generation;
  int? get generation => _$this._generation;
  set generation(int? generation) => _$this._generation = generation;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _trippedAt;
  DateTime? get trippedAt => _$this._trippedAt;
  set trippedAt(DateTime? trippedAt) => _$this._trippedAt = trippedAt;

  FundingRailCircuitOpenBuilder() {
    FundingRailCircuitOpen._defaults(this);
  }

  FundingRailCircuitOpenBuilder get _$this {
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
  void replace(FundingRailCircuitOpen other) {
    _$v = other as _$FundingRailCircuitOpen;
  }

  @override
  void update(void Function(FundingRailCircuitOpenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRailCircuitOpen build() => _build();

  _$FundingRailCircuitOpen _build() {
    final _$result = _$v ??
        _$FundingRailCircuitOpen._(
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'FundingRailCircuitOpen', 'scope'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'FundingRailCircuitOpen', 'state'),
          generation: BuiltValueNullFieldError.checkNotNull(
              generation, r'FundingRailCircuitOpen', 'generation'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'FundingRailCircuitOpen', 'reason'),
          trippedAt: BuiltValueNullFieldError.checkNotNull(
              trippedAt, r'FundingRailCircuitOpen', 'trippedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
