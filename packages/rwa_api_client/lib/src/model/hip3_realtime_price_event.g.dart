// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_price_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimePriceEventEventEnum
    _$hip3RealtimePriceEventEventEnum_hip3Price =
    const Hip3RealtimePriceEventEventEnum._('hip3Price');
const Hip3RealtimePriceEventEventEnum
    _$hip3RealtimePriceEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimePriceEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimePriceEventEventEnum _$hip3RealtimePriceEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Price':
      return _$hip3RealtimePriceEventEventEnum_hip3Price;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePriceEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePriceEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePriceEventEventEnum>
    _$hip3RealtimePriceEventEventEnumValues = BuiltSet<
        Hip3RealtimePriceEventEventEnum>(const <Hip3RealtimePriceEventEventEnum>[
  _$hip3RealtimePriceEventEventEnum_hip3Price,
  _$hip3RealtimePriceEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimePriceEventEventEnum>
    _$hip3RealtimePriceEventEventEnumSerializer =
    _$Hip3RealtimePriceEventEventEnumSerializer();

class _$Hip3RealtimePriceEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePriceEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Price': 'hip3_price',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_price': 'hip3Price',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimePriceEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimePriceEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePriceEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePriceEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePriceEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePriceEvent extends Hip3RealtimePriceEvent {
  @override
  final Hip3RealtimePrice data;
  @override
  final Hip3RealtimePriceEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimePriceEvent(
          [void Function(Hip3RealtimePriceEventBuilder)? updates]) =>
      (Hip3RealtimePriceEventBuilder()..update(updates))._build();

  _$Hip3RealtimePriceEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimePriceEvent rebuild(
          void Function(Hip3RealtimePriceEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimePriceEventBuilder toBuilder() =>
      Hip3RealtimePriceEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimePriceEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimePriceEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimePriceEventBuilder
    implements
        Builder<Hip3RealtimePriceEvent, Hip3RealtimePriceEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimePriceEvent? _$v;

  Hip3RealtimePriceBuilder? _data;
  Hip3RealtimePriceBuilder get data =>
      _$this._data ??= Hip3RealtimePriceBuilder();
  set data(covariant Hip3RealtimePriceBuilder? data) => _$this._data = data;

  Hip3RealtimePriceEventEventEnum? _event;
  Hip3RealtimePriceEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimePriceEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimePriceEventBuilder() {
    Hip3RealtimePriceEvent._defaults(this);
  }

  Hip3RealtimePriceEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimePriceEvent other) {
    _$v = other as _$Hip3RealtimePriceEvent;
  }

  @override
  void update(void Function(Hip3RealtimePriceEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimePriceEvent build() => _build();

  _$Hip3RealtimePriceEvent _build() {
    _$Hip3RealtimePriceEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimePriceEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimePriceEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimePriceEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimePriceEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimePriceEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
