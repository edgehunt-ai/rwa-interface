// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_realtime_price.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3RealtimePriceEnvironmentEnum
    _$hip3RealtimePriceEnvironmentEnum_mainnet =
    const Hip3RealtimePriceEnvironmentEnum._('mainnet');
const Hip3RealtimePriceEnvironmentEnum
    _$hip3RealtimePriceEnvironmentEnum_testnet =
    const Hip3RealtimePriceEnvironmentEnum._('testnet');
const Hip3RealtimePriceEnvironmentEnum
    _$hip3RealtimePriceEnvironmentEnum_unknownDefaultOpenApi =
    const Hip3RealtimePriceEnvironmentEnum._('unknownDefaultOpenApi');

Hip3RealtimePriceEnvironmentEnum _$hip3RealtimePriceEnvironmentEnumValueOf(
    String name) {
  switch (name) {
    case 'mainnet':
      return _$hip3RealtimePriceEnvironmentEnum_mainnet;
    case 'testnet':
      return _$hip3RealtimePriceEnvironmentEnum_testnet;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePriceEnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePriceEnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePriceEnvironmentEnum>
    _$hip3RealtimePriceEnvironmentEnumValues = BuiltSet<
        Hip3RealtimePriceEnvironmentEnum>(const <Hip3RealtimePriceEnvironmentEnum>[
  _$hip3RealtimePriceEnvironmentEnum_mainnet,
  _$hip3RealtimePriceEnvironmentEnum_testnet,
  _$hip3RealtimePriceEnvironmentEnum_unknownDefaultOpenApi,
]);

const Hip3RealtimePricePriceLabelEnum
    _$hip3RealtimePricePriceLabelEnum_markPrice =
    const Hip3RealtimePricePriceLabelEnum._('markPrice');
const Hip3RealtimePricePriceLabelEnum
    _$hip3RealtimePricePriceLabelEnum_unknownDefaultOpenApi =
    const Hip3RealtimePricePriceLabelEnum._('unknownDefaultOpenApi');

Hip3RealtimePricePriceLabelEnum _$hip3RealtimePricePriceLabelEnumValueOf(
    String name) {
  switch (name) {
    case 'markPrice':
      return _$hip3RealtimePricePriceLabelEnum_markPrice;
    case 'unknownDefaultOpenApi':
      return _$hip3RealtimePricePriceLabelEnum_unknownDefaultOpenApi;
    default:
      return _$hip3RealtimePricePriceLabelEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3RealtimePricePriceLabelEnum>
    _$hip3RealtimePricePriceLabelEnumValues = BuiltSet<
        Hip3RealtimePricePriceLabelEnum>(const <Hip3RealtimePricePriceLabelEnum>[
  _$hip3RealtimePricePriceLabelEnum_markPrice,
  _$hip3RealtimePricePriceLabelEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3RealtimePriceEnvironmentEnum>
    _$hip3RealtimePriceEnvironmentEnumSerializer =
    _$Hip3RealtimePriceEnvironmentEnumSerializer();
Serializer<Hip3RealtimePricePriceLabelEnum>
    _$hip3RealtimePricePriceLabelEnumSerializer =
    _$Hip3RealtimePricePriceLabelEnumSerializer();

class _$Hip3RealtimePriceEnvironmentEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePriceEnvironmentEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3RealtimePriceEnvironmentEnum];
  @override
  final String wireName = 'Hip3RealtimePriceEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePriceEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePriceEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePriceEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePricePriceLabelEnumSerializer
    implements PrimitiveSerializer<Hip3RealtimePricePriceLabelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'markPrice': 'Mark price',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Mark price': 'markPrice',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3RealtimePricePriceLabelEnum];
  @override
  final String wireName = 'Hip3RealtimePricePriceLabelEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3RealtimePricePriceLabelEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3RealtimePricePriceLabelEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3RealtimePricePriceLabelEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3RealtimePrice extends Hip3RealtimePrice {
  @override
  final String source_;
  @override
  final DateTime freshUntil;
  @override
  final Hip3RealtimePricePriceLabelEnum priceLabel;
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
  final String price;
  @override
  final String change24hPercent;
  @override
  final DateTime updatedAt;

  factory _$Hip3RealtimePrice(
          [void Function(Hip3RealtimePriceBuilder)? updates]) =>
      (Hip3RealtimePriceBuilder()..update(updates))._build();

  _$Hip3RealtimePrice._(
      {required this.source_,
      required this.freshUntil,
      required this.priceLabel,
      required this.productId,
      required this.venue,
      required this.environment,
      required this.settlementAsset,
      required this.tradable,
      this.unavailableReason,
      required this.symbol,
      required this.kind,
      required this.price,
      required this.change24hPercent,
      required this.updatedAt})
      : super._();
  @override
  Hip3RealtimePrice rebuild(void Function(Hip3RealtimePriceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3RealtimePriceBuilder toBuilder() =>
      Hip3RealtimePriceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3RealtimePrice &&
        source_ == other.source_ &&
        freshUntil == other.freshUntil &&
        priceLabel == other.priceLabel &&
        productId == other.productId &&
        venue == other.venue &&
        environment == other.environment &&
        settlementAsset == other.settlementAsset &&
        tradable == other.tradable &&
        unavailableReason == other.unavailableReason &&
        symbol == other.symbol &&
        kind == other.kind &&
        price == other.price &&
        change24hPercent == other.change24hPercent &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, freshUntil.hashCode);
    _$hash = $jc(_$hash, priceLabel.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, venue.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, tradable.hashCode);
    _$hash = $jc(_$hash, unavailableReason.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, change24hPercent.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3RealtimePrice')
          ..add('source_', source_)
          ..add('freshUntil', freshUntil)
          ..add('priceLabel', priceLabel)
          ..add('productId', productId)
          ..add('venue', venue)
          ..add('environment', environment)
          ..add('settlementAsset', settlementAsset)
          ..add('tradable', tradable)
          ..add('unavailableReason', unavailableReason)
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('price', price)
          ..add('change24hPercent', change24hPercent)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class Hip3RealtimePriceBuilder
    implements
        Builder<Hip3RealtimePrice, Hip3RealtimePriceBuilder>,
        Hip3PublicMarketBuilder,
        RealtimePriceUpdateBuilder {
  _$Hip3RealtimePrice? _$v;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(covariant String? source_) => _$this._source_ = source_;

  DateTime? _freshUntil;
  DateTime? get freshUntil => _$this._freshUntil;
  set freshUntil(covariant DateTime? freshUntil) =>
      _$this._freshUntil = freshUntil;

  Hip3RealtimePricePriceLabelEnum? _priceLabel;
  Hip3RealtimePricePriceLabelEnum? get priceLabel => _$this._priceLabel;
  set priceLabel(covariant Hip3RealtimePricePriceLabelEnum? priceLabel) =>
      _$this._priceLabel = priceLabel;

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

  String? _price;
  String? get price => _$this._price;
  set price(covariant String? price) => _$this._price = price;

  String? _change24hPercent;
  String? get change24hPercent => _$this._change24hPercent;
  set change24hPercent(covariant String? change24hPercent) =>
      _$this._change24hPercent = change24hPercent;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(covariant DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  Hip3RealtimePriceBuilder() {
    Hip3RealtimePrice._defaults(this);
  }

  Hip3RealtimePriceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _source_ = $v.source_;
      _freshUntil = $v.freshUntil;
      _priceLabel = $v.priceLabel;
      _productId = $v.productId;
      _venue = $v.venue;
      _environment = $v.environment;
      _settlementAsset = $v.settlementAsset;
      _tradable = $v.tradable;
      _unavailableReason = $v.unavailableReason;
      _symbol = $v.symbol;
      _kind = $v.kind;
      _price = $v.price;
      _change24hPercent = $v.change24hPercent;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
// ignore: override_on_non_overriding_method
  void replace(covariant Hip3RealtimePrice other) {
    _$v = other as _$Hip3RealtimePrice;
  }

  @override
  void update(void Function(Hip3RealtimePriceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3RealtimePrice build() => _build();

  _$Hip3RealtimePrice _build() {
    final _$result = _$v ??
        _$Hip3RealtimePrice._(
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'Hip3RealtimePrice', 'source_'),
          freshUntil: BuiltValueNullFieldError.checkNotNull(
              freshUntil, r'Hip3RealtimePrice', 'freshUntil'),
          priceLabel: BuiltValueNullFieldError.checkNotNull(
              priceLabel, r'Hip3RealtimePrice', 'priceLabel'),
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3RealtimePrice', 'productId'),
          venue: BuiltValueNullFieldError.checkNotNull(
              venue, r'Hip3RealtimePrice', 'venue'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'Hip3RealtimePrice', 'environment'),
          settlementAsset: BuiltValueNullFieldError.checkNotNull(
              settlementAsset, r'Hip3RealtimePrice', 'settlementAsset'),
          tradable: BuiltValueNullFieldError.checkNotNull(
              tradable, r'Hip3RealtimePrice', 'tradable'),
          unavailableReason: unavailableReason,
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'Hip3RealtimePrice', 'symbol'),
          kind: BuiltValueNullFieldError.checkNotNull(
              kind, r'Hip3RealtimePrice', 'kind'),
          price: BuiltValueNullFieldError.checkNotNull(
              price, r'Hip3RealtimePrice', 'price'),
          change24hPercent: BuiltValueNullFieldError.checkNotNull(
              change24hPercent, r'Hip3RealtimePrice', 'change24hPercent'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Hip3RealtimePrice', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
