// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_balance_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeBalanceEventEventEnum
    _$hip3RealtimeBalanceEventEventEnum_hip3Balance =
    const Hip3RealtimeBalanceEventEventEnum._('hip3Balance');
const Hip3RealtimeBalanceEventEventEnum
    _$hip3RealtimeBalanceEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeBalanceEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeBalanceEventEventEnum _$hip3RealtimeBalanceEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Balance':
      return _$hip3RealtimeBalanceEventEventEnum_hip3Balance;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeBalanceEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeBalanceEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeBalanceEventEventEnum>
    _$hip3RealtimeBalanceEventEventEnumValues = BuiltSet<
        Hip3RealtimeBalanceEventEventEnum>(const <Hip3RealtimeBalanceEventEventEnum>[
  _$hip3RealtimeBalanceEventEventEnum_hip3Balance,
  _$hip3RealtimeBalanceEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeBalanceEventEventEnum>
    _$hip3RealtimeBalanceEventEventEnumSerializer =
    _$Hip3RealtimeBalanceEventEventEnumSerializer();

class _$Hip3RealtimeBalanceEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeBalanceEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Balance': 'hip3_balance',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_balance': 'hip3Balance',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeBalanceEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimeBalanceEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeBalanceEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeBalanceEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeBalanceEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeBalanceEvent extends Hip3RealtimeBalanceEvent {
  @override
  final Hip3RealtimeBalance data;
  @override
  final Hip3RealtimeBalanceEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimeBalanceEvent(
          [void Function(Hip3RealtimeBalanceEventBuilder)? updates]) =>
      (Hip3RealtimeBalanceEventBuilder()..update(updates))._build();

  _$Hip3RealtimeBalanceEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimeBalanceEvent rebuild(
          void Function(Hip3RealtimeBalanceEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeBalanceEventBuilder toBuilder() =>
      Hip3RealtimeBalanceEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeBalanceEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeBalanceEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimeBalanceEventBuilder
    implements
        Builder<Hip3RealtimeBalanceEvent, Hip3RealtimeBalanceEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimeBalanceEvent? _$v;

  Hip3RealtimeBalanceBuilder? _data;
  Hip3RealtimeBalanceBuilder get data =>
      _$this._data ??= Hip3RealtimeBalanceBuilder();
  set data(covariant Hip3RealtimeBalanceBuilder? data) => _$this._data = data;

  Hip3RealtimeBalanceEventEventEnum? _event;
  Hip3RealtimeBalanceEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimeBalanceEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimeBalanceEventBuilder() {
    Hip3RealtimeBalanceEvent._defaults(this);
  }

  Hip3RealtimeBalanceEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimeBalanceEvent other) {
    _$v = other as _$Hip3RealtimeBalanceEvent;
  }

  @override
  void update(void Function(Hip3RealtimeBalanceEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeBalanceEvent build() => _build();

  _$Hip3RealtimeBalanceEvent _build() {
    _$Hip3RealtimeBalanceEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeBalanceEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeBalanceEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimeBalanceEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimeBalanceEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeBalanceEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
