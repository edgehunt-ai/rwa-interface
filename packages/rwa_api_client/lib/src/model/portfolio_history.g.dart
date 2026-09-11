// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_history.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioHistoryRangeEnum _$portfolioHistoryRangeEnum_n1d =
    const PortfolioHistoryRangeEnum._('n1d');
const PortfolioHistoryRangeEnum _$portfolioHistoryRangeEnum_n1w =
    const PortfolioHistoryRangeEnum._('n1w');
const PortfolioHistoryRangeEnum _$portfolioHistoryRangeEnum_n1m =
    const PortfolioHistoryRangeEnum._('n1m');
const PortfolioHistoryRangeEnum _$portfolioHistoryRangeEnum_n1y =
    const PortfolioHistoryRangeEnum._('n1y');
const PortfolioHistoryRangeEnum
    _$portfolioHistoryRangeEnum_unknownDefaultOpenApi =
    const PortfolioHistoryRangeEnum._('unknownDefaultOpenApi');

PortfolioHistoryRangeEnum _$portfolioHistoryRangeEnumValueOf(String name) {
  switch (name) {
    case 'n1d':
      return _$portfolioHistoryRangeEnum_n1d;
    case 'n1w':
      return _$portfolioHistoryRangeEnum_n1w;
    case 'n1m':
      return _$portfolioHistoryRangeEnum_n1m;
    case 'n1y':
      return _$portfolioHistoryRangeEnum_n1y;
    case 'unknownDefaultOpenApi':
      return _$portfolioHistoryRangeEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioHistoryRangeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioHistoryRangeEnum> _$portfolioHistoryRangeEnumValues =
    BuiltSet<PortfolioHistoryRangeEnum>(const <PortfolioHistoryRangeEnum>[
  _$portfolioHistoryRangeEnum_n1d,
  _$portfolioHistoryRangeEnum_n1w,
  _$portfolioHistoryRangeEnum_n1m,
  _$portfolioHistoryRangeEnum_n1y,
  _$portfolioHistoryRangeEnum_unknownDefaultOpenApi,
]);

const PortfolioHistoryIntervalEnum _$portfolioHistoryIntervalEnum_n5m =
    const PortfolioHistoryIntervalEnum._('n5m');
const PortfolioHistoryIntervalEnum _$portfolioHistoryIntervalEnum_n1h =
    const PortfolioHistoryIntervalEnum._('n1h');
const PortfolioHistoryIntervalEnum _$portfolioHistoryIntervalEnum_n1d =
    const PortfolioHistoryIntervalEnum._('n1d');
const PortfolioHistoryIntervalEnum _$portfolioHistoryIntervalEnum_n1w =
    const PortfolioHistoryIntervalEnum._('n1w');
const PortfolioHistoryIntervalEnum
    _$portfolioHistoryIntervalEnum_unknownDefaultOpenApi =
    const PortfolioHistoryIntervalEnum._('unknownDefaultOpenApi');

PortfolioHistoryIntervalEnum _$portfolioHistoryIntervalEnumValueOf(
    String name) {
  switch (name) {
    case 'n5m':
      return _$portfolioHistoryIntervalEnum_n5m;
    case 'n1h':
      return _$portfolioHistoryIntervalEnum_n1h;
    case 'n1d':
      return _$portfolioHistoryIntervalEnum_n1d;
    case 'n1w':
      return _$portfolioHistoryIntervalEnum_n1w;
    case 'unknownDefaultOpenApi':
      return _$portfolioHistoryIntervalEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioHistoryIntervalEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioHistoryIntervalEnum>
    _$portfolioHistoryIntervalEnumValues =
    BuiltSet<PortfolioHistoryIntervalEnum>(const <PortfolioHistoryIntervalEnum>[
  _$portfolioHistoryIntervalEnum_n5m,
  _$portfolioHistoryIntervalEnum_n1h,
  _$portfolioHistoryIntervalEnum_n1d,
  _$portfolioHistoryIntervalEnum_n1w,
  _$portfolioHistoryIntervalEnum_unknownDefaultOpenApi,
]);

Serializer<PortfolioHistoryRangeEnum> _$portfolioHistoryRangeEnumSerializer =
    _$PortfolioHistoryRangeEnumSerializer();
Serializer<PortfolioHistoryIntervalEnum>
    _$portfolioHistoryIntervalEnumSerializer =
    _$PortfolioHistoryIntervalEnumSerializer();

class _$PortfolioHistoryRangeEnumSerializer
    implements PrimitiveSerializer<PortfolioHistoryRangeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n1d': '1d',
    'n1w': '1w',
    'n1m': '1m',
    'n1y': '1y',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '1d': 'n1d',
    '1w': 'n1w',
    '1m': 'n1m',
    '1y': 'n1y',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioHistoryRangeEnum];
  @override
  final String wireName = 'PortfolioHistoryRangeEnum';

  @override
  Object serialize(Serializers serializers, PortfolioHistoryRangeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioHistoryRangeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioHistoryRangeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioHistoryIntervalEnumSerializer
    implements PrimitiveSerializer<PortfolioHistoryIntervalEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n5m': '5m',
    'n1h': '1h',
    'n1d': '1d',
    'n1w': '1w',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '5m': 'n5m',
    '1h': 'n1h',
    '1d': 'n1d',
    '1w': 'n1w',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioHistoryIntervalEnum];
  @override
  final String wireName = 'PortfolioHistoryIntervalEnum';

  @override
  Object serialize(Serializers serializers, PortfolioHistoryIntervalEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioHistoryIntervalEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioHistoryIntervalEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioHistory extends PortfolioHistory {
  @override
  final PortfolioHistoryRangeEnum range;
  @override
  final PortfolioHistoryIntervalEnum interval;
  @override
  final BuiltList<PortfolioHistoryPoint> points;
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

  factory _$PortfolioHistory(
          [void Function(PortfolioHistoryBuilder)? updates]) =>
      (PortfolioHistoryBuilder()..update(updates))._build();

  _$PortfolioHistory._(
      {required this.range,
      required this.interval,
      required this.points,
      required this.dataStatus,
      required this.freshness,
      required this.calculatedAt,
      required this.warnings,
      required this.sources})
      : super._();
  @override
  PortfolioHistory rebuild(void Function(PortfolioHistoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioHistoryBuilder toBuilder() =>
      PortfolioHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioHistory &&
        range == other.range &&
        interval == other.interval &&
        points == other.points &&
        dataStatus == other.dataStatus &&
        freshness == other.freshness &&
        calculatedAt == other.calculatedAt &&
        warnings == other.warnings &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, range.hashCode);
    _$hash = $jc(_$hash, interval.hashCode);
    _$hash = $jc(_$hash, points.hashCode);
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
    return (newBuiltValueToStringHelper(r'PortfolioHistory')
          ..add('range', range)
          ..add('interval', interval)
          ..add('points', points)
          ..add('dataStatus', dataStatus)
          ..add('freshness', freshness)
          ..add('calculatedAt', calculatedAt)
          ..add('warnings', warnings)
          ..add('sources', sources))
        .toString();
  }
}

class PortfolioHistoryBuilder
    implements Builder<PortfolioHistory, PortfolioHistoryBuilder> {
  _$PortfolioHistory? _$v;

  PortfolioHistoryRangeEnum? _range;
  PortfolioHistoryRangeEnum? get range => _$this._range;
  set range(PortfolioHistoryRangeEnum? range) => _$this._range = range;

  PortfolioHistoryIntervalEnum? _interval;
  PortfolioHistoryIntervalEnum? get interval => _$this._interval;
  set interval(PortfolioHistoryIntervalEnum? interval) =>
      _$this._interval = interval;

  ListBuilder<PortfolioHistoryPoint>? _points;
  ListBuilder<PortfolioHistoryPoint> get points =>
      _$this._points ??= ListBuilder<PortfolioHistoryPoint>();
  set points(ListBuilder<PortfolioHistoryPoint>? points) =>
      _$this._points = points;

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

  PortfolioHistoryBuilder() {
    PortfolioHistory._defaults(this);
  }

  PortfolioHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _range = $v.range;
      _interval = $v.interval;
      _points = $v.points.toBuilder();
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
  void replace(PortfolioHistory other) {
    _$v = other as _$PortfolioHistory;
  }

  @override
  void update(void Function(PortfolioHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioHistory build() => _build();

  _$PortfolioHistory _build() {
    _$PortfolioHistory _$result;
    try {
      _$result = _$v ??
          _$PortfolioHistory._(
            range: BuiltValueNullFieldError.checkNotNull(
                range, r'PortfolioHistory', 'range'),
            interval: BuiltValueNullFieldError.checkNotNull(
                interval, r'PortfolioHistory', 'interval'),
            points: points.build(),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'PortfolioHistory', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioHistory', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'PortfolioHistory', 'calculatedAt'),
            warnings: warnings.build(),
            sources: sources.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'points';
        points.build();

        _$failedField = 'warnings';
        warnings.build();
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioHistory', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
