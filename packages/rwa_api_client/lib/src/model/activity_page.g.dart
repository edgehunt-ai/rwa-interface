// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityPage extends ActivityPage {
  @override
  final BuiltList<ActivityRecord> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$ActivityPage([void Function(ActivityPageBuilder)? updates]) =>
      (ActivityPageBuilder()..update(updates))._build();

  _$ActivityPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  ActivityPage rebuild(void Function(ActivityPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityPageBuilder toBuilder() => ActivityPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityPage &&
        items == other.items &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class ActivityPageBuilder
    implements Builder<ActivityPage, ActivityPageBuilder>, PageBuilder {
  _$ActivityPage? _$v;

  ListBuilder<ActivityRecord>? _items;
  ListBuilder<ActivityRecord> get items =>
      _$this._items ??= ListBuilder<ActivityRecord>();
  set items(covariant ListBuilder<ActivityRecord>? items) =>
      _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  ActivityPageBuilder() {
    ActivityPage._defaults(this);
  }

  ActivityPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant ActivityPage other) {
    _$v = other as _$ActivityPage;
  }

  @override
  void update(void Function(ActivityPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityPage build() => _build();

  _$ActivityPage _build() {
    _$ActivityPage _$result;
    try {
      _$result = _$v ??
          _$ActivityPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'ActivityPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ActivityPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
