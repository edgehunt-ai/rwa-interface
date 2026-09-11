// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_holding_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioHoldingPage extends PortfolioHoldingPage {
  @override
  final PortfolioHoldingPageAllOfCoverage? coverage;
  @override
  final String totalEquityUsd;
  @override
  final BuiltList<PortfolioSourceSummary> sources;
  @override
  final DateTime? oldestObservationAt;
  @override
  final BuiltList<PortfolioNotice> warnings;
  @override
  final PortfolioDataStatus dataStatus;
  @override
  final PortfolioFreshness freshness;
  @override
  final BuiltList<HoldingGroup> items;
  @override
  final DateTime calculatedAt;
  @override
  final String? totalValueUsd;
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$PortfolioHoldingPage(
          [void Function(PortfolioHoldingPageBuilder)? updates]) =>
      (PortfolioHoldingPageBuilder()..update(updates))._build();

  _$PortfolioHoldingPage._(
      {this.coverage,
      required this.totalEquityUsd,
      required this.sources,
      this.oldestObservationAt,
      required this.warnings,
      required this.dataStatus,
      required this.freshness,
      required this.items,
      required this.calculatedAt,
      this.totalValueUsd,
      this.nextCursor,
      required this.hasMore})
      : super._();
  @override
  PortfolioHoldingPage rebuild(
          void Function(PortfolioHoldingPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioHoldingPageBuilder toBuilder() =>
      PortfolioHoldingPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioHoldingPage &&
        coverage == other.coverage &&
        totalEquityUsd == other.totalEquityUsd &&
        sources == other.sources &&
        oldestObservationAt == other.oldestObservationAt &&
        warnings == other.warnings &&
        dataStatus == other.dataStatus &&
        freshness == other.freshness &&
        items == other.items &&
        calculatedAt == other.calculatedAt &&
        totalValueUsd == other.totalValueUsd &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, coverage.hashCode);
    _$hash = $jc(_$hash, totalEquityUsd.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jc(_$hash, oldestObservationAt.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioHoldingPage')
          ..add('coverage', coverage)
          ..add('totalEquityUsd', totalEquityUsd)
          ..add('sources', sources)
          ..add('oldestObservationAt', oldestObservationAt)
          ..add('warnings', warnings)
          ..add('dataStatus', dataStatus)
          ..add('freshness', freshness)
          ..add('items', items)
          ..add('calculatedAt', calculatedAt)
          ..add('totalValueUsd', totalValueUsd)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class PortfolioHoldingPageBuilder
    implements
        Builder<PortfolioHoldingPage, PortfolioHoldingPageBuilder>,
        PageBuilder {
  _$PortfolioHoldingPage? _$v;

  PortfolioHoldingPageAllOfCoverageBuilder? _coverage;
  PortfolioHoldingPageAllOfCoverageBuilder get coverage =>
      _$this._coverage ??= PortfolioHoldingPageAllOfCoverageBuilder();
  set coverage(covariant PortfolioHoldingPageAllOfCoverageBuilder? coverage) =>
      _$this._coverage = coverage;

  String? _totalEquityUsd;
  String? get totalEquityUsd => _$this._totalEquityUsd;
  set totalEquityUsd(covariant String? totalEquityUsd) =>
      _$this._totalEquityUsd = totalEquityUsd;

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

  PortfolioDataStatus? _dataStatus;
  PortfolioDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(covariant PortfolioDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(covariant PortfolioFreshness? freshness) =>
      _$this._freshness = freshness;

  ListBuilder<HoldingGroup>? _items;
  ListBuilder<HoldingGroup> get items =>
      _$this._items ??= ListBuilder<HoldingGroup>();
  set items(covariant ListBuilder<HoldingGroup>? items) =>
      _$this._items = items;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(covariant DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(covariant String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  PortfolioHoldingPageBuilder() {
    PortfolioHoldingPage._defaults(this);
  }

  PortfolioHoldingPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coverage = $v.coverage?.toBuilder();
      _totalEquityUsd = $v.totalEquityUsd;
      _sources = $v.sources.toBuilder();
      _oldestObservationAt = $v.oldestObservationAt;
      _warnings = $v.warnings.toBuilder();
      _dataStatus = $v.dataStatus;
      _freshness = $v.freshness;
      _items = $v.items.toBuilder();
      _calculatedAt = $v.calculatedAt;
      _totalValueUsd = $v.totalValueUsd;
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant PortfolioHoldingPage other) {
    _$v = other as _$PortfolioHoldingPage;
  }

  @override
  void update(void Function(PortfolioHoldingPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioHoldingPage build() => _build();

  _$PortfolioHoldingPage _build() {
    _$PortfolioHoldingPage _$result;
    try {
      _$result = _$v ??
          _$PortfolioHoldingPage._(
            coverage: _coverage?.build(),
            totalEquityUsd: BuiltValueNullFieldError.checkNotNull(
                totalEquityUsd, r'PortfolioHoldingPage', 'totalEquityUsd'),
            sources: sources.build(),
            oldestObservationAt: oldestObservationAt,
            warnings: warnings.build(),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'PortfolioHoldingPage', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioHoldingPage', 'freshness'),
            items: items.build(),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'PortfolioHoldingPage', 'calculatedAt'),
            totalValueUsd: totalValueUsd,
            nextCursor: nextCursor,
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'PortfolioHoldingPage', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coverage';
        _coverage?.build();

        _$failedField = 'sources';
        sources.build();

        _$failedField = 'warnings';
        warnings.build();

        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioHoldingPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
