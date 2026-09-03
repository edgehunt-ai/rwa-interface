// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_event_base.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class RealtimeEventBaseBuilder {
  void replace(RealtimeEventBase other);
  void update(void Function(RealtimeEventBaseBuilder) updates);
  String? get eventId;
  set eventId(String? eventId);

  DateTime? get emittedAt;
  set emittedAt(DateTime? emittedAt);
}

class _$$RealtimeEventBase extends $RealtimeEventBase {
  @override
  final String eventId;
  @override
  final DateTime emittedAt;

  factory _$$RealtimeEventBase(
          [void Function($RealtimeEventBaseBuilder)? updates]) =>
      ($RealtimeEventBaseBuilder()..update(updates))._build();

  _$$RealtimeEventBase._({required this.eventId, required this.emittedAt})
      : super._();
  @override
  $RealtimeEventBase rebuild(
          void Function($RealtimeEventBaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $RealtimeEventBaseBuilder toBuilder() =>
      $RealtimeEventBaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $RealtimeEventBase &&
        eventId == other.eventId &&
        emittedAt == other.emittedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, eventId.hashCode);
    _$hash = $jc(_$hash, emittedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$RealtimeEventBase')
          ..add('eventId', eventId)
          ..add('emittedAt', emittedAt))
        .toString();
  }
}

class $RealtimeEventBaseBuilder
    implements
        Builder<$RealtimeEventBase, $RealtimeEventBaseBuilder>,
        RealtimeEventBaseBuilder {
  _$$RealtimeEventBase? _$v;

  String? _eventId;
  String? get eventId => _$this._eventId;
  set eventId(covariant String? eventId) => _$this._eventId = eventId;

  DateTime? _emittedAt;
  DateTime? get emittedAt => _$this._emittedAt;
  set emittedAt(covariant DateTime? emittedAt) => _$this._emittedAt = emittedAt;

  $RealtimeEventBaseBuilder() {
    $RealtimeEventBase._defaults(this);
  }

  $RealtimeEventBaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventId = $v.eventId;
      _emittedAt = $v.emittedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $RealtimeEventBase other) {
    _$v = other as _$$RealtimeEventBase;
  }

  @override
  void update(void Function($RealtimeEventBaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $RealtimeEventBase build() => _build();

  _$$RealtimeEventBase _build() {
    final _$result = _$v ??
        _$$RealtimeEventBase._(
          eventId: BuiltValueNullFieldError.checkNotNull(
              eventId, r'$RealtimeEventBase', 'eventId'),
          emittedAt: BuiltValueNullFieldError.checkNotNull(
              emittedAt, r'$RealtimeEventBase', 'emittedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
