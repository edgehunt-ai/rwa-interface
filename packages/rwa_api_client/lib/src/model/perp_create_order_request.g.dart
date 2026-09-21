// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_create_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpCreateOrderRequestKindEnum _$perpCreateOrderRequestKindEnum_perp =
    const PerpCreateOrderRequestKindEnum._('perp');
const PerpCreateOrderRequestKindEnum
    _$perpCreateOrderRequestKindEnum_unknownDefaultOpenApi =
    const PerpCreateOrderRequestKindEnum._('unknownDefaultOpenApi');

PerpCreateOrderRequestKindEnum _$perpCreateOrderRequestKindEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$perpCreateOrderRequestKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpCreateOrderRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$perpCreateOrderRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpCreateOrderRequestKindEnum>
    _$perpCreateOrderRequestKindEnumValues = BuiltSet<
        PerpCreateOrderRequestKindEnum>(const <PerpCreateOrderRequestKindEnum>[
  _$perpCreateOrderRequestKindEnum_perp,
  _$perpCreateOrderRequestKindEnum_unknownDefaultOpenApi,
]);

const PerpCreateOrderRequestSideEnum _$perpCreateOrderRequestSideEnum_long =
    const PerpCreateOrderRequestSideEnum._('long');
const PerpCreateOrderRequestSideEnum _$perpCreateOrderRequestSideEnum_short =
    const PerpCreateOrderRequestSideEnum._('short');
const PerpCreateOrderRequestSideEnum
    _$perpCreateOrderRequestSideEnum_unknownDefaultOpenApi =
    const PerpCreateOrderRequestSideEnum._('unknownDefaultOpenApi');

PerpCreateOrderRequestSideEnum _$perpCreateOrderRequestSideEnumValueOf(
    String name) {
  switch (name) {
    case 'long':
      return _$perpCreateOrderRequestSideEnum_long;
    case 'short':
      return _$perpCreateOrderRequestSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$perpCreateOrderRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$perpCreateOrderRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpCreateOrderRequestSideEnum>
    _$perpCreateOrderRequestSideEnumValues = BuiltSet<
        PerpCreateOrderRequestSideEnum>(const <PerpCreateOrderRequestSideEnum>[
  _$perpCreateOrderRequestSideEnum_long,
  _$perpCreateOrderRequestSideEnum_short,
  _$perpCreateOrderRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<PerpCreateOrderRequestKindEnum>
    _$perpCreateOrderRequestKindEnumSerializer =
    _$PerpCreateOrderRequestKindEnumSerializer();
Serializer<PerpCreateOrderRequestSideEnum>
    _$perpCreateOrderRequestSideEnumSerializer =
    _$PerpCreateOrderRequestSideEnumSerializer();

class _$PerpCreateOrderRequestKindEnumSerializer
    implements PrimitiveSerializer<PerpCreateOrderRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpCreateOrderRequestKindEnum];
  @override
  final String wireName = 'PerpCreateOrderRequestKindEnum';

  @override
  Object serialize(
          Serializers serializers, PerpCreateOrderRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpCreateOrderRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpCreateOrderRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpCreateOrderRequestSideEnumSerializer
    implements PrimitiveSerializer<PerpCreateOrderRequestSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'long': 'long',
    'short': 'short',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'long': 'long',
    'short': 'short',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpCreateOrderRequestSideEnum];
  @override
  final String wireName = 'PerpCreateOrderRequestSideEnum';

  @override
  Object serialize(
          Serializers serializers, PerpCreateOrderRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpCreateOrderRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpCreateOrderRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpCreateOrderRequest extends PerpCreateOrderRequest {
  @override
  final String? contextId;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final Hip3OrderProtectionSpec? protection;
  @override
  final String symbol;
  @override
  final PerpCreateOrderRequestKindEnum kind;
  @override
  final PerpCreateOrderRequestSideEnum side;
  @override
  final OrderType type;
  @override
  final String? amount;
  @override
  final String? quantity;
  @override
  final String? limitPrice;
  @override
  final String? leverage;
  @override
  final MarginMode marginMode;
  @override
  final bool? reduceOnly;
  @override
  final String? slippagePercent;
  @override
  final TpSlSpec? tpSl;
  @override
  final String? previewId;

  factory _$PerpCreateOrderRequest(
          [void Function(PerpCreateOrderRequestBuilder)? updates]) =>
      (PerpCreateOrderRequestBuilder()..update(updates))._build();

  _$PerpCreateOrderRequest._(
      {this.contextId,
      this.timeInForce,
      this.protection,
      required this.symbol,
      required this.kind,
      required this.side,
      required this.type,
      this.amount,
      this.quantity,
      this.limitPrice,
      this.leverage,
      required this.marginMode,
      this.reduceOnly,
      this.slippagePercent,
      this.tpSl,
      this.previewId})
      : super._();
  @override
  PerpCreateOrderRequest rebuild(
          void Function(PerpCreateOrderRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpCreateOrderRequestBuilder toBuilder() =>
      PerpCreateOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpCreateOrderRequest &&
        contextId == other.contextId &&
        timeInForce == other.timeInForce &&
        protection == other.protection &&
        symbol == other.symbol &&
        kind == other.kind &&
        side == other.side &&
        type == other.type &&
        amount == other.amount &&
        quantity == other.quantity &&
        limitPrice == other.limitPrice &&
        leverage == other.leverage &&
        marginMode == other.marginMode &&
        reduceOnly == other.reduceOnly &&
        slippagePercent == other.slippagePercent &&
        tpSl == other.tpSl &&
        previewId == other.previewId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contextId.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, protection.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jc(_$hash, reduceOnly.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, tpSl.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerpCreateOrderRequest')
          ..add('contextId', contextId)
          ..add('timeInForce', timeInForce)
          ..add('protection', protection)
          ..add('symbol', symbol)
          ..add('kind', kind)
          ..add('side', side)
          ..add('type', type)
          ..add('amount', amount)
          ..add('quantity', quantity)
          ..add('limitPrice', limitPrice)
          ..add('leverage', leverage)
          ..add('marginMode', marginMode)
          ..add('reduceOnly', reduceOnly)
          ..add('slippagePercent', slippagePercent)
          ..add('tpSl', tpSl)
          ..add('previewId', previewId))
        .toString();
  }
}

class PerpCreateOrderRequestBuilder
    implements Builder<PerpCreateOrderRequest, PerpCreateOrderRequestBuilder> {
  _$PerpCreateOrderRequest? _$v;

  String? _contextId;
  String? get contextId => _$this._contextId;
  set contextId(String? contextId) => _$this._contextId = contextId;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  Hip3OrderProtectionSpecBuilder? _protection;
  Hip3OrderProtectionSpecBuilder get protection =>
      _$this._protection ??= Hip3OrderProtectionSpecBuilder();
  set protection(Hip3OrderProtectionSpecBuilder? protection) =>
      _$this._protection = protection;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  PerpCreateOrderRequestKindEnum? _kind;
  PerpCreateOrderRequestKindEnum? get kind => _$this._kind;
  set kind(PerpCreateOrderRequestKindEnum? kind) => _$this._kind = kind;

  PerpCreateOrderRequestSideEnum? _side;
  PerpCreateOrderRequestSideEnum? get side => _$this._side;
  set side(PerpCreateOrderRequestSideEnum? side) => _$this._side = side;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(OrderType? type) => _$this._type = type;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(MarginMode? marginMode) => _$this._marginMode = marginMode;

  bool? _reduceOnly;
  bool? get reduceOnly => _$this._reduceOnly;
  set reduceOnly(bool? reduceOnly) => _$this._reduceOnly = reduceOnly;

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

  PerpCreateOrderRequestBuilder() {
    PerpCreateOrderRequest._defaults(this);
  }

  PerpCreateOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contextId = $v.contextId;
      _timeInForce = $v.timeInForce;
      _protection = $v.protection?.toBuilder();
      _symbol = $v.symbol;
      _kind = $v.kind;
      _side = $v.side;
      _type = $v.type;
      _amount = $v.amount;
      _quantity = $v.quantity;
      _limitPrice = $v.limitPrice;
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _reduceOnly = $v.reduceOnly;
      _slippagePercent = $v.slippagePercent;
      _tpSl = $v.tpSl?.toBuilder();
      _previewId = $v.previewId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PerpCreateOrderRequest other) {
    _$v = other as _$PerpCreateOrderRequest;
  }

  @override
  void update(void Function(PerpCreateOrderRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpCreateOrderRequest build() => _build();

  _$PerpCreateOrderRequest _build() {
    _$PerpCreateOrderRequest _$result;
    try {
      _$result = _$v ??
          _$PerpCreateOrderRequest._(
            contextId: contextId,
            timeInForce: timeInForce,
            protection: _protection?.build(),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PerpCreateOrderRequest', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'PerpCreateOrderRequest', 'kind'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'PerpCreateOrderRequest', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'PerpCreateOrderRequest', 'type'),
            amount: amount,
            quantity: quantity,
            limitPrice: limitPrice,
            leverage: leverage,
            marginMode: BuiltValueNullFieldError.checkNotNull(
                marginMode, r'PerpCreateOrderRequest', 'marginMode'),
            reduceOnly: reduceOnly,
            slippagePercent: slippagePercent,
            tpSl: _tpSl?.build(),
            previewId: previewId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protection';
        _protection?.build();

        _$failedField = 'tpSl';
        _tpSl?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpCreateOrderRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
