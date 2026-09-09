// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingCatalog extends FundingCatalog {
  @override
  final String catalogVersion;
  @override
  final FundingSourceAssetCatalog sourceAssets;
  @override
  final BuiltSet<FundingRail> rails;
  @override
  final BuiltList<DepositRail> depositRails;
  @override
  final DateTime updatedAt;

  factory _$FundingCatalog([void Function(FundingCatalogBuilder)? updates]) =>
      (FundingCatalogBuilder()..update(updates))._build();

  _$FundingCatalog._(
      {required this.catalogVersion,
      required this.sourceAssets,
      required this.rails,
      required this.depositRails,
      required this.updatedAt})
      : super._();
  @override
  FundingCatalog rebuild(void Function(FundingCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingCatalogBuilder toBuilder() => FundingCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingCatalog &&
        catalogVersion == other.catalogVersion &&
        sourceAssets == other.sourceAssets &&
        rails == other.rails &&
        depositRails == other.depositRails &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, catalogVersion.hashCode);
    _$hash = $jc(_$hash, sourceAssets.hashCode);
    _$hash = $jc(_$hash, rails.hashCode);
    _$hash = $jc(_$hash, depositRails.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingCatalog')
          ..add('catalogVersion', catalogVersion)
          ..add('sourceAssets', sourceAssets)
          ..add('rails', rails)
          ..add('depositRails', depositRails)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class FundingCatalogBuilder
    implements Builder<FundingCatalog, FundingCatalogBuilder> {
  _$FundingCatalog? _$v;

  String? _catalogVersion;
  String? get catalogVersion => _$this._catalogVersion;
  set catalogVersion(String? catalogVersion) =>
      _$this._catalogVersion = catalogVersion;

  FundingSourceAssetCatalogBuilder? _sourceAssets;
  FundingSourceAssetCatalogBuilder get sourceAssets =>
      _$this._sourceAssets ??= FundingSourceAssetCatalogBuilder();
  set sourceAssets(FundingSourceAssetCatalogBuilder? sourceAssets) =>
      _$this._sourceAssets = sourceAssets;

  SetBuilder<FundingRail>? _rails;
  SetBuilder<FundingRail> get rails =>
      _$this._rails ??= SetBuilder<FundingRail>();
  set rails(SetBuilder<FundingRail>? rails) => _$this._rails = rails;

  ListBuilder<DepositRail>? _depositRails;
  ListBuilder<DepositRail> get depositRails =>
      _$this._depositRails ??= ListBuilder<DepositRail>();
  set depositRails(ListBuilder<DepositRail>? depositRails) =>
      _$this._depositRails = depositRails;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  FundingCatalogBuilder() {
    FundingCatalog._defaults(this);
  }

  FundingCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _catalogVersion = $v.catalogVersion;
      _sourceAssets = $v.sourceAssets.toBuilder();
      _rails = $v.rails.toBuilder();
      _depositRails = $v.depositRails.toBuilder();
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingCatalog other) {
    _$v = other as _$FundingCatalog;
  }

  @override
  void update(void Function(FundingCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingCatalog build() => _build();

  _$FundingCatalog _build() {
    _$FundingCatalog _$result;
    try {
      _$result = _$v ??
          _$FundingCatalog._(
            catalogVersion: BuiltValueNullFieldError.checkNotNull(
                catalogVersion, r'FundingCatalog', 'catalogVersion'),
            sourceAssets: sourceAssets.build(),
            rails: rails.build(),
            depositRails: depositRails.build(),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'FundingCatalog', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sourceAssets';
        sourceAssets.build();
        _$failedField = 'rails';
        rails.build();
        _$failedField = 'depositRails';
        depositRails.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingCatalog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
