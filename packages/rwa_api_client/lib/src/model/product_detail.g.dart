// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductDetailTradingHoursEnum _$productDetailTradingHoursEnum_n24x7 =
    const ProductDetailTradingHoursEnum._('n24x7');
const ProductDetailTradingHoursEnum
    _$productDetailTradingHoursEnum_usMarketHours =
    const ProductDetailTradingHoursEnum._('usMarketHours');
const ProductDetailTradingHoursEnum
    _$productDetailTradingHoursEnum_unknownDefaultOpenApi =
    const ProductDetailTradingHoursEnum._('unknownDefaultOpenApi');

ProductDetailTradingHoursEnum _$productDetailTradingHoursEnumValueOf(
    String name) {
  switch (name) {
    case 'n24x7':
      return _$productDetailTradingHoursEnum_n24x7;
    case 'usMarketHours':
      return _$productDetailTradingHoursEnum_usMarketHours;
    case 'unknownDefaultOpenApi':
      return _$productDetailTradingHoursEnum_unknownDefaultOpenApi;
    default:
      return _$productDetailTradingHoursEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductDetailTradingHoursEnum>
    _$productDetailTradingHoursEnumValues = BuiltSet<
        ProductDetailTradingHoursEnum>(const <ProductDetailTradingHoursEnum>[
  _$productDetailTradingHoursEnum_n24x7,
  _$productDetailTradingHoursEnum_usMarketHours,
  _$productDetailTradingHoursEnum_unknownDefaultOpenApi,
]);

Serializer<ProductDetailTradingHoursEnum>
    _$productDetailTradingHoursEnumSerializer =
    _$ProductDetailTradingHoursEnumSerializer();

class _$ProductDetailTradingHoursEnumSerializer
    implements PrimitiveSerializer<ProductDetailTradingHoursEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n24x7': '24x7',
    'usMarketHours': 'us_market_hours',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '24x7': 'n24x7',
    'us_market_hours': 'usMarketHours',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductDetailTradingHoursEnum];
  @override
  final String wireName = 'ProductDetailTradingHoursEnum';

  @override
  Object serialize(
          Serializers serializers, ProductDetailTradingHoursEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductDetailTradingHoursEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductDetailTradingHoursEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ProductDetail extends ProductDetail {
  @override
  final Hip3PublicMarket? hip3Market;
  @override
  final bool? tradable;
  @override
  final BstockOrderAssets? orderAssets;
  @override
  final bool? isFavorite;
  @override
  final String symbol;
  @override
  final String? name;
  @override
  final ProductKind kind;
  @override
  final String? title;
  @override
  final String? badge;
  @override
  final String? description;
  @override
  final Quote quote;
  @override
  final MarketStats? stats;
  @override
  final AssetInfo assetInfo;
  @override
  final ProductDetailTradingHoursEnum? tradingHours;

  factory _$ProductDetail([void Function(ProductDetailBuilder)? updates]) =>
      (ProductDetailBuilder()..update(updates))._build();

  _$ProductDetail._(
      {this.hip3Market,
      this.tradable,
      this.orderAssets,
      this.isFavorite,
      required this.symbol,
      this.name,
      required this.kind,
      this.title,
      this.badge,
      this.description,
      required this.quote,
      this.stats,
      required this.assetInfo,
      this.tradingHours})
      : super._();
  @override
  ProductDetail rebuild(void Function(ProductDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductDetailBuilder toBuilder() => ProductDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductDetail &&
        hip3Market == other.hip3Market &&
        tradable == other.tradable &&
        orderAssets == other.orderAssets &&
        isFavorite == other.isFavorite &&
        symbol == other.symbol &&
        name == other.name &&
        kind == other.kind &&
        title == other.title &&
        badge == other.badge &&
        description == other.description &&
        quote == other.quote &&
        stats == other.stats &&
        assetInfo == other.assetInfo &&
        tradingHours == other.tradingHours;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hip3Market.hashCode);
    _$hash = $jc(_$hash, tradable.hashCode);
    _$hash = $jc(_$hash, orderAssets.hashCode);
    _$hash = $jc(_$hash, isFavorite.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, badge.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, quote.hashCode);
    _$hash = $jc(_$hash, stats.hashCode);
    _$hash = $jc(_$hash, assetInfo.hashCode);
    _$hash = $jc(_$hash, tradingHours.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductDetail')
          ..add('hip3Market', hip3Market)
          ..add('tradable', tradable)
          ..add('orderAssets', orderAssets)
          ..add('isFavorite', isFavorite)
          ..add('symbol', symbol)
          ..add('name', name)
          ..add('kind', kind)
          ..add('title', title)
          ..add('badge', badge)
          ..add('description', description)
          ..add('quote', quote)
          ..add('stats', stats)
          ..add('assetInfo', assetInfo)
          ..add('tradingHours', tradingHours))
        .toString();
  }
}

class ProductDetailBuilder
    implements Builder<ProductDetail, ProductDetailBuilder> {
  _$ProductDetail? _$v;

  Hip3PublicMarket? _hip3Market;
  Hip3PublicMarket? get hip3Market => _$this._hip3Market;
  set hip3Market(Hip3PublicMarket? hip3Market) =>
      _$this._hip3Market = hip3Market;

  bool? _tradable;
  bool? get tradable => _$this._tradable;
  set tradable(bool? tradable) => _$this._tradable = tradable;

  BstockOrderAssetsBuilder? _orderAssets;
  BstockOrderAssetsBuilder get orderAssets =>
      _$this._orderAssets ??= BstockOrderAssetsBuilder();
  set orderAssets(BstockOrderAssetsBuilder? orderAssets) =>
      _$this._orderAssets = orderAssets;

  bool? _isFavorite;
  bool? get isFavorite => _$this._isFavorite;
  set isFavorite(bool? isFavorite) => _$this._isFavorite = isFavorite;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _badge;
  String? get badge => _$this._badge;
  set badge(String? badge) => _$this._badge = badge;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  QuoteBuilder? _quote;
  QuoteBuilder get quote => _$this._quote ??= QuoteBuilder();
  set quote(QuoteBuilder? quote) => _$this._quote = quote;

  MarketStatsBuilder? _stats;
  MarketStatsBuilder get stats => _$this._stats ??= MarketStatsBuilder();
  set stats(MarketStatsBuilder? stats) => _$this._stats = stats;

  AssetInfoBuilder? _assetInfo;
  AssetInfoBuilder get assetInfo => _$this._assetInfo ??= AssetInfoBuilder();
  set assetInfo(AssetInfoBuilder? assetInfo) => _$this._assetInfo = assetInfo;

  ProductDetailTradingHoursEnum? _tradingHours;
  ProductDetailTradingHoursEnum? get tradingHours => _$this._tradingHours;
  set tradingHours(ProductDetailTradingHoursEnum? tradingHours) =>
      _$this._tradingHours = tradingHours;

  ProductDetailBuilder() {
    ProductDetail._defaults(this);
  }

  ProductDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hip3Market = $v.hip3Market;
      _tradable = $v.tradable;
      _orderAssets = $v.orderAssets?.toBuilder();
      _isFavorite = $v.isFavorite;
      _symbol = $v.symbol;
      _name = $v.name;
      _kind = $v.kind;
      _title = $v.title;
      _badge = $v.badge;
      _description = $v.description;
      _quote = $v.quote.toBuilder();
      _stats = $v.stats?.toBuilder();
      _assetInfo = $v.assetInfo.toBuilder();
      _tradingHours = $v.tradingHours;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductDetail other) {
    _$v = other as _$ProductDetail;
  }

  @override
  void update(void Function(ProductDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductDetail build() => _build();

  _$ProductDetail _build() {
    _$ProductDetail _$result;
    try {
      _$result = _$v ??
          _$ProductDetail._(
            hip3Market: hip3Market,
            tradable: tradable,
            orderAssets: _orderAssets?.build(),
            isFavorite: isFavorite,
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'ProductDetail', 'symbol'),
            name: name,
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'ProductDetail', 'kind'),
            title: title,
            badge: badge,
            description: description,
            quote: quote.build(),
            stats: _stats?.build(),
            assetInfo: assetInfo.build(),
            tradingHours: tradingHours,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orderAssets';
        _orderAssets?.build();

        _$failedField = 'quote';
        quote.build();
        _$failedField = 'stats';
        _stats?.build();
        _$failedField = 'assetInfo';
        assetInfo.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ProductDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
