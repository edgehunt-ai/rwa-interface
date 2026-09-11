// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rail_portfolio_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RailPortfolioAllocationDimensionEnum
    _$railPortfolioAllocationDimensionEnum_rail =
    const RailPortfolioAllocationDimensionEnum._('rail');
const RailPortfolioAllocationDimensionEnum
    _$railPortfolioAllocationDimensionEnum_unknownDefaultOpenApi =
    const RailPortfolioAllocationDimensionEnum._('unknownDefaultOpenApi');

RailPortfolioAllocationDimensionEnum
    _$railPortfolioAllocationDimensionEnumValueOf(String name) {
  switch (name) {
    case 'rail':
      return _$railPortfolioAllocationDimensionEnum_rail;
    case 'unknownDefaultOpenApi':
      return _$railPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
    default:
      return _$railPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RailPortfolioAllocationDimensionEnum>
    _$railPortfolioAllocationDimensionEnumValues = BuiltSet<
        RailPortfolioAllocationDimensionEnum>(const <RailPortfolioAllocationDimensionEnum>[
  _$railPortfolioAllocationDimensionEnum_rail,
  _$railPortfolioAllocationDimensionEnum_unknownDefaultOpenApi,
]);

Serializer<RailPortfolioAllocationDimensionEnum>
    _$railPortfolioAllocationDimensionEnumSerializer =
    _$RailPortfolioAllocationDimensionEnumSerializer();

class _$RailPortfolioAllocationDimensionEnumSerializer
    implements PrimitiveSerializer<RailPortfolioAllocationDimensionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'rail': 'rail',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'rail': 'rail',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RailPortfolioAllocationDimensionEnum
  ];
  @override
  final String wireName = 'RailPortfolioAllocationDimensionEnum';

  @override
  Object serialize(
          Serializers serializers, RailPortfolioAllocationDimensionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RailPortfolioAllocationDimensionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RailPortfolioAllocationDimensionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RailPortfolioAllocation extends RailPortfolioAllocation {
  @override
  final RailPortfolioAllocationDimensionEnum dimension;
  @override
  final BuiltList<RailPortfolioAllocationItem> items;
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

  factory _$RailPortfolioAllocation(
          [void Function(RailPortfolioAllocationBuilder)? updates]) =>
      (RailPortfolioAllocationBuilder()..update(updates))._build();

  _$RailPortfolioAllocation._(
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
  RailPortfolioAllocation rebuild(
          void Function(RailPortfolioAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RailPortfolioAllocationBuilder toBuilder() =>
      RailPortfolioAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RailPortfolioAllocation &&
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
    return (newBuiltValueToStringHelper(r'RailPortfolioAllocation')
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

class RailPortfolioAllocationBuilder
    implements
        Builder<RailPortfolioAllocation, RailPortfolioAllocationBuilder> {
  _$RailPortfolioAllocation? _$v;

  RailPortfolioAllocationDimensionEnum? _dimension;
  RailPortfolioAllocationDimensionEnum? get dimension => _$this._dimension;
  set dimension(RailPortfolioAllocationDimensionEnum? dimension) =>
      _$this._dimension = dimension;

  ListBuilder<RailPortfolioAllocationItem>? _items;
  ListBuilder<RailPortfolioAllocationItem> get items =>
      _$this._items ??= ListBuilder<RailPortfolioAllocationItem>();
  set items(ListBuilder<RailPortfolioAllocationItem>? items) =>
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

  RailPortfolioAllocationBuilder() {
    RailPortfolioAllocation._defaults(this);
  }

  RailPortfolioAllocationBuilder get _$this {
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
  void replace(RailPortfolioAllocation other) {
    _$v = other as _$RailPortfolioAllocation;
  }

  @override
  void update(void Function(RailPortfolioAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RailPortfolioAllocation build() => _build();

  _$RailPortfolioAllocation _build() {
    _$RailPortfolioAllocation _$result;
    try {
      _$result = _$v ??
          _$RailPortfolioAllocation._(
            dimension: BuiltValueNullFieldError.checkNotNull(
                dimension, r'RailPortfolioAllocation', 'dimension'),
            items: items.build(),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd, r'RailPortfolioAllocation', 'valuedTotalUsd'),
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'RailPortfolioAllocation',
                'unvaluedAssetCount'),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'RailPortfolioAllocation', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'RailPortfolioAllocation', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'RailPortfolioAllocation', 'calculatedAt'),
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
            r'RailPortfolioAllocation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
