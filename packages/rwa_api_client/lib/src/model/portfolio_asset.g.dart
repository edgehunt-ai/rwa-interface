// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioAsset extends PortfolioAsset {
  @override
  final BstocksPortfolioAvailability? bstocks;
  @override
  final String assetId;
  @override
  final PortfolioAssetSourceKind source_;
  @override
  final PortfolioAssetNetwork network;
  @override
  final String? walletId;
  @override
  final String? accountRef;
  @override
  final String? contractAddress;
  @override
  final bool native_;
  @override
  final String symbol;
  @override
  final int decimals;
  @override
  final String balanceRaw;
  @override
  final String balance;
  @override
  final String? priceUsd;
  @override
  final PortfolioPriceSource pricingSource;
  @override
  final String? valueUsd;
  @override
  final DateTime observedAt;
  @override
  final int? blockNumber;
  @override
  final String? blockHash;
  @override
  final PortfolioFreshness freshness;
  @override
  final BuiltList<PortfolioWarningCode> warnings;

  factory _$PortfolioAsset([void Function(PortfolioAssetBuilder)? updates]) =>
      (PortfolioAssetBuilder()..update(updates))._build();

  _$PortfolioAsset._(
      {this.bstocks,
      required this.assetId,
      required this.source_,
      required this.network,
      this.walletId,
      this.accountRef,
      this.contractAddress,
      required this.native_,
      required this.symbol,
      required this.decimals,
      required this.balanceRaw,
      required this.balance,
      this.priceUsd,
      required this.pricingSource,
      this.valueUsd,
      required this.observedAt,
      this.blockNumber,
      this.blockHash,
      required this.freshness,
      required this.warnings})
      : super._();
  @override
  PortfolioAsset rebuild(void Function(PortfolioAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAssetBuilder toBuilder() => PortfolioAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAsset &&
        bstocks == other.bstocks &&
        assetId == other.assetId &&
        source_ == other.source_ &&
        network == other.network &&
        walletId == other.walletId &&
        accountRef == other.accountRef &&
        contractAddress == other.contractAddress &&
        native_ == other.native_ &&
        symbol == other.symbol &&
        decimals == other.decimals &&
        balanceRaw == other.balanceRaw &&
        balance == other.balance &&
        priceUsd == other.priceUsd &&
        pricingSource == other.pricingSource &&
        valueUsd == other.valueUsd &&
        observedAt == other.observedAt &&
        blockNumber == other.blockNumber &&
        blockHash == other.blockHash &&
        freshness == other.freshness &&
        warnings == other.warnings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bstocks.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, contractAddress.hashCode);
    _$hash = $jc(_$hash, native_.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jc(_$hash, balanceRaw.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, priceUsd.hashCode);
    _$hash = $jc(_$hash, pricingSource.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, blockNumber.hashCode);
    _$hash = $jc(_$hash, blockHash.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAsset')
          ..add('bstocks', bstocks)
          ..add('assetId', assetId)
          ..add('source_', source_)
          ..add('network', network)
          ..add('walletId', walletId)
          ..add('accountRef', accountRef)
          ..add('contractAddress', contractAddress)
          ..add('native_', native_)
          ..add('symbol', symbol)
          ..add('decimals', decimals)
          ..add('balanceRaw', balanceRaw)
          ..add('balance', balance)
          ..add('priceUsd', priceUsd)
          ..add('pricingSource', pricingSource)
          ..add('valueUsd', valueUsd)
          ..add('observedAt', observedAt)
          ..add('blockNumber', blockNumber)
          ..add('blockHash', blockHash)
          ..add('freshness', freshness)
          ..add('warnings', warnings))
        .toString();
  }
}

class PortfolioAssetBuilder
    implements Builder<PortfolioAsset, PortfolioAssetBuilder> {
  _$PortfolioAsset? _$v;

  BstocksPortfolioAvailabilityBuilder? _bstocks;
  BstocksPortfolioAvailabilityBuilder get bstocks =>
      _$this._bstocks ??= BstocksPortfolioAvailabilityBuilder();
  set bstocks(BstocksPortfolioAvailabilityBuilder? bstocks) =>
      _$this._bstocks = bstocks;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  PortfolioAssetSourceKind? _source_;
  PortfolioAssetSourceKind? get source_ => _$this._source_;
  set source_(PortfolioAssetSourceKind? source_) => _$this._source_ = source_;

  PortfolioAssetNetwork? _network;
  PortfolioAssetNetwork? get network => _$this._network;
  set network(PortfolioAssetNetwork? network) => _$this._network = network;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  String? _contractAddress;
  String? get contractAddress => _$this._contractAddress;
  set contractAddress(String? contractAddress) =>
      _$this._contractAddress = contractAddress;

  bool? _native_;
  bool? get native_ => _$this._native_;
  set native_(bool? native_) => _$this._native_ = native_;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  String? _balanceRaw;
  String? get balanceRaw => _$this._balanceRaw;
  set balanceRaw(String? balanceRaw) => _$this._balanceRaw = balanceRaw;

  String? _balance;
  String? get balance => _$this._balance;
  set balance(String? balance) => _$this._balance = balance;

  String? _priceUsd;
  String? get priceUsd => _$this._priceUsd;
  set priceUsd(String? priceUsd) => _$this._priceUsd = priceUsd;

  PortfolioPriceSource? _pricingSource;
  PortfolioPriceSource? get pricingSource => _$this._pricingSource;
  set pricingSource(PortfolioPriceSource? pricingSource) =>
      _$this._pricingSource = pricingSource;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  int? _blockNumber;
  int? get blockNumber => _$this._blockNumber;
  set blockNumber(int? blockNumber) => _$this._blockNumber = blockNumber;

  String? _blockHash;
  String? get blockHash => _$this._blockHash;
  set blockHash(String? blockHash) => _$this._blockHash = blockHash;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  ListBuilder<PortfolioWarningCode>? _warnings;
  ListBuilder<PortfolioWarningCode> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioWarningCode>();
  set warnings(ListBuilder<PortfolioWarningCode>? warnings) =>
      _$this._warnings = warnings;

  PortfolioAssetBuilder() {
    PortfolioAsset._defaults(this);
  }

  PortfolioAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bstocks = $v.bstocks?.toBuilder();
      _assetId = $v.assetId;
      _source_ = $v.source_;
      _network = $v.network;
      _walletId = $v.walletId;
      _accountRef = $v.accountRef;
      _contractAddress = $v.contractAddress;
      _native_ = $v.native_;
      _symbol = $v.symbol;
      _decimals = $v.decimals;
      _balanceRaw = $v.balanceRaw;
      _balance = $v.balance;
      _priceUsd = $v.priceUsd;
      _pricingSource = $v.pricingSource;
      _valueUsd = $v.valueUsd;
      _observedAt = $v.observedAt;
      _blockNumber = $v.blockNumber;
      _blockHash = $v.blockHash;
      _freshness = $v.freshness;
      _warnings = $v.warnings.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAsset other) {
    _$v = other as _$PortfolioAsset;
  }

  @override
  void update(void Function(PortfolioAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAsset build() => _build();

  _$PortfolioAsset _build() {
    _$PortfolioAsset _$result;
    try {
      _$result = _$v ??
          _$PortfolioAsset._(
            bstocks: _bstocks?.build(),
            assetId: BuiltValueNullFieldError.checkNotNull(
                assetId, r'PortfolioAsset', 'assetId'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'PortfolioAsset', 'source_'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'PortfolioAsset', 'network'),
            walletId: walletId,
            accountRef: accountRef,
            contractAddress: contractAddress,
            native_: BuiltValueNullFieldError.checkNotNull(
                native_, r'PortfolioAsset', 'native_'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PortfolioAsset', 'symbol'),
            decimals: BuiltValueNullFieldError.checkNotNull(
                decimals, r'PortfolioAsset', 'decimals'),
            balanceRaw: BuiltValueNullFieldError.checkNotNull(
                balanceRaw, r'PortfolioAsset', 'balanceRaw'),
            balance: BuiltValueNullFieldError.checkNotNull(
                balance, r'PortfolioAsset', 'balance'),
            priceUsd: priceUsd,
            pricingSource: BuiltValueNullFieldError.checkNotNull(
                pricingSource, r'PortfolioAsset', 'pricingSource'),
            valueUsd: valueUsd,
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'PortfolioAsset', 'observedAt'),
            blockNumber: blockNumber,
            blockHash: blockHash,
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioAsset', 'freshness'),
            warnings: warnings.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bstocks';
        _bstocks?.build();

        _$failedField = 'warnings';
        warnings.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAsset', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
