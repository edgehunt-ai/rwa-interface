// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_trading_rules.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3TradingRulesOrderTypesEnum _$hip3TradingRulesOrderTypesEnum_market =
    const Hip3TradingRulesOrderTypesEnum._('market');
const Hip3TradingRulesOrderTypesEnum _$hip3TradingRulesOrderTypesEnum_limit =
    const Hip3TradingRulesOrderTypesEnum._('limit');
const Hip3TradingRulesOrderTypesEnum
    _$hip3TradingRulesOrderTypesEnum_unknownDefaultOpenApi =
    const Hip3TradingRulesOrderTypesEnum._('unknownDefaultOpenApi');

Hip3TradingRulesOrderTypesEnum _$hip3TradingRulesOrderTypesEnumValueOf(
    String name) {
  switch (name) {
    case 'market':
      return _$hip3TradingRulesOrderTypesEnum_market;
    case 'limit':
      return _$hip3TradingRulesOrderTypesEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3TradingRulesOrderTypesEnum_unknownDefaultOpenApi;
    default:
      return _$hip3TradingRulesOrderTypesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TradingRulesOrderTypesEnum>
    _$hip3TradingRulesOrderTypesEnumValues = BuiltSet<
        Hip3TradingRulesOrderTypesEnum>(const <Hip3TradingRulesOrderTypesEnum>[
  _$hip3TradingRulesOrderTypesEnum_market,
  _$hip3TradingRulesOrderTypesEnum_limit,
  _$hip3TradingRulesOrderTypesEnum_unknownDefaultOpenApi,
]);

const Hip3TradingRulesTriggerReferencesEnum
    _$hip3TradingRulesTriggerReferencesEnum_mark =
    const Hip3TradingRulesTriggerReferencesEnum._('mark');
const Hip3TradingRulesTriggerReferencesEnum
    _$hip3TradingRulesTriggerReferencesEnum_oracle =
    const Hip3TradingRulesTriggerReferencesEnum._('oracle');
const Hip3TradingRulesTriggerReferencesEnum
    _$hip3TradingRulesTriggerReferencesEnum_last =
    const Hip3TradingRulesTriggerReferencesEnum._('last');
const Hip3TradingRulesTriggerReferencesEnum
    _$hip3TradingRulesTriggerReferencesEnum_unknownDefaultOpenApi =
    const Hip3TradingRulesTriggerReferencesEnum._('unknownDefaultOpenApi');

Hip3TradingRulesTriggerReferencesEnum
    _$hip3TradingRulesTriggerReferencesEnumValueOf(String name) {
  switch (name) {
    case 'mark':
      return _$hip3TradingRulesTriggerReferencesEnum_mark;
    case 'oracle':
      return _$hip3TradingRulesTriggerReferencesEnum_oracle;
    case 'last':
      return _$hip3TradingRulesTriggerReferencesEnum_last;
    case 'unknownDefaultOpenApi':
      return _$hip3TradingRulesTriggerReferencesEnum_unknownDefaultOpenApi;
    default:
      return _$hip3TradingRulesTriggerReferencesEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3TradingRulesTriggerReferencesEnum>
    _$hip3TradingRulesTriggerReferencesEnumValues = BuiltSet<
        Hip3TradingRulesTriggerReferencesEnum>(const <Hip3TradingRulesTriggerReferencesEnum>[
  _$hip3TradingRulesTriggerReferencesEnum_mark,
  _$hip3TradingRulesTriggerReferencesEnum_oracle,
  _$hip3TradingRulesTriggerReferencesEnum_last,
  _$hip3TradingRulesTriggerReferencesEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3TradingRulesOrderTypesEnum>
    _$hip3TradingRulesOrderTypesEnumSerializer =
    _$Hip3TradingRulesOrderTypesEnumSerializer();
Serializer<Hip3TradingRulesTriggerReferencesEnum>
    _$hip3TradingRulesTriggerReferencesEnumSerializer =
    _$Hip3TradingRulesTriggerReferencesEnumSerializer();

class _$Hip3TradingRulesOrderTypesEnumSerializer
    implements PrimitiveSerializer<Hip3TradingRulesOrderTypesEnum> {
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
  final Iterable<Type> types = const <Type>[Hip3TradingRulesOrderTypesEnum];
  @override
  final String wireName = 'Hip3TradingRulesOrderTypesEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3TradingRulesOrderTypesEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TradingRulesOrderTypesEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TradingRulesOrderTypesEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3TradingRulesTriggerReferencesEnumSerializer
    implements PrimitiveSerializer<Hip3TradingRulesTriggerReferencesEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mark': 'mark',
    'oracle': 'oracle',
    'last': 'last',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mark': 'mark',
    'oracle': 'oracle',
    'last': 'last',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3TradingRulesTriggerReferencesEnum
  ];
  @override
  final String wireName = 'Hip3TradingRulesTriggerReferencesEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3TradingRulesTriggerReferencesEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3TradingRulesTriggerReferencesEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3TradingRulesTriggerReferencesEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3TradingRules extends Hip3TradingRules {
  @override
  final String rulesVersion;
  @override
  final int sizeDecimals;
  @override
  final int priceMaxSignificantDigits;
  @override
  final int priceMaxDecimals;
  @override
  final bool integerPricesAllowed;
  @override
  final String minimumNotionalUsdc;
  @override
  final String? maximumNotionalUsdc;
  @override
  final String maxLeverage;
  @override
  final BuiltList<MarginMode> marginModes;
  @override
  final BuiltList<Hip3TradingRulesOrderTypesEnum> orderTypes;
  @override
  final BuiltList<Hip3TimeInForce> timeInForce;
  @override
  final BuiltList<Hip3TradingRulesTriggerReferencesEnum> triggerReferences;
  @override
  final DateTime observedAt;

  factory _$Hip3TradingRules(
          [void Function(Hip3TradingRulesBuilder)? updates]) =>
      (Hip3TradingRulesBuilder()..update(updates))._build();

  _$Hip3TradingRules._(
      {required this.rulesVersion,
      required this.sizeDecimals,
      required this.priceMaxSignificantDigits,
      required this.priceMaxDecimals,
      required this.integerPricesAllowed,
      required this.minimumNotionalUsdc,
      this.maximumNotionalUsdc,
      required this.maxLeverage,
      required this.marginModes,
      required this.orderTypes,
      required this.timeInForce,
      required this.triggerReferences,
      required this.observedAt})
      : super._();
  @override
  Hip3TradingRules rebuild(void Function(Hip3TradingRulesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3TradingRulesBuilder toBuilder() =>
      Hip3TradingRulesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3TradingRules &&
        rulesVersion == other.rulesVersion &&
        sizeDecimals == other.sizeDecimals &&
        priceMaxSignificantDigits == other.priceMaxSignificantDigits &&
        priceMaxDecimals == other.priceMaxDecimals &&
        integerPricesAllowed == other.integerPricesAllowed &&
        minimumNotionalUsdc == other.minimumNotionalUsdc &&
        maximumNotionalUsdc == other.maximumNotionalUsdc &&
        maxLeverage == other.maxLeverage &&
        marginModes == other.marginModes &&
        orderTypes == other.orderTypes &&
        timeInForce == other.timeInForce &&
        triggerReferences == other.triggerReferences &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rulesVersion.hashCode);
    _$hash = $jc(_$hash, sizeDecimals.hashCode);
    _$hash = $jc(_$hash, priceMaxSignificantDigits.hashCode);
    _$hash = $jc(_$hash, priceMaxDecimals.hashCode);
    _$hash = $jc(_$hash, integerPricesAllowed.hashCode);
    _$hash = $jc(_$hash, minimumNotionalUsdc.hashCode);
    _$hash = $jc(_$hash, maximumNotionalUsdc.hashCode);
    _$hash = $jc(_$hash, maxLeverage.hashCode);
    _$hash = $jc(_$hash, marginModes.hashCode);
    _$hash = $jc(_$hash, orderTypes.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, triggerReferences.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3TradingRules')
          ..add('rulesVersion', rulesVersion)
          ..add('sizeDecimals', sizeDecimals)
          ..add('priceMaxSignificantDigits', priceMaxSignificantDigits)
          ..add('priceMaxDecimals', priceMaxDecimals)
          ..add('integerPricesAllowed', integerPricesAllowed)
          ..add('minimumNotionalUsdc', minimumNotionalUsdc)
          ..add('maximumNotionalUsdc', maximumNotionalUsdc)
          ..add('maxLeverage', maxLeverage)
          ..add('marginModes', marginModes)
          ..add('orderTypes', orderTypes)
          ..add('timeInForce', timeInForce)
          ..add('triggerReferences', triggerReferences)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class Hip3TradingRulesBuilder
    implements Builder<Hip3TradingRules, Hip3TradingRulesBuilder> {
  _$Hip3TradingRules? _$v;

  String? _rulesVersion;
  String? get rulesVersion => _$this._rulesVersion;
  set rulesVersion(String? rulesVersion) => _$this._rulesVersion = rulesVersion;

  int? _sizeDecimals;
  int? get sizeDecimals => _$this._sizeDecimals;
  set sizeDecimals(int? sizeDecimals) => _$this._sizeDecimals = sizeDecimals;

  int? _priceMaxSignificantDigits;
  int? get priceMaxSignificantDigits => _$this._priceMaxSignificantDigits;
  set priceMaxSignificantDigits(int? priceMaxSignificantDigits) =>
      _$this._priceMaxSignificantDigits = priceMaxSignificantDigits;

  int? _priceMaxDecimals;
  int? get priceMaxDecimals => _$this._priceMaxDecimals;
  set priceMaxDecimals(int? priceMaxDecimals) =>
      _$this._priceMaxDecimals = priceMaxDecimals;

  bool? _integerPricesAllowed;
  bool? get integerPricesAllowed => _$this._integerPricesAllowed;
  set integerPricesAllowed(bool? integerPricesAllowed) =>
      _$this._integerPricesAllowed = integerPricesAllowed;

  String? _minimumNotionalUsdc;
  String? get minimumNotionalUsdc => _$this._minimumNotionalUsdc;
  set minimumNotionalUsdc(String? minimumNotionalUsdc) =>
      _$this._minimumNotionalUsdc = minimumNotionalUsdc;

  String? _maximumNotionalUsdc;
  String? get maximumNotionalUsdc => _$this._maximumNotionalUsdc;
  set maximumNotionalUsdc(String? maximumNotionalUsdc) =>
      _$this._maximumNotionalUsdc = maximumNotionalUsdc;

  String? _maxLeverage;
  String? get maxLeverage => _$this._maxLeverage;
  set maxLeverage(String? maxLeverage) => _$this._maxLeverage = maxLeverage;

  ListBuilder<MarginMode>? _marginModes;
  ListBuilder<MarginMode> get marginModes =>
      _$this._marginModes ??= ListBuilder<MarginMode>();
  set marginModes(ListBuilder<MarginMode>? marginModes) =>
      _$this._marginModes = marginModes;

  ListBuilder<Hip3TradingRulesOrderTypesEnum>? _orderTypes;
  ListBuilder<Hip3TradingRulesOrderTypesEnum> get orderTypes =>
      _$this._orderTypes ??= ListBuilder<Hip3TradingRulesOrderTypesEnum>();
  set orderTypes(ListBuilder<Hip3TradingRulesOrderTypesEnum>? orderTypes) =>
      _$this._orderTypes = orderTypes;

  ListBuilder<Hip3TimeInForce>? _timeInForce;
  ListBuilder<Hip3TimeInForce> get timeInForce =>
      _$this._timeInForce ??= ListBuilder<Hip3TimeInForce>();
  set timeInForce(ListBuilder<Hip3TimeInForce>? timeInForce) =>
      _$this._timeInForce = timeInForce;

  ListBuilder<Hip3TradingRulesTriggerReferencesEnum>? _triggerReferences;
  ListBuilder<Hip3TradingRulesTriggerReferencesEnum> get triggerReferences =>
      _$this._triggerReferences ??=
          ListBuilder<Hip3TradingRulesTriggerReferencesEnum>();
  set triggerReferences(
          ListBuilder<Hip3TradingRulesTriggerReferencesEnum>?
              triggerReferences) =>
      _$this._triggerReferences = triggerReferences;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  Hip3TradingRulesBuilder() {
    Hip3TradingRules._defaults(this);
  }

  Hip3TradingRulesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rulesVersion = $v.rulesVersion;
      _sizeDecimals = $v.sizeDecimals;
      _priceMaxSignificantDigits = $v.priceMaxSignificantDigits;
      _priceMaxDecimals = $v.priceMaxDecimals;
      _integerPricesAllowed = $v.integerPricesAllowed;
      _minimumNotionalUsdc = $v.minimumNotionalUsdc;
      _maximumNotionalUsdc = $v.maximumNotionalUsdc;
      _maxLeverage = $v.maxLeverage;
      _marginModes = $v.marginModes.toBuilder();
      _orderTypes = $v.orderTypes.toBuilder();
      _timeInForce = $v.timeInForce.toBuilder();
      _triggerReferences = $v.triggerReferences.toBuilder();
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3TradingRules other) {
    _$v = other as _$Hip3TradingRules;
  }

  @override
  void update(void Function(Hip3TradingRulesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3TradingRules build() => _build();

  _$Hip3TradingRules _build() {
    _$Hip3TradingRules _$result;
    try {
      _$result = _$v ??
          _$Hip3TradingRules._(
            rulesVersion: BuiltValueNullFieldError.checkNotNull(
                rulesVersion, r'Hip3TradingRules', 'rulesVersion'),
            sizeDecimals: BuiltValueNullFieldError.checkNotNull(
                sizeDecimals, r'Hip3TradingRules', 'sizeDecimals'),
            priceMaxSignificantDigits: BuiltValueNullFieldError.checkNotNull(
                priceMaxSignificantDigits,
                r'Hip3TradingRules',
                'priceMaxSignificantDigits'),
            priceMaxDecimals: BuiltValueNullFieldError.checkNotNull(
                priceMaxDecimals, r'Hip3TradingRules', 'priceMaxDecimals'),
            integerPricesAllowed: BuiltValueNullFieldError.checkNotNull(
                integerPricesAllowed,
                r'Hip3TradingRules',
                'integerPricesAllowed'),
            minimumNotionalUsdc: BuiltValueNullFieldError.checkNotNull(
                minimumNotionalUsdc,
                r'Hip3TradingRules',
                'minimumNotionalUsdc'),
            maximumNotionalUsdc: maximumNotionalUsdc,
            maxLeverage: BuiltValueNullFieldError.checkNotNull(
                maxLeverage, r'Hip3TradingRules', 'maxLeverage'),
            marginModes: marginModes.build(),
            orderTypes: orderTypes.build(),
            timeInForce: timeInForce.build(),
            triggerReferences: triggerReferences.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3TradingRules', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'marginModes';
        marginModes.build();
        _$failedField = 'orderTypes';
        orderTypes.build();
        _$failedField = 'timeInForce';
        timeInForce.build();
        _$failedField = 'triggerReferences';
        triggerReferences.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3TradingRules', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
