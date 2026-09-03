// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssetInfo extends AssetInfo {
  @override
  final String title;
  @override
  final String badge;
  @override
  final String description;
  @override
  final BuiltList<KeyValue> rows;

  factory _$AssetInfo([void Function(AssetInfoBuilder)? updates]) =>
      (AssetInfoBuilder()..update(updates))._build();

  _$AssetInfo._(
      {required this.title,
      required this.badge,
      required this.description,
      required this.rows})
      : super._();
  @override
  AssetInfo rebuild(void Function(AssetInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetInfoBuilder toBuilder() => AssetInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetInfo &&
        title == other.title &&
        badge == other.badge &&
        description == other.description &&
        rows == other.rows;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, badge.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, rows.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetInfo')
          ..add('title', title)
          ..add('badge', badge)
          ..add('description', description)
          ..add('rows', rows))
        .toString();
  }
}

class AssetInfoBuilder implements Builder<AssetInfo, AssetInfoBuilder> {
  _$AssetInfo? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _badge;
  String? get badge => _$this._badge;
  set badge(String? badge) => _$this._badge = badge;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<KeyValue>? _rows;
  ListBuilder<KeyValue> get rows => _$this._rows ??= ListBuilder<KeyValue>();
  set rows(ListBuilder<KeyValue>? rows) => _$this._rows = rows;

  AssetInfoBuilder() {
    AssetInfo._defaults(this);
  }

  AssetInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _badge = $v.badge;
      _description = $v.description;
      _rows = $v.rows.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetInfo other) {
    _$v = other as _$AssetInfo;
  }

  @override
  void update(void Function(AssetInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetInfo build() => _build();

  _$AssetInfo _build() {
    _$AssetInfo _$result;
    try {
      _$result = _$v ??
          _$AssetInfo._(
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'AssetInfo', 'title'),
            badge: BuiltValueNullFieldError.checkNotNull(
                badge, r'AssetInfo', 'badge'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'AssetInfo', 'description'),
            rows: rows.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rows';
        rows.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AssetInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
