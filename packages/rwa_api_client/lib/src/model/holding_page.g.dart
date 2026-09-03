// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HoldingPage extends HoldingPage {
  @override
  final BuiltList<HoldingGroup> items;
  @override
  final String totalValueUsd;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$HoldingPage([void Function(HoldingPageBuilder)? updates]) =>
      (HoldingPageBuilder()..update(updates))._build();

  _$HoldingPage._(
      {required this.items,
      required this.totalValueUsd,
      this.nextCursor,
      required this.hasMore})
      : super._();
  @override
  HoldingPage rebuild(void Function(HoldingPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HoldingPageBuilder toBuilder() => HoldingPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HoldingPage &&
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
    return (newBuiltValueToStringHelper(r'HoldingPage')
          ..add('items', items)
          ..add('totalValueUsd', totalValueUsd)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class HoldingPageBuilder
    implements Builder<HoldingPage, HoldingPageBuilder>, PageBuilder {
  _$HoldingPage? _$v;

  ListBuilder<HoldingGroup>? _items;
  ListBuilder<HoldingGroup> get items =>
      _$this._items ??= ListBuilder<HoldingGroup>();
  set items(covariant ListBuilder<HoldingGroup>? items) =>
      _$this._items = items;

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

  HoldingPageBuilder() {
    HoldingPage._defaults(this);
  }

  HoldingPageBuilder get _$this {
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
  void replace(covariant HoldingPage other) {
    _$v = other as _$HoldingPage;
  }

  @override
  void update(void Function(HoldingPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HoldingPage build() => _build();

  _$HoldingPage _build() {
    _$HoldingPage _$result;
    try {
      _$result = _$v ??
          _$HoldingPage._(
            items: items.build(),
            totalValueUsd: BuiltValueNullFieldError.checkNotNull(
                totalValueUsd, r'HoldingPage', 'totalValueUsd'),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'HoldingPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HoldingPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
