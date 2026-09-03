// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WithdrawalPage extends WithdrawalPage {
  @override
  final BuiltList<Withdrawal> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$WithdrawalPage([void Function(WithdrawalPageBuilder)? updates]) =>
      (WithdrawalPageBuilder()..update(updates))._build();

  _$WithdrawalPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  WithdrawalPage rebuild(void Function(WithdrawalPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalPageBuilder toBuilder() => WithdrawalPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WithdrawalPage &&
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
    return (newBuiltValueToStringHelper(r'WithdrawalPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class WithdrawalPageBuilder
    implements Builder<WithdrawalPage, WithdrawalPageBuilder>, PageBuilder {
  _$WithdrawalPage? _$v;

  ListBuilder<Withdrawal>? _items;
  ListBuilder<Withdrawal> get items =>
      _$this._items ??= ListBuilder<Withdrawal>();
  set items(covariant ListBuilder<Withdrawal>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  WithdrawalPageBuilder() {
    WithdrawalPage._defaults(this);
  }

  WithdrawalPageBuilder get _$this {
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
  void replace(covariant WithdrawalPage other) {
    _$v = other as _$WithdrawalPage;
  }

  @override
  void update(void Function(WithdrawalPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WithdrawalPage build() => _build();

  _$WithdrawalPage _build() {
    _$WithdrawalPage _$result;
    try {
      _$result = _$v ??
          _$WithdrawalPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'WithdrawalPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WithdrawalPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
