// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_deposit_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeDepositEventEventEnum _$realtimeDepositEventEventEnum_deposit =
    const RealtimeDepositEventEventEnum._('deposit');
const RealtimeDepositEventEventEnum
    _$realtimeDepositEventEventEnum_unknownDefaultOpenApi =
    const RealtimeDepositEventEventEnum._('unknownDefaultOpenApi');

RealtimeDepositEventEventEnum _$realtimeDepositEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'deposit':
      return _$realtimeDepositEventEventEnum_deposit;
    case 'unknownDefaultOpenApi':
      return _$realtimeDepositEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeDepositEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeDepositEventEventEnum>
    _$realtimeDepositEventEventEnumValues = BuiltSet<
        RealtimeDepositEventEventEnum>(const <RealtimeDepositEventEventEnum>[
  _$realtimeDepositEventEventEnum_deposit,
  _$realtimeDepositEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeDepositEventEventEnum>
    _$realtimeDepositEventEventEnumSerializer =
    _$RealtimeDepositEventEventEnumSerializer();

class _$RealtimeDepositEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeDepositEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'deposit': 'deposit',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'deposit': 'deposit',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeDepositEventEventEnum];
  @override
  final String wireName = 'RealtimeDepositEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeDepositEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeDepositEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeDepositEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeDepositEvent extends RealtimeDepositEvent {
  @override
  final Deposit data;
  @override
  final RealtimeDepositEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeDepositEvent(
          [void Function(RealtimeDepositEventBuilder)? updates]) =>
      (RealtimeDepositEventBuilder()..update(updates))._build();

  _$RealtimeDepositEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeDepositEvent rebuild(
          void Function(RealtimeDepositEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeDepositEventBuilder toBuilder() =>
      RealtimeDepositEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeDepositEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeDepositEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeDepositEventBuilder
    implements
        Builder<RealtimeDepositEvent, RealtimeDepositEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeDepositEvent? _$v;

  DepositBuilder? _data;
  DepositBuilder get data => _$this._data ??= DepositBuilder();
  set data(covariant DepositBuilder? data) => _$this._data = data;

  RealtimeDepositEventEventEnum? _event;
  RealtimeDepositEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeDepositEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeDepositEventBuilder() {
    RealtimeDepositEvent._defaults(this);
  }

  RealtimeDepositEventBuilder get _$this {
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
  void replace(covariant RealtimeDepositEvent other) {
    _$v = other as _$RealtimeDepositEvent;
  }

  @override
  void update(void Function(RealtimeDepositEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeDepositEvent build() => _build();

  _$RealtimeDepositEvent _build() {
    _$RealtimeDepositEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeDepositEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeDepositEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeDepositEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeDepositEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeDepositEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
