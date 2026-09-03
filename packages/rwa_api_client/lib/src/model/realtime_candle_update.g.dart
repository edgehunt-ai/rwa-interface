// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_candle_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n1m =
    const RealtimeCandleUpdateIntervalEnum._('n1m');
const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n5m =
    const RealtimeCandleUpdateIntervalEnum._('n5m');
const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n15m =
    const RealtimeCandleUpdateIntervalEnum._('n15m');
const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n1h =
    const RealtimeCandleUpdateIntervalEnum._('n1h');
const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n4h =
    const RealtimeCandleUpdateIntervalEnum._('n4h');
const RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnum_n1d =
    const RealtimeCandleUpdateIntervalEnum._('n1d');
const RealtimeCandleUpdateIntervalEnum
    _$realtimeCandleUpdateIntervalEnum_unknownDefaultOpenApi =
    const RealtimeCandleUpdateIntervalEnum._('unknownDefaultOpenApi');

RealtimeCandleUpdateIntervalEnum _$realtimeCandleUpdateIntervalEnumValueOf(
    String name) {
  switch (name) {
    case 'n1m':
      return _$realtimeCandleUpdateIntervalEnum_n1m;
    case 'n5m':
      return _$realtimeCandleUpdateIntervalEnum_n5m;
    case 'n15m':
      return _$realtimeCandleUpdateIntervalEnum_n15m;
    case 'n1h':
      return _$realtimeCandleUpdateIntervalEnum_n1h;
    case 'n4h':
      return _$realtimeCandleUpdateIntervalEnum_n4h;
    case 'n1d':
      return _$realtimeCandleUpdateIntervalEnum_n1d;
    case 'unknownDefaultOpenApi':
      return _$realtimeCandleUpdateIntervalEnum_unknownDefaultOpenApi;
    default:
      return _$realtimeCandleUpdateIntervalEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeCandleUpdateIntervalEnum>
    _$realtimeCandleUpdateIntervalEnumValues = BuiltSet<
        RealtimeCandleUpdateIntervalEnum>(const <RealtimeCandleUpdateIntervalEnum>[
  _$realtimeCandleUpdateIntervalEnum_n1m,
  _$realtimeCandleUpdateIntervalEnum_n5m,
  _$realtimeCandleUpdateIntervalEnum_n15m,
  _$realtimeCandleUpdateIntervalEnum_n1h,
  _$realtimeCandleUpdateIntervalEnum_n4h,
  _$realtimeCandleUpdateIntervalEnum_n1d,
  _$realtimeCandleUpdateIntervalEnum_unknownDefaultOpenApi,
]);

Serializer<RealtimeCandleUpdateIntervalEnum>
    _$realtimeCandleUpdateIntervalEnumSerializer =
    _$RealtimeCandleUpdateIntervalEnumSerializer();

class _$RealtimeCandleUpdateIntervalEnumSerializer
    implements PrimitiveSerializer<RealtimeCandleUpdateIntervalEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n1m': '1m',
    'n5m': '5m',
    'n15m': '15m',
    'n1h': '1h',
    'n4h': '4h',
    'n1d': '1d',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '1m': 'n1m',
    '5m': 'n5m',
    '15m': 'n15m',
    '1h': 'n1h',
    '4h': 'n4h',
    '1d': 'n1d',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeCandleUpdateIntervalEnum];
  @override
  final String wireName = 'RealtimeCandleUpdateIntervalEnum';

  @override
  Object serialize(
          Serializers serializers, RealtimeCandleUpdateIntervalEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeCandleUpdateIntervalEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeCandleUpdateIntervalEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RealtimeCandleUpdate extends RealtimeCandleUpdate {
  @override
  final String symbol;
  @override
  final ProductKind kind;
  @override
  final RealtimeCandleUpdateIntervalEnum interval;
  @override
  final CandlePoint point;

  factory _$RealtimeCandleUpdate(
          [void Function(RealtimeCandleUpdateBuilder)? updates]) =>
      (RealtimeCandleUpdateBuilder()..update(updates))._build();

  _$RealtimeCandleUpdate._(
      {required this.symbol,
      required this.kind,
      required this.interval,
      required this.point})
      : super._();
  @override
  RealtimeCandleUpdate rebuild(
          void Function(RealtimeCandleUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeCandleUpdateBuilder toBuilder() =>
      RealtimeCandleUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeCandleUpdate &&
        symbol == other.symbol &&
        kind == other.kind &&
        interval == other.interval &&
        point == other.point;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, interval.hashCode);
    _$hash = $jc(_$hash, point.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RealtimeCandleUpdate')
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('interval', interval)
          ..add('point', point))
        .toString();
  }
}

class RealtimeCandleUpdateBuilder
    implements Builder<RealtimeCandleUpdate, RealtimeCandleUpdateBuilder> {
  _$RealtimeCandleUpdate? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  RealtimeCandleUpdateIntervalEnum? _interval;
  RealtimeCandleUpdateIntervalEnum? get interval => _$this._interval;
  set interval(RealtimeCandleUpdateIntervalEnum? interval) =>
      _$this._interval = interval;

  CandlePointBuilder? _point;
  CandlePointBuilder get point => _$this._point ??= CandlePointBuilder();
  set point(CandlePointBuilder? point) => _$this._point = point;

  RealtimeCandleUpdateBuilder() {
    RealtimeCandleUpdate._defaults(this);
  }

  RealtimeCandleUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _kind = $v.kind;
      _interval = $v.interval;
      _point = $v.point.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RealtimeCandleUpdate other) {
    _$v = other as _$RealtimeCandleUpdate;
  }

  @override
  void update(void Function(RealtimeCandleUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeCandleUpdate build() => _build();

  _$RealtimeCandleUpdate _build() {
    _$RealtimeCandleUpdate _$result;
    try {
      _$result = _$v ??
          _$RealtimeCandleUpdate._(
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'RealtimeCandleUpdate', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'RealtimeCandleUpdate', 'kind'),
            interval: BuiltValueNullFieldError.checkNotNull(
                interval, r'RealtimeCandleUpdate', 'interval'),
            point: point.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'point';
        point.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeCandleUpdate', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
