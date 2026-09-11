// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resource_changed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RealtimeResourceChanged extends RealtimeResourceChanged {
  @override
  final RealtimePrivateChannel channel;
  @override
  final RealtimeResourceType resourceType;
  @override
  final String resourceId;
  @override
  final RealtimeResourceChange change;
  @override
  final String resourceVersion;

  factory _$RealtimeResourceChanged(
          [void Function(RealtimeResourceChangedBuilder)? updates]) =>
      (RealtimeResourceChangedBuilder()..update(updates))._build();

  _$RealtimeResourceChanged._(
      {required this.channel,
      required this.resourceType,
      required this.resourceId,
      required this.change,
      required this.resourceVersion})
      : super._();
  @override
  RealtimeResourceChanged rebuild(
          void Function(RealtimeResourceChangedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeResourceChangedBuilder toBuilder() =>
      RealtimeResourceChangedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeResourceChanged &&
        channel == other.channel &&
        resourceType == other.resourceType &&
        resourceId == other.resourceId &&
        change == other.change &&
        resourceVersion == other.resourceVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, channel.hashCode);
    _$hash = $jc(_$hash, resourceType.hashCode);
    _$hash = $jc(_$hash, resourceId.hashCode);
    _$hash = $jc(_$hash, change.hashCode);
    _$hash = $jc(_$hash, resourceVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RealtimeResourceChanged')
          ..add('channel', channel)
          ..add('resourceType', resourceType)
          ..add('resourceId', resourceId)
          ..add('change', change)
          ..add('resourceVersion', resourceVersion))
        .toString();
  }
}

class RealtimeResourceChangedBuilder
    implements
        Builder<RealtimeResourceChanged, RealtimeResourceChangedBuilder> {
  _$RealtimeResourceChanged? _$v;

  RealtimePrivateChannel? _channel;
  RealtimePrivateChannel? get channel => _$this._channel;
  set channel(RealtimePrivateChannel? channel) => _$this._channel = channel;

  RealtimeResourceType? _resourceType;
  RealtimeResourceType? get resourceType => _$this._resourceType;
  set resourceType(RealtimeResourceType? resourceType) =>
      _$this._resourceType = resourceType;

  String? _resourceId;
  String? get resourceId => _$this._resourceId;
  set resourceId(String? resourceId) => _$this._resourceId = resourceId;

  RealtimeResourceChange? _change;
  RealtimeResourceChange? get change => _$this._change;
  set change(RealtimeResourceChange? change) => _$this._change = change;

  String? _resourceVersion;
  String? get resourceVersion => _$this._resourceVersion;
  set resourceVersion(String? resourceVersion) =>
      _$this._resourceVersion = resourceVersion;

  RealtimeResourceChangedBuilder() {
    RealtimeResourceChanged._defaults(this);
  }

  RealtimeResourceChangedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _channel = $v.channel;
      _resourceType = $v.resourceType;
      _resourceId = $v.resourceId;
      _change = $v.change;
      _resourceVersion = $v.resourceVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RealtimeResourceChanged other) {
    _$v = other as _$RealtimeResourceChanged;
  }

  @override
  void update(void Function(RealtimeResourceChangedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeResourceChanged build() => _build();

  _$RealtimeResourceChanged _build() {
    final _$result = _$v ??
        _$RealtimeResourceChanged._(
          channel: BuiltValueNullFieldError.checkNotNull(
              channel, r'RealtimeResourceChanged', 'channel'),
          resourceType: BuiltValueNullFieldError.checkNotNull(
              resourceType, r'RealtimeResourceChanged', 'resourceType'),
          resourceId: BuiltValueNullFieldError.checkNotNull(
              resourceId, r'RealtimeResourceChanged', 'resourceId'),
          change: BuiltValueNullFieldError.checkNotNull(
              change, r'RealtimeResourceChanged', 'change'),
          resourceVersion: BuiltValueNullFieldError.checkNotNull(
              resourceVersion, r'RealtimeResourceChanged', 'resourceVersion'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
