// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainnet_funding_source_asset_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainnetFundingSourceAssetCatalog
    extends MainnetFundingSourceAssetCatalog {
  @override
  final FundingSourceAsset ethereumUsdc;
  @override
  final FundingSourceAsset ethereumUsdt;
  @override
  final FundingSourceAsset arbitrumUsdc;
  @override
  final FundingSourceAsset arbitrumUsdt;
  @override
  final FundingSourceAsset baseUsdc;
  @override
  final FundingSourceAsset baseUsdt;
  @override
  final FundingSourceAsset bscUsdc;
  @override
  final FundingSourceAsset bscUsdt;

  factory _$MainnetFundingSourceAssetCatalog(
          [void Function(MainnetFundingSourceAssetCatalogBuilder)? updates]) =>
      (MainnetFundingSourceAssetCatalogBuilder()..update(updates))._build();

  _$MainnetFundingSourceAssetCatalog._(
      {required this.ethereumUsdc,
      required this.ethereumUsdt,
      required this.arbitrumUsdc,
      required this.arbitrumUsdt,
      required this.baseUsdc,
      required this.baseUsdt,
      required this.bscUsdc,
      required this.bscUsdt})
      : super._();
  @override
  MainnetFundingSourceAssetCatalog rebuild(
          void Function(MainnetFundingSourceAssetCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainnetFundingSourceAssetCatalogBuilder toBuilder() =>
      MainnetFundingSourceAssetCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainnetFundingSourceAssetCatalog &&
        ethereumUsdc == other.ethereumUsdc &&
        ethereumUsdt == other.ethereumUsdt &&
        arbitrumUsdc == other.arbitrumUsdc &&
        arbitrumUsdt == other.arbitrumUsdt &&
        baseUsdc == other.baseUsdc &&
        baseUsdt == other.baseUsdt &&
        bscUsdc == other.bscUsdc &&
        bscUsdt == other.bscUsdt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ethereumUsdc.hashCode);
    _$hash = $jc(_$hash, ethereumUsdt.hashCode);
    _$hash = $jc(_$hash, arbitrumUsdc.hashCode);
    _$hash = $jc(_$hash, arbitrumUsdt.hashCode);
    _$hash = $jc(_$hash, baseUsdc.hashCode);
    _$hash = $jc(_$hash, baseUsdt.hashCode);
    _$hash = $jc(_$hash, bscUsdc.hashCode);
    _$hash = $jc(_$hash, bscUsdt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MainnetFundingSourceAssetCatalog')
          ..add('ethereumUsdc', ethereumUsdc)
          ..add('ethereumUsdt', ethereumUsdt)
          ..add('arbitrumUsdc', arbitrumUsdc)
          ..add('arbitrumUsdt', arbitrumUsdt)
          ..add('baseUsdc', baseUsdc)
          ..add('baseUsdt', baseUsdt)
          ..add('bscUsdc', bscUsdc)
          ..add('bscUsdt', bscUsdt))
        .toString();
  }
}

class MainnetFundingSourceAssetCatalogBuilder
    implements
        Builder<MainnetFundingSourceAssetCatalog,
            MainnetFundingSourceAssetCatalogBuilder> {
  _$MainnetFundingSourceAssetCatalog? _$v;

  FundingSourceAssetBuilder? _ethereumUsdc;
  FundingSourceAssetBuilder get ethereumUsdc =>
      _$this._ethereumUsdc ??= FundingSourceAssetBuilder();
  set ethereumUsdc(FundingSourceAssetBuilder? ethereumUsdc) =>
      _$this._ethereumUsdc = ethereumUsdc;

  FundingSourceAssetBuilder? _ethereumUsdt;
  FundingSourceAssetBuilder get ethereumUsdt =>
      _$this._ethereumUsdt ??= FundingSourceAssetBuilder();
  set ethereumUsdt(FundingSourceAssetBuilder? ethereumUsdt) =>
      _$this._ethereumUsdt = ethereumUsdt;

  FundingSourceAssetBuilder? _arbitrumUsdc;
  FundingSourceAssetBuilder get arbitrumUsdc =>
      _$this._arbitrumUsdc ??= FundingSourceAssetBuilder();
  set arbitrumUsdc(FundingSourceAssetBuilder? arbitrumUsdc) =>
      _$this._arbitrumUsdc = arbitrumUsdc;

  FundingSourceAssetBuilder? _arbitrumUsdt;
  FundingSourceAssetBuilder get arbitrumUsdt =>
      _$this._arbitrumUsdt ??= FundingSourceAssetBuilder();
  set arbitrumUsdt(FundingSourceAssetBuilder? arbitrumUsdt) =>
      _$this._arbitrumUsdt = arbitrumUsdt;

  FundingSourceAssetBuilder? _baseUsdc;
  FundingSourceAssetBuilder get baseUsdc =>
      _$this._baseUsdc ??= FundingSourceAssetBuilder();
  set baseUsdc(FundingSourceAssetBuilder? baseUsdc) =>
      _$this._baseUsdc = baseUsdc;

  FundingSourceAssetBuilder? _baseUsdt;
  FundingSourceAssetBuilder get baseUsdt =>
      _$this._baseUsdt ??= FundingSourceAssetBuilder();
  set baseUsdt(FundingSourceAssetBuilder? baseUsdt) =>
      _$this._baseUsdt = baseUsdt;

  FundingSourceAssetBuilder? _bscUsdc;
  FundingSourceAssetBuilder get bscUsdc =>
      _$this._bscUsdc ??= FundingSourceAssetBuilder();
  set bscUsdc(FundingSourceAssetBuilder? bscUsdc) => _$this._bscUsdc = bscUsdc;

  FundingSourceAssetBuilder? _bscUsdt;
  FundingSourceAssetBuilder get bscUsdt =>
      _$this._bscUsdt ??= FundingSourceAssetBuilder();
  set bscUsdt(FundingSourceAssetBuilder? bscUsdt) => _$this._bscUsdt = bscUsdt;

  MainnetFundingSourceAssetCatalogBuilder() {
    MainnetFundingSourceAssetCatalog._defaults(this);
  }

  MainnetFundingSourceAssetCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ethereumUsdc = $v.ethereumUsdc.toBuilder();
      _ethereumUsdt = $v.ethereumUsdt.toBuilder();
      _arbitrumUsdc = $v.arbitrumUsdc.toBuilder();
      _arbitrumUsdt = $v.arbitrumUsdt.toBuilder();
      _baseUsdc = $v.baseUsdc.toBuilder();
      _baseUsdt = $v.baseUsdt.toBuilder();
      _bscUsdc = $v.bscUsdc.toBuilder();
      _bscUsdt = $v.bscUsdt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainnetFundingSourceAssetCatalog other) {
    _$v = other as _$MainnetFundingSourceAssetCatalog;
  }

  @override
  void update(void Function(MainnetFundingSourceAssetCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MainnetFundingSourceAssetCatalog build() => _build();

  _$MainnetFundingSourceAssetCatalog _build() {
    _$MainnetFundingSourceAssetCatalog _$result;
    try {
      _$result = _$v ??
          _$MainnetFundingSourceAssetCatalog._(
            ethereumUsdc: ethereumUsdc.build(),
            ethereumUsdt: ethereumUsdt.build(),
            arbitrumUsdc: arbitrumUsdc.build(),
            arbitrumUsdt: arbitrumUsdt.build(),
            baseUsdc: baseUsdc.build(),
            baseUsdt: baseUsdt.build(),
            bscUsdc: bscUsdc.build(),
            bscUsdt: bscUsdt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ethereumUsdc';
        ethereumUsdc.build();
        _$failedField = 'ethereumUsdt';
        ethereumUsdt.build();
        _$failedField = 'arbitrumUsdc';
        arbitrumUsdc.build();
        _$failedField = 'arbitrumUsdt';
        arbitrumUsdt.build();
        _$failedField = 'baseUsdc';
        baseUsdc.build();
        _$failedField = 'baseUsdt';
        baseUsdt.build();
        _$failedField = 'bscUsdc';
        bscUsdc.build();
        _$failedField = 'bscUsdt';
        bscUsdt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MainnetFundingSourceAssetCatalog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
