// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_transfer_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeTransferEventEventEnum _$realtimeTransferEventEventEnum_transfer =
    const RealtimeTransferEventEventEnum._('transfer');
const RealtimeTransferEventEventEnum
    _$realtimeTransferEventEventEnum_unknownDefaultOpenApi =
    const RealtimeTransferEventEventEnum._('unknownDefaultOpenApi');

RealtimeTransferEventEventEnum _$realtimeTransferEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'transfer':
      return _$realtimeTransferEventEventEnum_transfer;
    case 'unknownDefaultOpenApi':
      return _$realtimeTransferEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeTransferEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeTransferEventEventEnum>
    _$realtimeTransferEventEventEnumValues = BuiltSet<
        RealtimeTransferEventEventEnum>(const <RealtimeTransferEventEventEnum>[
  _$realtimeTransferEventEventEnum_transfer,
  _$realtimeTransferEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeTransferEventEventEnum>
    _$realtimeTransferEventEventEnumSerializer =
    _$RealtimeTransferEventEventEnumSerializer();

class _$RealtimeTransferEventEventEnumSerializer
    implements PrimitiveSerializer<RealtimeTransferEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'transfer': 'transfer',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'transfer': 'transfer',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeTransferEventEventEnum];
  @override
  final String wireName = 'RealtimeTransferEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeTransferEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeTransferEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeTransferEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeTransferEvent extends RealtimeTransferEvent {
  @override
  final Transfer data;
  @override
  final RealtimeTransferEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$RealtimeTransferEvent(
          [void Function(RealtimeTransferEventBuilder)? updates]) =>
      (RealtimeTransferEventBuilder()..update(updates))._build();

  _$RealtimeTransferEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  RealtimeTransferEvent rebuild(
          void Function(RealtimeTransferEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeTransferEventBuilder toBuilder() =>
      RealtimeTransferEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeTransferEvent &&
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
    return (newBuiltValueToStringHelper(r'RealtimeTransferEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class RealtimeTransferEventBuilder
    implements
        Builder<RealtimeTransferEvent, RealtimeTransferEventBuilder>,
        RealtimeEventBaseBuilder {
  _$RealtimeTransferEvent? _$v;

  TransferBuilder? _data;
  TransferBuilder get data => _$this._data ??= TransferBuilder();
  set data(covariant TransferBuilder? data) => _$this._data = data;

  RealtimeTransferEventEventEnum? _event;
  RealtimeTransferEventEventEnum? get event => _$this._event;
  set event(covariant RealtimeTransferEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  RealtimeTransferEventBuilder() {
    RealtimeTransferEvent._defaults(this);
  }

  RealtimeTransferEventBuilder get _$this {
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
  void replace(covariant RealtimeTransferEvent other) {
    _$v = other as _$RealtimeTransferEvent;
  }

  @override
  void update(void Function(RealtimeTransferEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeTransferEvent build() => _build();

  _$RealtimeTransferEvent _build() {
    _$RealtimeTransferEvent _$result;
    try {
      _$result = _$v ??
          _$RealtimeTransferEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'RealtimeTransferEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'RealtimeTransferEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'RealtimeTransferEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeTransferEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
