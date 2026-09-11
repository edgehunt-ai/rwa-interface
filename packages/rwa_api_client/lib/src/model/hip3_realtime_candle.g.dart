// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_candle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimeCandleEnvironmentEnum
    _$hip3RealtimeCandleEnvironmentEnum_mainnet =
    const Hip3RealtimeCandleEnvironmentEnum._('mainnet');
const Hip3RealtimeCandleEnvironmentEnum
    _$hip3RealtimeCandleEnvironmentEnum_testnet =
    const Hip3RealtimeCandleEnvironmentEnum._('testnet');
const Hip3RealtimeCandleEnvironmentEnum
    _$hip3RealtimeCandleEnvironmentEnum_unknownDefaultOpenApi =
    const Hip3RealtimeCandleEnvironmentEnum._('unknownDefaultOpenApi');

Hip3RealtimeCandleEnvironmentEnum _$hip3RealtimeCandleEnvironmentEnumValueOf(
    String name) {
  switch (name) {
    case 'mainnet':
      return _$hip3RealtimeCandleEnvironmentEnum_mainnet;
    case 'testnet':
      return _$hip3RealtimeCandleEnvironmentEnum_testnet;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeCandleEnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeCandleEnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeCandleEnvironmentEnum>
    _$hip3RealtimeCandleEnvironmentEnumValues = BuiltSet<
        Hip3RealtimeCandleEnvironmentEnum>(const <Hip3RealtimeCandleEnvironmentEnum>[
  _$hip3RealtimeCandleEnvironmentEnum_mainnet,
  _$hip3RealtimeCandleEnvironmentEnum_testnet,
  _$hip3RealtimeCandleEnvironmentEnum_unknownDefaultOpenApi,
]);

const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n1m =
    const Hip3RealtimeCandleIntervalEnum._('n1m');
const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n5m =
    const Hip3RealtimeCandleIntervalEnum._('n5m');
const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n15m =
    const Hip3RealtimeCandleIntervalEnum._('n15m');
const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n1h =
    const Hip3RealtimeCandleIntervalEnum._('n1h');
const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n4h =
    const Hip3RealtimeCandleIntervalEnum._('n4h');
const Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnum_n1d =
    const Hip3RealtimeCandleIntervalEnum._('n1d');
const Hip3RealtimeCandleIntervalEnum
    _$hip3RealtimeCandleIntervalEnum_unknownDefaultOpenApi =
    const Hip3RealtimeCandleIntervalEnum._('unknownDefaultOpenApi');

Hip3RealtimeCandleIntervalEnum _$hip3RealtimeCandleIntervalEnumValueOf(
    String name) {
  switch (name) {
    case 'n1m':
      return _$hip3RealtimeCandleIntervalEnum_n1m;
    case 'n5m':
      return _$hip3RealtimeCandleIntervalEnum_n5m;
    case 'n15m':
      return _$hip3RealtimeCandleIntervalEnum_n15m;
    case 'n1h':
      return _$hip3RealtimeCandleIntervalEnum_n1h;
    case 'n4h':
      return _$hip3RealtimeCandleIntervalEnum_n4h;
    case 'n1d':
      return _$hip3RealtimeCandleIntervalEnum_n1d;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimeCandleIntervalEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimeCandleIntervalEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimeCandleIntervalEnum>
    _$hip3RealtimeCandleIntervalEnumValues = BuiltSet<
        Hip3RealtimeCandleIntervalEnum>(const <Hip3RealtimeCandleIntervalEnum>[
  _$hip3RealtimeCandleIntervalEnum_n1m,
  _$hip3RealtimeCandleIntervalEnum_n5m,
  _$hip3RealtimeCandleIntervalEnum_n15m,
  _$hip3RealtimeCandleIntervalEnum_n1h,
  _$hip3RealtimeCandleIntervalEnum_n4h,
  _$hip3RealtimeCandleIntervalEnum_n1d,
  _$hip3RealtimeCandleIntervalEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimeCandleEnvironmentEnum>
    _$hip3RealtimeCandleEnvironmentEnumSerializer =
    _$Hip3RealtimeCandleEnvironmentEnumSerializer();
Serializer<Hip3RealtimeCandleIntervalEnum>
    _$hip3RealtimeCandleIntervalEnumSerializer =
    _$Hip3RealtimeCandleIntervalEnumSerializer();

class _$Hip3RealtimeCandleEnvironmentEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeCandleEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimeCandleEnvironmentEnum];
  @override
  final String wireName = 'Hip3RealtimeCandleEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeCandleEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeCandleEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeCandleEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeCandleIntervalEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimeCandleIntervalEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3RealtimeCandleIntervalEnum];
  @override
  final String wireName = 'Hip3RealtimeCandleIntervalEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimeCandleIntervalEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimeCandleIntervalEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimeCandleIntervalEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimeCandle extends Hip3RealtimeCandle {
  @override
  final String source_;
  @override
  final bool closed;
  @override
  final DateTime freshUntil;
  @override
  final DateTime updatedAt;
  @override
  final String productId;
  @override
  final String venue;
  @override
  final Hip3PublicMarketEnvironmentEnum environment;
  @override
  final String settlementAsset;
  @override
  final bool tradable;
  @override
  final String? unavailableReason;
  @override
  final String symbol;
  @override
  final ProductKind kind;
  @override
  final RealtimeCandleUpdateIntervalEnum interval;
  @override
  final CandlePoint point;

  factory _$Hip3RealtimeCandle(
          [void Function(Hip3RealtimeCandleBuilder)? updates]) =>
      (Hip3RealtimeCandleBuilder()..update(updates))._build();

  _$Hip3RealtimeCandle._(
      {required this.source_,
      required this.closed,
      required this.freshUntil,
      required this.updatedAt,
      required this.productId,
      required this.venue,
      required this.environment,
      required this.settlementAsset,
      required this.tradable,
      this.unavailableReason,
      required this.symbol,
      required this.kind,
      required this.interval,
      required this.point})
      : super._();
  @override
  Hip3RealtimeCandle rebuild(
          void Function(Hip3RealtimeCandleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimeCandleBuilder toBuilder() =>
      Hip3RealtimeCandleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimeCandle &&
        source_ == other.source_ &&
        closed == other.closed &&
        freshUntil == other.freshUntil &&
        updatedAt == other.updatedAt &&
        productId == other.productId &&
        venue == other.venue &&
        environment == other.environment &&
        settlementAsset == other.settlementAsset &&
        tradable == other.tradable &&
        unavailableReason == other.unavailableReason &&
        symbol == other.symbol &&
        kind == other.kind &&
        interval == other.interval &&
        point == other.point;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, closed.hashCode);
    _$hash = $jc(_$hash, freshUntil.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, venue.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, tradable.hashCode);
    _$hash = $jc(_$hash, unavailableReason.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, interval.hashCode);
    _$hash = $jc(_$hash, point.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3RealtimeCandle')
          ..add('source_', source_)
          ..add('closed', closed)
          ..add('freshUntil', freshUntil)
          ..add('updatedAt', updatedAt)
          ..add('productId', productId)
          ..add('venue', venue)
          ..add('environment', environment)
          ..add('settlementAsset', settlementAsset)
          ..add('tradable', tradable)
          ..add('unavailableReason', unavailableReason)
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('interval', interval)
          ..add('point', point))
        .toString();
  }
}

class Hip3RealtimeCandleBuilder
    implements
        Builder<Hip3RealtimeCandle, Hip3RealtimeCandleBuilder>,
        Hip3PublicMarketBuilder,
        RealtimeCandleUpdateBuilder {
  _$Hip3RealtimeCandle? _$v;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(covariant String? source_) => _$this._source_ = source_;

  bool? _closed;
  bool? get closed => _$this._closed;
  set closed(covariant bool? closed) => _$this._closed = closed;

  DateTime? _freshUntil;
  DateTime? get freshUntil => _$this._freshUntil;
  set freshUntil(covariant DateTime? freshUntil) =>
      _$this._freshUntil = freshUntil;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(covariant String? productId) => _$this._productId = productId;

  String? _venue;
  String? get venue => _$this._venue;
  set venue(covariant String? venue) => _$this._venue = venue;

  Hip3PublicMarketEnvironmentEnum? _environment;
  Hip3PublicMarketEnvironmentEnum? get environment => _$this._environment;
  set environment(covariant Hip3PublicMarketEnvironmentEnum? environment) =>
      _$this._environment = environment;

  String? _settlementAsset;
  String? get settlementAsset => _$this._settlementAsset;
  set settlementAsset(covariant String? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  bool? _tradable;
  bool? get tradable => _$this._tradable;
  set tradable(covariant bool? tradable) => _$this._tradable = tradable;

  String? _unavailableReason;
  String? get unavailableReason => _$this._unavailableReason;
  set unavailableReason(covariant String? unavailableReason) =>
      _$this._unavailableReason = unavailableReason;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(covariant String? symbol) => _$this._symbol = symbol;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(covariant ProductKind? kind) => _$this._kind = kind;

  RealtimeCandleUpdateIntervalEnum? _interval;
  RealtimeCandleUpdateIntervalEnum? get interval => _$this._interval;
  set interval(covariant RealtimeCandleUpdateIntervalEnum? interval) =>
      _$this._interval = interval;

  CandlePointBuilder? _point;
  CandlePointBuilder get point => _$this._point ??= CandlePointBuilder();
  set point(covariant CandlePointBuilder? point) => _$this._point = point;

  Hip3RealtimeCandleBuilder() {
    Hip3RealtimeCandle._defaults(this);
  }

  Hip3RealtimeCandleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_;
      _closed = $v.closed;
      _freshUntil = $v.freshUntil;
      _updatedAt = $v.updatedAt;
      _productId = $v.productId;
      _venue = $v.venue;
      _environment = $v.environment;
      _settlementAsset = $v.settlementAsset;
      _tradable = $v.tradable;
      _unavailableReason = $v.unavailableReason;
      _symbol = $v.symbol;
      _kind = $v.kind;
      _interval = $v.interval;
      _point = $v.point.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant Hip3RealtimeCandle other) {
    _$v = other as _$Hip3RealtimeCandle;
  }

  @override
  void update(void Function(Hip3RealtimeCandleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimeCandle build() => _build();

  _$Hip3RealtimeCandle _build() {
    _$Hip3RealtimeCandle _$result;
    try {
      _$result = _$v ??
          _$Hip3RealtimeCandle._(
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'Hip3RealtimeCandle', 'source_'),
            closed: BuiltValueNullFieldError.checkNotNull(
                closed, r'Hip3RealtimeCandle', 'closed'),
            freshUntil: BuiltValueNullFieldError.checkNotNull(
                freshUntil, r'Hip3RealtimeCandle', 'freshUntil'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'Hip3RealtimeCandle', 'updatedAt'),
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'Hip3RealtimeCandle', 'productId'),
            venue: BuiltValueNullFieldError.checkNotNull(
                venue, r'Hip3RealtimeCandle', 'venue'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3RealtimeCandle', 'environment'),
            settlementAsset: BuiltValueNullFieldError.checkNotNull(
                settlementAsset, r'Hip3RealtimeCandle', 'settlementAsset'),
            tradable: BuiltValueNullFieldError.checkNotNull(
                tradable, r'Hip3RealtimeCandle', 'tradable'),
            unavailableReason: unavailableReason,
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'Hip3RealtimeCandle', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'Hip3RealtimeCandle', 'kind'),
            interval: BuiltValueNullFieldError.checkNotNull(
                interval, r'Hip3RealtimeCandle', 'interval'),
            point: point.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'point';
        point.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3RealtimeCandle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
