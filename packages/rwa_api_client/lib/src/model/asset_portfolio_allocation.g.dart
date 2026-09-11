// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_portfolio_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AssetPortfolioAllocationDimensionEnum
    _$assetPortfolioAllocationDimensionEnum_asset =
    const AssetPortfolioAllocationDimensionEnum._('asset');
const AssetPortfolioAllocationDimensionEnum
    _$assetPortfolioAllocationDimensionEnum_unknownDefaultOpenApi =
    const AssetPortfolioAllocationDimensionEnum._('unknownDefaultOpenApi');

AssetPortfolioAllocationDimensionEnum
    _$assetPortfolioAllocationDimensionEnumValueOf(String name) {
  switch (name) {
    case 'asset':
      return _$assetPortfolioAllocationDimensionEnum_asset;
    case 'unknownDefaultOpenApi':
      return _$assetPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
    default:
      return _$assetPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AssetPortfolioAllocationDimensionEnum>
    _$assetPortfolioAllocationDimensionEnumValues = BuiltSet<
        AssetPortfolioAllocationDimensionEnum>(const <AssetPortfolioAllocationDimensionEnum>[
  _$assetPortfolioAllocationDimensionEnum_asset,
  _$assetPortfolioAllocationDimensionEnum_unknownDefaultOpenApi,
]);

Serializer<AssetPortfolioAllocationDimensionEnum>
    _$assetPortfolioAllocationDimensionEnumSerializer =
    _$AssetPortfolioAllocationDimensionEnumSerializer();

class _$AssetPortfolioAllocationDimensionEnumSerializer
    implements PrimitiveSerializer<AssetPortfolioAllocationDimensionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'asset': 'asset',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'asset': 'asset',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AssetPortfolioAllocationDimensionEnum
  ];
  @override
  final String wireName = 'AssetPortfolioAllocationDimensionEnum';

  @override
  Object serialize(
          Serializers serializers, AssetPortfolioAllocationDimensionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AssetPortfolioAllocationDimensionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AssetPortfolioAllocationDimensionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AssetPortfolioAllocation extends AssetPortfolioAllocation {
  @override
  final AssetPortfolioAllocationDimensionEnum dimension;
  @override
  final BuiltList<AssetPortfolioAllocationItem> items;
  @override
  final String valuedTotalUsd;
  @override
  final int unvaluedAssetCount;
  @override
  final PortfolioDataStatus dataStatus;
  @override
  final PortfolioFreshness freshness;
  @override
  final DateTime calculatedAt;
  @override
  final BuiltList<PortfolioNotice> warnings;
  @override
  final BuiltList<PortfolioSourceSummary> sources;

  factory _$AssetPortfolioAllocation(
          [void Function(AssetPortfolioAllocationBuilder)? updates]) =>
      (AssetPortfolioAllocationBuilder()..update(updates))._build();

  _$AssetPortfolioAllocation._(
      {required this.dimension,
      required this.items,
      required this.valuedTotalUsd,
      required this.unvaluedAssetCount,
      required this.dataStatus,
      required this.freshness,
      required this.calculatedAt,
      required this.warnings,
      required this.sources})
      : super._();
  @override
  AssetPortfolioAllocation rebuild(
          void Function(AssetPortfolioAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssetPortfolioAllocationBuilder toBuilder() =>
      AssetPortfolioAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssetPortfolioAllocation &&
        dimension == other.dimension &&
        items == other.items &&
        valuedTotalUsd == other.valuedTotalUsd &&
        unvaluedAssetCount == other.unvaluedAssetCount &&
        dataStatus == other.dataStatus &&
        freshness == other.freshness &&
        calculatedAt == other.calculatedAt &&
        warnings == other.warnings &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dimension.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, valuedTotalUsd.hashCode);
    _$hash = $jc(_$hash, unvaluedAssetCount.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssetPortfolioAllocation')
          ..add('dimension', dimension)
          ..add('items', items)
          ..add('valuedTotalUsd', valuedTotalUsd)
          ..add('unvaluedAssetCount', unvaluedAssetCount)
          ..add('dataStatus', dataStatus)
          ..add('freshness', freshness)
          ..add('calculatedAt', calculatedAt)
          ..add('warnings', warnings)
          ..add('sources', sources))
        .toString();
  }
}

class AssetPortfolioAllocationBuilder
    implements
        Builder<AssetPortfolioAllocation, AssetPortfolioAllocationBuilder> {
  _$AssetPortfolioAllocation? _$v;

  AssetPortfolioAllocationDimensionEnum? _dimension;
  AssetPortfolioAllocationDimensionEnum? get dimension => _$this._dimension;
  set dimension(AssetPortfolioAllocationDimensionEnum? dimension) =>
      _$this._dimension = dimension;

  ListBuilder<AssetPortfolioAllocationItem>? _items;
  ListBuilder<AssetPortfolioAllocationItem> get items =>
      _$this._items ??= ListBuilder<AssetPortfolioAllocationItem>();
  set items(ListBuilder<AssetPortfolioAllocationItem>? items) =>
      _$this._items = items;

  String? _valuedTotalUsd;
  String? get valuedTotalUsd => _$this._valuedTotalUsd;
  set valuedTotalUsd(String? valuedTotalUsd) =>
      _$this._valuedTotalUsd = valuedTotalUsd;

  int? _unvaluedAssetCount;
  int? get unvaluedAssetCount => _$this._unvaluedAssetCount;
  set unvaluedAssetCount(int? unvaluedAssetCount) =>
      _$this._unvaluedAssetCount = unvaluedAssetCount;

  PortfolioDataStatus? _dataStatus;
  PortfolioDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(PortfolioDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  ListBuilder<PortfolioNotice>? _warnings;
  ListBuilder<PortfolioNotice> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioNotice>();
  set warnings(ListBuilder<PortfolioNotice>? warnings) =>
      _$this._warnings = warnings;

  ListBuilder<PortfolioSourceSummary>? _sources;
  ListBuilder<PortfolioSourceSummary> get sources =>
      _$this._sources ??= ListBuilder<PortfolioSourceSummary>();
  set sources(ListBuilder<PortfolioSourceSummary>? sources) =>
      _$this._sources = sources;

  AssetPortfolioAllocationBuilder() {
    AssetPortfolioAllocation._defaults(this);
  }

  AssetPortfolioAllocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dimension = $v.dimension;
      _items = $v.items.toBuilder();
      _valuedTotalUsd = $v.valuedTotalUsd;
      _unvaluedAssetCount = $v.unvaluedAssetCount;
      _dataStatus = $v.dataStatus;
      _freshness = $v.freshness;
      _calculatedAt = $v.calculatedAt;
      _warnings = $v.warnings.toBuilder();
      _sources = $v.sources.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssetPortfolioAllocation other) {
    _$v = other as _$AssetPortfolioAllocation;
  }

  @override
  void update(void Function(AssetPortfolioAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssetPortfolioAllocation build() => _build();

  _$AssetPortfolioAllocation _build() {
    _$AssetPortfolioAllocation _$result;
    try {
      _$result = _$v ??
          _$AssetPortfolioAllocation._(
            dimension: BuiltValueNullFieldError.checkNotNull(
                dimension, r'AssetPortfolioAllocation', 'dimension'),
            items: items.build(),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd, r'AssetPortfolioAllocation', 'valuedTotalUsd'),
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'AssetPortfolioAllocation',
                'unvaluedAssetCount'),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'AssetPortfolioAllocation', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'AssetPortfolioAllocation', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'AssetPortfolioAllocation', 'calculatedAt'),
            warnings: warnings.build(),
            sources: sources.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();

        _$failedField = 'warnings';
        warnings.build();
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AssetPortfolioAllocation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
