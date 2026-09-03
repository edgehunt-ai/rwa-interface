// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_position_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimePositionEventEventEnum _$realtimePositionEventEventEnum_position =
    const RealtimePositionEventEventEnum._('position');
const RealtimePositionEventEventEnum
    _$realtimePositionEventEventEnum_unknownDefaultOpenApi =
    const RealtimePositionEventEventEnum._('unknownDefaultOpenApi');

RealtimePositionEventEventEnum _$realtimePositionEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'position':
      return _$realtimePositionEventEventEnum_position;
    case 'unknownDefaultOpenApi':
      return _$realtimePositionEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimePositionEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimePositionEventEventEnum>
    _$realtimePositionEventEventEnumValues = BuiltSet<
        RealtimePositionEventEventEnum>(const <RealtimePositionEventEventEnum>[
  _$realtimePositionEventEventEnum_position,
  _$realtimePositionEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimePositionEventEventEnum>
    _$realtimePositionEventEventEnumSerializer =
    _$RealtimePositionEventEventEnumSerializer();

class _$RealtimePositionEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimePositionEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'position': 'position',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'position': 'position',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimePositionEventEventEnum];
  @override
  final String wireName = 'RealtimePositionEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimePositionEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimePositionEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimePositionEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimePositionEvent extends RealtimePositionEvent {
  @override
  final Position data;
  @override
  final RealtimePositionEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimePositionEvent(
          [void Function(RealtimePositionEventBuilder)? updates]) =>
      (RealtimePositionEventBuilder()..update(updates))._build();

  _$RealtimePositionEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimePositionEvent rebuild(
          void Function(RealtimePositionEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimePositionEventBuilder toBuilder() =>
      RealtimePositionEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimePositionEvent &&
        data == other.data &&
        event == other.event &&
        eventId == other.eventId &&
        emittedAt == other.emittedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, event.hashCode);
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, emittedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RealtimePositionEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimePositionEventBuilder
    implements
        Builder<RealtimePositionEvent, RealtimePositionEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimePositionEvent? _$v;

  PositionBuilder? _data;
  PositionBuilder get data => _$this._data ??= PositionBuilder();
  set data(covariant PositionBuilder? data) => _$this._data = data;

  RealtimePositionEventEventEnum? _event;
  RealtimePositionEventEventEnum? get event => _$this._event;
  set event(covariant RealtimePositionEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimePositionEventBuilder() {
    RealtimePositionEvent._defaults(this);
  }

  RealtimePositionEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _event = $v.event;
      _eventId = $v.eventId;
      _emittedAt = $v.emittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant RealtimePositionEvent other) {
    _$v = other as _$RealtimePositionEvent;
  }

  @override
  void update(void Function(RealtimePositionEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimePositionEvent build() => _build();

  _$RealtimePositionEvent _build() {
    _$RealtimePositionEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimePositionEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimePositionEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimePositionEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimePositionEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimePositionEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
