// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_assets.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstockOrderAssets extends BstockOrderAssets {
  @override
  final BstockOrderAsset buy;
  @override
  final BstockOrderAsset sell;

  factory _$BstockOrderAssets(
          [void Function(BstockOrderAssetsBuilder)? updates]) =>
      (BstockOrderAssetsBuilder()..update(updates))._build();

  _$BstockOrderAssets._({required this.buy, required this.sell}) : super._();
  @override
  BstockOrderAssets rebuild(void Function(BstockOrderAssetsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderAssetsBuilder toBuilder() =>
      BstockOrderAssetsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderAssets && buy == other.buy && sell == other.sell;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, buy.hashCode);
    _$hash = $jc(_$hash, sell.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockOrderAssets')
          ..add('buy', buy)
          ..add('sell', sell))
        .toString();
  }
}

class BstockOrderAssetsBuilder
    implements Builder<BstockOrderAssets, BstockOrderAssetsBuilder> {
  _$BstockOrderAssets? _$v;

  BstockOrderAssetBuilder? _buy;
  BstockOrderAssetBuilder get buy => _$this._buy ??= BstockOrderAssetBuilder();
  set buy(BstockOrderAssetBuilder? buy) => _$this._buy = buy;

  BstockOrderAssetBuilder? _sell;
  BstockOrderAssetBuilder get sell =>
      _$this._sell ??= BstockOrderAssetBuilder();
  set sell(BstockOrderAssetBuilder? sell) => _$this._sell = sell;

  BstockOrderAssetsBuilder() {
    BstockOrderAssets._defaults(this);
  }

  BstockOrderAssetsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _buy = $v.buy.toBuilder();
      _sell = $v.sell.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockOrderAssets other) {
    _$v = other as _$BstockOrderAssets;
  }

  @override
  void update(void Function(BstockOrderAssetsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderAssets build() => _build();

  _$BstockOrderAssets _build() {
    _$BstockOrderAssets _$result;
    try {
      _$result = _$v ??
          _$BstockOrderAssets._(
            buy: buy.build(),
            sell: sell.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'buy';
        buy.build();
        _$failedField = 'sell';
        sell.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockOrderAssets', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
