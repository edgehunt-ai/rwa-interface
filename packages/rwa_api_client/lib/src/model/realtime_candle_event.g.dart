// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_candle_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeCandleEventEventEnum _$realtimeCandleEventEventEnum_candle =
    const RealtimeCandleEventEventEnum._('candle');
const RealtimeCandleEventEventEnum
    _$realtimeCandleEventEventEnum_unknownDefaultOpenApi =
    const RealtimeCandleEventEventEnum._('unknownDefaultOpenApi');

RealtimeCandleEventEventEnum _$realtimeCandleEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'candle':
      return _$realtimeCandleEventEventEnum_candle;
    case 'unknownDefaultOpenApi':
      return _$realtimeCandleEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeCandleEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeCandleEventEventEnum>
    _$realtimeCandleEventEventEnumValues =
    BuiltSet<RealtimeCandleEventEventEnum>(const <RealtimeCandleEventEventEnum>[
  _$realtimeCandleEventEventEnum_candle,
  _$realtimeCandleEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeCandleEventEventEnum>
    _$realtimeCandleEventEventEnumSerializer =
    _$RealtimeCandleEventEventEnumSerializer();

class _$RealtimeCandleEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeCandleEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'candle': 'candle',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'candle': 'candle',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeCandleEventEventEnum];
  @override
  final String wireName = 'RealtimeCandleEventEventEnum';

  @override
  Object serialize(Serializers serializers, RealtimeCandleEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeCandleEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeCandleEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeCandleEvent extends RealtimeCandleEvent {
  @override
  final RealtimeCandleUpdate data;
  @override
  final RealtimeCandleEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeCandleEvent(
          [void Function(RealtimeCandleEventBuilder)? updates]) =>
      (RealtimeCandleEventBuilder()..update(updates))._build();

  _$RealtimeCandleEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeCandleEvent rebuild(
          void Function(RealtimeCandleEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeCandleEventBuilder toBuilder() =>
      RealtimeCandleEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeCandleEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeCandleEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeCandleEventBuilder
    implements
        Builder<RealtimeCandleEvent, RealtimeCandleEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeCandleEvent? _$v;

  RealtimeCandleUpdate? _data;
  RealtimeCandleUpdate? get data => _$this._data;
  set data(covariant RealtimeCandleUpdate? data) => _$this._data = data;

  RealtimeCandleEventEventEnum? _event;
  RealtimeCandleEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeCandleEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeCandleEventBuilder() {
    RealtimeCandleEvent._defaults(this);
  }

  RealtimeCandleEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data;
      _event = $v.event;
      _eventId = $v.eventId;
      _emittedAt = $v.emittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant RealtimeCandleEvent other) {
    _$v = other as _$RealtimeCandleEvent;
  }

  @override
  void update(void Function(RealtimeCandleEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeCandleEvent build() => _build();

  _$RealtimeCandleEvent _build() {
    final _$result = _$v ??
        _$RealtimeCandleEvent._(
          data: BuiltValueNullFieldError.checkNotNull(
              data, r'RealtimeCandleEvent', 'data'),
          event: BuiltValueNullFieldError.checkNotNull(
              event, r'RealtimeCandleEvent', 'event'),
          eventId: BuiltValueNullFieldError.checkNotNull(
              eventId, r'RealtimeCandleEvent', 'eventId'),
          emittedAt: BuiltValueNullFieldError.checkNotNull(
              emittedAt, r'RealtimeCandleEvent', 'emittedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
