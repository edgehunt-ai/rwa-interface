// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rail_portfolio_allocation_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RailPortfolioAllocationItem extends RailPortfolioAllocationItem {
  @override
  final ProductKind rail;
  @override
  final String valueUsd;
  @override
  final String percent;

  factory _$RailPortfolioAllocationItem(
          [void Function(RailPortfolioAllocationItemBuilder)? updates]) =>
      (RailPortfolioAllocationItemBuilder()..update(updates))._build();

  _$RailPortfolioAllocationItem._(
      {required this.rail, required this.valueUsd, required this.percent})
      : super._();
  @override
  RailPortfolioAllocationItem rebuild(
          void Function(RailPortfolioAllocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RailPortfolioAllocationItemBuilder toBuilder() =>
      RailPortfolioAllocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RailPortfolioAllocationItem &&
        rail == other.rail &&
        valueUsd == other.valueUsd &&
        percent == other.percent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RailPortfolioAllocationItem')
          ..add('rail', rail)
          ..add('valueUsd', valueUsd)
          ..add('percent', percent))
        .toString();
  }
}

class RailPortfolioAllocationItemBuilder
    implements
        Builder<RailPortfolioAllocationItem,
            RailPortfolioAllocationItemBuilder> {
  _$RailPortfolioAllocationItem? _$v;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  RailPortfolioAllocationItemBuilder() {
    RailPortfolioAllocationItem._defaults(this);
  }

  RailPortfolioAllocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rail = $v.rail;
      _valueUsd = $v.valueUsd;
      _percent = $v.percent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RailPortfolioAllocationItem other) {
    _$v = other as _$RailPortfolioAllocationItem;
  }

  @override
  void update(void Function(RailPortfolioAllocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RailPortfolioAllocationItem build() => _build();

  _$RailPortfolioAllocationItem _build() {
    final _$result = _$v ??
        _$RailPortfolioAllocationItem._(
          rail: BuiltValueNullFieldError.checkNotNull(
              rail, r'RailPortfolioAllocationItem', 'rail'),
          valueUsd: BuiltValueNullFieldError.checkNotNull(
              valueUsd, r'RailPortfolioAllocationItem', 'valueUsd'),
          percent: BuiltValueNullFieldError.checkNotNull(
              percent, r'RailPortfolioAllocationItem', 'percent'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
