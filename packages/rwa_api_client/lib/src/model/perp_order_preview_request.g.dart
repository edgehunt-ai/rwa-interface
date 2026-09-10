// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_order_preview_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpOrderPreviewRequestKindEnum _$perpOrderPreviewRequestKindEnum_perp =
    const PerpOrderPreviewRequestKindEnum._('perp');
const PerpOrderPreviewRequestKindEnum
    _$perpOrderPreviewRequestKindEnum_unknownDefaultOpenApi =
    const PerpOrderPreviewRequestKindEnum._('unknownDefaultOpenApi');

PerpOrderPreviewRequestKindEnum _$perpOrderPreviewRequestKindEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$perpOrderPreviewRequestKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpOrderPreviewRequestKindEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderPreviewRequestKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderPreviewRequestKindEnum>
    _$perpOrderPreviewRequestKindEnumValues = BuiltSet<
        PerpOrderPreviewRequestKindEnum>(const <PerpOrderPreviewRequestKindEnum>[
  _$perpOrderPreviewRequestKindEnum_perp,
  _$perpOrderPreviewRequestKindEnum_unknownDefaultOpenApi,
]);

const PerpOrderPreviewRequestSideEnum _$perpOrderPreviewRequestSideEnum_long =
    const PerpOrderPreviewRequestSideEnum._('long');
const PerpOrderPreviewRequestSideEnum _$perpOrderPreviewRequestSideEnum_short =
    const PerpOrderPreviewRequestSideEnum._('short');
const PerpOrderPreviewRequestSideEnum
    _$perpOrderPreviewRequestSideEnum_unknownDefaultOpenApi =
    const PerpOrderPreviewRequestSideEnum._('unknownDefaultOpenApi');

PerpOrderPreviewRequestSideEnum _$perpOrderPreviewRequestSideEnumValueOf(
    String name) {
  switch (name) {
    case 'long':
      return _$perpOrderPreviewRequestSideEnum_long;
    case 'short':
      return _$perpOrderPreviewRequestSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$perpOrderPreviewRequestSideEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderPreviewRequestSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderPreviewRequestSideEnum>
    _$perpOrderPreviewRequestSideEnumValues = BuiltSet<
        PerpOrderPreviewRequestSideEnum>(const <PerpOrderPreviewRequestSideEnum>[
  _$perpOrderPreviewRequestSideEnum_long,
  _$perpOrderPreviewRequestSideEnum_short,
  _$perpOrderPreviewRequestSideEnum_unknownDefaultOpenApi,
]);

Serializer<PerpOrderPreviewRequestKindEnum>
    _$perpOrderPreviewRequestKindEnumSerializer =
    _$PerpOrderPreviewRequestKindEnumSerializer();
Serializer<PerpOrderPreviewRequestSideEnum>
    _$perpOrderPreviewRequestSideEnumSerializer =
    _$PerpOrderPreviewRequestSideEnumSerializer();

class _$PerpOrderPreviewRequestKindEnumSerializer
    implements PrimitiveSerializer<PerpOrderPreviewRequestKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderPreviewRequestKindEnum];
  @override
  final String wireName = 'PerpOrderPreviewRequestKindEnum';

  @override
  Object serialize(
          Serializers serializers, PerpOrderPreviewRequestKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderPreviewRequestKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderPreviewRequestKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderPreviewRequestSideEnumSerializer
    implements PrimitiveSerializer<PerpOrderPreviewRequestSideEnum> {
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
  final Iterable<Type> types = const <Type>[PerpOrderPreviewRequestSideEnum];
  @override
  final String wireName = 'PerpOrderPreviewRequestSideEnum';

  @override
  Object serialize(
          Serializers serializers, PerpOrderPreviewRequestSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderPreviewRequestSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderPreviewRequestSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderPreviewRequest extends PerpOrderPreviewRequest {
  @override
  final String? contextId;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final Hip3OrderProtectionSpec? protection;
  @override
  final String symbol;
  @override
  final PerpOrderPreviewRequestKindEnum kind;
  @override
  final PerpOrderPreviewRequestSideEnum side;
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
  final MarginMode? marginMode;
  @override
  final bool? reduceOnly;
  @override
  final String? slippagePercent;
  @override
  final TpSlSpec? tpSl;

  factory _$PerpOrderPreviewRequest(
          [void Function(PerpOrderPreviewRequestBuilder)? updates]) =>
      (PerpOrderPreviewRequestBuilder()..update(updates))._build();

  _$PerpOrderPreviewRequest._(
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
      this.marginMode,
      this.reduceOnly,
      this.slippagePercent,
      this.tpSl})
      : super._();
  @override
  PerpOrderPreviewRequest rebuild(
          void Function(PerpOrderPreviewRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpOrderPreviewRequestBuilder toBuilder() =>
      PerpOrderPreviewRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpOrderPreviewRequest &&
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
        tpSl == other.tpSl;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PerpOrderPreviewRequest')
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
          ..add('tpSl', tpSl))
        .toString();
  }
}

class PerpOrderPreviewRequestBuilder
    implements
        Builder<PerpOrderPreviewRequest, PerpOrderPreviewRequestBuilder> {
  _$PerpOrderPreviewRequest? _$v;

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

  PerpOrderPreviewRequestKindEnum? _kind;
  PerpOrderPreviewRequestKindEnum? get kind => _$this._kind;
  set kind(PerpOrderPreviewRequestKindEnum? kind) => _$this._kind = kind;

  PerpOrderPreviewRequestSideEnum? _side;
  PerpOrderPreviewRequestSideEnum? get side => _$this._side;
  set side(PerpOrderPreviewRequestSideEnum? side) => _$this._side = side;

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

  PerpOrderPreviewRequestBuilder() {
    PerpOrderPreviewRequest._defaults(this);
  }

  PerpOrderPreviewRequestBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PerpOrderPreviewRequest other) {
    _$v = other as _$PerpOrderPreviewRequest;
  }

  @override
  void update(void Function(PerpOrderPreviewRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpOrderPreviewRequest build() => _build();

  _$PerpOrderPreviewRequest _build() {
    _$PerpOrderPreviewRequest _$result;
    try {
      _$result = _$v ??
          _$PerpOrderPreviewRequest._(
            contextId: contextId,
            timeInForce: timeInForce,
            protection: _protection?.build(),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PerpOrderPreviewRequest', 'symbol'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'PerpOrderPreviewRequest', 'kind'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'PerpOrderPreviewRequest', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'PerpOrderPreviewRequest', 'type'),
            amount: amount,
            quantity: quantity,
            limitPrice: limitPrice,
            leverage: leverage,
            marginMode: marginMode,
            reduceOnly: reduceOnly,
            slippagePercent: slippagePercent,
            tpSl: _tpSl?.build(),
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
            r'PerpOrderPreviewRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
