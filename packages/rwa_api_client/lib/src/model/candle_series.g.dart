// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle_series.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CandleSeries extends CandleSeries {
  @override
  final String symbol;
  @override
  final ProductKind kind;
  @override
  final ChartRange range;
  @override
  final String? interval;
  @override
  final DateTime? from;
  @override
  final DateTime? to;
  @override
  final String? changeAbsolute;
  @override
  final String? changePercent;
  @override
  final BuiltList<CandlePoint> points;
  @override
  final BuiltList<CandlePoint>? referencePoints;
  @override
  final BuiltList<SessionSegment>? sessions;

  factory _$CandleSeries([void Function(CandleSeriesBuilder)? updates]) =>
      (CandleSeriesBuilder()..update(updates))._build();

  _$CandleSeries._(
      {required this.symbol,
      required this.kind,
      required this.range,
      this.interval,
      this.from,
      this.to,
      this.changeAbsolute,
      this.changePercent,
      required this.points,
      this.referencePoints,
      this.sessions})
      : super._();
  @override
  CandleSeries rebuild(void Function(CandleSeriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CandleSeriesBuilder toBuilder() => CandleSeriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CandleSeries &&
        symbol == other.symbol &&
        kind == other.kind &&
        range == other.range &&
        interval == other.interval &&
        from == other.from &&
        to == other.to &&
        changeAbsolute == other.changeAbsolute &&
        changePercent == other.changePercent &&
        points == other.points &&
        referencePoints == other.referencePoints &&
        sessions == other.sessions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, range.hashCode);
    _$hash = $jc(_$hash, interval.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, changeAbsolute.hashCode);
    _$hash = $jc(_$hash, changePercent.hashCode);
    _$hash = $jc(_$hash, points.hashCode);
    _$hash = $jc(_$hash, referencePoints.hashCode);
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CandleSeries')
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('range', range)
          ..add('interval', interval)
          ..add('from', from)
          ..add('to', to)
          ..add('changeAbsolute', changeAbsolute)
          ..add('changePercent', changePercent)
          ..add('points', points)
          ..add('referencePoints', referencePoints)
          ..add('sessions', sessions))
        .toString();
  }
}

class CandleSeriesBuilder
    implements Builder<CandleSeries, CandleSeriesBuilder> {
  _$CandleSeries? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  ChartRange? _range;
  ChartRange? get range => _$this._range;
  set range(ChartRange? range) => _$this._range = range;

  String? _interval;
  String? get interval => _$this._interval;
  set interval(String? interval) => _$this._interval = interval;

  DateTime? _from;
  DateTime? get from => _$this._from;
  set from(DateTime? from) => _$this._from = from;

  DateTime? _to;
  DateTime? get to => _$this._to;
  set to(DateTime? to) => _$this._to = to;

  String? _changeAbsolute;
  String? get changeAbsolute => _$this._changeAbsolute;
  set changeAbsolute(String? changeAbsolute) =>
      _$this._changeAbsolute = changeAbsolute;

  String? _changePercent;
  String? get changePercent => _$this._changePercent;
  set changePercent(String? changePercent) =>
      _$this._changePercent = changePercent;

  ListBuilder<CandlePoint>? _points;
  ListBuilder<CandlePoint> get points =>
      _$this._points ??= ListBuilder<CandlePoint>();
  set points(ListBuilder<CandlePoint>? points) => _$this._points = points;

  ListBuilder<CandlePoint>? _referencePoints;
  ListBuilder<CandlePoint> get referencePoints =>
      _$this._referencePoints ??= ListBuilder<CandlePoint>();
  set referencePoints(ListBuilder<CandlePoint>? referencePoints) =>
      _$this._referencePoints = referencePoints;

  ListBuilder<SessionSegment>? _sessions;
  ListBuilder<SessionSegment> get sessions =>
      _$this._sessions ??= ListBuilder<SessionSegment>();
  set sessions(ListBuilder<SessionSegment>? sessions) =>
      _$this._sessions = sessions;

  CandleSeriesBuilder() {
    CandleSeries._defaults(this);
  }

  CandleSeriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _kind = $v.kind;
      _range = $v.range;
      _interval = $v.interval;
      _from = $v.from;
      _to = $v.to;
      _changeAbsolute = $v.changeAbsolute;
      _changePercent = $v.changePercent;
      _points = $v.points.toBuilder();
      _referencePoints = $v.referencePoints?.toBuilder();
      _sessions = $v.sessions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CandleSeries other) {
    _$v = other as _$CandleSeries;
  }

  @override
  void update(void Function(CandleSeriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CandleSeries build() => _build();

  _$CandleSeries _build() {
    _$CandleSeries _$result;
    try {
      _$result = _$v ??
          _$CandleSeries._(
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'CandleSeries', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'CandleSeries', 'kind'),
            range: BuiltValueNullFieldError.checkNotNull(
                range, r'CandleSeries', 'range'),
            interval: interval,
            from: from,
            to: to,
            changeAbsolute: changeAbsolute,
            changePercent: changePercent,
            points: points.build(),
            referencePoints: _referencePoints?.build(),
            sessions: _sessions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'points';
        points.build();
        _$failedField = 'referencePoints';
        _referencePoints?.build();
        _$failedField = 'sessions';
        _sessions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CandleSeries', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
