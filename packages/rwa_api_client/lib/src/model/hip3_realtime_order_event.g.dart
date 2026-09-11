// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_order_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeOrderEventEventEnum
    _$hip3RealtimeOrderEventEventEnum_hip3Order =
    const Hip3RealtimeOrderEventEventEnum._('hip3Order');
const Hip3RealtimeOrderEventEventEnum
    _$hip3RealtimeOrderEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeOrderEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeOrderEventEventEnum _$hip3RealtimeOrderEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Order':
      return _$hip3RealtimeOrderEventEventEnum_hip3Order;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeOrderEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeOrderEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeOrderEventEventEnum>
    _$hip3RealtimeOrderEventEventEnumValues = BuiltSet<
        Hip3RealtimeOrderEventEventEnum>(const <Hip3RealtimeOrderEventEventEnum>[
  _$hip3RealtimeOrderEventEventEnum_hip3Order,
  _$hip3RealtimeOrderEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeOrderEventEventEnum>
    _$hip3RealtimeOrderEventEventEnumSerializer =
    _$Hip3RealtimeOrderEventEventEnumSerializer();

class _$Hip3RealtimeOrderEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeOrderEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Order': 'hip3_order',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_order': 'hip3Order',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeOrderEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimeOrderEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeOrderEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeOrderEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeOrderEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeOrderEvent extends Hip3RealtimeOrderEvent {
  @override
  final Order data;
  @override
  final Hip3RealtimeOrderEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimeOrderEvent(
          [void Function(Hip3RealtimeOrderEventBuilder)? updates]) =>
      (Hip3RealtimeOrderEventBuilder()..update(updates))._build();

  _$Hip3RealtimeOrderEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimeOrderEvent rebuild(
          void Function(Hip3RealtimeOrderEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeOrderEventBuilder toBuilder() =>
      Hip3RealtimeOrderEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeOrderEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeOrderEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimeOrderEventBuilder
    implements
        Builder<Hip3RealtimeOrderEvent, Hip3RealtimeOrderEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimeOrderEvent? _$v;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(covariant OrderBuilder? data) => _$this._data = data;

  Hip3RealtimeOrderEventEventEnum? _event;
  Hip3RealtimeOrderEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimeOrderEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimeOrderEventBuilder() {
    Hip3RealtimeOrderEvent._defaults(this);
  }

  Hip3RealtimeOrderEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimeOrderEvent other) {
    _$v = other as _$Hip3RealtimeOrderEvent;
  }

  @override
  void update(void Function(Hip3RealtimeOrderEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeOrderEvent build() => _build();

  _$Hip3RealtimeOrderEvent _build() {
    _$Hip3RealtimeOrderEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeOrderEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeOrderEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimeOrderEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimeOrderEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeOrderEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
