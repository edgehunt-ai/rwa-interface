// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_session_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeSessionEventEventEnum _$realtimeSessionEventEventEnum_session =
    const RealtimeSessionEventEventEnum._('session');
const RealtimeSessionEventEventEnum
    _$realtimeSessionEventEventEnum_unknownDefaultOpenApi =
    const RealtimeSessionEventEventEnum._('unknownDefaultOpenApi');

RealtimeSessionEventEventEnum _$realtimeSessionEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'session':
      return _$realtimeSessionEventEventEnum_session;
    case 'unknownDefaultOpenApi':
      return _$realtimeSessionEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeSessionEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeSessionEventEventEnum>
    _$realtimeSessionEventEventEnumValues = BuiltSet<
        RealtimeSessionEventEventEnum>(const <RealtimeSessionEventEventEnum>[
  _$realtimeSessionEventEventEnum_session,
  _$realtimeSessionEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeSessionEventEventEnum>
    _$realtimeSessionEventEventEnumSerializer =
    _$RealtimeSessionEventEventEnumSerializer();

class _$RealtimeSessionEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeSessionEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'session': 'session',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'session': 'session',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeSessionEventEventEnum];
  @override
  final String wireName = 'RealtimeSessionEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeSessionEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeSessionEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeSessionEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeSessionEvent extends RealtimeSessionEvent {
  @override
  final MarketSessionInfo data;
  @override
  final RealtimeSessionEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeSessionEvent(
          [void Function(RealtimeSessionEventBuilder)? updates]) =>
      (RealtimeSessionEventBuilder()..update(updates))._build();

  _$RealtimeSessionEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeSessionEvent rebuild(
          void Function(RealtimeSessionEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeSessionEventBuilder toBuilder() =>
      RealtimeSessionEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeSessionEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeSessionEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeSessionEventBuilder
    implements
        Builder<RealtimeSessionEvent, RealtimeSessionEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeSessionEvent? _$v;

  MarketSessionInfoBuilder? _data;
  MarketSessionInfoBuilder get data =>
      _$this._data ??= MarketSessionInfoBuilder();
  set data(covariant MarketSessionInfoBuilder? data) => _$this._data = data;

  RealtimeSessionEventEventEnum? _event;
  RealtimeSessionEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeSessionEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeSessionEventBuilder() {
    RealtimeSessionEvent._defaults(this);
  }

  RealtimeSessionEventBuilder get _$this {
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
  void replace(covariant RealtimeSessionEvent other) {
    _$v = other as _$RealtimeSessionEvent;
  }

  @override
  void update(void Function(RealtimeSessionEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeSessionEvent build() => _build();

  _$RealtimeSessionEvent _build() {
    _$RealtimeSessionEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeSessionEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeSessionEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeSessionEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeSessionEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeSessionEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
