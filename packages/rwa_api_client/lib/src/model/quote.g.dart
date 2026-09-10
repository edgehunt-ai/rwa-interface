// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const QuotePriceKindEnum _$quotePriceKindEnum_mark =
    const QuotePriceKindEnum._('mark');
const QuotePriceKindEnum _$quotePriceKindEnum_lastTrade =
    const QuotePriceKindEnum._('lastTrade');
const QuotePriceKindEnum _$quotePriceKindEnum_reference =
    const QuotePriceKindEnum._('reference');
const QuotePriceKindEnum _$quotePriceKindEnum_unknownDefaultOpenApi =
    const QuotePriceKindEnum._('unknownDefaultOpenApi');

QuotePriceKindEnum _$quotePriceKindEnumValueOf(String name) {
  switch (name) {
    case 'mark':
      return _$quotePriceKindEnum_mark;
    case 'lastTrade':
      return _$quotePriceKindEnum_lastTrade;
    case 'reference':
      return _$quotePriceKindEnum_reference;
    case 'unknownDefaultOpenApi':
      return _$quotePriceKindEnum_unknownDefaultOpenApi;
    default:
      return _$quotePriceKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<QuotePriceKindEnum> _$quotePriceKindEnumValues =
    BuiltSet<QuotePriceKindEnum>(const <QuotePriceKindEnum>[
  _$quotePriceKindEnum_mark,
  _$quotePriceKindEnum_lastTrade,
  _$quotePriceKindEnum_reference,
  _$quotePriceKindEnum_unknownDefaultOpenApi,
]);

const QuoteDataStatusEnum _$quoteDataStatusEnum_fresh =
    const QuoteDataStatusEnum._('fresh');
const QuoteDataStatusEnum _$quoteDataStatusEnum_stale =
    const QuoteDataStatusEnum._('stale');
const QuoteDataStatusEnum _$quoteDataStatusEnum_unknownDefaultOpenApi =
    const QuoteDataStatusEnum._('unknownDefaultOpenApi');

QuoteDataStatusEnum _$quoteDataStatusEnumValueOf(String name) {
  switch (name) {
    case 'fresh':
      return _$quoteDataStatusEnum_fresh;
    case 'stale':
      return _$quoteDataStatusEnum_stale;
    case 'unknownDefaultOpenApi':
      return _$quoteDataStatusEnum_unknownDefaultOpenApi;
    default:
      return _$quoteDataStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<QuoteDataStatusEnum> _$quoteDataStatusEnumValues =
    BuiltSet<QuoteDataStatusEnum>(const <QuoteDataStatusEnum>[
  _$quoteDataStatusEnum_fresh,
  _$quoteDataStatusEnum_stale,
  _$quoteDataStatusEnum_unknownDefaultOpenApi,
]);

Serializer<QuotePriceKindEnum> _$quotePriceKindEnumSerializer =
    _$QuotePriceKindEnumSerializer();
Serializer<QuoteDataStatusEnum> _$quoteDataStatusEnumSerializer =
    _$QuoteDataStatusEnumSerializer();

class _$QuotePriceKindEnumSerializer
    implements PrimitiveSerializer<QuotePriceKindEnum> {
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
  final Iterable<Type> types = const <Type>[QuotePriceKindEnum];
  @override
  final String wireName = 'QuotePriceKindEnum';

  @override
  Object serialize(Serializers serializers, QuotePriceKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  QuotePriceKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      QuotePriceKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$QuoteDataStatusEnumSerializer
    implements PrimitiveSerializer<QuoteDataStatusEnum> {
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
  final Iterable<Type> types = const <Type>[QuoteDataStatusEnum];
  @override
  final String wireName = 'QuoteDataStatusEnum';

  @override
  Object serialize(Serializers serializers, QuoteDataStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  QuoteDataStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      QuoteDataStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Quote extends Quote {
  @override
  final DateTime? validUntil;
  @override
  final QuotePriceKindEnum? priceKind;
  @override
  final QuoteDataStatusEnum? dataStatus;
  @override
  final String? label;
  @override
  final String price;
  @override
  final String? change24h;
  @override
  final String? change24hPercent;
  @override
  final DateTime? updatedAt;

  factory _$Quote([void Function(QuoteBuilder)? updates]) =>
      (QuoteBuilder()..update(updates))._build();

  _$Quote._(
      {this.validUntil,
      this.priceKind,
      this.dataStatus,
      this.label,
      required this.price,
      this.change24h,
      this.change24hPercent,
      this.updatedAt})
      : super._();
  @override
  Quote rebuild(void Function(QuoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuoteBuilder toBuilder() => QuoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Quote &&
        validUntil == other.validUntil &&
        priceKind == other.priceKind &&
        dataStatus == other.dataStatus &&
        label == other.label &&
        price == other.price &&
        change24h == other.change24h &&
        change24hPercent == other.change24hPercent &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, priceKind.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, change24h.hashCode);
    _$hash = $jc(_$hash, change24hPercent.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Quote')
          ..add('validUntil', validUntil)
          ..add('priceKind', priceKind)
          ..add('dataStatus', dataStatus)
          ..add('label', label)
          ..add('price', price)
          ..add('change24h', change24h)
          ..add('change24hPercent', change24hPercent)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class QuoteBuilder implements Builder<Quote, QuoteBuilder> {
  _$Quote? _$v;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  QuotePriceKindEnum? _priceKind;
  QuotePriceKindEnum? get priceKind => _$this._priceKind;
  set priceKind(QuotePriceKindEnum? priceKind) => _$this._priceKind = priceKind;

  QuoteDataStatusEnum? _dataStatus;
  QuoteDataStatusEnum? get dataStatus => _$this._dataStatus;
  set dataStatus(QuoteDataStatusEnum? dataStatus) =>
      _$this._dataStatus = dataStatus;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _change24h;
  String? get change24h => _$this._change24h;
  set change24h(String? change24h) => _$this._change24h = change24h;

  String? _change24hPercent;
  String? get change24hPercent => _$this._change24hPercent;
  set change24hPercent(String? change24hPercent) =>
      _$this._change24hPercent = change24hPercent;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  QuoteBuilder() {
    Quote._defaults(this);
  }

  QuoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _validUntil = $v.validUntil;
      _priceKind = $v.priceKind;
      _dataStatus = $v.dataStatus;
      _label = $v.label;
      _price = $v.price;
      _change24h = $v.change24h;
      _change24hPercent = $v.change24hPercent;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Quote other) {
    _$v = other as _$Quote;
  }

  @override
  void update(void Function(QuoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Quote build() => _build();

  _$Quote _build() {
    final _$result = _$v ??
        _$Quote._(
          validUntil: validUntil,
          priceKind: priceKind,
          dataStatus: dataStatus,
          label: label,
          price:
              BuiltValueNullFieldError.checkNotNull(price, r'Quote', 'price'),
          change24h: change24h,
          change24hPercent: change24hPercent,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
