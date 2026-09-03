// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resync_required_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeResyncRequiredEventEventEnum
    _$realtimeResyncRequiredEventEventEnum_resyncRequired =
    const RealtimeResyncRequiredEventEventEnum._('resyncRequired');
const RealtimeResyncRequiredEventEventEnum
    _$realtimeResyncRequiredEventEventEnum_unknownDefaultOpenApi =
    const RealtimeResyncRequiredEventEventEnum._('unknownDefaultOpenApi');

RealtimeResyncRequiredEventEventEnum
    _$realtimeResyncRequiredEventEventEnumValueOf(String name) {
  switch (name) {
    case 'resyncRequired':
      return _$realtimeResyncRequiredEventEventEnum_resyncRequired;
    case 'unknownDefaultOpenApi':
      return _$realtimeResyncRequiredEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeResyncRequiredEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeResyncRequiredEventEventEnum>
    _$realtimeResyncRequiredEventEventEnumValues = BuiltSet<
        RealtimeResyncRequiredEventEventEnum>(const <RealtimeResyncRequiredEventEventEnum>[
  _$realtimeResyncRequiredEventEventEnum_resyncRequired,
  _$realtimeResyncRequiredEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeResyncRequiredEventEventEnum>
    _$realtimeResyncRequiredEventEventEnumSerializer =
    _$RealtimeResyncRequiredEventEventEnumSerializer();

class _$RealtimeResyncRequiredEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeResyncRequiredEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'resyncRequired': 'resync_required',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'resync_required': 'resyncRequired',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RealtimeResyncRequiredEventEventEnum
  ];
  @override
  final String wireName = 'RealtimeResyncRequiredEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeResyncRequiredEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeResyncRequiredEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeResyncRequiredEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeResyncRequiredEvent extends RealtimeResyncRequiredEvent {
  @override
  final RealtimeResyncRequiredEventAllOfData data;
  @override
  final RealtimeResyncRequiredEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeResyncRequiredEvent(
          [void Function(RealtimeResyncRequiredEventBuilder)? updates]) =>
      (RealtimeResyncRequiredEventBuilder()..update(updates))._build();

  _$RealtimeResyncRequiredEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeResyncRequiredEvent rebuild(
          void Function(RealtimeResyncRequiredEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeResyncRequiredEventBuilder toBuilder() =>
      RealtimeResyncRequiredEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeResyncRequiredEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeResyncRequiredEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeResyncRequiredEventBuilder
    implements
        Builder<RealtimeResyncRequiredEvent,
            RealtimeResyncRequiredEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeResyncRequiredEvent? _$v;

  RealtimeResyncRequiredEventAllOfDataBuilder? _data;
  RealtimeResyncRequiredEventAllOfDataBuilder get data =>
      _$this._data ??= RealtimeResyncRequiredEventAllOfDataBuilder();
  set data(covariant RealtimeResyncRequiredEventAllOfDataBuilder? data) =>
      _$this._data = data;

  RealtimeResyncRequiredEventEventEnum? _event;
  RealtimeResyncRequiredEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeResyncRequiredEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeResyncRequiredEventBuilder() {
    RealtimeResyncRequiredEvent._defaults(this);
  }

  RealtimeResyncRequiredEventBuilder get _$this {
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
  void replace(covariant RealtimeResyncRequiredEvent other) {
    _$v = other as _$RealtimeResyncRequiredEvent;
  }

  @override
  void update(void Function(RealtimeResyncRequiredEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeResyncRequiredEvent build() => _build();

  _$RealtimeResyncRequiredEvent _build() {
    _$RealtimeResyncRequiredEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeResyncRequiredEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeResyncRequiredEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeResyncRequiredEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeResyncRequiredEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeResyncRequiredEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
