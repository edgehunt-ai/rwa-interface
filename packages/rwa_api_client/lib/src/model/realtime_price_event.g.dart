// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_price_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimePriceEventEventEnum _$realtimePriceEventEventEnum_price =
    const RealtimePriceEventEventEnum._('price');
const RealtimePriceEventEventEnum
    _$realtimePriceEventEventEnum_unknownDefaultOpenApi =
    const RealtimePriceEventEventEnum._('unknownDefaultOpenApi');

RealtimePriceEventEventEnum _$realtimePriceEventEventEnumValueOf(String name) {
  switch (name) {
    case 'price':
      return _$realtimePriceEventEventEnum_price;
    case 'unknownDefaultOpenApi':
      return _$realtimePriceEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimePriceEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimePriceEventEventEnum>
    _$realtimePriceEventEventEnumValues =
    BuiltSet<RealtimePriceEventEventEnum>(const <RealtimePriceEventEventEnum>[
  _$realtimePriceEventEventEnum_price,
  _$realtimePriceEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimePriceEventEventEnum>
    _$realtimePriceEventEventEnumSerializer =
    _$RealtimePriceEventEventEnumSerializer();

class _$RealtimePriceEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimePriceEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'price': 'price',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'price': 'price',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimePriceEventEventEnum];
  @override
  final String wireName = 'RealtimePriceEventEventEnum';

  @override
  Object serialize(Serializers serializers, RealtimePriceEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimePriceEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimePriceEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimePriceEvent extends RealtimePriceEvent {
  @override
  final RealtimePriceUpdate data;
  @override
  final RealtimePriceEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimePriceEvent(
          [void Function(RealtimePriceEventBuilder)? updates]) =>
      (RealtimePriceEventBuilder()..update(updates))._build();

  _$RealtimePriceEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimePriceEvent rebuild(
          void Function(RealtimePriceEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimePriceEventBuilder toBuilder() =>
      RealtimePriceEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimePriceEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimePriceEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimePriceEventBuilder
    implements
        Builder<RealtimePriceEvent, RealtimePriceEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimePriceEvent? _$v;

  RealtimePriceUpdateBuilder? _data;
  RealtimePriceUpdateBuilder get data =>
      _$this._data ??= RealtimePriceUpdateBuilder();
  set data(covariant RealtimePriceUpdateBuilder? data) => _$this._data = data;

  RealtimePriceEventEventEnum? _event;
  RealtimePriceEventEventEnum? get event => _$this._event;
  set event(covariant RealtimePriceEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimePriceEventBuilder() {
    RealtimePriceEvent._defaults(this);
  }

  RealtimePriceEventBuilder get _$this {
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
  void replace(covariant RealtimePriceEvent other) {
    _$v = other as _$RealtimePriceEvent;
  }

  @override
  void update(void Function(RealtimePriceEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimePriceEvent build() => _build();

  _$RealtimePriceEvent _build() {
    _$RealtimePriceEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimePriceEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimePriceEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimePriceEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimePriceEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimePriceEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
