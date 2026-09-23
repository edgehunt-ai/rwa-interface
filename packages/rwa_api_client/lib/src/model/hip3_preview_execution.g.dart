// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_preview_execution.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3PreviewExecutionTypeEnum _$hip3PreviewExecutionTypeEnum_market =
    const Hip3PreviewExecutionTypeEnum._('market');
const Hip3PreviewExecutionTypeEnum _$hip3PreviewExecutionTypeEnum_limit =
    const Hip3PreviewExecutionTypeEnum._('limit');
const Hip3PreviewExecutionTypeEnum
    _$hip3PreviewExecutionTypeEnum_unknownDefaultOpenApi =
    const Hip3PreviewExecutionTypeEnum._('unknownDefaultOpenApi');

Hip3PreviewExecutionTypeEnum _$hip3PreviewExecutionTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'market':
      return _$hip3PreviewExecutionTypeEnum_market;
    case 'limit':
      return _$hip3PreviewExecutionTypeEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3PreviewExecutionTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3PreviewExecutionTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3PreviewExecutionTypeEnum>
    _$hip3PreviewExecutionTypeEnumValues =
    BuiltSet<Hip3PreviewExecutionTypeEnum>(const <Hip3PreviewExecutionTypeEnum>[
  _$hip3PreviewExecutionTypeEnum_market,
  _$hip3PreviewExecutionTypeEnum_limit,
  _$hip3PreviewExecutionTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3PreviewExecutionTypeEnum>
    _$hip3PreviewExecutionTypeEnumSerializer =
    _$Hip3PreviewExecutionTypeEnumSerializer();

class _$Hip3PreviewExecutionTypeEnumSerializer
    implements PrimitiveSerializer<Hip3PreviewExecutionTypeEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3PreviewExecutionTypeEnum];
  @override
  final String wireName = 'Hip3PreviewExecutionTypeEnum';

  @override
  Object serialize(Serializers serializers, Hip3PreviewExecutionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PreviewExecutionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PreviewExecutionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PreviewExecution extends Hip3PreviewExecution {
  @override
  final Hip3OpeningProtectionConfirmation? openingProtection;
  @override
  final String contextId;
  @override
  final String productId;
  @override
  final Hip3Environment environment;
  @override
  final String quantity;
  @override
  final Hip3PreviewExecutionTypeEnum type;
  @override
  final Hip3TimeInForce timeInForce;
  @override
  final String limitPrice;
  @override
  final String leverage;
  @override
  final MarginMode marginMode;
  @override
  final bool reduceOnly;
  @override
  final String notionalUsdc;
  @override
  final String marginRequiredUsdc;
  @override
  final String availableMarginUsdc;
  @override
  final String maximumQuantity;
  @override
  final String estimatedFeeUsdc;
  @override
  final String? liquidationPrice;
  @override
  final String? liquidationPriceUnavailableReason;
  @override
  final BuiltList<Hip3CrossLiquidationImpact> crossLiquidationImpacts;
  @override
  final String slippagePercent;

  factory _$Hip3PreviewExecution(
          [void Function(Hip3PreviewExecutionBuilder)? updates]) =>
      (Hip3PreviewExecutionBuilder()..update(updates))._build();

  _$Hip3PreviewExecution._(
      {this.openingProtection,
      required this.contextId,
      required this.productId,
      required this.environment,
      required this.quantity,
      required this.type,
      required this.timeInForce,
      required this.limitPrice,
      required this.leverage,
      required this.marginMode,
      required this.reduceOnly,
      required this.notionalUsdc,
      required this.marginRequiredUsdc,
      required this.availableMarginUsdc,
      required this.maximumQuantity,
      required this.estimatedFeeUsdc,
      this.liquidationPrice,
      this.liquidationPriceUnavailableReason,
      required this.crossLiquidationImpacts,
      required this.slippagePercent})
      : super._();
  @override
  Hip3PreviewExecution rebuild(
          void Function(Hip3PreviewExecutionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3PreviewExecutionBuilder toBuilder() =>
      Hip3PreviewExecutionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3PreviewExecution &&
        openingProtection == other.openingProtection &&
        contextId == other.contextId &&
        productId == other.productId &&
        environment == other.environment &&
        quantity == other.quantity &&
        type == other.type &&
        timeInForce == other.timeInForce &&
        limitPrice == other.limitPrice &&
        leverage == other.leverage &&
        marginMode == other.marginMode &&
        reduceOnly == other.reduceOnly &&
        notionalUsdc == other.notionalUsdc &&
        marginRequiredUsdc == other.marginRequiredUsdc &&
        availableMarginUsdc == other.availableMarginUsdc &&
        maximumQuantity == other.maximumQuantity &&
        estimatedFeeUsdc == other.estimatedFeeUsdc &&
        liquidationPrice == other.liquidationPrice &&
        liquidationPriceUnavailableReason ==
            other.liquidationPriceUnavailableReason &&
        crossLiquidationImpacts == other.crossLiquidationImpacts &&
        slippagePercent == other.slippagePercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, openingProtection.hashCode);
    _$hash = $jc(_$hash, contextId.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jc(_$hash, reduceOnly.hashCode);
    _$hash = $jc(_$hash, notionalUsdc.hashCode);
    _$hash = $jc(_$hash, marginRequiredUsdc.hashCode);
    _$hash = $jc(_$hash, availableMarginUsdc.hashCode);
    _$hash = $jc(_$hash, maximumQuantity.hashCode);
    _$hash = $jc(_$hash, estimatedFeeUsdc.hashCode);
    _$hash = $jc(_$hash, liquidationPrice.hashCode);
    _$hash = $jc(_$hash, liquidationPriceUnavailableReason.hashCode);
    _$hash = $jc(_$hash, crossLiquidationImpacts.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3PreviewExecution')
          ..add('openingProtection', openingProtection)
          ..add('contextId', contextId)
          ..add('productId', productId)
          ..add('environment', environment)
          ..add('quantity', quantity)
          ..add('type', type)
          ..add('timeInForce', timeInForce)
          ..add('limitPrice', limitPrice)
          ..add('leverage', leverage)
          ..add('marginMode', marginMode)
          ..add('reduceOnly', reduceOnly)
          ..add('notionalUsdc', notionalUsdc)
          ..add('marginRequiredUsdc', marginRequiredUsdc)
          ..add('availableMarginUsdc', availableMarginUsdc)
          ..add('maximumQuantity', maximumQuantity)
          ..add('estimatedFeeUsdc', estimatedFeeUsdc)
          ..add('liquidationPrice', liquidationPrice)
          ..add('liquidationPriceUnavailableReason',
              liquidationPriceUnavailableReason)
          ..add('crossLiquidationImpacts', crossLiquidationImpacts)
          ..add('slippagePercent', slippagePercent))
        .toString();
  }
}

class Hip3PreviewExecutionBuilder
    implements Builder<Hip3PreviewExecution, Hip3PreviewExecutionBuilder> {
  _$Hip3PreviewExecution? _$v;

  Hip3OpeningProtectionConfirmationBuilder? _openingProtection;
  Hip3OpeningProtectionConfirmationBuilder get openingProtection =>
      _$this._openingProtection ??= Hip3OpeningProtectionConfirmationBuilder();
  set openingProtection(
          Hip3OpeningProtectionConfirmationBuilder? openingProtection) =>
      _$this._openingProtection = openingProtection;

  String? _contextId;
  String? get contextId => _$this._contextId;
  set contextId(String? contextId) => _$this._contextId = contextId;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  Hip3PreviewExecutionTypeEnum? _type;
  Hip3PreviewExecutionTypeEnum? get type => _$this._type;
  set type(Hip3PreviewExecutionTypeEnum? type) => _$this._type = type;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

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

  String? _notionalUsdc;
  String? get notionalUsdc => _$this._notionalUsdc;
  set notionalUsdc(String? notionalUsdc) => _$this._notionalUsdc = notionalUsdc;

  String? _marginRequiredUsdc;
  String? get marginRequiredUsdc => _$this._marginRequiredUsdc;
  set marginRequiredUsdc(String? marginRequiredUsdc) =>
      _$this._marginRequiredUsdc = marginRequiredUsdc;

  String? _availableMarginUsdc;
  String? get availableMarginUsdc => _$this._availableMarginUsdc;
  set availableMarginUsdc(String? availableMarginUsdc) =>
      _$this._availableMarginUsdc = availableMarginUsdc;

  String? _maximumQuantity;
  String? get maximumQuantity => _$this._maximumQuantity;
  set maximumQuantity(String? maximumQuantity) =>
      _$this._maximumQuantity = maximumQuantity;

  String? _estimatedFeeUsdc;
  String? get estimatedFeeUsdc => _$this._estimatedFeeUsdc;
  set estimatedFeeUsdc(String? estimatedFeeUsdc) =>
      _$this._estimatedFeeUsdc = estimatedFeeUsdc;

  String? _liquidationPrice;
  String? get liquidationPrice => _$this._liquidationPrice;
  set liquidationPrice(String? liquidationPrice) =>
      _$this._liquidationPrice = liquidationPrice;

  String? _liquidationPriceUnavailableReason;
  String? get liquidationPriceUnavailableReason =>
      _$this._liquidationPriceUnavailableReason;
  set liquidationPriceUnavailableReason(
          String? liquidationPriceUnavailableReason) =>
      _$this._liquidationPriceUnavailableReason =
          liquidationPriceUnavailableReason;

  ListBuilder<Hip3CrossLiquidationImpact>? _crossLiquidationImpacts;
  ListBuilder<Hip3CrossLiquidationImpact> get crossLiquidationImpacts =>
      _$this._crossLiquidationImpacts ??=
          ListBuilder<Hip3CrossLiquidationImpact>();
  set crossLiquidationImpacts(
          ListBuilder<Hip3CrossLiquidationImpact>? crossLiquidationImpacts) =>
      _$this._crossLiquidationImpacts = crossLiquidationImpacts;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  Hip3PreviewExecutionBuilder() {
    Hip3PreviewExecution._defaults(this);
  }

  Hip3PreviewExecutionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _openingProtection = $v.openingProtection?.toBuilder();
      _contextId = $v.contextId;
      _productId = $v.productId;
      _environment = $v.environment;
      _quantity = $v.quantity;
      _type = $v.type;
      _timeInForce = $v.timeInForce;
      _limitPrice = $v.limitPrice;
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _reduceOnly = $v.reduceOnly;
      _notionalUsdc = $v.notionalUsdc;
      _marginRequiredUsdc = $v.marginRequiredUsdc;
      _availableMarginUsdc = $v.availableMarginUsdc;
      _maximumQuantity = $v.maximumQuantity;
      _estimatedFeeUsdc = $v.estimatedFeeUsdc;
      _liquidationPrice = $v.liquidationPrice;
      _liquidationPriceUnavailableReason = $v.liquidationPriceUnavailableReason;
      _crossLiquidationImpacts = $v.crossLiquidationImpacts.toBuilder();
      _slippagePercent = $v.slippagePercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3PreviewExecution other) {
    _$v = other as _$Hip3PreviewExecution;
  }

  @override
  void update(void Function(Hip3PreviewExecutionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3PreviewExecution build() => _build();

  _$Hip3PreviewExecution _build() {
    _$Hip3PreviewExecution _$result;
    try {
      _$result = _$v ??
          _$Hip3PreviewExecution._(
            openingProtection: _openingProtection?.build(),
            contextId: BuiltValueNullFieldError.checkNotNull(
                contextId, r'Hip3PreviewExecution', 'contextId'),
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'Hip3PreviewExecution', 'productId'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3PreviewExecution', 'environment'),
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, r'Hip3PreviewExecution', 'quantity'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'Hip3PreviewExecution', 'type'),
            timeInForce: BuiltValueNullFieldError.checkNotNull(
                timeInForce, r'Hip3PreviewExecution', 'timeInForce'),
            limitPrice: BuiltValueNullFieldError.checkNotNull(
                limitPrice, r'Hip3PreviewExecution', 'limitPrice'),
            leverage: BuiltValueNullFieldError.checkNotNull(
                leverage, r'Hip3PreviewExecution', 'leverage'),
            marginMode: BuiltValueNullFieldError.checkNotNull(
                marginMode, r'Hip3PreviewExecution', 'marginMode'),
            reduceOnly: BuiltValueNullFieldError.checkNotNull(
                reduceOnly, r'Hip3PreviewExecution', 'reduceOnly'),
            notionalUsdc: BuiltValueNullFieldError.checkNotNull(
                notionalUsdc, r'Hip3PreviewExecution', 'notionalUsdc'),
            marginRequiredUsdc: BuiltValueNullFieldError.checkNotNull(
                marginRequiredUsdc,
                r'Hip3PreviewExecution',
                'marginRequiredUsdc'),
            availableMarginUsdc: BuiltValueNullFieldError.checkNotNull(
                availableMarginUsdc,
                r'Hip3PreviewExecution',
                'availableMarginUsdc'),
            maximumQuantity: BuiltValueNullFieldError.checkNotNull(
                maximumQuantity, r'Hip3PreviewExecution', 'maximumQuantity'),
            estimatedFeeUsdc: BuiltValueNullFieldError.checkNotNull(
                estimatedFeeUsdc, r'Hip3PreviewExecution', 'estimatedFeeUsdc'),
            liquidationPrice: liquidationPrice,
            liquidationPriceUnavailableReason:
                liquidationPriceUnavailableReason,
            crossLiquidationImpacts: crossLiquidationImpacts.build(),
            slippagePercent: BuiltValueNullFieldError.checkNotNull(
                slippagePercent, r'Hip3PreviewExecution', 'slippagePercent'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'openingProtection';
        _openingProtection?.build();

        _$failedField = 'crossLiquidationImpacts';
        crossLiquidationImpacts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3PreviewExecution', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
