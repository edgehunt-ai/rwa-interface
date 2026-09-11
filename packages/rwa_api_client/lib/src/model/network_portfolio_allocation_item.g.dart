// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_portfolio_allocation_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NetworkPortfolioAllocationItem extends NetworkPortfolioAllocationItem {
  @override
  final PortfolioAssetNetwork network;
  @override
  final String valueUsd;
  @override
  final String percent;

  factory _$NetworkPortfolioAllocationItem(
          [void Function(NetworkPortfolioAllocationItemBuilder)? updates]) =>
      (NetworkPortfolioAllocationItemBuilder()..update(updates))._build();

  _$NetworkPortfolioAllocationItem._(
      {required this.network, required this.valueUsd, required this.percent})
      : super._();
  @override
  NetworkPortfolioAllocationItem rebuild(
          void Function(NetworkPortfolioAllocationItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkPortfolioAllocationItemBuilder toBuilder() =>
      NetworkPortfolioAllocationItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkPortfolioAllocationItem &&
        network == other.network &&
        valueUsd == other.valueUsd &&
        percent == other.percent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NetworkPortfolioAllocationItem')
          ..add('network', network)
          ..add('valueUsd', valueUsd)
          ..add('percent', percent))
        .toString();
  }
}

class NetworkPortfolioAllocationItemBuilder
    implements
        Builder<NetworkPortfolioAllocationItem,
            NetworkPortfolioAllocationItemBuilder> {
  _$NetworkPortfolioAllocationItem? _$v;

  PortfolioAssetNetwork? _network;
  PortfolioAssetNetwork? get network => _$this._network;
  set network(PortfolioAssetNetwork? network) => _$this._network = network;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  NetworkPortfolioAllocationItemBuilder() {
    NetworkPortfolioAllocationItem._defaults(this);
  }

  NetworkPortfolioAllocationItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _network = $v.network;
      _valueUsd = $v.valueUsd;
      _percent = $v.percent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NetworkPortfolioAllocationItem other) {
    _$v = other as _$NetworkPortfolioAllocationItem;
  }

  @override
  void update(void Function(NetworkPortfolioAllocationItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NetworkPortfolioAllocationItem build() => _build();

  _$NetworkPortfolioAllocationItem _build() {
    final _$result = _$v ??
        _$NetworkPortfolioAllocationItem._(
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'NetworkPortfolioAllocationItem', 'network'),
          valueUsd: BuiltValueNullFieldError.checkNotNull(
              valueUsd, r'NetworkPortfolioAllocationItem', 'valueUsd'),
          percent: BuiltValueNullFieldError.checkNotNull(
              percent, r'NetworkPortfolioAllocationItem', 'percent'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
