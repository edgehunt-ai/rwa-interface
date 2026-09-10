// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_listing.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductListingPriceKindEnum _$productListingPriceKindEnum_mark =
    const ProductListingPriceKindEnum._('mark');
const ProductListingPriceKindEnum _$productListingPriceKindEnum_lastTrade =
    const ProductListingPriceKindEnum._('lastTrade');
const ProductListingPriceKindEnum _$productListingPriceKindEnum_reference =
    const ProductListingPriceKindEnum._('reference');
const ProductListingPriceKindEnum
    _$productListingPriceKindEnum_unknownDefaultOpenApi =
    const ProductListingPriceKindEnum._('unknownDefaultOpenApi');

ProductListingPriceKindEnum _$productListingPriceKindEnumValueOf(String name) {
  switch (name) {
    case 'mark':
      return _$productListingPriceKindEnum_mark;
    case 'lastTrade':
      return _$productListingPriceKindEnum_lastTrade;
    case 'reference':
      return _$productListingPriceKindEnum_reference;
    case 'unknownDefaultOpenApi':
      return _$productListingPriceKindEnum_unknownDefaultOpenApi;
    default:
      return _$productListingPriceKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductListingPriceKindEnum>
    _$productListingPriceKindEnumValues =
    BuiltSet<ProductListingPriceKindEnum>(const <ProductListingPriceKindEnum>[
  _$productListingPriceKindEnum_mark,
  _$productListingPriceKindEnum_lastTrade,
  _$productListingPriceKindEnum_reference,
  _$productListingPriceKindEnum_unknownDefaultOpenApi,
]);

const ProductListingDataStatusEnum _$productListingDataStatusEnum_fresh =
    const ProductListingDataStatusEnum._('fresh');
const ProductListingDataStatusEnum _$productListingDataStatusEnum_stale =
    const ProductListingDataStatusEnum._('stale');
const ProductListingDataStatusEnum
    _$productListingDataStatusEnum_unknownDefaultOpenApi =
    const ProductListingDataStatusEnum._('unknownDefaultOpenApi');

ProductListingDataStatusEnum _$productListingDataStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'fresh':
      return _$productListingDataStatusEnum_fresh;
    case 'stale':
      return _$productListingDataStatusEnum_stale;
    case 'unknownDefaultOpenApi':
      return _$productListingDataStatusEnum_unknownDefaultOpenApi;
    default:
      return _$productListingDataStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductListingDataStatusEnum>
    _$productListingDataStatusEnumValues =
    BuiltSet<ProductListingDataStatusEnum>(const <ProductListingDataStatusEnum>[
  _$productListingDataStatusEnum_fresh,
  _$productListingDataStatusEnum_stale,
  _$productListingDataStatusEnum_unknownDefaultOpenApi,
]);

const ProductListingProductTypeEnum _$productListingProductTypeEnum_spot =
    const ProductListingProductTypeEnum._('spot');
const ProductListingProductTypeEnum _$productListingProductTypeEnum_contract =
    const ProductListingProductTypeEnum._('contract');
const ProductListingProductTypeEnum
    _$productListingProductTypeEnum_unknownDefaultOpenApi =
    const ProductListingProductTypeEnum._('unknownDefaultOpenApi');

ProductListingProductTypeEnum _$productListingProductTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'spot':
      return _$productListingProductTypeEnum_spot;
    case 'contract':
      return _$productListingProductTypeEnum_contract;
    case 'unknownDefaultOpenApi':
      return _$productListingProductTypeEnum_unknownDefaultOpenApi;
    default:
      return _$productListingProductTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<ProductListingProductTypeEnum>
    _$productListingProductTypeEnumValues = BuiltSet<
        ProductListingProductTypeEnum>(const <ProductListingProductTypeEnum>[
  _$productListingProductTypeEnum_spot,
  _$productListingProductTypeEnum_contract,
  _$productListingProductTypeEnum_unknownDefaultOpenApi,
]);

Serializer<ProductListingPriceKindEnum>
    _$productListingPriceKindEnumSerializer =
    _$ProductListingPriceKindEnumSerializer();
Serializer<ProductListingDataStatusEnum>
    _$productListingDataStatusEnumSerializer =
    _$ProductListingDataStatusEnumSerializer();
Serializer<ProductListingProductTypeEnum>
    _$productListingProductTypeEnumSerializer =
    _$ProductListingProductTypeEnumSerializer();

class _$ProductListingPriceKindEnumSerializer
    implements PrimitiveSerializer<ProductListingPriceKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mark': 'mark',
    'lastTrade': 'last_trade',
    'reference': 'reference',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mark': 'mark',
    'last_trade': 'lastTrade',
    'reference': 'reference',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductListingPriceKindEnum];
  @override
  final String wireName = 'ProductListingPriceKindEnum';

  @override
  Object serialize(Serializers serializers, ProductListingPriceKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductListingPriceKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductListingPriceKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ProductListingDataStatusEnumSerializer
    implements PrimitiveSerializer<ProductListingDataStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'fresh': 'fresh',
    'stale': 'stale',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'fresh': 'fresh',
    'stale': 'stale',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductListingDataStatusEnum];
  @override
  final String wireName = 'ProductListingDataStatusEnum';

  @override
  Object serialize(Serializers serializers, ProductListingDataStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductListingDataStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductListingDataStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ProductListingProductTypeEnumSerializer
    implements PrimitiveSerializer<ProductListingProductTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'spot': 'spot',
    'contract': 'contract',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'spot': 'spot',
    'contract': 'contract',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductListingProductTypeEnum];
  @override
  final String wireName = 'ProductListingProductTypeEnum';

  @override
  Object serialize(
          Serializers serializers, ProductListingProductTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductListingProductTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductListingProductTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$ProductListing extends ProductListing {
  @override
  final Hip3PublicMarket? hip3Market;
  @override
  final ProductListingPriceKindEnum? priceKind;
  @override
  final ProductListingDataStatusEnum? dataStatus;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? validUntil;
  @override
  final String symbol;
  @override
  final String? name;
  @override
  final ProductKind kind;
  @override
  final ProductListingProductTypeEnum? productType;
  @override
  final String? label;
  @override
  final String price;
  @override
  final String? change24hPercent;
  @override
  final String? spreadVsReferencePercent;
  @override
  final String? volume24h;
  @override
  final String? volume24hUnit;
  @override
  final String? turnover24hUsd;
  @override
  final int? hotRank;
  @override
  final bool? isFavorite;

  factory _$ProductListing([void Function(ProductListingBuilder)? updates]) =>
      (ProductListingBuilder()..update(updates))._build();

  _$ProductListing._(
      {this.hip3Market,
      this.priceKind,
      this.dataStatus,
      this.updatedAt,
      this.validUntil,
      required this.symbol,
      this.name,
      required this.kind,
      this.productType,
      this.label,
      required this.price,
      this.change24hPercent,
      this.spreadVsReferencePercent,
      this.volume24h,
      this.volume24hUnit,
      this.turnover24hUsd,
      this.hotRank,
      this.isFavorite})
      : super._();
  @override
  ProductListing rebuild(void Function(ProductListingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductListingBuilder toBuilder() => ProductListingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductListing &&
        hip3Market == other.hip3Market &&
        priceKind == other.priceKind &&
        dataStatus == other.dataStatus &&
        updatedAt == other.updatedAt &&
        validUntil == other.validUntil &&
        symbol == other.symbol &&
        name == other.name &&
        kind == other.kind &&
        productType == other.productType &&
        label == other.label &&
        price == other.price &&
        change24hPercent == other.change24hPercent &&
        spreadVsReferencePercent == other.spreadVsReferencePercent &&
        volume24h == other.volume24h &&
        volume24hUnit == other.volume24hUnit &&
        turnover24hUsd == other.turnover24hUsd &&
        hotRank == other.hotRank &&
        isFavorite == other.isFavorite;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hip3Market.hashCode);
    _$hash = $jc(_$hash, priceKind.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, productType.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, change24hPercent.hashCode);
    _$hash = $jc(_$hash, spreadVsReferencePercent.hashCode);
    _$hash = $jc(_$hash, volume24h.hashCode);
    _$hash = $jc(_$hash, volume24hUnit.hashCode);
    _$hash = $jc(_$hash, turnover24hUsd.hashCode);
    _$hash = $jc(_$hash, hotRank.hashCode);
    _$hash = $jc(_$hash, isFavorite.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProductListing')
          ..add('hip3Market', hip3Market)
          ..add('priceKind', priceKind)
          ..add('dataStatus', dataStatus)
          ..add('updatedAt', updatedAt)
          ..add('validUntil', validUntil)
          ..add('symbol', symbol)
          ..add('name', name)
          ..add('kind', kind)
          ..add('productType', productType)
          ..add('label', label)
          ..add('price', price)
          ..add('change24hPercent', change24hPercent)
          ..add('spreadVsReferencePercent', spreadVsReferencePercent)
          ..add('volume24h', volume24h)
          ..add('volume24hUnit', volume24hUnit)
          ..add('turnover24hUsd', turnover24hUsd)
          ..add('hotRank', hotRank)
          ..add('isFavorite', isFavorite))
        .toString();
  }
}

class ProductListingBuilder
    implements Builder<ProductListing, ProductListingBuilder> {
  _$ProductListing? _$v;

  Hip3PublicMarketBuilder? _hip3Market;
  Hip3PublicMarketBuilder get hip3Market =>
      _$this._hip3Market ??= Hip3PublicMarketBuilder();
  set hip3Market(Hip3PublicMarketBuilder? hip3Market) =>
      _$this._hip3Market = hip3Market;

  ProductListingPriceKindEnum? _priceKind;
  ProductListingPriceKindEnum? get priceKind => _$this._priceKind;
  set priceKind(ProductListingPriceKindEnum? priceKind) =>
      _$this._priceKind = priceKind;

  ProductListingDataStatusEnum? _dataStatus;
  ProductListingDataStatusEnum? get dataStatus => _$this._dataStatus;
  set dataStatus(ProductListingDataStatusEnum? dataStatus) =>
      _$this._dataStatus = dataStatus;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  ProductListingProductTypeEnum? _productType;
  ProductListingProductTypeEnum? get productType => _$this._productType;
  set productType(ProductListingProductTypeEnum? productType) =>
      _$this._productType = productType;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _change24hPercent;
  String? get change24hPercent => _$this._change24hPercent;
  set change24hPercent(String? change24hPercent) =>
      _$this._change24hPercent = change24hPercent;

  String? _spreadVsReferencePercent;
  String? get spreadVsReferencePercent => _$this._spreadVsReferencePercent;
  set spreadVsReferencePercent(String? spreadVsReferencePercent) =>
      _$this._spreadVsReferencePercent = spreadVsReferencePercent;

  String? _volume24h;
  String? get volume24h => _$this._volume24h;
  set volume24h(String? volume24h) => _$this._volume24h = volume24h;

  String? _volume24hUnit;
  String? get volume24hUnit => _$this._volume24hUnit;
  set volume24hUnit(String? volume24hUnit) =>
      _$this._volume24hUnit = volume24hUnit;

  String? _turnover24hUsd;
  String? get turnover24hUsd => _$this._turnover24hUsd;
  set turnover24hUsd(String? turnover24hUsd) =>
      _$this._turnover24hUsd = turnover24hUsd;

  int? _hotRank;
  int? get hotRank => _$this._hotRank;
  set hotRank(int? hotRank) => _$this._hotRank = hotRank;

  bool? _isFavorite;
  bool? get isFavorite => _$this._isFavorite;
  set isFavorite(bool? isFavorite) => _$this._isFavorite = isFavorite;

  ProductListingBuilder() {
    ProductListing._defaults(this);
  }

  ProductListingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hip3Market = $v.hip3Market?.toBuilder();
      _priceKind = $v.priceKind;
      _dataStatus = $v.dataStatus;
      _updatedAt = $v.updatedAt;
      _validUntil = $v.validUntil;
      _symbol = $v.symbol;
      _name = $v.name;
      _kind = $v.kind;
      _productType = $v.productType;
      _label = $v.label;
      _price = $v.price;
      _change24hPercent = $v.change24hPercent;
      _spreadVsReferencePercent = $v.spreadVsReferencePercent;
      _volume24h = $v.volume24h;
      _volume24hUnit = $v.volume24hUnit;
      _turnover24hUsd = $v.turnover24hUsd;
      _hotRank = $v.hotRank;
      _isFavorite = $v.isFavorite;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductListing other) {
    _$v = other as _$ProductListing;
  }

  @override
  void update(void Function(ProductListingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProductListing build() => _build();

  _$ProductListing _build() {
    _$ProductListing _$result;
    try {
      _$result = _$v ??
          _$ProductListing._(
            hip3Market: _hip3Market?.build(),
            priceKind: priceKind,
            dataStatus: dataStatus,
            updatedAt: updatedAt,
            validUntil: validUntil,
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'ProductListing', 'symbol'),
            name: name,
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'ProductListing', 'kind'),
            productType: productType,
            label: label,
            price: BuiltValueNullFieldError.checkNotNull(
                price, r'ProductListing', 'price'),
            change24hPercent: change24hPercent,
            spreadVsReferencePercent: spreadVsReferencePercent,
            volume24h: volume24h,
            volume24hUnit: volume24hUnit,
            turnover24hUsd: turnover24hUsd,
            hotRank: hotRank,
            isFavorite: isFavorite,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hip3Market';
        _hip3Market?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ProductListing', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
