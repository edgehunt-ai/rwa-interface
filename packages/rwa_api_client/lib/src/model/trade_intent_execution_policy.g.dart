// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_execution_policy.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentExecutionPolicyOrderTypeEnum
    _$tradeIntentExecutionPolicyOrderTypeEnum_ioc =
    const TradeIntentExecutionPolicyOrderTypeEnum._('ioc');
const TradeIntentExecutionPolicyOrderTypeEnum
    _$tradeIntentExecutionPolicyOrderTypeEnum_unknownDefaultOpenApi =
    const TradeIntentExecutionPolicyOrderTypeEnum._('unknownDefaultOpenApi');

TradeIntentExecutionPolicyOrderTypeEnum
    _$tradeIntentExecutionPolicyOrderTypeEnumValueOf(String name) {
  switch (name) {
    case 'ioc':
      return _$tradeIntentExecutionPolicyOrderTypeEnum_ioc;
    case 'unknownDefaultOpenApi':
      return _$tradeIntentExecutionPolicyOrderTypeEnum_unknownDefaultOpenApi;
    default:
      return _$tradeIntentExecutionPolicyOrderTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentExecutionPolicyOrderTypeEnum>
    _$tradeIntentExecutionPolicyOrderTypeEnumValues = BuiltSet<
        TradeIntentExecutionPolicyOrderTypeEnum>(const <TradeIntentExecutionPolicyOrderTypeEnum>[
  _$tradeIntentExecutionPolicyOrderTypeEnum_ioc,
  _$tradeIntentExecutionPolicyOrderTypeEnum_unknownDefaultOpenApi,
]);

Serializer<TradeIntentExecutionPolicyOrderTypeEnum>
    _$tradeIntentExecutionPolicyOrderTypeEnumSerializer =
    _$TradeIntentExecutionPolicyOrderTypeEnumSerializer();

class _$TradeIntentExecutionPolicyOrderTypeEnumSerializer
    implements PrimitiveSerializer<TradeIntentExecutionPolicyOrderTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ioc': 'ioc',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ioc': 'ioc',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TradeIntentExecutionPolicyOrderTypeEnum
  ];
  @override
  final String wireName = 'TradeIntentExecutionPolicyOrderTypeEnum';

  @override
  Object serialize(Serializers serializers,
          TradeIntentExecutionPolicyOrderTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentExecutionPolicyOrderTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentExecutionPolicyOrderTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TradeIntentExecutionPolicy extends TradeIntentExecutionPolicy {
  @override
  final TradeIntentExecutionPolicyOrderTypeEnum orderType;
  @override
  final String limitPrice;
  @override
  final String? slippagePercent;
  @override
  final DateTime executeBefore;

  factory _$TradeIntentExecutionPolicy(
          [void Function(TradeIntentExecutionPolicyBuilder)? updates]) =>
      (TradeIntentExecutionPolicyBuilder()..update(updates))._build();

  _$TradeIntentExecutionPolicy._(
      {required this.orderType,
      required this.limitPrice,
      this.slippagePercent,
      required this.executeBefore})
      : super._();
  @override
  TradeIntentExecutionPolicy rebuild(
          void Function(TradeIntentExecutionPolicyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeIntentExecutionPolicyBuilder toBuilder() =>
      TradeIntentExecutionPolicyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeIntentExecutionPolicy &&
        orderType == other.orderType &&
        limitPrice == other.limitPrice &&
        slippagePercent == other.slippagePercent &&
        executeBefore == other.executeBefore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderType.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, executeBefore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TradeIntentExecutionPolicy')
          ..add('orderType', orderType)
          ..add('limitPrice', limitPrice)
          ..add('slippagePercent', slippagePercent)
          ..add('executeBefore', executeBefore))
        .toString();
  }
}

class TradeIntentExecutionPolicyBuilder
    implements
        Builder<TradeIntentExecutionPolicy, TradeIntentExecutionPolicyBuilder> {
  _$TradeIntentExecutionPolicy? _$v;

  TradeIntentExecutionPolicyOrderTypeEnum? _orderType;
  TradeIntentExecutionPolicyOrderTypeEnum? get orderType => _$this._orderType;
  set orderType(TradeIntentExecutionPolicyOrderTypeEnum? orderType) =>
      _$this._orderType = orderType;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  DateTime? _executeBefore;
  DateTime? get executeBefore => _$this._executeBefore;
  set executeBefore(DateTime? executeBefore) =>
      _$this._executeBefore = executeBefore;

  TradeIntentExecutionPolicyBuilder() {
    TradeIntentExecutionPolicy._defaults(this);
  }

  TradeIntentExecutionPolicyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderType = $v.orderType;
      _limitPrice = $v.limitPrice;
      _slippagePercent = $v.slippagePercent;
      _executeBefore = $v.executeBefore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeIntentExecutionPolicy other) {
    _$v = other as _$TradeIntentExecutionPolicy;
  }

  @override
  void update(void Function(TradeIntentExecutionPolicyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TradeIntentExecutionPolicy build() => _build();

  _$TradeIntentExecutionPolicy _build() {
    final _$result = _$v ??
        _$TradeIntentExecutionPolicy._(
          orderType: BuiltValueNullFieldError.checkNotNull(
              orderType, r'TradeIntentExecutionPolicy', 'orderType'),
          limitPrice: BuiltValueNullFieldError.checkNotNull(
              limitPrice, r'TradeIntentExecutionPolicy', 'limitPrice'),
          slippagePercent: slippagePercent,
          executeBefore: BuiltValueNullFieldError.checkNotNull(
              executeBefore, r'TradeIntentExecutionPolicy', 'executeBefore'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
