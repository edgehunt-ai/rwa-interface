// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3RealtimeSnapshot extends Hip3RealtimeSnapshot {
  @override
  final BuiltSet<String> channels;
  @override
  final String signer;
  @override
  final Hip3Environment environment;
  @override
  final DateTime completedAt;
  @override
  final BuiltList<Hip3RealtimeSnapshotItem> items;

  factory _$Hip3RealtimeSnapshot(
          [void Function(Hip3RealtimeSnapshotBuilder)? updates]) =>
      (Hip3RealtimeSnapshotBuilder()..update(updates))._build();

  _$Hip3RealtimeSnapshot._(
      {required this.channels,
      required this.signer,
      required this.environment,
      required this.completedAt,
      required this.items})
      : super._();
  @override
  Hip3RealtimeSnapshot rebuild(
          void Function(Hip3RealtimeSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeSnapshotBuilder toBuilder() =>
      Hip3RealtimeSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeSnapshot &&
        channels == other.channels &&
        signer == other.signer &&
        environment == other.environment &&
        completedAt == other.completedAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, channels.hashCode);
    _$hash = $jc(_$hash, signer.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3RealtimeSnapshot')
          ..add('channels', channels)
          ..add('signer', signer)
          ..add('environment', environment)
          ..add('completedAt', completedAt)
          ..add('items', items))
        .toString();
  }
}

class Hip3RealtimeSnapshotBuilder
    implements Builder<Hip3RealtimeSnapshot, Hip3RealtimeSnapshotBuilder> {
  _$Hip3RealtimeSnapshot? _$v;

  SetBuilder<String>? _channels;
  SetBuilder<String> get channels => _$this._channels ??= SetBuilder<String>();
  set channels(SetBuilder<String>? channels) => _$this._channels = channels;

  String? _signer;
  String? get signer => _$this._signer;
  set signer(String? signer) => _$this._signer = signer;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  ListBuilder<Hip3RealtimeSnapshotItem>? _items;
  ListBuilder<Hip3RealtimeSnapshotItem> get items =>
      _$this._items ??= ListBuilder<Hip3RealtimeSnapshotItem>();
  set items(ListBuilder<Hip3RealtimeSnapshotItem>? items) =>
      _$this._items = items;

  Hip3RealtimeSnapshotBuilder() {
    Hip3RealtimeSnapshot._defaults(this);
  }

  Hip3RealtimeSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _channels = $v.channels.toBuilder();
      _signer = $v.signer;
      _environment = $v.environment;
      _completedAt = $v.completedAt;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3RealtimeSnapshot other) {
    _$v = other as _$Hip3RealtimeSnapshot;
  }

  @override
  void update(void Function(Hip3RealtimeSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeSnapshot build() => _build();

  _$Hip3RealtimeSnapshot _build() {
    _$Hip3RealtimeSnapshot _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeSnapshot._(
            channels: channels.build(),
            signer: BuiltValueNullFieldError.checkNotNull(
                signer, r'Hip3RealtimeSnapshot', 'signer'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3RealtimeSnapshot', 'environment'),
            completedAt: BuiltValueNullFieldError.checkNotNull(
                completedAt, r'Hip3RealtimeSnapshot', 'completedAt'),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'channels';
        channels.build();

        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
