// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_position_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimePositionEventEventEnum
    _$hip3RealtimePositionEventEventEnum_hip3Position =
    const Hip3RealtimePositionEventEventEnum._('hip3Position');
const Hip3RealtimePositionEventEventEnum
    _$hip3RealtimePositionEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimePositionEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimePositionEventEventEnum _$hip3RealtimePositionEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Position':
      return _$hip3RealtimePositionEventEventEnum_hip3Position;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePositionEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePositionEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePositionEventEventEnum>
    _$hip3RealtimePositionEventEventEnumValues = BuiltSet<
        Hip3RealtimePositionEventEventEnum>(const <Hip3RealtimePositionEventEventEnum>[
  _$hip3RealtimePositionEventEventEnum_hip3Position,
  _$hip3RealtimePositionEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimePositionEventEventEnum>
    _$hip3RealtimePositionEventEventEnumSerializer =
    _$Hip3RealtimePositionEventEventEnumSerializer();

class _$Hip3RealtimePositionEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePositionEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Position': 'hip3_position',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_position': 'hip3Position',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimePositionEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimePositionEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePositionEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePositionEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePositionEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePositionEvent extends Hip3RealtimePositionEvent {
  @override
  final Position data;
  @override
  final Hip3RealtimePositionEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimePositionEvent(
          [void Function(Hip3RealtimePositionEventBuilder)? updates]) =>
      (Hip3RealtimePositionEventBuilder()..update(updates))._build();

  _$Hip3RealtimePositionEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimePositionEvent rebuild(
          void Function(Hip3RealtimePositionEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimePositionEventBuilder toBuilder() =>
      Hip3RealtimePositionEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimePositionEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimePositionEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimePositionEventBuilder
    implements
        Builder<Hip3RealtimePositionEvent, Hip3RealtimePositionEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimePositionEvent? _$v;

  PositionBuilder? _data;
  PositionBuilder get data => _$this._data ??= PositionBuilder();
  set data(covariant PositionBuilder? data) => _$this._data = data;

  Hip3RealtimePositionEventEventEnum? _event;
  Hip3RealtimePositionEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimePositionEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimePositionEventBuilder() {
    Hip3RealtimePositionEvent._defaults(this);
  }

  Hip3RealtimePositionEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimePositionEvent other) {
    _$v = other as _$Hip3RealtimePositionEvent;
  }

  @override
  void update(void Function(Hip3RealtimePositionEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimePositionEvent build() => _build();

  _$Hip3RealtimePositionEvent _build() {
    _$Hip3RealtimePositionEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimePositionEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimePositionEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimePositionEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimePositionEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimePositionEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
