// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_supported_token_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksSupportedTokenPage extends BstocksSupportedTokenPage {
  @override
  final BuiltList<BstocksSupportedToken> items;

  factory _$BstocksSupportedTokenPage(
          [void Function(BstocksSupportedTokenPageBuilder)? updates]) =>
      (BstocksSupportedTokenPageBuilder()..update(updates))._build();

  _$BstocksSupportedTokenPage._({required this.items}) : super._();
  @override
  BstocksSupportedTokenPage rebuild(
          void Function(BstocksSupportedTokenPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksSupportedTokenPageBuilder toBuilder() =>
      BstocksSupportedTokenPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksSupportedTokenPage && items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksSupportedTokenPage')
          ..add('items', items))
        .toString();
  }
}

class BstocksSupportedTokenPageBuilder
    implements
        Builder<BstocksSupportedTokenPage, BstocksSupportedTokenPageBuilder> {
  _$BstocksSupportedTokenPage? _$v;

  ListBuilder<BstocksSupportedToken>? _items;
  ListBuilder<BstocksSupportedToken> get items =>
      _$this._items ??= ListBuilder<BstocksSupportedToken>();
  set items(ListBuilder<BstocksSupportedToken>? items) => _$this._items = items;

  BstocksSupportedTokenPageBuilder() {
    BstocksSupportedTokenPage._defaults(this);
  }

  BstocksSupportedTokenPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksSupportedTokenPage other) {
    _$v = other as _$BstocksSupportedTokenPage;
  }

  @override
  void update(void Function(BstocksSupportedTokenPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksSupportedTokenPage build() => _build();

  _$BstocksSupportedTokenPage _build() {
    _$BstocksSupportedTokenPage _$result;
    try {
      _$result = _$v ??
          _$BstocksSupportedTokenPage._(
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksSupportedTokenPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
