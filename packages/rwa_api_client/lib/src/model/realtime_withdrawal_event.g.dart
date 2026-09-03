// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_withdrawal_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeWithdrawalEventEventEnum
    _$realtimeWithdrawalEventEventEnum_withdrawal =
    const RealtimeWithdrawalEventEventEnum._('withdrawal');
const RealtimeWithdrawalEventEventEnum
    _$realtimeWithdrawalEventEventEnum_unknownDefaultOpenApi =
    const RealtimeWithdrawalEventEventEnum._('unknownDefaultOpenApi');

RealtimeWithdrawalEventEventEnum _$realtimeWithdrawalEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'withdrawal':
      return _$realtimeWithdrawalEventEventEnum_withdrawal;
    case 'unknownDefaultOpenApi':
      return _$realtimeWithdrawalEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeWithdrawalEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeWithdrawalEventEventEnum>
    _$realtimeWithdrawalEventEventEnumValues = BuiltSet<
        RealtimeWithdrawalEventEventEnum>(const <RealtimeWithdrawalEventEventEnum>[
  _$realtimeWithdrawalEventEventEnum_withdrawal,
  _$realtimeWithdrawalEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeWithdrawalEventEventEnum>
    _$realtimeWithdrawalEventEventEnumSerializer =
    _$RealtimeWithdrawalEventEventEnumSerializer();

class _$RealtimeWithdrawalEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeWithdrawalEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'withdrawal': 'withdrawal',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'withdrawal': 'withdrawal',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeWithdrawalEventEventEnum];
  @override
  final String wireName = 'RealtimeWithdrawalEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeWithdrawalEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeWithdrawalEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeWithdrawalEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeWithdrawalEvent extends RealtimeWithdrawalEvent {
  @override
  final Withdrawal data;
  @override
  final RealtimeWithdrawalEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeWithdrawalEvent(
          [void Function(RealtimeWithdrawalEventBuilder)? updates]) =>
      (RealtimeWithdrawalEventBuilder()..update(updates))._build();

  _$RealtimeWithdrawalEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeWithdrawalEvent rebuild(
          void Function(RealtimeWithdrawalEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeWithdrawalEventBuilder toBuilder() =>
      RealtimeWithdrawalEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeWithdrawalEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeWithdrawalEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeWithdrawalEventBuilder
    implements
        Builder<RealtimeWithdrawalEvent, RealtimeWithdrawalEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeWithdrawalEvent? _$v;

  WithdrawalBuilder? _data;
  WithdrawalBuilder get data => _$this._data ??= WithdrawalBuilder();
  set data(covariant WithdrawalBuilder? data) => _$this._data = data;

  RealtimeWithdrawalEventEventEnum? _event;
  RealtimeWithdrawalEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeWithdrawalEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeWithdrawalEventBuilder() {
    RealtimeWithdrawalEvent._defaults(this);
  }

  RealtimeWithdrawalEventBuilder get _$this {
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
  void replace(covariant RealtimeWithdrawalEvent other) {
    _$v = other as _$RealtimeWithdrawalEvent;
  }

  @override
  void update(void Function(RealtimeWithdrawalEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeWithdrawalEvent build() => _build();

  _$RealtimeWithdrawalEvent _build() {
    _$RealtimeWithdrawalEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeWithdrawalEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeWithdrawalEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeWithdrawalEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeWithdrawalEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeWithdrawalEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
