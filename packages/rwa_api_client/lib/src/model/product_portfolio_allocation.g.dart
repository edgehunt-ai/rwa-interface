// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_portfolio_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductPortfolioAllocationDimensionEnum
    _$productPortfolioAllocationDimensionEnum_product =
    const ProductPortfolioAllocationDimensionEnum._('product');
const ProductPortfolioAllocationDimensionEnum
    _$productPortfolioAllocationDimensionEnum_unknownDefaultOpenApi =
    const ProductPortfolioAllocationDimensionEnum._('unknownDefaultOpenApi');

ProductPortfolioAllocationDimensionEnum
    _$productPortfolioAllocationDimensionEnumValueOf(String name) {
  switch (name) {
    case 'product':
      return _$productPortfolioAllocationDimensionEnum_product;
    case 'unknownDefaultOpenApi':
      return _$productPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
    default:
      return _$productPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductPortfolioAllocationDimensionEnum>
    _$productPortfolioAllocationDimensionEnumValues = BuiltSet<
        ProductPortfolioAllocationDimensionEnum>(const <ProductPortfolioAllocationDimensionEnum>[
  _$productPortfolioAllocationDimensionEnum_product,
  _$productPortfolioAllocationDimensionEnum_unknownDefaultOpenApi,
]);

Serializer<ProductPortfolioAllocationDimensionEnum>
    _$productPortfolioAllocationDimensionEnumSerializer =
    _$ProductPortfolioAllocationDimensionEnumSerializer();

class _$ProductPortfolioAllocationDimensionEnumSerializer
    implements PrimitiveSerializer<ProductPortfolioAllocationDimensionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'product': 'product',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'product': 'product',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ProductPortfolioAllocationDimensionEnum
  ];
  @override
  final String wireName = 'ProductPortfolioAllocationDimensionEnum';

  @override
  Object serialize(Serializers serializers,
          ProductPortfolioAllocationDimensionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductPortfolioAllocationDimensionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductPortfolioAllocationDimensionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ProductPortfolioAllocation extends ProductPortfolioAllocation {
  @override
  final ProductPortfolioAllocationDimensionEnum dimension;
  @override
  final BuiltList<ProductPortfolioAllocationItem> items;
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

  factory _$ProductPortfolioAllocation(
          [void Function(ProductPortfolioAllocationBuilder)? updates]) =>
      (ProductPortfolioAllocationBuilder()..update(updates))._build();

  _$ProductPortfolioAllocation._(
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
  ProductPortfolioAllocation rebuild(
          void Function(ProductPortfolioAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductPortfolioAllocationBuilder toBuilder() =>
      ProductPortfolioAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductPortfolioAllocation &&
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
    return (newBuiltValueToStringHelper(r'ProductPortfolioAllocation')
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

class ProductPortfolioAllocationBuilder
    implements
        Builder<ProductPortfolioAllocation, ProductPortfolioAllocationBuilder> {
  _$ProductPortfolioAllocation? _$v;

  ProductPortfolioAllocationDimensionEnum? _dimension;
  ProductPortfolioAllocationDimensionEnum? get dimension => _$this._dimension;
  set dimension(ProductPortfolioAllocationDimensionEnum? dimension) =>
      _$this._dimension = dimension;

  ListBuilder<ProductPortfolioAllocationItem>? _items;
  ListBuilder<ProductPortfolioAllocationItem> get items =>
      _$this._items ??= ListBuilder<ProductPortfolioAllocationItem>();
  set items(ListBuilder<ProductPortfolioAllocationItem>? items) =>
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

  ProductPortfolioAllocationBuilder() {
    ProductPortfolioAllocation._defaults(this);
  }

  ProductPortfolioAllocationBuilder get _$this {
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
  void replace(ProductPortfolioAllocation other) {
    _$v = other as _$ProductPortfolioAllocation;
  }

  @override
  void update(void Function(ProductPortfolioAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductPortfolioAllocation build() => _build();

  _$ProductPortfolioAllocation _build() {
    _$ProductPortfolioAllocation _$result;
    try {
      _$result = _$v ??
          _$ProductPortfolioAllocation._(
            dimension: BuiltValueNullFieldError.checkNotNull(
                dimension, r'ProductPortfolioAllocation', 'dimension'),
            items: items.build(),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd,
                r'ProductPortfolioAllocation',
                'valuedTotalUsd'),
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'ProductPortfolioAllocation',
                'unvaluedAssetCount'),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'ProductPortfolioAllocation', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'ProductPortfolioAllocation', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'ProductPortfolioAllocation', 'calculatedAt'),
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
            r'ProductPortfolioAllocation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
