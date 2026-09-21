// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PositionSideEnum _$positionSideEnum_long =
    const PositionSideEnum._('long');
const PositionSideEnum _$positionSideEnum_short =
    const PositionSideEnum._('short');
const PositionSideEnum _$positionSideEnum_unknownDefaultOpenApi =
    const PositionSideEnum._('unknownDefaultOpenApi');

PositionSideEnum _$positionSideEnumValueOf(String name) {
  switch (name) {
    case 'long':
      return _$positionSideEnum_long;
    case 'short':
      return _$positionSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$positionSideEnum_unknownDefaultOpenApi;
    default:
      return _$positionSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PositionSideEnum> _$positionSideEnumValues =
    BuiltSet<PositionSideEnum>(const <PositionSideEnum>[
  _$positionSideEnum_long,
  _$positionSideEnum_short,
  _$positionSideEnum_unknownDefaultOpenApi,
]);

const PositionChainIdEnum _$positionChainIdEnum_number56 =
    const PositionChainIdEnum._('number56');
const PositionChainIdEnum _$positionChainIdEnum_number97 =
    const PositionChainIdEnum._('number97');
const PositionChainIdEnum _$positionChainIdEnum_number31337 =
    const PositionChainIdEnum._('number31337');
const PositionChainIdEnum _$positionChainIdEnum_unknownDefaultOpenApi =
    const PositionChainIdEnum._('unknownDefaultOpenApi');

PositionChainIdEnum _$positionChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$positionChainIdEnum_number56;
    case 'number97':
      return _$positionChainIdEnum_number97;
    case 'number31337':
      return _$positionChainIdEnum_number31337;
    case 'unknownDefaultOpenApi':
      return _$positionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$positionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PositionChainIdEnum> _$positionChainIdEnumValues =
    BuiltSet<PositionChainIdEnum>(const <PositionChainIdEnum>[
  _$positionChainIdEnum_number56,
  _$positionChainIdEnum_number97,
  _$positionChainIdEnum_number31337,
  _$positionChainIdEnum_unknownDefaultOpenApi,
]);

const PositionPnlStatusEnum _$positionPnlStatusEnum_known =
    const PositionPnlStatusEnum._('known');
const PositionPnlStatusEnum _$positionPnlStatusEnum_unknownCost =
    const PositionPnlStatusEnum._('unknownCost');
const PositionPnlStatusEnum _$positionPnlStatusEnum_unknownDefaultOpenApi =
    const PositionPnlStatusEnum._('unknownDefaultOpenApi');

PositionPnlStatusEnum _$positionPnlStatusEnumValueOf(String name) {
  switch (name) {
    case 'known':
      return _$positionPnlStatusEnum_known;
    case 'unknownCost':
      return _$positionPnlStatusEnum_unknownCost;
    case 'unknownDefaultOpenApi':
      return _$positionPnlStatusEnum_unknownDefaultOpenApi;
    default:
      return _$positionPnlStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PositionPnlStatusEnum> _$positionPnlStatusEnumValues =
    BuiltSet<PositionPnlStatusEnum>(const <PositionPnlStatusEnum>[
  _$positionPnlStatusEnum_known,
  _$positionPnlStatusEnum_unknownCost,
  _$positionPnlStatusEnum_unknownDefaultOpenApi,
]);

const PositionValuationStatusEnum _$positionValuationStatusEnum_referenceOnly =
    const PositionValuationStatusEnum._('referenceOnly');
const PositionValuationStatusEnum
    _$positionValuationStatusEnum_unknownDefaultOpenApi =
    const PositionValuationStatusEnum._('unknownDefaultOpenApi');

PositionValuationStatusEnum _$positionValuationStatusEnumValueOf(String name) {
  switch (name) {
    case 'referenceOnly':
      return _$positionValuationStatusEnum_referenceOnly;
    case 'unknownDefaultOpenApi':
      return _$positionValuationStatusEnum_unknownDefaultOpenApi;
    default:
      return _$positionValuationStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PositionValuationStatusEnum>
    _$positionValuationStatusEnumValues =
    BuiltSet<PositionValuationStatusEnum>(const <PositionValuationStatusEnum>[
  _$positionValuationStatusEnum_referenceOnly,
  _$positionValuationStatusEnum_unknownDefaultOpenApi,
]);

Serializer<PositionSideEnum> _$positionSideEnumSerializer =
    _$PositionSideEnumSerializer();
Serializer<PositionChainIdEnum> _$positionChainIdEnumSerializer =
    _$PositionChainIdEnumSerializer();
Serializer<PositionPnlStatusEnum> _$positionPnlStatusEnumSerializer =
    _$PositionPnlStatusEnumSerializer();
Serializer<PositionValuationStatusEnum>
    _$positionValuationStatusEnumSerializer =
    _$PositionValuationStatusEnumSerializer();

class _$PositionSideEnumSerializer
    implements PrimitiveSerializer<PositionSideEnum> {
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
  final Iterable<Type> types = const <Type>[PositionSideEnum];
  @override
  final String wireName = 'PositionSideEnum';

  @override
  Object serialize(Serializers serializers, PositionSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PositionSideEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PositionSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PositionChainIdEnumSerializer
    implements PrimitiveSerializer<PositionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number97': 97,
    'number31337': 31337,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    97: 'number97',
    31337: 'number31337',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PositionChainIdEnum];
  @override
  final String wireName = 'PositionChainIdEnum';

  @override
  Object serialize(Serializers serializers, PositionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PositionChainIdEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PositionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PositionPnlStatusEnumSerializer
    implements PrimitiveSerializer<PositionPnlStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'known': 'known',
    'unknownCost': 'unknown_cost',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'known': 'known',
    'unknown_cost': 'unknownCost',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PositionPnlStatusEnum];
  @override
  final String wireName = 'PositionPnlStatusEnum';

  @override
  Object serialize(Serializers serializers, PositionPnlStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PositionPnlStatusEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PositionPnlStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PositionValuationStatusEnumSerializer
    implements PrimitiveSerializer<PositionValuationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'referenceOnly': 'reference_only',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'reference_only': 'referenceOnly',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PositionValuationStatusEnum];
  @override
  final String wireName = 'PositionValuationStatusEnum';

  @override
  Object serialize(Serializers serializers, PositionValuationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PositionValuationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PositionValuationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Position extends Position {
  @override
  final String? productId;
  @override
  final String? positionVersion;
  @override
  final String? hip3ActionId;
  @override
  final BuiltList<String>? protectionOrderIds;
  @override
  final String positionId;
  @override
  final String symbol;
  @override
  final String? name;
  @override
  final ProductKind kind;
  @override
  final PositionSideEnum? side;
  @override
  final String quantity;
  @override
  final String? quantityUnit;
  @override
  final PositionChainIdEnum? chainId;
  @override
  final String? environment;
  @override
  final String? freshness;
  @override
  final PositionPnlStatusEnum? pnlStatus;
  @override
  final PositionValuationStatusEnum? valuationStatus;
  @override
  final String? costBasisQuote;
  @override
  final String? costBasisQuoteAsset;
  @override
  final String? referenceCostUsd;
  @override
  final String? unrealizedPnlReferenceUsd;
  @override
  final String? valueUsd;
  @override
  final String? entryPrice;
  @override
  final String? markPrice;
  @override
  final String? unrealizedPnl;
  @override
  final String? unrealizedPnlPercent;
  @override
  final String? realizedPnl;
  @override
  final String? costBasis;
  @override
  final String? leverage;
  @override
  final MarginMode? marginMode;
  @override
  final String? margin;
  @override
  final String? liquidationPrice;
  @override
  final String? fundingPaid;
  @override
  final String? takeProfitPrice;
  @override
  final String? stopLossPrice;
  @override
  final String? stopLimitPrice;
  @override
  final DateTime? openedAt;
  @override
  final DateTime? updatedAt;

  factory _$Position([void Function(PositionBuilder)? updates]) =>
      (PositionBuilder()..update(updates))._build();

  _$Position._(
      {this.productId,
      this.positionVersion,
      this.hip3ActionId,
      this.protectionOrderIds,
      required this.positionId,
      required this.symbol,
      this.name,
      required this.kind,
      this.side,
      required this.quantity,
      this.quantityUnit,
      this.chainId,
      this.environment,
      this.freshness,
      this.pnlStatus,
      this.valuationStatus,
      this.costBasisQuote,
      this.costBasisQuoteAsset,
      this.referenceCostUsd,
      this.unrealizedPnlReferenceUsd,
      this.valueUsd,
      this.entryPrice,
      this.markPrice,
      this.unrealizedPnl,
      this.unrealizedPnlPercent,
      this.realizedPnl,
      this.costBasis,
      this.leverage,
      this.marginMode,
      this.margin,
      this.liquidationPrice,
      this.fundingPaid,
      this.takeProfitPrice,
      this.stopLossPrice,
      this.stopLimitPrice,
      this.openedAt,
      this.updatedAt})
      : super._();
  @override
  Position rebuild(void Function(PositionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionBuilder toBuilder() => PositionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Position &&
        productId == other.productId &&
        positionVersion == other.positionVersion &&
        hip3ActionId == other.hip3ActionId &&
        protectionOrderIds == other.protectionOrderIds &&
        positionId == other.positionId &&
        symbol == other.symbol &&
        name == other.name &&
        kind == other.kind &&
        side == other.side &&
        quantity == other.quantity &&
        quantityUnit == other.quantityUnit &&
        chainId == other.chainId &&
        environment == other.environment &&
        freshness == other.freshness &&
        pnlStatus == other.pnlStatus &&
        valuationStatus == other.valuationStatus &&
        costBasisQuote == other.costBasisQuote &&
        costBasisQuoteAsset == other.costBasisQuoteAsset &&
        referenceCostUsd == other.referenceCostUsd &&
        unrealizedPnlReferenceUsd == other.unrealizedPnlReferenceUsd &&
        valueUsd == other.valueUsd &&
        entryPrice == other.entryPrice &&
        markPrice == other.markPrice &&
        unrealizedPnl == other.unrealizedPnl &&
        unrealizedPnlPercent == other.unrealizedPnlPercent &&
        realizedPnl == other.realizedPnl &&
        costBasis == other.costBasis &&
        leverage == other.leverage &&
        marginMode == other.marginMode &&
        margin == other.margin &&
        liquidationPrice == other.liquidationPrice &&
        fundingPaid == other.fundingPaid &&
        takeProfitPrice == other.takeProfitPrice &&
        stopLossPrice == other.stopLossPrice &&
        stopLimitPrice == other.stopLimitPrice &&
        openedAt == other.openedAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, positionVersion.hashCode);
    _$hash = $jc(_$hash, hip3ActionId.hashCode);
    _$hash = $jc(_$hash, protectionOrderIds.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, quantityUnit.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, pnlStatus.hashCode);
    _$hash = $jc(_$hash, valuationStatus.hashCode);
    _$hash = $jc(_$hash, costBasisQuote.hashCode);
    _$hash = $jc(_$hash, costBasisQuoteAsset.hashCode);
    _$hash = $jc(_$hash, referenceCostUsd.hashCode);
    _$hash = $jc(_$hash, unrealizedPnlReferenceUsd.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, entryPrice.hashCode);
    _$hash = $jc(_$hash, markPrice.hashCode);
    _$hash = $jc(_$hash, unrealizedPnl.hashCode);
    _$hash = $jc(_$hash, unrealizedPnlPercent.hashCode);
    _$hash = $jc(_$hash, realizedPnl.hashCode);
    _$hash = $jc(_$hash, costBasis.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jc(_$hash, margin.hashCode);
    _$hash = $jc(_$hash, liquidationPrice.hashCode);
    _$hash = $jc(_$hash, fundingPaid.hashCode);
    _$hash = $jc(_$hash, takeProfitPrice.hashCode);
    _$hash = $jc(_$hash, stopLossPrice.hashCode);
    _$hash = $jc(_$hash, stopLimitPrice.hashCode);
    _$hash = $jc(_$hash, openedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Position')
          ..add('productId', productId)
          ..add('positionVersion', positionVersion)
          ..add('hip3ActionId', hip3ActionId)
          ..add('protectionOrderIds', protectionOrderIds)
          ..add('positionId', positionId)
          ..add('symbol', symbol)
          ..add('name', name)
          ..add('kind', kind)
          ..add('side', side)
          ..add('quantity', quantity)
          ..add('quantityUnit', quantityUnit)
          ..add('chainId', chainId)
          ..add('environment', environment)
          ..add('freshness', freshness)
          ..add('pnlStatus', pnlStatus)
          ..add('valuationStatus', valuationStatus)
          ..add('costBasisQuote', costBasisQuote)
          ..add('costBasisQuoteAsset', costBasisQuoteAsset)
          ..add('referenceCostUsd', referenceCostUsd)
          ..add('unrealizedPnlReferenceUsd', unrealizedPnlReferenceUsd)
          ..add('valueUsd', valueUsd)
          ..add('entryPrice', entryPrice)
          ..add('markPrice', markPrice)
          ..add('unrealizedPnl', unrealizedPnl)
          ..add('unrealizedPnlPercent', unrealizedPnlPercent)
          ..add('realizedPnl', realizedPnl)
          ..add('costBasis', costBasis)
          ..add('leverage', leverage)
          ..add('marginMode', marginMode)
          ..add('margin', margin)
          ..add('liquidationPrice', liquidationPrice)
          ..add('fundingPaid', fundingPaid)
          ..add('takeProfitPrice', takeProfitPrice)
          ..add('stopLossPrice', stopLossPrice)
          ..add('stopLimitPrice', stopLimitPrice)
          ..add('openedAt', openedAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class PositionBuilder implements Builder<Position, PositionBuilder> {
  _$Position? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  String? _positionVersion;
  String? get positionVersion => _$this._positionVersion;
  set positionVersion(String? positionVersion) =>
      _$this._positionVersion = positionVersion;

  String? _hip3ActionId;
  String? get hip3ActionId => _$this._hip3ActionId;
  set hip3ActionId(String? hip3ActionId) => _$this._hip3ActionId = hip3ActionId;

  ListBuilder<String>? _protectionOrderIds;
  ListBuilder<String> get protectionOrderIds =>
      _$this._protectionOrderIds ??= ListBuilder<String>();
  set protectionOrderIds(ListBuilder<String>? protectionOrderIds) =>
      _$this._protectionOrderIds = protectionOrderIds;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ProductKind? _kind;
  ProductKind? get kind => _$this._kind;
  set kind(ProductKind? kind) => _$this._kind = kind;

  PositionSideEnum? _side;
  PositionSideEnum? get side => _$this._side;
  set side(PositionSideEnum? side) => _$this._side = side;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _quantityUnit;
  String? get quantityUnit => _$this._quantityUnit;
  set quantityUnit(String? quantityUnit) => _$this._quantityUnit = quantityUnit;

  PositionChainIdEnum? _chainId;
  PositionChainIdEnum? get chainId => _$this._chainId;
  set chainId(PositionChainIdEnum? chainId) => _$this._chainId = chainId;

  String? _environment;
  String? get environment => _$this._environment;
  set environment(String? environment) => _$this._environment = environment;

  String? _freshness;
  String? get freshness => _$this._freshness;
  set freshness(String? freshness) => _$this._freshness = freshness;

  PositionPnlStatusEnum? _pnlStatus;
  PositionPnlStatusEnum? get pnlStatus => _$this._pnlStatus;
  set pnlStatus(PositionPnlStatusEnum? pnlStatus) =>
      _$this._pnlStatus = pnlStatus;

  PositionValuationStatusEnum? _valuationStatus;
  PositionValuationStatusEnum? get valuationStatus => _$this._valuationStatus;
  set valuationStatus(PositionValuationStatusEnum? valuationStatus) =>
      _$this._valuationStatus = valuationStatus;

  String? _costBasisQuote;
  String? get costBasisQuote => _$this._costBasisQuote;
  set costBasisQuote(String? costBasisQuote) =>
      _$this._costBasisQuote = costBasisQuote;

  String? _costBasisQuoteAsset;
  String? get costBasisQuoteAsset => _$this._costBasisQuoteAsset;
  set costBasisQuoteAsset(String? costBasisQuoteAsset) =>
      _$this._costBasisQuoteAsset = costBasisQuoteAsset;

  String? _referenceCostUsd;
  String? get referenceCostUsd => _$this._referenceCostUsd;
  set referenceCostUsd(String? referenceCostUsd) =>
      _$this._referenceCostUsd = referenceCostUsd;

  String? _unrealizedPnlReferenceUsd;
  String? get unrealizedPnlReferenceUsd => _$this._unrealizedPnlReferenceUsd;
  set unrealizedPnlReferenceUsd(String? unrealizedPnlReferenceUsd) =>
      _$this._unrealizedPnlReferenceUsd = unrealizedPnlReferenceUsd;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  String? _entryPrice;
  String? get entryPrice => _$this._entryPrice;
  set entryPrice(String? entryPrice) => _$this._entryPrice = entryPrice;

  String? _markPrice;
  String? get markPrice => _$this._markPrice;
  set markPrice(String? markPrice) => _$this._markPrice = markPrice;

  String? _unrealizedPnl;
  String? get unrealizedPnl => _$this._unrealizedPnl;
  set unrealizedPnl(String? unrealizedPnl) =>
      _$this._unrealizedPnl = unrealizedPnl;

  String? _unrealizedPnlPercent;
  String? get unrealizedPnlPercent => _$this._unrealizedPnlPercent;
  set unrealizedPnlPercent(String? unrealizedPnlPercent) =>
      _$this._unrealizedPnlPercent = unrealizedPnlPercent;

  String? _realizedPnl;
  String? get realizedPnl => _$this._realizedPnl;
  set realizedPnl(String? realizedPnl) => _$this._realizedPnl = realizedPnl;

  String? _costBasis;
  String? get costBasis => _$this._costBasis;
  set costBasis(String? costBasis) => _$this._costBasis = costBasis;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(MarginMode? marginMode) => _$this._marginMode = marginMode;

  String? _margin;
  String? get margin => _$this._margin;
  set margin(String? margin) => _$this._margin = margin;

  String? _liquidationPrice;
  String? get liquidationPrice => _$this._liquidationPrice;
  set liquidationPrice(String? liquidationPrice) =>
      _$this._liquidationPrice = liquidationPrice;

  String? _fundingPaid;
  String? get fundingPaid => _$this._fundingPaid;
  set fundingPaid(String? fundingPaid) => _$this._fundingPaid = fundingPaid;

  String? _takeProfitPrice;
  String? get takeProfitPrice => _$this._takeProfitPrice;
  set takeProfitPrice(String? takeProfitPrice) =>
      _$this._takeProfitPrice = takeProfitPrice;

  String? _stopLossPrice;
  String? get stopLossPrice => _$this._stopLossPrice;
  set stopLossPrice(String? stopLossPrice) =>
      _$this._stopLossPrice = stopLossPrice;

  String? _stopLimitPrice;
  String? get stopLimitPrice => _$this._stopLimitPrice;
  set stopLimitPrice(String? stopLimitPrice) =>
      _$this._stopLimitPrice = stopLimitPrice;

  DateTime? _openedAt;
  DateTime? get openedAt => _$this._openedAt;
  set openedAt(DateTime? openedAt) => _$this._openedAt = openedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  PositionBuilder() {
    Position._defaults(this);
  }

  PositionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _positionVersion = $v.positionVersion;
      _hip3ActionId = $v.hip3ActionId;
      _protectionOrderIds = $v.protectionOrderIds?.toBuilder();
      _positionId = $v.positionId;
      _symbol = $v.symbol;
      _name = $v.name;
      _kind = $v.kind;
      _side = $v.side;
      _quantity = $v.quantity;
      _quantityUnit = $v.quantityUnit;
      _chainId = $v.chainId;
      _environment = $v.environment;
      _freshness = $v.freshness;
      _pnlStatus = $v.pnlStatus;
      _valuationStatus = $v.valuationStatus;
      _costBasisQuote = $v.costBasisQuote;
      _costBasisQuoteAsset = $v.costBasisQuoteAsset;
      _referenceCostUsd = $v.referenceCostUsd;
      _unrealizedPnlReferenceUsd = $v.unrealizedPnlReferenceUsd;
      _valueUsd = $v.valueUsd;
      _entryPrice = $v.entryPrice;
      _markPrice = $v.markPrice;
      _unrealizedPnl = $v.unrealizedPnl;
      _unrealizedPnlPercent = $v.unrealizedPnlPercent;
      _realizedPnl = $v.realizedPnl;
      _costBasis = $v.costBasis;
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _margin = $v.margin;
      _liquidationPrice = $v.liquidationPrice;
      _fundingPaid = $v.fundingPaid;
      _takeProfitPrice = $v.takeProfitPrice;
      _stopLossPrice = $v.stopLossPrice;
      _stopLimitPrice = $v.stopLimitPrice;
      _openedAt = $v.openedAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Position other) {
    _$v = other as _$Position;
  }

  @override
  void update(void Function(PositionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Position build() => _build();

  _$Position _build() {
    _$Position _$result;
    try {
      _$result = _$v ??
          _$Position._(
            productId: productId,
            positionVersion: positionVersion,
            hip3ActionId: hip3ActionId,
            protectionOrderIds: _protectionOrderIds?.build(),
            positionId: BuiltValueNullFieldError.checkNotNull(
                positionId, r'Position', 'positionId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'Position', 'symbol'),
            name: name,
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'Position', 'kind'),
            side: side,
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, r'Position', 'quantity'),
            quantityUnit: quantityUnit,
            chainId: chainId,
            environment: environment,
            freshness: freshness,
            pnlStatus: pnlStatus,
            valuationStatus: valuationStatus,
            costBasisQuote: costBasisQuote,
            costBasisQuoteAsset: costBasisQuoteAsset,
            referenceCostUsd: referenceCostUsd,
            unrealizedPnlReferenceUsd: unrealizedPnlReferenceUsd,
            valueUsd: valueUsd,
            entryPrice: entryPrice,
            markPrice: markPrice,
            unrealizedPnl: unrealizedPnl,
            unrealizedPnlPercent: unrealizedPnlPercent,
            realizedPnl: realizedPnl,
            costBasis: costBasis,
            leverage: leverage,
            marginMode: marginMode,
            margin: margin,
            liquidationPrice: liquidationPrice,
            fundingPaid: fundingPaid,
            takeProfitPrice: takeProfitPrice,
            stopLossPrice: stopLossPrice,
            stopLimitPrice: stopLimitPrice,
            openedAt: openedAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protectionOrderIds';
        _protectionOrderIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Position', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
