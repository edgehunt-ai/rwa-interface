// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_close_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ClosePreviewSideEnum _$hip3ClosePreviewSideEnum_long =
    const Hip3ClosePreviewSideEnum._('long');
const Hip3ClosePreviewSideEnum _$hip3ClosePreviewSideEnum_short =
    const Hip3ClosePreviewSideEnum._('short');
const Hip3ClosePreviewSideEnum
    _$hip3ClosePreviewSideEnum_unknownDefaultOpenApi =
    const Hip3ClosePreviewSideEnum._('unknownDefaultOpenApi');

Hip3ClosePreviewSideEnum _$hip3ClosePreviewSideEnumValueOf(String name) {
  switch (name) {
    case 'long':
      return _$hip3ClosePreviewSideEnum_long;
    case 'short':
      return _$hip3ClosePreviewSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$hip3ClosePreviewSideEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ClosePreviewSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ClosePreviewSideEnum> _$hip3ClosePreviewSideEnumValues =
    BuiltSet<Hip3ClosePreviewSideEnum>(const <Hip3ClosePreviewSideEnum>[
  _$hip3ClosePreviewSideEnum_long,
  _$hip3ClosePreviewSideEnum_short,
  _$hip3ClosePreviewSideEnum_unknownDefaultOpenApi,
]);

const Hip3ClosePreviewTypeEnum _$hip3ClosePreviewTypeEnum_market =
    const Hip3ClosePreviewTypeEnum._('market');
const Hip3ClosePreviewTypeEnum _$hip3ClosePreviewTypeEnum_limit =
    const Hip3ClosePreviewTypeEnum._('limit');
const Hip3ClosePreviewTypeEnum
    _$hip3ClosePreviewTypeEnum_unknownDefaultOpenApi =
    const Hip3ClosePreviewTypeEnum._('unknownDefaultOpenApi');

Hip3ClosePreviewTypeEnum _$hip3ClosePreviewTypeEnumValueOf(String name) {
  switch (name) {
    case 'market':
      return _$hip3ClosePreviewTypeEnum_market;
    case 'limit':
      return _$hip3ClosePreviewTypeEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3ClosePreviewTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ClosePreviewTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ClosePreviewTypeEnum> _$hip3ClosePreviewTypeEnumValues =
    BuiltSet<Hip3ClosePreviewTypeEnum>(const <Hip3ClosePreviewTypeEnum>[
  _$hip3ClosePreviewTypeEnum_market,
  _$hip3ClosePreviewTypeEnum_limit,
  _$hip3ClosePreviewTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ClosePreviewSideEnum> _$hip3ClosePreviewSideEnumSerializer =
    _$Hip3ClosePreviewSideEnumSerializer();
Serializer<Hip3ClosePreviewTypeEnum> _$hip3ClosePreviewTypeEnumSerializer =
    _$Hip3ClosePreviewTypeEnumSerializer();

class _$Hip3ClosePreviewSideEnumSerializer
    implements PrimitiveSerializer<Hip3ClosePreviewSideEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3ClosePreviewSideEnum];
  @override
  final String wireName = 'Hip3ClosePreviewSideEnum';

  @override
  Object serialize(Serializers serializers, Hip3ClosePreviewSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ClosePreviewSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ClosePreviewSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ClosePreviewTypeEnumSerializer
    implements PrimitiveSerializer<Hip3ClosePreviewTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ClosePreviewTypeEnum];
  @override
  final String wireName = 'Hip3ClosePreviewTypeEnum';

  @override
  Object serialize(Serializers serializers, Hip3ClosePreviewTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ClosePreviewTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ClosePreviewTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ClosePreview extends Hip3ClosePreview {
  @override
  final String previewId;
  @override
  final String positionId;
  @override
  final String positionVersion;
  @override
  final Hip3Environment environment;
  @override
  final String productId;
  @override
  final Hip3ClosePreviewSideEnum side;
  @override
  final Hip3ClosePreviewTypeEnum type;
  @override
  final Hip3TimeInForce timeInForce;
  @override
  final String quantity;
  @override
  final String remainingQuantity;
  @override
  final String entryPrice;
  @override
  final String markPrice;
  @override
  final String? limitPrice;
  @override
  final String estimatedPrice;
  @override
  final String notionalUsdc;
  @override
  final String estimatedFeeUsdc;
  @override
  final String estimatedRealizedPnlUsdc;
  @override
  final String? liquidationPrice;
  @override
  final String slippagePercent;
  @override
  final DateTime quoteExpiresAt;
  @override
  final DateTime observedAt;

  factory _$Hip3ClosePreview(
          [void Function(Hip3ClosePreviewBuilder)? updates]) =>
      (Hip3ClosePreviewBuilder()..update(updates))._build();

  _$Hip3ClosePreview._(
      {required this.previewId,
      required this.positionId,
      required this.positionVersion,
      required this.environment,
      required this.productId,
      required this.side,
      required this.type,
      required this.timeInForce,
      required this.quantity,
      required this.remainingQuantity,
      required this.entryPrice,
      required this.markPrice,
      this.limitPrice,
      required this.estimatedPrice,
      required this.notionalUsdc,
      required this.estimatedFeeUsdc,
      required this.estimatedRealizedPnlUsdc,
      this.liquidationPrice,
      required this.slippagePercent,
      required this.quoteExpiresAt,
      required this.observedAt})
      : super._();
  @override
  Hip3ClosePreview rebuild(void Function(Hip3ClosePreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ClosePreviewBuilder toBuilder() =>
      Hip3ClosePreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ClosePreview &&
        previewId == other.previewId &&
        positionId == other.positionId &&
        positionVersion == other.positionVersion &&
        environment == other.environment &&
        productId == other.productId &&
        side == other.side &&
        type == other.type &&
        timeInForce == other.timeInForce &&
        quantity == other.quantity &&
        remainingQuantity == other.remainingQuantity &&
        entryPrice == other.entryPrice &&
        markPrice == other.markPrice &&
        limitPrice == other.limitPrice &&
        estimatedPrice == other.estimatedPrice &&
        notionalUsdc == other.notionalUsdc &&
        estimatedFeeUsdc == other.estimatedFeeUsdc &&
        estimatedRealizedPnlUsdc == other.estimatedRealizedPnlUsdc &&
        liquidationPrice == other.liquidationPrice &&
        slippagePercent == other.slippagePercent &&
        quoteExpiresAt == other.quoteExpiresAt &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, positionVersion.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, remainingQuantity.hashCode);
    _$hash = $jc(_$hash, entryPrice.hashCode);
    _$hash = $jc(_$hash, markPrice.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, estimatedPrice.hashCode);
    _$hash = $jc(_$hash, notionalUsdc.hashCode);
    _$hash = $jc(_$hash, estimatedFeeUsdc.hashCode);
    _$hash = $jc(_$hash, estimatedRealizedPnlUsdc.hashCode);
    _$hash = $jc(_$hash, liquidationPrice.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, quoteExpiresAt.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ClosePreview')
          ..add('previewId', previewId)
          ..add('positionId', positionId)
          ..add('positionVersion', positionVersion)
          ..add('environment', environment)
          ..add('productId', productId)
          ..add('side', side)
          ..add('type', type)
          ..add('timeInForce', timeInForce)
          ..add('quantity', quantity)
          ..add('remainingQuantity', remainingQuantity)
          ..add('entryPrice', entryPrice)
          ..add('markPrice', markPrice)
          ..add('limitPrice', limitPrice)
          ..add('estimatedPrice', estimatedPrice)
          ..add('notionalUsdc', notionalUsdc)
          ..add('estimatedFeeUsdc', estimatedFeeUsdc)
          ..add('estimatedRealizedPnlUsdc', estimatedRealizedPnlUsdc)
          ..add('liquidationPrice', liquidationPrice)
          ..add('slippagePercent', slippagePercent)
          ..add('quoteExpiresAt', quoteExpiresAt)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class Hip3ClosePreviewBuilder
    implements Builder<Hip3ClosePreview, Hip3ClosePreviewBuilder> {
  _$Hip3ClosePreview? _$v;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _positionVersion;
  String? get positionVersion => _$this._positionVersion;
  set positionVersion(String? positionVersion) =>
      _$this._positionVersion = positionVersion;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  Hip3ClosePreviewSideEnum? _side;
  Hip3ClosePreviewSideEnum? get side => _$this._side;
  set side(Hip3ClosePreviewSideEnum? side) => _$this._side = side;

  Hip3ClosePreviewTypeEnum? _type;
  Hip3ClosePreviewTypeEnum? get type => _$this._type;
  set type(Hip3ClosePreviewTypeEnum? type) => _$this._type = type;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _remainingQuantity;
  String? get remainingQuantity => _$this._remainingQuantity;
  set remainingQuantity(String? remainingQuantity) =>
      _$this._remainingQuantity = remainingQuantity;

  String? _entryPrice;
  String? get entryPrice => _$this._entryPrice;
  set entryPrice(String? entryPrice) => _$this._entryPrice = entryPrice;

  String? _markPrice;
  String? get markPrice => _$this._markPrice;
  set markPrice(String? markPrice) => _$this._markPrice = markPrice;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _estimatedPrice;
  String? get estimatedPrice => _$this._estimatedPrice;
  set estimatedPrice(String? estimatedPrice) =>
      _$this._estimatedPrice = estimatedPrice;

  String? _notionalUsdc;
  String? get notionalUsdc => _$this._notionalUsdc;
  set notionalUsdc(String? notionalUsdc) => _$this._notionalUsdc = notionalUsdc;

  String? _estimatedFeeUsdc;
  String? get estimatedFeeUsdc => _$this._estimatedFeeUsdc;
  set estimatedFeeUsdc(String? estimatedFeeUsdc) =>
      _$this._estimatedFeeUsdc = estimatedFeeUsdc;

  String? _estimatedRealizedPnlUsdc;
  String? get estimatedRealizedPnlUsdc => _$this._estimatedRealizedPnlUsdc;
  set estimatedRealizedPnlUsdc(String? estimatedRealizedPnlUsdc) =>
      _$this._estimatedRealizedPnlUsdc = estimatedRealizedPnlUsdc;

  String? _liquidationPrice;
  String? get liquidationPrice => _$this._liquidationPrice;
  set liquidationPrice(String? liquidationPrice) =>
      _$this._liquidationPrice = liquidationPrice;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  DateTime? _quoteExpiresAt;
  DateTime? get quoteExpiresAt => _$this._quoteExpiresAt;
  set quoteExpiresAt(DateTime? quoteExpiresAt) =>
      _$this._quoteExpiresAt = quoteExpiresAt;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  Hip3ClosePreviewBuilder() {
    Hip3ClosePreview._defaults(this);
  }

  Hip3ClosePreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _previewId = $v.previewId;
      _positionId = $v.positionId;
      _positionVersion = $v.positionVersion;
      _environment = $v.environment;
      _productId = $v.productId;
      _side = $v.side;
      _type = $v.type;
      _timeInForce = $v.timeInForce;
      _quantity = $v.quantity;
      _remainingQuantity = $v.remainingQuantity;
      _entryPrice = $v.entryPrice;
      _markPrice = $v.markPrice;
      _limitPrice = $v.limitPrice;
      _estimatedPrice = $v.estimatedPrice;
      _notionalUsdc = $v.notionalUsdc;
      _estimatedFeeUsdc = $v.estimatedFeeUsdc;
      _estimatedRealizedPnlUsdc = $v.estimatedRealizedPnlUsdc;
      _liquidationPrice = $v.liquidationPrice;
      _slippagePercent = $v.slippagePercent;
      _quoteExpiresAt = $v.quoteExpiresAt;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ClosePreview other) {
    _$v = other as _$Hip3ClosePreview;
  }

  @override
  void update(void Function(Hip3ClosePreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ClosePreview build() => _build();

  _$Hip3ClosePreview _build() {
    final _$result = _$v ??
        _$Hip3ClosePreview._(
          previewId: BuiltValueNullFieldError.checkNotNull(
              previewId, r'Hip3ClosePreview', 'previewId'),
          positionId: BuiltValueNullFieldError.checkNotNull(
              positionId, r'Hip3ClosePreview', 'positionId'),
          positionVersion: BuiltValueNullFieldError.checkNotNull(
              positionVersion, r'Hip3ClosePreview', 'positionVersion'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'Hip3ClosePreview', 'environment'),
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3ClosePreview', 'productId'),
          side: BuiltValueNullFieldError.checkNotNull(
              side, r'Hip3ClosePreview', 'side'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'Hip3ClosePreview', 'type'),
          timeInForce: BuiltValueNullFieldError.checkNotNull(
              timeInForce, r'Hip3ClosePreview', 'timeInForce'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'Hip3ClosePreview', 'quantity'),
          remainingQuantity: BuiltValueNullFieldError.checkNotNull(
              remainingQuantity, r'Hip3ClosePreview', 'remainingQuantity'),
          entryPrice: BuiltValueNullFieldError.checkNotNull(
              entryPrice, r'Hip3ClosePreview', 'entryPrice'),
          markPrice: BuiltValueNullFieldError.checkNotNull(
              markPrice, r'Hip3ClosePreview', 'markPrice'),
          limitPrice: limitPrice,
          estimatedPrice: BuiltValueNullFieldError.checkNotNull(
              estimatedPrice, r'Hip3ClosePreview', 'estimatedPrice'),
          notionalUsdc: BuiltValueNullFieldError.checkNotNull(
              notionalUsdc, r'Hip3ClosePreview', 'notionalUsdc'),
          estimatedFeeUsdc: BuiltValueNullFieldError.checkNotNull(
              estimatedFeeUsdc, r'Hip3ClosePreview', 'estimatedFeeUsdc'),
          estimatedRealizedPnlUsdc: BuiltValueNullFieldError.checkNotNull(
              estimatedRealizedPnlUsdc,
              r'Hip3ClosePreview',
              'estimatedRealizedPnlUsdc'),
          liquidationPrice: liquidationPrice,
          slippagePercent: BuiltValueNullFieldError.checkNotNull(
              slippagePercent, r'Hip3ClosePreview', 'slippagePercent'),
          quoteExpiresAt: BuiltValueNullFieldError.checkNotNull(
              quoteExpiresAt, r'Hip3ClosePreview', 'quoteExpiresAt'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'Hip3ClosePreview', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
