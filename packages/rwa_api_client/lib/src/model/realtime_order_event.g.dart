// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_order_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeOrderEventEventEnum _$realtimeOrderEventEventEnum_order =
    const RealtimeOrderEventEventEnum._('order');
const RealtimeOrderEventEventEnum
    _$realtimeOrderEventEventEnum_unknownDefaultOpenApi =
    const RealtimeOrderEventEventEnum._('unknownDefaultOpenApi');

RealtimeOrderEventEventEnum _$realtimeOrderEventEventEnumValueOf(String name) {
  switch (name) {
    case 'order':
      return _$realtimeOrderEventEventEnum_order;
    case 'unknownDefaultOpenApi':
      return _$realtimeOrderEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeOrderEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeOrderEventEventEnum>
    _$realtimeOrderEventEventEnumValues =
    BuiltSet<RealtimeOrderEventEventEnum>(const <RealtimeOrderEventEventEnum>[
  _$realtimeOrderEventEventEnum_order,
  _$realtimeOrderEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeOrderEventEventEnum>
    _$realtimeOrderEventEventEnumSerializer =
    _$RealtimeOrderEventEventEnumSerializer();

class _$RealtimeOrderEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeOrderEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'order': 'order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order': 'order',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeOrderEventEventEnum];
  @override
  final String wireName = 'RealtimeOrderEventEventEnum';

  @override
  Object serialize(Serializers serializers, RealtimeOrderEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeOrderEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeOrderEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeOrderEvent extends RealtimeOrderEvent {
  @override
  final Order data;
  @override
  final RealtimeOrderEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeOrderEvent(
          [void Function(RealtimeOrderEventBuilder)? updates]) =>
      (RealtimeOrderEventBuilder()..update(updates))._build();

  _$RealtimeOrderEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeOrderEvent rebuild(
          void Function(RealtimeOrderEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeOrderEventBuilder toBuilder() =>
      RealtimeOrderEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeOrderEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeOrderEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeOrderEventBuilder
    implements
        Builder<RealtimeOrderEvent, RealtimeOrderEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeOrderEvent? _$v;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(covariant OrderBuilder? data) => _$this._data = data;

  RealtimeOrderEventEventEnum? _event;
  RealtimeOrderEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeOrderEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeOrderEventBuilder() {
    RealtimeOrderEvent._defaults(this);
  }

  RealtimeOrderEventBuilder get _$this {
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
  void replace(covariant RealtimeOrderEvent other) {
    _$v = other as _$RealtimeOrderEvent;
  }

  @override
  void update(void Function(RealtimeOrderEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeOrderEvent build() => _build();

  _$RealtimeOrderEvent _build() {
    _$RealtimeOrderEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeOrderEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeOrderEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeOrderEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeOrderEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeOrderEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
