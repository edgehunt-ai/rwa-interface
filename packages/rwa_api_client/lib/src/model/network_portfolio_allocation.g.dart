// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_portfolio_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NetworkPortfolioAllocationDimensionEnum
    _$networkPortfolioAllocationDimensionEnum_network =
    const NetworkPortfolioAllocationDimensionEnum._('network');
const NetworkPortfolioAllocationDimensionEnum
    _$networkPortfolioAllocationDimensionEnum_unknownDefaultOpenApi =
    const NetworkPortfolioAllocationDimensionEnum._('unknownDefaultOpenApi');

NetworkPortfolioAllocationDimensionEnum
    _$networkPortfolioAllocationDimensionEnumValueOf(String name) {
  switch (name) {
    case 'network':
      return _$networkPortfolioAllocationDimensionEnum_network;
    case 'unknownDefaultOpenApi':
      return _$networkPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
    default:
      return _$networkPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<NetworkPortfolioAllocationDimensionEnum>
    _$networkPortfolioAllocationDimensionEnumValues = BuiltSet<
        NetworkPortfolioAllocationDimensionEnum>(const <NetworkPortfolioAllocationDimensionEnum>[
  _$networkPortfolioAllocationDimensionEnum_network,
  _$networkPortfolioAllocationDimensionEnum_unknownDefaultOpenApi,
]);

Serializer<NetworkPortfolioAllocationDimensionEnum>
    _$networkPortfolioAllocationDimensionEnumSerializer =
    _$NetworkPortfolioAllocationDimensionEnumSerializer();

class _$NetworkPortfolioAllocationDimensionEnumSerializer
    implements PrimitiveSerializer<NetworkPortfolioAllocationDimensionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'network': 'network',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'network': 'network',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    NetworkPortfolioAllocationDimensionEnum
  ];
  @override
  final String wireName = 'NetworkPortfolioAllocationDimensionEnum';

  @override
  Object serialize(Serializers serializers,
          NetworkPortfolioAllocationDimensionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NetworkPortfolioAllocationDimensionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NetworkPortfolioAllocationDimensionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$NetworkPortfolioAllocation extends NetworkPortfolioAllocation {
  @override
  final NetworkPortfolioAllocationDimensionEnum dimension;
  @override
  final BuiltList<NetworkPortfolioAllocationItem> items;
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

  factory _$NetworkPortfolioAllocation(
          [void Function(NetworkPortfolioAllocationBuilder)? updates]) =>
      (NetworkPortfolioAllocationBuilder()..update(updates))._build();

  _$NetworkPortfolioAllocation._(
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
  NetworkPortfolioAllocation rebuild(
          void Function(NetworkPortfolioAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NetworkPortfolioAllocationBuilder toBuilder() =>
      NetworkPortfolioAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NetworkPortfolioAllocation &&
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
    return (newBuiltValueToStringHelper(r'NetworkPortfolioAllocation')
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

class NetworkPortfolioAllocationBuilder
    implements
        Builder<NetworkPortfolioAllocation, NetworkPortfolioAllocationBuilder> {
  _$NetworkPortfolioAllocation? _$v;

  NetworkPortfolioAllocationDimensionEnum? _dimension;
  NetworkPortfolioAllocationDimensionEnum? get dimension => _$this._dimension;
  set dimension(NetworkPortfolioAllocationDimensionEnum? dimension) =>
      _$this._dimension = dimension;

  ListBuilder<NetworkPortfolioAllocationItem>? _items;
  ListBuilder<NetworkPortfolioAllocationItem> get items =>
      _$this._items ??= ListBuilder<NetworkPortfolioAllocationItem>();
  set items(ListBuilder<NetworkPortfolioAllocationItem>? items) =>
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

  NetworkPortfolioAllocationBuilder() {
    NetworkPortfolioAllocation._defaults(this);
  }

  NetworkPortfolioAllocationBuilder get _$this {
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
  void replace(NetworkPortfolioAllocation other) {
    _$v = other as _$NetworkPortfolioAllocation;
  }

  @override
  void update(void Function(NetworkPortfolioAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NetworkPortfolioAllocation build() => _build();

  _$NetworkPortfolioAllocation _build() {
    _$NetworkPortfolioAllocation _$result;
    try {
      _$result = _$v ??
          _$NetworkPortfolioAllocation._(
            dimension: BuiltValueNullFieldError.checkNotNull(
                dimension, r'NetworkPortfolioAllocation', 'dimension'),
            items: items.build(),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd,
                r'NetworkPortfolioAllocation',
                'valuedTotalUsd'),
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'NetworkPortfolioAllocation',
                'unvaluedAssetCount'),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'NetworkPortfolioAllocation', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'NetworkPortfolioAllocation', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'NetworkPortfolioAllocation', 'calculatedAt'),
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
            r'NetworkPortfolioAllocation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
