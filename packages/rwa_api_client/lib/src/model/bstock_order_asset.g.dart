// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstockOrderAsset extends BstockOrderAsset {
  @override
  final String symbol;
  @override
  final int chainId;
  @override
  final String assetId;
  @override
  final String tokenContract;
  @override
  final int decimals;

  factory _$BstockOrderAsset(
          [void Function(BstockOrderAssetBuilder)? updates]) =>
      (BstockOrderAssetBuilder()..update(updates))._build();

  _$BstockOrderAsset._(
      {required this.symbol,
      required this.chainId,
      required this.assetId,
      required this.tokenContract,
      required this.decimals})
      : super._();
  @override
  BstockOrderAsset rebuild(void Function(BstockOrderAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderAssetBuilder toBuilder() =>
      BstockOrderAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderAsset &&
        symbol == other.symbol &&
        chainId == other.chainId &&
        assetId == other.assetId &&
        tokenContract == other.tokenContract &&
        decimals == other.decimals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockOrderAsset')
          ..add('symbol', symbol)
          ..add('chainId', chainId)
          ..add('assetId', assetId)
          ..add('tokenContract', tokenContract)
          ..add('decimals', decimals))
        .toString();
  }
}

class BstockOrderAssetBuilder
    implements Builder<BstockOrderAsset, BstockOrderAssetBuilder> {
  _$BstockOrderAsset? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  BstockOrderAssetBuilder() {
    BstockOrderAsset._defaults(this);
  }

  BstockOrderAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _chainId = $v.chainId;
      _assetId = $v.assetId;
      _tokenContract = $v.tokenContract;
      _decimals = $v.decimals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockOrderAsset other) {
    _$v = other as _$BstockOrderAsset;
  }

  @override
  void update(void Function(BstockOrderAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderAsset build() => _build();

  _$BstockOrderAsset _build() {
    final _$result = _$v ??
        _$BstockOrderAsset._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'BstockOrderAsset', 'symbol'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'BstockOrderAsset', 'chainId'),
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'BstockOrderAsset', 'assetId'),
          tokenContract: BuiltValueNullFieldError.checkNotNull(
              tokenContract, r'BstockOrderAsset', 'tokenContract'),
          decimals: BuiltValueNullFieldError.checkNotNull(
              decimals, r'BstockOrderAsset', 'decimals'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
