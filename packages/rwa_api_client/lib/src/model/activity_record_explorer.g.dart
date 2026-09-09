// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record_explorer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityRecordExplorer extends ActivityRecordExplorer {
  @override
  final String name;
  @override
  final String url;

  factory _$ActivityRecordExplorer(
          [void Function(ActivityRecordExplorerBuilder)? updates]) =>
      (ActivityRecordExplorerBuilder()..update(updates))._build();

  _$ActivityRecordExplorer._({required this.name, required this.url})
      : super._();
  @override
  ActivityRecordExplorer rebuild(
          void Function(ActivityRecordExplorerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityRecordExplorerBuilder toBuilder() =>
      ActivityRecordExplorerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityRecordExplorer &&
        name == other.name &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityRecordExplorer')
          ..add('name', name)
          ..add('url', url))
        .toString();
  }
}

class ActivityRecordExplorerBuilder
    implements Builder<ActivityRecordExplorer, ActivityRecordExplorerBuilder> {
  _$ActivityRecordExplorer? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ActivityRecordExplorerBuilder() {
    ActivityRecordExplorer._defaults(this);
  }

  ActivityRecordExplorerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityRecordExplorer other) {
    _$v = other as _$ActivityRecordExplorer;
  }

  @override
  void update(void Function(ActivityRecordExplorerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityRecordExplorer build() => _build();

  _$ActivityRecordExplorer _build() {
    final _$result = _$v ??
        _$ActivityRecordExplorer._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'ActivityRecordExplorer', 'name'),
          url: BuiltValueNullFieldError.checkNotNull(
              url, r'ActivityRecordExplorer', 'url'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
