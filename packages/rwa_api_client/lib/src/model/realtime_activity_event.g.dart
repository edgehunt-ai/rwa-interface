// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_activity_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeActivityEventEventEnum _$realtimeActivityEventEventEnum_activity =
    const RealtimeActivityEventEventEnum._('activity');
const RealtimeActivityEventEventEnum
    _$realtimeActivityEventEventEnum_unknownDefaultOpenApi =
    const RealtimeActivityEventEventEnum._('unknownDefaultOpenApi');

RealtimeActivityEventEventEnum _$realtimeActivityEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'activity':
      return _$realtimeActivityEventEventEnum_activity;
    case 'unknownDefaultOpenApi':
      return _$realtimeActivityEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeActivityEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeActivityEventEventEnum>
    _$realtimeActivityEventEventEnumValues = BuiltSet<
        RealtimeActivityEventEventEnum>(const <RealtimeActivityEventEventEnum>[
  _$realtimeActivityEventEventEnum_activity,
  _$realtimeActivityEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeActivityEventEventEnum>
    _$realtimeActivityEventEventEnumSerializer =
    _$RealtimeActivityEventEventEnumSerializer();

class _$RealtimeActivityEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeActivityEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'activity': 'activity',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'activity': 'activity',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeActivityEventEventEnum];
  @override
  final String wireName = 'RealtimeActivityEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeActivityEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeActivityEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeActivityEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeActivityEvent extends RealtimeActivityEvent {
  @override
  final ActivityRecord data;
  @override
  final RealtimeActivityEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeActivityEvent(
          [void Function(RealtimeActivityEventBuilder)? updates]) =>
      (RealtimeActivityEventBuilder()..update(updates))._build();

  _$RealtimeActivityEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeActivityEvent rebuild(
          void Function(RealtimeActivityEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeActivityEventBuilder toBuilder() =>
      RealtimeActivityEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeActivityEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeActivityEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeActivityEventBuilder
    implements
        Builder<RealtimeActivityEvent, RealtimeActivityEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeActivityEvent? _$v;

  ActivityRecordBuilder? _data;
  ActivityRecordBuilder get data => _$this._data ??= ActivityRecordBuilder();
  set data(covariant ActivityRecordBuilder? data) => _$this._data = data;

  RealtimeActivityEventEventEnum? _event;
  RealtimeActivityEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeActivityEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeActivityEventBuilder() {
    RealtimeActivityEvent._defaults(this);
  }

  RealtimeActivityEventBuilder get _$this {
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
  void replace(covariant RealtimeActivityEvent other) {
    _$v = other as _$RealtimeActivityEvent;
  }

  @override
  void update(void Function(RealtimeActivityEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeActivityEvent build() => _build();

  _$RealtimeActivityEvent _build() {
    _$RealtimeActivityEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeActivityEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeActivityEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeActivityEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeActivityEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeActivityEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
