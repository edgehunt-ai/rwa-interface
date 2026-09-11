// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_portfolio_allocation_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssetPortfolioAllocationItem extends AssetPortfolioAllocationItem {
  @override
  final String assetId;
  @override
  final String symbol;
  @override
  final String valueUsd;
  @override
  final String percent;

  factory _$AssetPortfolioAllocationItem(
          [void Function(AssetPortfolioAllocationItemBuilder)? updates]) =>
      (AssetPortfolioAllocationItemBuilder()..update(updates))._build();

  _$AssetPortfolioAllocationItem._(
      {required this.assetId,
      required this.symbol,
      required this.valueUsd,
      required this.percent})
      : super._();
  @override
  AssetPortfolioAllocationItem rebuild(
          void Function(AssetPortfolioAllocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetPortfolioAllocationItemBuilder toBuilder() =>
      AssetPortfolioAllocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetPortfolioAllocationItem &&
        assetId == other.assetId &&
        symbol == other.symbol &&
        valueUsd == other.valueUsd &&
        percent == other.percent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetPortfolioAllocationItem')
          ..add('assetId', assetId)
          ..add('symbol', symbol)
          ..add('valueUsd', valueUsd)
          ..add('percent', percent))
        .toString();
  }
}

class AssetPortfolioAllocationItemBuilder
    implements
        Builder<AssetPortfolioAllocationItem,
            AssetPortfolioAllocationItemBuilder> {
  _$AssetPortfolioAllocationItem? _$v;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  AssetPortfolioAllocationItemBuilder() {
    AssetPortfolioAllocationItem._defaults(this);
  }

  AssetPortfolioAllocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assetId = $v.assetId;
      _symbol = $v.symbol;
      _valueUsd = $v.valueUsd;
      _percent = $v.percent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetPortfolioAllocationItem other) {
    _$v = other as _$AssetPortfolioAllocationItem;
  }

  @override
  void update(void Function(AssetPortfolioAllocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetPortfolioAllocationItem build() => _build();

  _$AssetPortfolioAllocationItem _build() {
    final _$result = _$v ??
        _$AssetPortfolioAllocationItem._(
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'AssetPortfolioAllocationItem', 'assetId'),
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'AssetPortfolioAllocationItem', 'symbol'),
          valueUsd: BuiltValueNullFieldError.checkNotNull(
              valueUsd, r'AssetPortfolioAllocationItem', 'valueUsd'),
          percent: BuiltValueNullFieldError.checkNotNull(
              percent, r'AssetPortfolioAllocationItem', 'percent'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
