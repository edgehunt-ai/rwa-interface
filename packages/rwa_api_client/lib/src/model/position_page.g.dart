// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PositionPage extends PositionPage {
  @override
  final BuiltList<Position> items;
  @override
  final String? totalValueUsd;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$PositionPage([void Function(PositionPageBuilder)? updates]) =>
      (PositionPageBuilder()..update(updates))._build();

  _$PositionPage._(
      {required this.items,
      this.totalValueUsd,
      this.nextCursor,
      required this.hasMore})
      : super._();
  @override
  PositionPage rebuild(void Function(PositionPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionPageBuilder toBuilder() => PositionPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PositionPage &&
        items == other.items &&
        totalValueUsd == other.totalValueUsd &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PositionPage')
          ..add('items', items)
          ..add('totalValueUsd', totalValueUsd)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class PositionPageBuilder
    implements Builder<PositionPage, PositionPageBuilder>, PageBuilder {
  _$PositionPage? _$v;

  ListBuilder<Position>? _items;
  ListBuilder<Position> get items => _$this._items ??= ListBuilder<Position>();
  set items(covariant ListBuilder<Position>? items) => _$this._items = items;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(covariant String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  PositionPageBuilder() {
    PositionPage._defaults(this);
  }

  PositionPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _totalValueUsd = $v.totalValueUsd;
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PositionPage other) {
    _$v = other as _$PositionPage;
  }

  @override
  void update(void Function(PositionPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PositionPage build() => _build();

  _$PositionPage _build() {
    _$PositionPage _$result;
    try {
      _$result = _$v ??
          _$PositionPage._(
            items: items.build(),
            totalValueUsd: totalValueUsd,
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'PositionPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PositionPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
