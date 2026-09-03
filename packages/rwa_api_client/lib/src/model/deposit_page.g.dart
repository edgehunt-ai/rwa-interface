// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositPage extends DepositPage {
  @override
  final BuiltList<Deposit> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$DepositPage([void Function(DepositPageBuilder)? updates]) =>
      (DepositPageBuilder()..update(updates))._build();

  _$DepositPage._({required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  DepositPage rebuild(void Function(DepositPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositPageBuilder toBuilder() => DepositPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositPage &&
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
    return (newBuiltValueToStringHelper(r'DepositPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class DepositPageBuilder
    implements Builder<DepositPage, DepositPageBuilder>, PageBuilder {
  _$DepositPage? _$v;

  ListBuilder<Deposit>? _items;
  ListBuilder<Deposit> get items => _$this._items ??= ListBuilder<Deposit>();
  set items(covariant ListBuilder<Deposit>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  DepositPageBuilder() {
    DepositPage._defaults(this);
  }

  DepositPageBuilder get _$this {
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
  void replace(covariant DepositPage other) {
    _$v = other as _$DepositPage;
  }

  @override
  void update(void Function(DepositPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositPage build() => _build();

  _$DepositPage _build() {
    _$DepositPage _$result;
    try {
      _$result = _$v ??
          _$DepositPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'DepositPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
