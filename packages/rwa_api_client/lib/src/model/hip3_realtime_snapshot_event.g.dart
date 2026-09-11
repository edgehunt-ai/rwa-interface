// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_snapshot_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeSnapshotEventEventEnum
    _$hip3RealtimeSnapshotEventEventEnum_hip3Snapshot =
    const Hip3RealtimeSnapshotEventEventEnum._('hip3Snapshot');
const Hip3RealtimeSnapshotEventEventEnum
    _$hip3RealtimeSnapshotEventEventEnum_unknownDefaultOpenApi =
    const Hip3RealtimeSnapshotEventEventEnum._('unknownDefaultOpenApi');

Hip3RealtimeSnapshotEventEventEnum _$hip3RealtimeSnapshotEventEventEnumValueOf(
    String name) {
  switch (name) {
    case 'hip3Snapshot':
      return _$hip3RealtimeSnapshotEventEventEnum_hip3Snapshot;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeSnapshotEventEventEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeSnapshotEventEventEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeSnapshotEventEventEnum>
    _$hip3RealtimeSnapshotEventEventEnumValues = BuiltSet<
        Hip3RealtimeSnapshotEventEventEnum>(const <Hip3RealtimeSnapshotEventEventEnum>[
  _$hip3RealtimeSnapshotEventEventEnum_hip3Snapshot,
  _$hip3RealtimeSnapshotEventEventEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeSnapshotEventEventEnum>
    _$hip3RealtimeSnapshotEventEventEnumSerializer =
    _$Hip3RealtimeSnapshotEventEventEnumSerializer();

class _$Hip3RealtimeSnapshotEventEventEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeSnapshotEventEventEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hip3Snapshot': 'hip3_snapshot',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hip3_snapshot': 'hip3Snapshot',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeSnapshotEventEventEnum];
  @override
  final String wireName = 'Hip3RealtimeSnapshotEventEventEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeSnapshotEventEventEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeSnapshotEventEventEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeSnapshotEventEventEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeSnapshotEvent extends Hip3RealtimeSnapshotEvent {
  @override
  final Hip3RealtimeSnapshot data;
  @override
  final Hip3RealtimeSnapshotEventEventEnum event;
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$Hip3RealtimeSnapshotEvent(
          [void Function(Hip3RealtimeSnapshotEventBuilder)? updates]) =>
      (Hip3RealtimeSnapshotEventBuilder()..update(updates))._build();

  _$Hip3RealtimeSnapshotEvent._(
      {required this.data,
      required this.event,
      required this.eventId,
      required this.emittedAt})
      : super._();
  @override
  Hip3RealtimeSnapshotEvent rebuild(
          void Function(Hip3RealtimeSnapshotEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeSnapshotEventBuilder toBuilder() =>
      Hip3RealtimeSnapshotEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeSnapshotEvent &&
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
    return (newBuiltValueToStringHelper(r'Hip3RealtimeSnapshotEvent')
          ..add('data', data)
          ..add('event', event)
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class Hip3RealtimeSnapshotEventBuilder
    implements
        Builder<Hip3RealtimeSnapshotEvent, Hip3RealtimeSnapshotEventBuilder>,
        RealtimeEventBaseBuilder {
  _$Hip3RealtimeSnapshotEvent? _$v;

  Hip3RealtimeSnapshotBuilder? _data;
  Hip3RealtimeSnapshotBuilder get data =>
      _$this._data ??= Hip3RealtimeSnapshotBuilder();
  set data(covariant Hip3RealtimeSnapshotBuilder? data) => _$this._data = data;

  Hip3RealtimeSnapshotEventEventEnum? _event;
  Hip3RealtimeSnapshotEventEventEnum? get event => _$this._event;
  set event(covariant Hip3RealtimeSnapshotEventEventEnum? event) =>
      _$this._event = event;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  Hip3RealtimeSnapshotEventBuilder() {
    Hip3RealtimeSnapshotEvent._defaults(this);
  }

  Hip3RealtimeSnapshotEventBuilder get _$this {
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
  void replace(covariant Hip3RealtimeSnapshotEvent other) {
    _$v = other as _$Hip3RealtimeSnapshotEvent;
  }

  @override
  void update(void Function(Hip3RealtimeSnapshotEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeSnapshotEvent build() => _build();

  _$Hip3RealtimeSnapshotEvent _build() {
    _$Hip3RealtimeSnapshotEvent _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeSnapshotEvent._(
            data: data.build(),
            event: BuiltValueNullFieldError.checkNotNull(
                event, r'Hip3RealtimeSnapshotEvent', 'event'),
            eventId: BuiltValueNullFieldError.checkNotNull(
                eventId, r'Hip3RealtimeSnapshotEvent', 'eventId'),
            emittedAt: BuiltValueNullFieldError.checkNotNull(
                emittedAt, r'Hip3RealtimeSnapshotEvent', 'emittedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeSnapshotEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
