// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_create_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockCreateOrderRequestKindEnum
    _$bstockCreateOrderRequestKindEnum_bstock =
    const BstockCreateOrderRequestKindEnum._('bstock');
const BstockCreateOrderRequestKindEnum
    _$bstockCreateOrderRequestKindEnum_unknownDefaultOpenApi =
    const BstockCreateOrderRequestKindEnum._('unknownDefaultOpenApi');

BstockCreateOrderRequestKindEnum _$bstockCreateOrderRequestKindEnumValueOf(
    String name) {
  switch (name) {
    case 'bstock':
      return _$bstockCreateOrderRequestKindEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockCreateOrderRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstockCreateOrderRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockCreateOrderRequestKindEnum>
    _$bstockCreateOrderRequestKindEnumValues = BuiltSet<
        BstockCreateOrderRequestKindEnum>(const <BstockCreateOrderRequestKindEnum>[
  _$bstockCreateOrderRequestKindEnum_bstock,
  _$bstockCreateOrderRequestKindEnum_unknownDefaultOpenApi,
]);

const BstockCreateOrderRequestSideEnum _$bstockCreateOrderRequestSideEnum_buy =
    const BstockCreateOrderRequestSideEnum._('buy');
const BstockCreateOrderRequestSideEnum _$bstockCreateOrderRequestSideEnum_sell =
    const BstockCreateOrderRequestSideEnum._('sell');
const BstockCreateOrderRequestSideEnum
    _$bstockCreateOrderRequestSideEnum_unknownDefaultOpenApi =
    const BstockCreateOrderRequestSideEnum._('unknownDefaultOpenApi');

BstockCreateOrderRequestSideEnum _$bstockCreateOrderRequestSideEnumValueOf(
    String name) {
  switch (name) {
    case 'buy':
      return _$bstockCreateOrderRequestSideEnum_buy;
    case 'sell':
      return _$bstockCreateOrderRequestSideEnum_sell;
    case 'unknownDefaultOpenApi':
      return _$bstockCreateOrderRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$bstockCreateOrderRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockCreateOrderRequestSideEnum>
    _$bstockCreateOrderRequestSideEnumValues = BuiltSet<
        BstockCreateOrderRequestSideEnum>(const <BstockCreateOrderRequestSideEnum>[
  _$bstockCreateOrderRequestSideEnum_buy,
  _$bstockCreateOrderRequestSideEnum_sell,
  _$bstockCreateOrderRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<BstockCreateOrderRequestKindEnum>
    _$bstockCreateOrderRequestKindEnumSerializer =
    _$BstockCreateOrderRequestKindEnumSerializer();
Serializer<BstockCreateOrderRequestSideEnum>
    _$bstockCreateOrderRequestSideEnumSerializer =
    _$BstockCreateOrderRequestSideEnumSerializer();

class _$BstockCreateOrderRequestKindEnumSerializer
    implements PrimitiveSerializer<BstockCreateOrderRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockCreateOrderRequestKindEnum];
  @override
  final String wireName = 'BstockCreateOrderRequestKindEnum';

  @override
  Object serialize(
          Serializers serializers, BstockCreateOrderRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockCreateOrderRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockCreateOrderRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockCreateOrderRequestSideEnumSerializer
    implements PrimitiveSerializer<BstockCreateOrderRequestSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'buy': 'buy',
    'sell': 'sell',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'buy': 'buy',
    'sell': 'sell',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockCreateOrderRequestSideEnum];
  @override
  final String wireName = 'BstockCreateOrderRequestSideEnum';

  @override
  Object serialize(
          Serializers serializers, BstockCreateOrderRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockCreateOrderRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockCreateOrderRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockCreateOrderRequest extends BstockCreateOrderRequest {
  @override
  final String symbol;
  @override
  final BstockCreateOrderRequestKindEnum kind;
  @override
  final BstockCreateOrderRequestSideEnum side;
  @override
  final OrderType type;
  @override
  final BstocksTimeInForce? timeInForce;
  @override
  final String? amount;
  @override
  final String? quantity;
  @override
  final String? limitPrice;
  @override
  final String? slippagePercent;
  @override
  final TpSlSpec? tpSl;
  @override
  final String? previewId;

  factory _$BstockCreateOrderRequest(
          [void Function(BstockCreateOrderRequestBuilder)? updates]) =>
      (BstockCreateOrderRequestBuilder()..update(updates))._build();

  _$BstockCreateOrderRequest._(
      {required this.symbol,
      required this.kind,
      required this.side,
      required this.type,
      this.timeInForce,
      this.amount,
      this.quantity,
      this.limitPrice,
      this.slippagePercent,
      this.tpSl,
      this.previewId})
      : super._();
  @override
  BstockCreateOrderRequest rebuild(
          void Function(BstockCreateOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockCreateOrderRequestBuilder toBuilder() =>
      BstockCreateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockCreateOrderRequest &&
        symbol == other.symbol &&
        kind == other.kind &&
        side == other.side &&
        type == other.type &&
        timeInForce == other.timeInForce &&
        amount == other.amount &&
        quantity == other.quantity &&
        limitPrice == other.limitPrice &&
        slippagePercent == other.slippagePercent &&
        tpSl == other.tpSl &&
        previewId == other.previewId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, tpSl.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockCreateOrderRequest')
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('side', side)
          ..add('type', type)
          ..add('timeInForce', timeInForce)
          ..add('amount', amount)
          ..add('quantity', quantity)
          ..add('limitPrice', limitPrice)
          ..add('slippagePercent', slippagePercent)
          ..add('tpSl', tpSl)
          ..add('previewId', previewId))
        .toString();
  }
}

class BstockCreateOrderRequestBuilder
    implements
        Builder<BstockCreateOrderRequest, BstockCreateOrderRequestBuilder> {
  _$BstockCreateOrderRequest? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  BstockCreateOrderRequestKindEnum? _kind;
  BstockCreateOrderRequestKindEnum? get kind => _$this._kind;
  set kind(BstockCreateOrderRequestKindEnum? kind) => _$this._kind = kind;

  BstockCreateOrderRequestSideEnum? _side;
  BstockCreateOrderRequestSideEnum? get side => _$this._side;
  set side(BstockCreateOrderRequestSideEnum? side) => _$this._side = side;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(OrderType? type) => _$this._type = type;

  BstocksTimeInForce? _timeInForce;
  BstocksTimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(BstocksTimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  TpSlSpecBuilder? _tpSl;
  TpSlSpecBuilder get tpSl => _$this._tpSl ??= TpSlSpecBuilder();
  set tpSl(TpSlSpecBuilder? tpSl) => _$this._tpSl = tpSl;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  BstockCreateOrderRequestBuilder() {
    BstockCreateOrderRequest._defaults(this);
  }

  BstockCreateOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _kind = $v.kind;
      _side = $v.side;
      _type = $v.type;
      _timeInForce = $v.timeInForce;
      _amount = $v.amount;
      _quantity = $v.quantity;
      _limitPrice = $v.limitPrice;
      _slippagePercent = $v.slippagePercent;
      _tpSl = $v.tpSl?.toBuilder();
      _previewId = $v.previewId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockCreateOrderRequest other) {
    _$v = other as _$BstockCreateOrderRequest;
  }

  @override
  void update(void Function(BstockCreateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockCreateOrderRequest build() => _build();

  _$BstockCreateOrderRequest _build() {
    _$BstockCreateOrderRequest _$result;
    try {
      _$result = _$v ??
          _$BstockCreateOrderRequest._(
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'BstockCreateOrderRequest', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'BstockCreateOrderRequest', 'kind'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'BstockCreateOrderRequest', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'BstockCreateOrderRequest', 'type'),
            timeInForce: timeInForce,
            amount: amount,
            quantity: quantity,
            limitPrice: limitPrice,
            slippagePercent: slippagePercent,
            tpSl: _tpSl?.build(),
            previewId: previewId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tpSl';
        _tpSl?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockCreateOrderRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
