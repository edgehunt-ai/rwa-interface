// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_account_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioAccountAllocation extends PortfolioAccountAllocation {
  @override
  final BuiltList<PortfolioAccountAllocationItem> items;
  @override
  final String valuedTotalUsd;

  factory _$PortfolioAccountAllocation(
          [void Function(PortfolioAccountAllocationBuilder)? updates]) =>
      (PortfolioAccountAllocationBuilder()..update(updates))._build();

  _$PortfolioAccountAllocation._(
      {required this.items, required this.valuedTotalUsd})
      : super._();
  @override
  PortfolioAccountAllocation rebuild(
          void Function(PortfolioAccountAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAccountAllocationBuilder toBuilder() =>
      PortfolioAccountAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAccountAllocation &&
        items == other.items &&
        valuedTotalUsd == other.valuedTotalUsd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, valuedTotalUsd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAccountAllocation')
          ..add('items', items)
          ..add('valuedTotalUsd', valuedTotalUsd))
        .toString();
  }
}

class PortfolioAccountAllocationBuilder
    implements
        Builder<PortfolioAccountAllocation, PortfolioAccountAllocationBuilder> {
  _$PortfolioAccountAllocation? _$v;

  ListBuilder<PortfolioAccountAllocationItem>? _items;
  ListBuilder<PortfolioAccountAllocationItem> get items =>
      _$this._items ??= ListBuilder<PortfolioAccountAllocationItem>();
  set items(ListBuilder<PortfolioAccountAllocationItem>? items) =>
      _$this._items = items;

  String? _valuedTotalUsd;
  String? get valuedTotalUsd => _$this._valuedTotalUsd;
  set valuedTotalUsd(String? valuedTotalUsd) =>
      _$this._valuedTotalUsd = valuedTotalUsd;

  PortfolioAccountAllocationBuilder() {
    PortfolioAccountAllocation._defaults(this);
  }

  PortfolioAccountAllocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _valuedTotalUsd = $v.valuedTotalUsd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAccountAllocation other) {
    _$v = other as _$PortfolioAccountAllocation;
  }

  @override
  void update(void Function(PortfolioAccountAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAccountAllocation build() => _build();

  _$PortfolioAccountAllocation _build() {
    _$PortfolioAccountAllocation _$result;
    try {
      _$result = _$v ??
          _$PortfolioAccountAllocation._(
            items: items.build(),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd,
                r'PortfolioAccountAllocation',
                'valuedTotalUsd'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAccountAllocation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
