// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_preview_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockOrderPreviewRequestKindEnum
    _$bstockOrderPreviewRequestKindEnum_bstock =
    const BstockOrderPreviewRequestKindEnum._('bstock');
const BstockOrderPreviewRequestKindEnum
    _$bstockOrderPreviewRequestKindEnum_unknownDefaultOpenApi =
    const BstockOrderPreviewRequestKindEnum._('unknownDefaultOpenApi');

BstockOrderPreviewRequestKindEnum _$bstockOrderPreviewRequestKindEnumValueOf(
    String name) {
  switch (name) {
    case 'bstock':
      return _$bstockOrderPreviewRequestKindEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderPreviewRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderPreviewRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderPreviewRequestKindEnum>
    _$bstockOrderPreviewRequestKindEnumValues = BuiltSet<
        BstockOrderPreviewRequestKindEnum>(const <BstockOrderPreviewRequestKindEnum>[
  _$bstockOrderPreviewRequestKindEnum_bstock,
  _$bstockOrderPreviewRequestKindEnum_unknownDefaultOpenApi,
]);

const BstockOrderPreviewRequestSideEnum
    _$bstockOrderPreviewRequestSideEnum_buy =
    const BstockOrderPreviewRequestSideEnum._('buy');
const BstockOrderPreviewRequestSideEnum
    _$bstockOrderPreviewRequestSideEnum_sell =
    const BstockOrderPreviewRequestSideEnum._('sell');
const BstockOrderPreviewRequestSideEnum
    _$bstockOrderPreviewRequestSideEnum_unknownDefaultOpenApi =
    const BstockOrderPreviewRequestSideEnum._('unknownDefaultOpenApi');

BstockOrderPreviewRequestSideEnum _$bstockOrderPreviewRequestSideEnumValueOf(
    String name) {
  switch (name) {
    case 'buy':
      return _$bstockOrderPreviewRequestSideEnum_buy;
    case 'sell':
      return _$bstockOrderPreviewRequestSideEnum_sell;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderPreviewRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderPreviewRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderPreviewRequestSideEnum>
    _$bstockOrderPreviewRequestSideEnumValues = BuiltSet<
        BstockOrderPreviewRequestSideEnum>(const <BstockOrderPreviewRequestSideEnum>[
  _$bstockOrderPreviewRequestSideEnum_buy,
  _$bstockOrderPreviewRequestSideEnum_sell,
  _$bstockOrderPreviewRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<BstockOrderPreviewRequestKindEnum>
    _$bstockOrderPreviewRequestKindEnumSerializer =
    _$BstockOrderPreviewRequestKindEnumSerializer();
Serializer<BstockOrderPreviewRequestSideEnum>
    _$bstockOrderPreviewRequestSideEnumSerializer =
    _$BstockOrderPreviewRequestSideEnumSerializer();

class _$BstockOrderPreviewRequestKindEnumSerializer
    implements PrimitiveSerializer<BstockOrderPreviewRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockOrderPreviewRequestKindEnum];
  @override
  final String wireName = 'BstockOrderPreviewRequestKindEnum';

  @override
  Object serialize(
          Serializers serializers, BstockOrderPreviewRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderPreviewRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderPreviewRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderPreviewRequestSideEnumSerializer
    implements PrimitiveSerializer<BstockOrderPreviewRequestSideEnum> {
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
  final Iterable<Type> types = const <Type>[BstockOrderPreviewRequestSideEnum];
  @override
  final String wireName = 'BstockOrderPreviewRequestSideEnum';

  @override
  Object serialize(
          Serializers serializers, BstockOrderPreviewRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderPreviewRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderPreviewRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderPreviewRequest extends BstockOrderPreviewRequest {
  @override
  final String symbol;
  @override
  final BstockOrderPreviewRequestKindEnum kind;
  @override
  final BstockOrderPreviewRequestSideEnum side;
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

  factory _$BstockOrderPreviewRequest(
          [void Function(BstockOrderPreviewRequestBuilder)? updates]) =>
      (BstockOrderPreviewRequestBuilder()..update(updates))._build();

  _$BstockOrderPreviewRequest._(
      {required this.symbol,
      required this.kind,
      required this.side,
      required this.type,
      this.timeInForce,
      this.amount,
      this.quantity,
      this.limitPrice,
      this.slippagePercent,
      this.tpSl})
      : super._();
  @override
  BstockOrderPreviewRequest rebuild(
          void Function(BstockOrderPreviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderPreviewRequestBuilder toBuilder() =>
      BstockOrderPreviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderPreviewRequest &&
        symbol == other.symbol &&
        kind == other.kind &&
        side == other.side &&
        type == other.type &&
        timeInForce == other.timeInForce &&
        amount == other.amount &&
        quantity == other.quantity &&
        limitPrice == other.limitPrice &&
        slippagePercent == other.slippagePercent &&
        tpSl == other.tpSl;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstockOrderPreviewRequest')
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('side', side)
          ..add('type', type)
          ..add('timeInForce', timeInForce)
          ..add('amount', amount)
          ..add('quantity', quantity)
          ..add('limitPrice', limitPrice)
          ..add('slippagePercent', slippagePercent)
          ..add('tpSl', tpSl))
        .toString();
  }
}

class BstockOrderPreviewRequestBuilder
    implements
        Builder<BstockOrderPreviewRequest, BstockOrderPreviewRequestBuilder> {
  _$BstockOrderPreviewRequest? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  BstockOrderPreviewRequestKindEnum? _kind;
  BstockOrderPreviewRequestKindEnum? get kind => _$this._kind;
  set kind(BstockOrderPreviewRequestKindEnum? kind) => _$this._kind = kind;

  BstockOrderPreviewRequestSideEnum? _side;
  BstockOrderPreviewRequestSideEnum? get side => _$this._side;
  set side(BstockOrderPreviewRequestSideEnum? side) => _$this._side = side;

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

  BstockOrderPreviewRequestBuilder() {
    BstockOrderPreviewRequest._defaults(this);
  }

  BstockOrderPreviewRequestBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstockOrderPreviewRequest other) {
    _$v = other as _$BstockOrderPreviewRequest;
  }

  @override
  void update(void Function(BstockOrderPreviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderPreviewRequest build() => _build();

  _$BstockOrderPreviewRequest _build() {
    _$BstockOrderPreviewRequest _$result;
    try {
      _$result = _$v ??
          _$BstockOrderPreviewRequest._(
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'BstockOrderPreviewRequest', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'BstockOrderPreviewRequest', 'kind'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'BstockOrderPreviewRequest', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'BstockOrderPreviewRequest', 'type'),
            timeInForce: timeInForce,
            amount: amount,
            quantity: quantity,
            limitPrice: limitPrice,
            slippagePercent: slippagePercent,
            tpSl: _tpSl?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tpSl';
        _tpSl?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstockOrderPreviewRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
