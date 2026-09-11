// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resource_changed_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeResourceChangedEventEventEnum
    _$realtimeResourceChangedEventEventEnum_resourceChanged =
    const RealtimeResourceChangedEventEventEnum._('resourceChanged');
const RealtimeResourceChangedEventEventEnum
    _$realtimeResourceChangedEventEventEnum_unknownDefaultOpenApi =
    const RealtimeResourceChangedEventEventEnum._('unknownDefaultOpenApi');

RealtimeResourceChangedEventEventEnum
    _$realtimeResourceChangedEventEventEnumValueOf(String name) {
  switch (name) {
    case 'resourceChanged':
      return _$realtimeResourceChangedEventEventEnum_resourceChanged;
    case 'unknownDefaultOpenApi':
      return _$realtimeResourceChangedEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeResourceChangedEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeResourceChangedEventEventEnum>
    _$realtimeResourceChangedEventEventEnumValues = BuiltSet<
        RealtimeResourceChangedEventEventEnum>(const <RealtimeResourceChangedEventEventEnum>[
  _$realtimeResourceChangedEventEventEnum_resourceChanged,
  _$realtimeResourceChangedEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeResourceChangedEventEventEnum>
    _$realtimeResourceChangedEventEventEnumSerializer =
    _$RealtimeResourceChangedEventEventEnumSerializer();

class _$RealtimeResourceChangedEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeResourceChangedEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'resourceChanged': 'resource_changed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'resource_changed': 'resourceChanged',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RealtimeResourceChangedEventEventEnum
  ];
  @override
  final String wireName = 'RealtimeResourceChangedEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeResourceChangedEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeResourceChangedEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeResourceChangedEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeResourceChangedEvent extends RealtimeResourceChangedEvent {
  @override
  final RealtimeResourceChanged data;
  @override
  final RealtimeResourceChangedEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeResourceChangedEvent(
          [void Function(RealtimeResourceChangedEventBuilder)? updates]) =>
      (RealtimeResourceChangedEventBuilder()..update(updates))._build();

  _$RealtimeResourceChangedEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeResourceChangedEvent rebuild(
          void Function(RealtimeResourceChangedEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeResourceChangedEventBuilder toBuilder() =>
      RealtimeResourceChangedEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeResourceChangedEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeResourceChangedEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeResourceChangedEventBuilder
    implements
        Builder<RealtimeResourceChangedEvent,
            RealtimeResourceChangedEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeResourceChangedEvent? _$v;

  RealtimeResourceChangedBuilder? _data;
  RealtimeResourceChangedBuilder get data =>
      _$this._data ??= RealtimeResourceChangedBuilder();
  set data(covariant RealtimeResourceChangedBuilder? data) =>
      _$this._data = data;

  RealtimeResourceChangedEventEventEnum? _event;
  RealtimeResourceChangedEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeResourceChangedEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeResourceChangedEventBuilder() {
    RealtimeResourceChangedEvent._defaults(this);
  }

  RealtimeResourceChangedEventBuilder get _$this {
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
  void replace(covariant RealtimeResourceChangedEvent other) {
    _$v = other as _$RealtimeResourceChangedEvent;
  }

  @override
  void update(void Function(RealtimeResourceChangedEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeResourceChangedEvent build() => _build();

  _$RealtimeResourceChangedEvent _build() {
    _$RealtimeResourceChangedEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeResourceChangedEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeResourceChangedEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeResourceChangedEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeResourceChangedEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeResourceChangedEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
