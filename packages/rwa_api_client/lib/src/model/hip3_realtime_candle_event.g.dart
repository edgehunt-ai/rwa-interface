// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_candle_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeCandleEventEventEnum
    _$hip3RealtimeCandleEventEventEnum_hip3Candle =
    const Hip3RealtimeCandleEventEventEnum._('hip3Candle');
const Hip3RealtimeCandleEventEventEnum
    _$hip3RealtimeCandleEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeCandleEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeCandleEventEventEnum _$hip3RealtimeCandleEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Candle':
      return _$hip3RealtimeCandleEventEventEnum_hip3Candle;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeCandleEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeCandleEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeCandleEventEventEnum>
    _$hip3RealtimeCandleEventEventEnumValues = BuiltSet<
        Hip3RealtimeCandleEventEventEnum>(const <Hip3RealtimeCandleEventEventEnum>[
  _$hip3RealtimeCandleEventEventEnum_hip3Candle,
  _$hip3RealtimeCandleEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeCandleEventEventEnum>
    _$hip3RealtimeCandleEventEventEnumSerializer =
    _$Hip3RealtimeCandleEventEventEnumSerializer();

class _$Hip3RealtimeCandleEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeCandleEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Candle': 'hip3_candle',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_candle': 'hip3Candle',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeCandleEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimeCandleEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeCandleEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeCandleEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeCandleEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeCandleEvent extends Hip3RealtimeCandleEvent {
  @override
  final Hip3RealtimeCandle data;
  @override
  final Hip3RealtimeCandleEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimeCandleEvent(
          [void Function(Hip3RealtimeCandleEventBuilder)? updates]) =>
      (Hip3RealtimeCandleEventBuilder()..update(updates))._build();

  _$Hip3RealtimeCandleEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimeCandleEvent rebuild(
          void Function(Hip3RealtimeCandleEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeCandleEventBuilder toBuilder() =>
      Hip3RealtimeCandleEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeCandleEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeCandleEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimeCandleEventBuilder
    implements
        Builder<Hip3RealtimeCandleEvent, Hip3RealtimeCandleEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimeCandleEvent? _$v;

  Hip3RealtimeCandleBuilder? _data;
  Hip3RealtimeCandleBuilder get data =>
      _$this._data ??= Hip3RealtimeCandleBuilder();
  set data(covariant Hip3RealtimeCandleBuilder? data) => _$this._data = data;

  Hip3RealtimeCandleEventEventEnum? _event;
  Hip3RealtimeCandleEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimeCandleEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimeCandleEventBuilder() {
    Hip3RealtimeCandleEvent._defaults(this);
  }

  Hip3RealtimeCandleEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimeCandleEvent other) {
    _$v = other as _$Hip3RealtimeCandleEvent;
  }

  @override
  void update(void Function(Hip3RealtimeCandleEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeCandleEvent build() => _build();

  _$Hip3RealtimeCandleEvent _build() {
    _$Hip3RealtimeCandleEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeCandleEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeCandleEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimeCandleEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimeCandleEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeCandleEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
