// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_asset_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAssetPageAccountEnum _$portfolioAssetPageAccountEnum_spot =
    const PortfolioAssetPageAccountEnum._('spot');

PortfolioAssetPageAccountEnum _$portfolioAssetPageAccountEnumValueOf(
    String name) {
  switch (name) {
    case 'spot':
      return _$portfolioAssetPageAccountEnum_spot;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioAssetPageAccountEnum>
    _$portfolioAssetPageAccountEnumValues = BuiltSet<
        PortfolioAssetPageAccountEnum>(const <PortfolioAssetPageAccountEnum>[
  _$portfolioAssetPageAccountEnum_spot,
]);

Serializer<PortfolioAssetPageAccountEnum>
    _$portfolioAssetPageAccountEnumSerializer =
    _$PortfolioAssetPageAccountEnumSerializer();

class _$PortfolioAssetPageAccountEnumSerializer
    implements PrimitiveSerializer<PortfolioAssetPageAccountEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'spot': 'spot',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'spot': 'spot',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAssetPageAccountEnum];
  @override
  final String wireName = 'PortfolioAssetPageAccountEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioAssetPageAccountEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAssetPageAccountEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAssetPageAccountEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAssetPage extends PortfolioAssetPage {
  @override
  final int unvaluedAssetCount;
  @override
  final BuiltList<PortfolioSourceSummary> sources;
  @override
  final DateTime? oldestObservationAt;
  @override
  final BuiltList<PortfolioNotice> warnings;
  @override
  final String? filteredTotalUsd;
  @override
  final PortfolioDataStatus dataStatus;
  @override
  final String valuedTotalUsd;
  @override
  final int? totalCount;
  @override
  final PortfolioFreshness freshness;
  @override
  final BuiltList<PortfolioAsset> items;
  @override
  final PortfolioAssetPageAccountEnum? account;
  @override
  final DateTime calculatedAt;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$PortfolioAssetPage(
          [void Function(PortfolioAssetPageBuilder)? updates]) =>
      (PortfolioAssetPageBuilder()..update(updates))._build();

  _$PortfolioAssetPage._(
      {required this.unvaluedAssetCount,
      required this.sources,
      this.oldestObservationAt,
      required this.warnings,
      this.filteredTotalUsd,
      required this.dataStatus,
      required this.valuedTotalUsd,
      this.totalCount,
      required this.freshness,
      required this.items,
      this.account,
      required this.calculatedAt,
      this.nextCursor,
      required this.hasMore})
      : super._();
  @override
  PortfolioAssetPage rebuild(
          void Function(PortfolioAssetPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAssetPageBuilder toBuilder() =>
      PortfolioAssetPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAssetPage &&
        unvaluedAssetCount == other.unvaluedAssetCount &&
        sources == other.sources &&
        oldestObservationAt == other.oldestObservationAt &&
        warnings == other.warnings &&
        filteredTotalUsd == other.filteredTotalUsd &&
        dataStatus == other.dataStatus &&
        valuedTotalUsd == other.valuedTotalUsd &&
        totalCount == other.totalCount &&
        freshness == other.freshness &&
        items == other.items &&
        account == other.account &&
        calculatedAt == other.calculatedAt &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unvaluedAssetCount.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jc(_$hash, oldestObservationAt.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, filteredTotalUsd.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, valuedTotalUsd.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAssetPage')
          ..add('unvaluedAssetCount', unvaluedAssetCount)
          ..add('sources', sources)
          ..add('oldestObservationAt', oldestObservationAt)
          ..add('warnings', warnings)
          ..add('filteredTotalUsd', filteredTotalUsd)
          ..add('dataStatus', dataStatus)
          ..add('valuedTotalUsd', valuedTotalUsd)
          ..add('totalCount', totalCount)
          ..add('freshness', freshness)
          ..add('items', items)
          ..add('account', account)
          ..add('calculatedAt', calculatedAt)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class PortfolioAssetPageBuilder
    implements
        Builder<PortfolioAssetPage, PortfolioAssetPageBuilder>,
        PageBuilder {
  _$PortfolioAssetPage? _$v;

  int? _unvaluedAssetCount;
  int? get unvaluedAssetCount => _$this._unvaluedAssetCount;
  set unvaluedAssetCount(covariant int? unvaluedAssetCount) =>
      _$this._unvaluedAssetCount = unvaluedAssetCount;

  ListBuilder<PortfolioSourceSummary>? _sources;
  ListBuilder<PortfolioSourceSummary> get sources =>
      _$this._sources ??= ListBuilder<PortfolioSourceSummary>();
  set sources(covariant ListBuilder<PortfolioSourceSummary>? sources) =>
      _$this._sources = sources;

  DateTime? _oldestObservationAt;
  DateTime? get oldestObservationAt => _$this._oldestObservationAt;
  set oldestObservationAt(covariant DateTime? oldestObservationAt) =>
      _$this._oldestObservationAt = oldestObservationAt;

  ListBuilder<PortfolioNotice>? _warnings;
  ListBuilder<PortfolioNotice> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioNotice>();
  set warnings(covariant ListBuilder<PortfolioNotice>? warnings) =>
      _$this._warnings = warnings;

  String? _filteredTotalUsd;
  String? get filteredTotalUsd => _$this._filteredTotalUsd;
  set filteredTotalUsd(covariant String? filteredTotalUsd) =>
      _$this._filteredTotalUsd = filteredTotalUsd;

  PortfolioDataStatus? _dataStatus;
  PortfolioDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(covariant PortfolioDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  String? _valuedTotalUsd;
  String? get valuedTotalUsd => _$this._valuedTotalUsd;
  set valuedTotalUsd(covariant String? valuedTotalUsd) =>
      _$this._valuedTotalUsd = valuedTotalUsd;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(covariant int? totalCount) => _$this._totalCount = totalCount;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(covariant PortfolioFreshness? freshness) =>
      _$this._freshness = freshness;

  ListBuilder<PortfolioAsset>? _items;
  ListBuilder<PortfolioAsset> get items =>
      _$this._items ??= ListBuilder<PortfolioAsset>();
  set items(covariant ListBuilder<PortfolioAsset>? items) =>
      _$this._items = items;

  PortfolioAssetPageAccountEnum? _account;
  PortfolioAssetPageAccountEnum? get account => _$this._account;
  set account(covariant PortfolioAssetPageAccountEnum? account) =>
      _$this._account = account;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(covariant DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  PortfolioAssetPageBuilder() {
    PortfolioAssetPage._defaults(this);
  }

  PortfolioAssetPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unvaluedAssetCount = $v.unvaluedAssetCount;
      _sources = $v.sources.toBuilder();
      _oldestObservationAt = $v.oldestObservationAt;
      _warnings = $v.warnings.toBuilder();
      _filteredTotalUsd = $v.filteredTotalUsd;
      _dataStatus = $v.dataStatus;
      _valuedTotalUsd = $v.valuedTotalUsd;
      _totalCount = $v.totalCount;
      _freshness = $v.freshness;
      _items = $v.items.toBuilder();
      _account = $v.account;
      _calculatedAt = $v.calculatedAt;
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PortfolioAssetPage other) {
    _$v = other as _$PortfolioAssetPage;
  }

  @override
  void update(void Function(PortfolioAssetPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAssetPage build() => _build();

  _$PortfolioAssetPage _build() {
    _$PortfolioAssetPage _$result;
    try {
      _$result = _$v ??
          _$PortfolioAssetPage._(
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount,
                r'PortfolioAssetPage',
                'unvaluedAssetCount'),
            sources: sources.build(),
            oldestObservationAt: oldestObservationAt,
            warnings: warnings.build(),
            filteredTotalUsd: filteredTotalUsd,
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'PortfolioAssetPage', 'dataStatus'),
            valuedTotalUsd: BuiltValueNullFieldError.checkNotNull(
                valuedTotalUsd, r'PortfolioAssetPage', 'valuedTotalUsd'),
            totalCount: totalCount,
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioAssetPage', 'freshness'),
            items: items.build(),
            account: account,
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'PortfolioAssetPage', 'calculatedAt'),
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'PortfolioAssetPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sources';
        sources.build();

        _$failedField = 'warnings';
        warnings.build();

        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioAssetPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
