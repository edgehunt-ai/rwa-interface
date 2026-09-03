// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_claim_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeClaimEventEventEnum _$realtimeClaimEventEventEnum_claim =
    const RealtimeClaimEventEventEnum._('claim');
const RealtimeClaimEventEventEnum
    _$realtimeClaimEventEventEnum_unknownDefaultOpenApi =
    const RealtimeClaimEventEventEnum._('unknownDefaultOpenApi');

RealtimeClaimEventEventEnum _$realtimeClaimEventEventEnumValueOf(String name) {
  switch (name) {
    case 'claim':
      return _$realtimeClaimEventEventEnum_claim;
    case 'unknownDefaultOpenApi':
      return _$realtimeClaimEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeClaimEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeClaimEventEventEnum>
    _$realtimeClaimEventEventEnumValues =
    BuiltSet<RealtimeClaimEventEventEnum>(const <RealtimeClaimEventEventEnum>[
  _$realtimeClaimEventEventEnum_claim,
  _$realtimeClaimEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeClaimEventEventEnum>
    _$realtimeClaimEventEventEnumSerializer =
    _$RealtimeClaimEventEventEnumSerializer();

class _$RealtimeClaimEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeClaimEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'claim': 'claim',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'claim': 'claim',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeClaimEventEventEnum];
  @override
  final String wireName = 'RealtimeClaimEventEventEnum';

  @override
  Object serialize(Serializers serializers, RealtimeClaimEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeClaimEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeClaimEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeClaimEvent extends RealtimeClaimEvent {
  @override
  final Claim data;
  @override
  final RealtimeClaimEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeClaimEvent(
          [void Function(RealtimeClaimEventBuilder)? updates]) =>
      (RealtimeClaimEventBuilder()..update(updates))._build();

  _$RealtimeClaimEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeClaimEvent rebuild(
          void Function(RealtimeClaimEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeClaimEventBuilder toBuilder() =>
      RealtimeClaimEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeClaimEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeClaimEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeClaimEventBuilder
    implements
        Builder<RealtimeClaimEvent, RealtimeClaimEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeClaimEvent? _$v;

  ClaimBuilder? _data;
  ClaimBuilder get data => _$this._data ??= ClaimBuilder();
  set data(covariant ClaimBuilder? data) => _$this._data = data;

  RealtimeClaimEventEventEnum? _event;
  RealtimeClaimEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeClaimEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeClaimEventBuilder() {
    RealtimeClaimEvent._defaults(this);
  }

  RealtimeClaimEventBuilder get _$this {
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
  void replace(covariant RealtimeClaimEvent other) {
    _$v = other as _$RealtimeClaimEvent;
  }

  @override
  void update(void Function(RealtimeClaimEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeClaimEvent build() => _build();

  _$RealtimeClaimEvent _build() {
    _$RealtimeClaimEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeClaimEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeClaimEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeClaimEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeClaimEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeClaimEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
