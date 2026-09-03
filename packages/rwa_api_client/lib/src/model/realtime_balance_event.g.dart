// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_balance_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeBalanceEventEventEnum _$realtimeBalanceEventEventEnum_balance =
    const RealtimeBalanceEventEventEnum._('balance');
const RealtimeBalanceEventEventEnum
    _$realtimeBalanceEventEventEnum_unknownDefaultOpenApi =
    const RealtimeBalanceEventEventEnum._('unknownDefaultOpenApi');

RealtimeBalanceEventEventEnum _$realtimeBalanceEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'balance':
      return _$realtimeBalanceEventEventEnum_balance;
    case 'unknownDefaultOpenApi':
      return _$realtimeBalanceEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeBalanceEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeBalanceEventEventEnum>
    _$realtimeBalanceEventEventEnumValues = BuiltSet<
        RealtimeBalanceEventEventEnum>(const <RealtimeBalanceEventEventEnum>[
  _$realtimeBalanceEventEventEnum_balance,
  _$realtimeBalanceEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeBalanceEventEventEnum>
    _$realtimeBalanceEventEventEnumSerializer =
    _$RealtimeBalanceEventEventEnumSerializer();

class _$RealtimeBalanceEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeBalanceEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'balance': 'balance',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'balance': 'balance',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeBalanceEventEventEnum];
  @override
  final String wireName = 'RealtimeBalanceEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeBalanceEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeBalanceEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeBalanceEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeBalanceEvent extends RealtimeBalanceEvent {
  @override
  final AccountBalance data;
  @override
  final RealtimeBalanceEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeBalanceEvent(
          [void Function(RealtimeBalanceEventBuilder)? updates]) =>
      (RealtimeBalanceEventBuilder()..update(updates))._build();

  _$RealtimeBalanceEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeBalanceEvent rebuild(
          void Function(RealtimeBalanceEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeBalanceEventBuilder toBuilder() =>
      RealtimeBalanceEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeBalanceEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeBalanceEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeBalanceEventBuilder
    implements
        Builder<RealtimeBalanceEvent, RealtimeBalanceEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeBalanceEvent? _$v;

  AccountBalanceBuilder? _data;
  AccountBalanceBuilder get data => _$this._data ??= AccountBalanceBuilder();
  set data(covariant AccountBalanceBuilder? data) => _$this._data = data;

  RealtimeBalanceEventEventEnum? _event;
  RealtimeBalanceEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeBalanceEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeBalanceEventBuilder() {
    RealtimeBalanceEvent._defaults(this);
  }

  RealtimeBalanceEventBuilder get _$this {
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
  void replace(covariant RealtimeBalanceEvent other) {
    _$v = other as _$RealtimeBalanceEvent;
  }

  @override
  void update(void Function(RealtimeBalanceEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeBalanceEvent build() => _build();

  _$RealtimeBalanceEvent _build() {
    _$RealtimeBalanceEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeBalanceEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeBalanceEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeBalanceEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeBalanceEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeBalanceEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
