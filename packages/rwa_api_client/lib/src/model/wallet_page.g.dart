// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WalletPage extends WalletPage {
  @override
  final BuiltList<Wallet> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$WalletPage([void Function(WalletPageBuilder)? updates]) =>
      (WalletPageBuilder()..update(updates))._build();

  _$WalletPage._({required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  WalletPage rebuild(void Function(WalletPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletPageBuilder toBuilder() => WalletPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletPage &&
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
    return (newBuiltValueToStringHelper(r'WalletPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class WalletPageBuilder
    implements Builder<WalletPage, WalletPageBuilder>, PageBuilder {
  _$WalletPage? _$v;

  ListBuilder<Wallet>? _items;
  ListBuilder<Wallet> get items => _$this._items ??= ListBuilder<Wallet>();
  set items(covariant ListBuilder<Wallet>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  WalletPageBuilder() {
    WalletPage._defaults(this);
  }

  WalletPageBuilder get _$this {
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
  void replace(covariant WalletPage other) {
    _$v = other as _$WalletPage;
  }

  @override
  void update(void Function(WalletPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletPage build() => _build();

  _$WalletPage _build() {
    _$WalletPage _$result;
    try {
      _$result = _$v ??
          _$WalletPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'WalletPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WalletPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
