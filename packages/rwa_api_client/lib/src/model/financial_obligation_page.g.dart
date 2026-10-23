// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_obligation_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialObligationPage extends FinancialObligationPage {
  @override
  final BuiltList<FinancialObligation> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$FinancialObligationPage(
          [void Function(FinancialObligationPageBuilder)? updates]) =>
      (FinancialObligationPageBuilder()..update(updates))._build();

  _$FinancialObligationPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  FinancialObligationPage rebuild(
          void Function(FinancialObligationPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialObligationPageBuilder toBuilder() =>
      FinancialObligationPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialObligationPage &&
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
    return (newBuiltValueToStringHelper(r'FinancialObligationPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class FinancialObligationPageBuilder
    implements
        Builder<FinancialObligationPage, FinancialObligationPageBuilder>,
        PageBuilder {
  _$FinancialObligationPage? _$v;

  ListBuilder<FinancialObligation>? _items;
  ListBuilder<FinancialObligation> get items =>
      _$this._items ??= ListBuilder<FinancialObligation>();
  set items(covariant ListBuilder<FinancialObligation>? items) =>
      _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  FinancialObligationPageBuilder() {
    FinancialObligationPage._defaults(this);
  }

  FinancialObligationPageBuilder get _$this {
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
  void replace(covariant FinancialObligationPage other) {
    _$v = other as _$FinancialObligationPage;
  }

  @override
  void update(void Function(FinancialObligationPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialObligationPage build() => _build();

  _$FinancialObligationPage _build() {
    _$FinancialObligationPage _$result;
    try {
      _$result = _$v ??
          _$FinancialObligationPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'FinancialObligationPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinancialObligationPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
