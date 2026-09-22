// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testnet_funding_source_asset_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TestnetFundingSourceAssetCatalog
    extends TestnetFundingSourceAssetCatalog {
  @override
  final FundingSourceAsset arbitrumSepoliaUsdc;
  @override
  final FundingSourceAsset arbitrumSepoliaUsdc2;
  @override
  final FundingSourceAsset bscTestnetTusdt;

  factory _$TestnetFundingSourceAssetCatalog(
          [void Function(TestnetFundingSourceAssetCatalogBuilder)? updates]) =>
      (TestnetFundingSourceAssetCatalogBuilder()..update(updates))._build();

  _$TestnetFundingSourceAssetCatalog._(
      {required this.arbitrumSepoliaUsdc,
      required this.arbitrumSepoliaUsdc2,
      required this.bscTestnetTusdt})
      : super._();
  @override
  TestnetFundingSourceAssetCatalog rebuild(
          void Function(TestnetFundingSourceAssetCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TestnetFundingSourceAssetCatalogBuilder toBuilder() =>
      TestnetFundingSourceAssetCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TestnetFundingSourceAssetCatalog &&
        arbitrumSepoliaUsdc == other.arbitrumSepoliaUsdc &&
        arbitrumSepoliaUsdc2 == other.arbitrumSepoliaUsdc2 &&
        bscTestnetTusdt == other.bscTestnetTusdt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, arbitrumSepoliaUsdc.hashCode);
    _$hash = $jc(_$hash, arbitrumSepoliaUsdc2.hashCode);
    _$hash = $jc(_$hash, bscTestnetTusdt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TestnetFundingSourceAssetCatalog')
          ..add('arbitrumSepoliaUsdc', arbitrumSepoliaUsdc)
          ..add('arbitrumSepoliaUsdc2', arbitrumSepoliaUsdc2)
          ..add('bscTestnetTusdt', bscTestnetTusdt))
        .toString();
  }
}

class TestnetFundingSourceAssetCatalogBuilder
    implements
        Builder<TestnetFundingSourceAssetCatalog,
            TestnetFundingSourceAssetCatalogBuilder> {
  _$TestnetFundingSourceAssetCatalog? _$v;

  FundingSourceAssetBuilder? _arbitrumSepoliaUsdc;
  FundingSourceAssetBuilder get arbitrumSepoliaUsdc =>
      _$this._arbitrumSepoliaUsdc ??= FundingSourceAssetBuilder();
  set arbitrumSepoliaUsdc(FundingSourceAssetBuilder? arbitrumSepoliaUsdc) =>
      _$this._arbitrumSepoliaUsdc = arbitrumSepoliaUsdc;

  FundingSourceAssetBuilder? _arbitrumSepoliaUsdc2;
  FundingSourceAssetBuilder get arbitrumSepoliaUsdc2 =>
      _$this._arbitrumSepoliaUsdc2 ??= FundingSourceAssetBuilder();
  set arbitrumSepoliaUsdc2(FundingSourceAssetBuilder? arbitrumSepoliaUsdc2) =>
      _$this._arbitrumSepoliaUsdc2 = arbitrumSepoliaUsdc2;

  FundingSourceAssetBuilder? _bscTestnetTusdt;
  FundingSourceAssetBuilder get bscTestnetTusdt =>
      _$this._bscTestnetTusdt ??= FundingSourceAssetBuilder();
  set bscTestnetTusdt(FundingSourceAssetBuilder? bscTestnetTusdt) =>
      _$this._bscTestnetTusdt = bscTestnetTusdt;

  TestnetFundingSourceAssetCatalogBuilder() {
    TestnetFundingSourceAssetCatalog._defaults(this);
  }

  TestnetFundingSourceAssetCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _arbitrumSepoliaUsdc = $v.arbitrumSepoliaUsdc.toBuilder();
      _arbitrumSepoliaUsdc2 = $v.arbitrumSepoliaUsdc2.toBuilder();
      _bscTestnetTusdt = $v.bscTestnetTusdt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TestnetFundingSourceAssetCatalog other) {
    _$v = other as _$TestnetFundingSourceAssetCatalog;
  }

  @override
  void update(void Function(TestnetFundingSourceAssetCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TestnetFundingSourceAssetCatalog build() => _build();

  _$TestnetFundingSourceAssetCatalog _build() {
    _$TestnetFundingSourceAssetCatalog _$result;
    try {
      _$result = _$v ??
          _$TestnetFundingSourceAssetCatalog._(
            arbitrumSepoliaUsdc: arbitrumSepoliaUsdc.build(),
            arbitrumSepoliaUsdc2: arbitrumSepoliaUsdc2.build(),
            bscTestnetTusdt: bscTestnetTusdt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'arbitrumSepoliaUsdc';
        arbitrumSepoliaUsdc.build();
        _$failedField = 'arbitrumSepoliaUsdc2';
        arbitrumSepoliaUsdc2.build();
        _$failedField = 'bscTestnetTusdt';
        bscTestnetTusdt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TestnetFundingSourceAssetCatalog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
