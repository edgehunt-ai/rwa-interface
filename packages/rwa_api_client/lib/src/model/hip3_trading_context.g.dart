// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_trading_context.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3TradingContextSettlementAssetEnum
    _$hip3TradingContextSettlementAssetEnum_USDC =
    const Hip3TradingContextSettlementAssetEnum._('USDC');
const Hip3TradingContextSettlementAssetEnum
    _$hip3TradingContextSettlementAssetEnum_unknownDefaultOpenApi =
    const Hip3TradingContextSettlementAssetEnum._('unknownDefaultOpenApi');

Hip3TradingContextSettlementAssetEnum
    _$hip3TradingContextSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$hip3TradingContextSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$hip3TradingContextSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$hip3TradingContextSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TradingContextSettlementAssetEnum>
    _$hip3TradingContextSettlementAssetEnumValues = BuiltSet<
        Hip3TradingContextSettlementAssetEnum>(const <Hip3TradingContextSettlementAssetEnum>[
  _$hip3TradingContextSettlementAssetEnum_USDC,
  _$hip3TradingContextSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3TradingContextSettlementAssetEnum>
    _$hip3TradingContextSettlementAssetEnumSerializer =
    _$Hip3TradingContextSettlementAssetEnumSerializer();

class _$Hip3TradingContextSettlementAssetEnumSerializer
    implements PrimitiveSerializer<Hip3TradingContextSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3TradingContextSettlementAssetEnum
  ];
  @override
  final String wireName = 'Hip3TradingContextSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3TradingContextSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TradingContextSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TradingContextSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3TradingContext extends Hip3TradingContext {
  @override
  final String contextId;
  @override
  final Hip3Environment environment;
  @override
  final String productId;
  @override
  final String symbol;
  @override
  final String venue;
  @override
  final Hip3TradingContextSettlementAssetEnum settlementAsset;
  @override
  final Hip3TradingRules rules;
  @override
  final String? currentLeverage;
  @override
  final MarginMode? currentMarginMode;
  @override
  final String availableMarginUsdc;
  @override
  final String withdrawableUsdc;
  @override
  final BuiltList<Hip3Operation> supportedOperations;
  @override
  final String? blocker;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$Hip3TradingContext(
          [void Function(Hip3TradingContextBuilder)? updates]) =>
      (Hip3TradingContextBuilder()..update(updates))._build();

  _$Hip3TradingContext._(
      {required this.contextId,
      required this.environment,
      required this.productId,
      required this.symbol,
      required this.venue,
      required this.settlementAsset,
      required this.rules,
      this.currentLeverage,
      this.currentMarginMode,
      required this.availableMarginUsdc,
      required this.withdrawableUsdc,
      required this.supportedOperations,
      this.blocker,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  Hip3TradingContext rebuild(
          void Function(Hip3TradingContextBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3TradingContextBuilder toBuilder() =>
      Hip3TradingContextBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3TradingContext &&
        contextId == other.contextId &&
        environment == other.environment &&
        productId == other.productId &&
        symbol == other.symbol &&
        venue == other.venue &&
        settlementAsset == other.settlementAsset &&
        rules == other.rules &&
        currentLeverage == other.currentLeverage &&
        currentMarginMode == other.currentMarginMode &&
        availableMarginUsdc == other.availableMarginUsdc &&
        withdrawableUsdc == other.withdrawableUsdc &&
        supportedOperations == other.supportedOperations &&
        blocker == other.blocker &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, contextId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, venue.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, rules.hashCode);
    _$hash = $jc(_$hash, currentLeverage.hashCode);
    _$hash = $jc(_$hash, currentMarginMode.hashCode);
    _$hash = $jc(_$hash, availableMarginUsdc.hashCode);
    _$hash = $jc(_$hash, withdrawableUsdc.hashCode);
    _$hash = $jc(_$hash, supportedOperations.hashCode);
    _$hash = $jc(_$hash, blocker.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3TradingContext')
          ..add('contextId', contextId)
          ..add('environment', environment)
          ..add('productId', productId)
          ..add('symbol', symbol)
          ..add('venue', venue)
          ..add('settlementAsset', settlementAsset)
          ..add('rules', rules)
          ..add('currentLeverage', currentLeverage)
          ..add('currentMarginMode', currentMarginMode)
          ..add('availableMarginUsdc', availableMarginUsdc)
          ..add('withdrawableUsdc', withdrawableUsdc)
          ..add('supportedOperations', supportedOperations)
          ..add('blocker', blocker)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class Hip3TradingContextBuilder
    implements Builder<Hip3TradingContext, Hip3TradingContextBuilder> {
  _$Hip3TradingContext? _$v;

  String? _contextId;
  String? get contextId => _$this._contextId;
  set contextId(String? contextId) => _$this._contextId = contextId;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _venue;
  String? get venue => _$this._venue;
  set venue(String? venue) => _$this._venue = venue;

  Hip3TradingContextSettlementAssetEnum? _settlementAsset;
  Hip3TradingContextSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(Hip3TradingContextSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  Hip3TradingRulesBuilder? _rules;
  Hip3TradingRulesBuilder get rules =>
      _$this._rules ??= Hip3TradingRulesBuilder();
  set rules(Hip3TradingRulesBuilder? rules) => _$this._rules = rules;

  String? _currentLeverage;
  String? get currentLeverage => _$this._currentLeverage;
  set currentLeverage(String? currentLeverage) =>
      _$this._currentLeverage = currentLeverage;

  MarginMode? _currentMarginMode;
  MarginMode? get currentMarginMode => _$this._currentMarginMode;
  set currentMarginMode(MarginMode? currentMarginMode) =>
      _$this._currentMarginMode = currentMarginMode;

  String? _availableMarginUsdc;
  String? get availableMarginUsdc => _$this._availableMarginUsdc;
  set availableMarginUsdc(String? availableMarginUsdc) =>
      _$this._availableMarginUsdc = availableMarginUsdc;

  String? _withdrawableUsdc;
  String? get withdrawableUsdc => _$this._withdrawableUsdc;
  set withdrawableUsdc(String? withdrawableUsdc) =>
      _$this._withdrawableUsdc = withdrawableUsdc;

  ListBuilder<Hip3Operation>? _supportedOperations;
  ListBuilder<Hip3Operation> get supportedOperations =>
      _$this._supportedOperations ??= ListBuilder<Hip3Operation>();
  set supportedOperations(ListBuilder<Hip3Operation>? supportedOperations) =>
      _$this._supportedOperations = supportedOperations;

  String? _blocker;
  String? get blocker => _$this._blocker;
  set blocker(String? blocker) => _$this._blocker = blocker;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  Hip3TradingContextBuilder() {
    Hip3TradingContext._defaults(this);
  }

  Hip3TradingContextBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _contextId = $v.contextId;
      _environment = $v.environment;
      _productId = $v.productId;
      _symbol = $v.symbol;
      _venue = $v.venue;
      _settlementAsset = $v.settlementAsset;
      _rules = $v.rules.toBuilder();
      _currentLeverage = $v.currentLeverage;
      _currentMarginMode = $v.currentMarginMode;
      _availableMarginUsdc = $v.availableMarginUsdc;
      _withdrawableUsdc = $v.withdrawableUsdc;
      _supportedOperations = $v.supportedOperations.toBuilder();
      _blocker = $v.blocker;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3TradingContext other) {
    _$v = other as _$Hip3TradingContext;
  }

  @override
  void update(void Function(Hip3TradingContextBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3TradingContext build() => _build();

  _$Hip3TradingContext _build() {
    _$Hip3TradingContext _$result;
    try {
      _$result = _$v ??
          _$Hip3TradingContext._(
            contextId: BuiltValueNullFieldError.checkNotNull(
                contextId, r'Hip3TradingContext', 'contextId'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3TradingContext', 'environment'),
            productId: BuiltValueNullFieldError.checkNotNull(
                productId, r'Hip3TradingContext', 'productId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'Hip3TradingContext', 'symbol'),
            venue: BuiltValueNullFieldError.checkNotNull(
                venue, r'Hip3TradingContext', 'venue'),
            settlementAsset: BuiltValueNullFieldError.checkNotNull(
                settlementAsset, r'Hip3TradingContext', 'settlementAsset'),
            rules: rules.build(),
            currentLeverage: currentLeverage,
            currentMarginMode: currentMarginMode,
            availableMarginUsdc: BuiltValueNullFieldError.checkNotNull(
                availableMarginUsdc,
                r'Hip3TradingContext',
                'availableMarginUsdc'),
            withdrawableUsdc: BuiltValueNullFieldError.checkNotNull(
                withdrawableUsdc, r'Hip3TradingContext', 'withdrawableUsdc'),
            supportedOperations: supportedOperations.build(),
            blocker: blocker,
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3TradingContext', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'Hip3TradingContext', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rules';
        rules.build();

        _$failedField = 'supportedOperations';
        supportedOperations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3TradingContext', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
