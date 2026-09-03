// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeEventEventEnum _$realtimeEventEventEnum_resyncRequired =
    const RealtimeEventEventEnum._('resyncRequired');
const RealtimeEventEventEnum _$realtimeEventEventEnum_unknownDefaultOpenApi =
    const RealtimeEventEventEnum._('unknownDefaultOpenApi');

RealtimeEventEventEnum _$realtimeEventEventEnumValueOf(String name) {
  switch (name) {
    case 'resyncRequired':
      return _$realtimeEventEventEnum_resyncRequired;
    case 'unknownDefaultOpenApi':
      return _$realtimeEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeEventEventEnum> _$realtimeEventEventEnumValues =
    BuiltSet<RealtimeEventEventEnum>(const <RealtimeEventEventEnum>[
  _$realtimeEventEventEnum_resyncRequired,
  _$realtimeEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeEventEventEnum> _$realtimeEventEventEnumSerializer =
    _$RealtimeEventEventEnumSerializer();

class _$RealtimeEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'resyncRequired': 'resync_required',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'resync_required': 'resyncRequired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeEventEventEnum];
  @override
  final String wireName = 'RealtimeEventEventEnum';

  @override
  Object serialize(Serializers serializers, RealtimeEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeEventEventEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeEvent extends RealtimeEvent {
  @override
  final OneOf oneOf;

  factory _$RealtimeEvent([void Function(RealtimeEventBuilder)? updates]) =>
      (RealtimeEventBuilder()..update(updates))._build();

  _$RealtimeEvent._({required this.oneOf}) : super._();
  @override
  RealtimeEvent rebuild(void Function(RealtimeEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeEventBuilder toBuilder() => RealtimeEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeEvent && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'RealtimeEvent')..add('oneOf', oneOf))
        .toString();
  }
}

class RealtimeEventBuilder
    implements Builder<RealtimeEvent, RealtimeEventBuilder> {
  _$RealtimeEvent? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  RealtimeEventBuilder() {
    RealtimeEvent._defaults(this);
  }

  RealtimeEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RealtimeEvent other) {
    _$v = other as _$RealtimeEvent;
  }

  @override
  void update(void Function(RealtimeEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeEvent build() => _build();

  _$RealtimeEvent _build() {
    final _$result = _$v ??
        _$RealtimeEvent._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'RealtimeEvent', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
