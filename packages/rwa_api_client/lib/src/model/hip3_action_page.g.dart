// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_action_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3ActionPage extends Hip3ActionPage {
  @override
  final BuiltList<Hip3Action> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$Hip3ActionPage([void Function(Hip3ActionPageBuilder)? updates]) =>
      (Hip3ActionPageBuilder()..update(updates))._build();

  _$Hip3ActionPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  Hip3ActionPage rebuild(void Function(Hip3ActionPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ActionPageBuilder toBuilder() => Hip3ActionPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ActionPage &&
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
    return (newBuiltValueToStringHelper(r'Hip3ActionPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class Hip3ActionPageBuilder
    implements Builder<Hip3ActionPage, Hip3ActionPageBuilder>, PageBuilder {
  _$Hip3ActionPage? _$v;

  ListBuilder<Hip3Action>? _items;
  ListBuilder<Hip3Action> get items =>
      _$this._items ??= ListBuilder<Hip3Action>();
  set items(covariant ListBuilder<Hip3Action>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  Hip3ActionPageBuilder() {
    Hip3ActionPage._defaults(this);
  }

  Hip3ActionPageBuilder get _$this {
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
  void replace(covariant Hip3ActionPage other) {
    _$v = other as _$Hip3ActionPage;
  }

  @override
  void update(void Function(Hip3ActionPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ActionPage build() => _build();

  _$Hip3ActionPage _build() {
    _$Hip3ActionPage _$result;
    try {
      _$result = _$v ??
          _$Hip3ActionPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'Hip3ActionPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ActionPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
