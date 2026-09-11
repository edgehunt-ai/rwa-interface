// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_observation_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositObservationPage extends DepositObservationPage {
  @override
  final BuiltList<DepositObservation> items;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$DepositObservationPage(
          [void Function(DepositObservationPageBuilder)? updates]) =>
      (DepositObservationPageBuilder()..update(updates))._build();

  _$DepositObservationPage._(
      {required this.items, this.nextCursor, required this.hasMore})
      : super._();
  @override
  DepositObservationPage rebuild(
          void Function(DepositObservationPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositObservationPageBuilder toBuilder() =>
      DepositObservationPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositObservationPage &&
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
    return (newBuiltValueToStringHelper(r'DepositObservationPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class DepositObservationPageBuilder
    implements Builder<DepositObservationPage, DepositObservationPageBuilder> {
  _$DepositObservationPage? _$v;

  ListBuilder<DepositObservation>? _items;
  ListBuilder<DepositObservation> get items =>
      _$this._items ??= ListBuilder<DepositObservation>();
  set items(ListBuilder<DepositObservation>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  DepositObservationPageBuilder() {
    DepositObservationPage._defaults(this);
  }

  DepositObservationPageBuilder get _$this {
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
  void replace(DepositObservationPage other) {
    _$v = other as _$DepositObservationPage;
  }

  @override
  void update(void Function(DepositObservationPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositObservationPage build() => _build();

  _$DepositObservationPage _build() {
    _$DepositObservationPage _$result;
    try {
      _$result = _$v ??
          _$DepositObservationPage._(
            items: items.build(),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'DepositObservationPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DepositObservationPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
