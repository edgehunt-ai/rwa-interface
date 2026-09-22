// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_preview_common.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderPreviewCommonFundingModeEnum
    _$orderPreviewCommonFundingModeEnum_unreservedTransferFrom =
    const OrderPreviewCommonFundingModeEnum._('unreservedTransferFrom');
const OrderPreviewCommonFundingModeEnum
    _$orderPreviewCommonFundingModeEnum_unknownDefaultOpenApi =
    const OrderPreviewCommonFundingModeEnum._('unknownDefaultOpenApi');

OrderPreviewCommonFundingModeEnum _$orderPreviewCommonFundingModeEnumValueOf(
    String name) {
  switch (name) {
    case 'unreservedTransferFrom':
      return _$orderPreviewCommonFundingModeEnum_unreservedTransferFrom;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewCommonFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewCommonFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewCommonFundingModeEnum>
    _$orderPreviewCommonFundingModeEnumValues = BuiltSet<
        OrderPreviewCommonFundingModeEnum>(const <OrderPreviewCommonFundingModeEnum>[
  _$orderPreviewCommonFundingModeEnum_unreservedTransferFrom,
  _$orderPreviewCommonFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<OrderPreviewCommonFundingModeEnum>
    _$orderPreviewCommonFundingModeEnumSerializer =
    _$OrderPreviewCommonFundingModeEnumSerializer();

class _$OrderPreviewCommonFundingModeEnumSerializer
    implements PrimitiveSerializer<OrderPreviewCommonFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unreservedTransferFrom': 'unreserved_transfer_from',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unreserved_transfer_from': 'unreservedTransferFrom',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewCommonFundingModeEnum];
  @override
  final String wireName = 'OrderPreviewCommonFundingModeEnum';

  @override
  Object serialize(
          Serializers serializers, OrderPreviewCommonFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewCommonFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewCommonFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class OrderPreviewCommonBuilder {
  void replace(OrderPreviewCommon other);
  void update(void Function(OrderPreviewCommonBuilder) updates);
  BstocksPreviewEconomicsBuilder get bstocks;
  set bstocks(BstocksPreviewEconomicsBuilder? bstocks);

  BstocksApprovalMode? get approvalMode;
  set approvalMode(BstocksApprovalMode? approvalMode);

  String? get approvalAmountRaw;
  set approvalAmountRaw(String? approvalAmountRaw);

  Hip3TimeInForce? get timeInForce;
  set timeInForce(Hip3TimeInForce? timeInForce);

  String? get limitPrice;
  set limitPrice(String? limitPrice);

  bool? get priceConditionMet;
  set priceConditionMet(bool? priceConditionMet);

  OrderPreviewCommonFundingModeEnum? get fundingMode;
  set fundingMode(OrderPreviewCommonFundingModeEnum? fundingMode);

  bool? get fundsReserved;
  set fundsReserved(bool? fundsReserved);

  String? get requiredFundingRaw;
  set requiredFundingRaw(String? requiredFundingRaw);

  String? get fundingToken;
  set fundingToken(String? fundingToken);

  String? get balanceRaw;
  set balanceRaw(String? balanceRaw);

  String? get allowanceRaw;
  set allowanceRaw(String? allowanceRaw);

  bool? get balanceSufficient;
  set balanceSufficient(bool? balanceSufficient);

  bool? get allowanceSufficient;
  set allowanceSufficient(bool? allowanceSufficient);

  bool? get approvalRequired;
  set approvalRequired(bool? approvalRequired);

  String? get orderRouter;
  set orderRouter(String? orderRouter);

  BstocksPreviewRouteBuilder get route;
  set route(BstocksPreviewRouteBuilder? route);

  BstocksCancellationPolicyBuilder get cancellationPolicy;
  set cancellationPolicy(BstocksCancellationPolicyBuilder? cancellationPolicy);

  Hip3PreviewExecutionBuilder get hip3Execution;
  set hip3Execution(Hip3PreviewExecutionBuilder? hip3Execution);

  String? get previewId;
  set previewId(String? previewId);

  String? get symbol;
  set symbol(String? symbol);

  OrderSide? get side;
  set side(OrderSide? side);

  OrderType? get type;
  set type(OrderType? type);

  String? get marketPrice;
  set marketPrice(String? marketPrice);

  String? get estimatedPrice;
  set estimatedPrice(String? estimatedPrice);

  bool? get priceUpdated;
  set priceUpdated(bool? priceUpdated);

  String? get estimatedQuantity;
  set estimatedQuantity(String? estimatedQuantity);

  String? get estimatedReceive;
  set estimatedReceive(String? estimatedReceive);

  String? get estimatedReceiveUnit;
  set estimatedReceiveUnit(String? estimatedReceiveUnit);

  String? get orderValue;
  set orderValue(String? orderValue);

  String? get fee;
  set fee(String? fee);

  String? get feeRate;
  set feeRate(String? feeRate);

  String? get slippagePercent;
  set slippagePercent(String? slippagePercent);

  String? get orderBookImpactPercent;
  set orderBookImpactPercent(String? orderBookImpactPercent);

  String? get networkFee;
  set networkFee(String? networkFee);

  AccountKind? get settlementAccount;
  set settlementAccount(AccountKind? settlementAccount);

  String? get settlementAccountLabel;
  set settlementAccountLabel(String? settlementAccountLabel);

  String? get marginRequired;
  set marginRequired(String? marginRequired);

  String? get liquidationPrice;
  set liquidationPrice(String? liquidationPrice);

  DateTime? get quoteExpiresAt;
  set quoteExpiresAt(DateTime? quoteExpiresAt);

  ListBuilder<KeyValue> get details;
  set details(ListBuilder<KeyValue>? details);

  String? get feeAsset;
  set feeAsset(String? feeAsset);

  String? get feeNote;
  set feeNote(String? feeNote);
}

class _$$OrderPreviewCommon extends $OrderPreviewCommon {
  @override
  final BstocksPreviewEconomics? bstocks;
  @override
  final BstocksApprovalMode? approvalMode;
  @override
  final String? approvalAmountRaw;
  @override
  final Hip3TimeInForce? timeInForce;
  @override
  final String? limitPrice;
  @override
  final bool? priceConditionMet;
  @override
  final OrderPreviewCommonFundingModeEnum? fundingMode;
  @override
  final bool? fundsReserved;
  @override
  final String? requiredFundingRaw;
  @override
  final String? fundingToken;
  @override
  final String? balanceRaw;
  @override
  final String? allowanceRaw;
  @override
  final bool? balanceSufficient;
  @override
  final bool? allowanceSufficient;
  @override
  final bool? approvalRequired;
  @override
  final String? orderRouter;
  @override
  final BstocksPreviewRoute? route;
  @override
  final BstocksCancellationPolicy? cancellationPolicy;
  @override
  final Hip3PreviewExecution? hip3Execution;
  @override
  final String previewId;
  @override
  final String symbol;
  @override
  final OrderSide side;
  @override
  final OrderType type;
  @override
  final String? marketPrice;
  @override
  final String? estimatedPrice;
  @override
  final bool? priceUpdated;
  @override
  final String? estimatedQuantity;
  @override
  final String? estimatedReceive;
  @override
  final String? estimatedReceiveUnit;
  @override
  final String orderValue;
  @override
  final String? fee;
  @override
  final String? feeRate;
  @override
  final String? slippagePercent;
  @override
  final String? orderBookImpactPercent;
  @override
  final String? networkFee;
  @override
  final AccountKind? settlementAccount;
  @override
  final String? settlementAccountLabel;
  @override
  final String? marginRequired;
  @override
  final String? liquidationPrice;
  @override
  final DateTime? quoteExpiresAt;
  @override
  final BuiltList<KeyValue>? details;
  @override
  final String? feeAsset;
  @override
  final String? feeNote;

  factory _$$OrderPreviewCommon(
          [void Function($OrderPreviewCommonBuilder)? updates]) =>
      ($OrderPreviewCommonBuilder()..update(updates))._build();

  _$$OrderPreviewCommon._(
      {this.bstocks,
      this.approvalMode,
      this.approvalAmountRaw,
      this.timeInForce,
      this.limitPrice,
      this.priceConditionMet,
      this.fundingMode,
      this.fundsReserved,
      this.requiredFundingRaw,
      this.fundingToken,
      this.balanceRaw,
      this.allowanceRaw,
      this.balanceSufficient,
      this.allowanceSufficient,
      this.approvalRequired,
      this.orderRouter,
      this.route,
      this.cancellationPolicy,
      this.hip3Execution,
      required this.previewId,
      required this.symbol,
      required this.side,
      required this.type,
      this.marketPrice,
      this.estimatedPrice,
      this.priceUpdated,
      this.estimatedQuantity,
      this.estimatedReceive,
      this.estimatedReceiveUnit,
      required this.orderValue,
      this.fee,
      this.feeRate,
      this.slippagePercent,
      this.orderBookImpactPercent,
      this.networkFee,
      this.settlementAccount,
      this.settlementAccountLabel,
      this.marginRequired,
      this.liquidationPrice,
      this.quoteExpiresAt,
      this.details,
      this.feeAsset,
      this.feeNote})
      : super._();
  @override
  $OrderPreviewCommon rebuild(
          void Function($OrderPreviewCommonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $OrderPreviewCommonBuilder toBuilder() =>
      $OrderPreviewCommonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $OrderPreviewCommon &&
        bstocks == other.bstocks &&
        approvalMode == other.approvalMode &&
        approvalAmountRaw == other.approvalAmountRaw &&
        timeInForce == other.timeInForce &&
        limitPrice == other.limitPrice &&
        priceConditionMet == other.priceConditionMet &&
        fundingMode == other.fundingMode &&
        fundsReserved == other.fundsReserved &&
        requiredFundingRaw == other.requiredFundingRaw &&
        fundingToken == other.fundingToken &&
        balanceRaw == other.balanceRaw &&
        allowanceRaw == other.allowanceRaw &&
        balanceSufficient == other.balanceSufficient &&
        allowanceSufficient == other.allowanceSufficient &&
        approvalRequired == other.approvalRequired &&
        orderRouter == other.orderRouter &&
        route == other.route &&
        cancellationPolicy == other.cancellationPolicy &&
        hip3Execution == other.hip3Execution &&
        previewId == other.previewId &&
        symbol == other.symbol &&
        side == other.side &&
        type == other.type &&
        marketPrice == other.marketPrice &&
        estimatedPrice == other.estimatedPrice &&
        priceUpdated == other.priceUpdated &&
        estimatedQuantity == other.estimatedQuantity &&
        estimatedReceive == other.estimatedReceive &&
        estimatedReceiveUnit == other.estimatedReceiveUnit &&
        orderValue == other.orderValue &&
        fee == other.fee &&
        feeRate == other.feeRate &&
        slippagePercent == other.slippagePercent &&
        orderBookImpactPercent == other.orderBookImpactPercent &&
        networkFee == other.networkFee &&
        settlementAccount == other.settlementAccount &&
        settlementAccountLabel == other.settlementAccountLabel &&
        marginRequired == other.marginRequired &&
        liquidationPrice == other.liquidationPrice &&
        quoteExpiresAt == other.quoteExpiresAt &&
        details == other.details &&
        feeAsset == other.feeAsset &&
        feeNote == other.feeNote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bstocks.hashCode);
    _$hash = $jc(_$hash, approvalMode.hashCode);
    _$hash = $jc(_$hash, approvalAmountRaw.hashCode);
    _$hash = $jc(_$hash, timeInForce.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, priceConditionMet.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jc(_$hash, fundsReserved.hashCode);
    _$hash = $jc(_$hash, requiredFundingRaw.hashCode);
    _$hash = $jc(_$hash, fundingToken.hashCode);
    _$hash = $jc(_$hash, balanceRaw.hashCode);
    _$hash = $jc(_$hash, allowanceRaw.hashCode);
    _$hash = $jc(_$hash, balanceSufficient.hashCode);
    _$hash = $jc(_$hash, allowanceSufficient.hashCode);
    _$hash = $jc(_$hash, approvalRequired.hashCode);
    _$hash = $jc(_$hash, orderRouter.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jc(_$hash, cancellationPolicy.hashCode);
    _$hash = $jc(_$hash, hip3Execution.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, marketPrice.hashCode);
    _$hash = $jc(_$hash, estimatedPrice.hashCode);
    _$hash = $jc(_$hash, priceUpdated.hashCode);
    _$hash = $jc(_$hash, estimatedQuantity.hashCode);
    _$hash = $jc(_$hash, estimatedReceive.hashCode);
    _$hash = $jc(_$hash, estimatedReceiveUnit.hashCode);
    _$hash = $jc(_$hash, orderValue.hashCode);
    _$hash = $jc(_$hash, fee.hashCode);
    _$hash = $jc(_$hash, feeRate.hashCode);
    _$hash = $jc(_$hash, slippagePercent.hashCode);
    _$hash = $jc(_$hash, orderBookImpactPercent.hashCode);
    _$hash = $jc(_$hash, networkFee.hashCode);
    _$hash = $jc(_$hash, settlementAccount.hashCode);
    _$hash = $jc(_$hash, settlementAccountLabel.hashCode);
    _$hash = $jc(_$hash, marginRequired.hashCode);
    _$hash = $jc(_$hash, liquidationPrice.hashCode);
    _$hash = $jc(_$hash, quoteExpiresAt.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, feeAsset.hashCode);
    _$hash = $jc(_$hash, feeNote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$OrderPreviewCommon')
          ..add('bstocks', bstocks)
          ..add('approvalMode', approvalMode)
          ..add('approvalAmountRaw', approvalAmountRaw)
          ..add('timeInForce', timeInForce)
          ..add('limitPrice', limitPrice)
          ..add('priceConditionMet', priceConditionMet)
          ..add('fundingMode', fundingMode)
          ..add('fundsReserved', fundsReserved)
          ..add('requiredFundingRaw', requiredFundingRaw)
          ..add('fundingToken', fundingToken)
          ..add('balanceRaw', balanceRaw)
          ..add('allowanceRaw', allowanceRaw)
          ..add('balanceSufficient', balanceSufficient)
          ..add('allowanceSufficient', allowanceSufficient)
          ..add('approvalRequired', approvalRequired)
          ..add('orderRouter', orderRouter)
          ..add('route', route)
          ..add('cancellationPolicy', cancellationPolicy)
          ..add('hip3Execution', hip3Execution)
          ..add('previewId', previewId)
          ..add('symbol', symbol)
          ..add('side', side)
          ..add('type', type)
          ..add('marketPrice', marketPrice)
          ..add('estimatedPrice', estimatedPrice)
          ..add('priceUpdated', priceUpdated)
          ..add('estimatedQuantity', estimatedQuantity)
          ..add('estimatedReceive', estimatedReceive)
          ..add('estimatedReceiveUnit', estimatedReceiveUnit)
          ..add('orderValue', orderValue)
          ..add('fee', fee)
          ..add('feeRate', feeRate)
          ..add('slippagePercent', slippagePercent)
          ..add('orderBookImpactPercent', orderBookImpactPercent)
          ..add('networkFee', networkFee)
          ..add('settlementAccount', settlementAccount)
          ..add('settlementAccountLabel', settlementAccountLabel)
          ..add('marginRequired', marginRequired)
          ..add('liquidationPrice', liquidationPrice)
          ..add('quoteExpiresAt', quoteExpiresAt)
          ..add('details', details)
          ..add('feeAsset', feeAsset)
          ..add('feeNote', feeNote))
        .toString();
  }
}

class $OrderPreviewCommonBuilder
    implements
        Builder<$OrderPreviewCommon, $OrderPreviewCommonBuilder>,
        OrderPreviewCommonBuilder {
  _$$OrderPreviewCommon? _$v;

  BstocksPreviewEconomicsBuilder? _bstocks;
  BstocksPreviewEconomicsBuilder get bstocks =>
      _$this._bstocks ??= BstocksPreviewEconomicsBuilder();
  set bstocks(covariant BstocksPreviewEconomicsBuilder? bstocks) =>
      _$this._bstocks = bstocks;

  BstocksApprovalMode? _approvalMode;
  BstocksApprovalMode? get approvalMode => _$this._approvalMode;
  set approvalMode(covariant BstocksApprovalMode? approvalMode) =>
      _$this._approvalMode = approvalMode;

  String? _approvalAmountRaw;
  String? get approvalAmountRaw => _$this._approvalAmountRaw;
  set approvalAmountRaw(covariant String? approvalAmountRaw) =>
      _$this._approvalAmountRaw = approvalAmountRaw;

  Hip3TimeInForce? _timeInForce;
  Hip3TimeInForce? get timeInForce => _$this._timeInForce;
  set timeInForce(covariant Hip3TimeInForce? timeInForce) =>
      _$this._timeInForce = timeInForce;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(covariant String? limitPrice) =>
      _$this._limitPrice = limitPrice;

  bool? _priceConditionMet;
  bool? get priceConditionMet => _$this._priceConditionMet;
  set priceConditionMet(covariant bool? priceConditionMet) =>
      _$this._priceConditionMet = priceConditionMet;

  OrderPreviewCommonFundingModeEnum? _fundingMode;
  OrderPreviewCommonFundingModeEnum? get fundingMode => _$this._fundingMode;
  set fundingMode(covariant OrderPreviewCommonFundingModeEnum? fundingMode) =>
      _$this._fundingMode = fundingMode;

  bool? _fundsReserved;
  bool? get fundsReserved => _$this._fundsReserved;
  set fundsReserved(covariant bool? fundsReserved) =>
      _$this._fundsReserved = fundsReserved;

  String? _requiredFundingRaw;
  String? get requiredFundingRaw => _$this._requiredFundingRaw;
  set requiredFundingRaw(covariant String? requiredFundingRaw) =>
      _$this._requiredFundingRaw = requiredFundingRaw;

  String? _fundingToken;
  String? get fundingToken => _$this._fundingToken;
  set fundingToken(covariant String? fundingToken) =>
      _$this._fundingToken = fundingToken;

  String? _balanceRaw;
  String? get balanceRaw => _$this._balanceRaw;
  set balanceRaw(covariant String? balanceRaw) =>
      _$this._balanceRaw = balanceRaw;

  String? _allowanceRaw;
  String? get allowanceRaw => _$this._allowanceRaw;
  set allowanceRaw(covariant String? allowanceRaw) =>
      _$this._allowanceRaw = allowanceRaw;

  bool? _balanceSufficient;
  bool? get balanceSufficient => _$this._balanceSufficient;
  set balanceSufficient(covariant bool? balanceSufficient) =>
      _$this._balanceSufficient = balanceSufficient;

  bool? _allowanceSufficient;
  bool? get allowanceSufficient => _$this._allowanceSufficient;
  set allowanceSufficient(covariant bool? allowanceSufficient) =>
      _$this._allowanceSufficient = allowanceSufficient;

  bool? _approvalRequired;
  bool? get approvalRequired => _$this._approvalRequired;
  set approvalRequired(covariant bool? approvalRequired) =>
      _$this._approvalRequired = approvalRequired;

  String? _orderRouter;
  String? get orderRouter => _$this._orderRouter;
  set orderRouter(covariant String? orderRouter) =>
      _$this._orderRouter = orderRouter;

  BstocksPreviewRouteBuilder? _route;
  BstocksPreviewRouteBuilder get route =>
      _$this._route ??= BstocksPreviewRouteBuilder();
  set route(covariant BstocksPreviewRouteBuilder? route) =>
      _$this._route = route;

  BstocksCancellationPolicyBuilder? _cancellationPolicy;
  BstocksCancellationPolicyBuilder get cancellationPolicy =>
      _$this._cancellationPolicy ??= BstocksCancellationPolicyBuilder();
  set cancellationPolicy(
          covariant BstocksCancellationPolicyBuilder? cancellationPolicy) =>
      _$this._cancellationPolicy = cancellationPolicy;

  Hip3PreviewExecutionBuilder? _hip3Execution;
  Hip3PreviewExecutionBuilder get hip3Execution =>
      _$this._hip3Execution ??= Hip3PreviewExecutionBuilder();
  set hip3Execution(covariant Hip3PreviewExecutionBuilder? hip3Execution) =>
      _$this._hip3Execution = hip3Execution;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(covariant String? previewId) => _$this._previewId = previewId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(covariant String? symbol) => _$this._symbol = symbol;

  OrderSide? _side;
  OrderSide? get side => _$this._side;
  set side(covariant OrderSide? side) => _$this._side = side;

  OrderType? _type;
  OrderType? get type => _$this._type;
  set type(covariant OrderType? type) => _$this._type = type;

  String? _marketPrice;
  String? get marketPrice => _$this._marketPrice;
  set marketPrice(covariant String? marketPrice) =>
      _$this._marketPrice = marketPrice;

  String? _estimatedPrice;
  String? get estimatedPrice => _$this._estimatedPrice;
  set estimatedPrice(covariant String? estimatedPrice) =>
      _$this._estimatedPrice = estimatedPrice;

  bool? _priceUpdated;
  bool? get priceUpdated => _$this._priceUpdated;
  set priceUpdated(covariant bool? priceUpdated) =>
      _$this._priceUpdated = priceUpdated;

  String? _estimatedQuantity;
  String? get estimatedQuantity => _$this._estimatedQuantity;
  set estimatedQuantity(covariant String? estimatedQuantity) =>
      _$this._estimatedQuantity = estimatedQuantity;

  String? _estimatedReceive;
  String? get estimatedReceive => _$this._estimatedReceive;
  set estimatedReceive(covariant String? estimatedReceive) =>
      _$this._estimatedReceive = estimatedReceive;

  String? _estimatedReceiveUnit;
  String? get estimatedReceiveUnit => _$this._estimatedReceiveUnit;
  set estimatedReceiveUnit(covariant String? estimatedReceiveUnit) =>
      _$this._estimatedReceiveUnit = estimatedReceiveUnit;

  String? _orderValue;
  String? get orderValue => _$this._orderValue;
  set orderValue(covariant String? orderValue) =>
      _$this._orderValue = orderValue;

  String? _fee;
  String? get fee => _$this._fee;
  set fee(covariant String? fee) => _$this._fee = fee;

  String? _feeRate;
  String? get feeRate => _$this._feeRate;
  set feeRate(covariant String? feeRate) => _$this._feeRate = feeRate;

  String? _slippagePercent;
  String? get slippagePercent => _$this._slippagePercent;
  set slippagePercent(covariant String? slippagePercent) =>
      _$this._slippagePercent = slippagePercent;

  String? _orderBookImpactPercent;
  String? get orderBookImpactPercent => _$this._orderBookImpactPercent;
  set orderBookImpactPercent(covariant String? orderBookImpactPercent) =>
      _$this._orderBookImpactPercent = orderBookImpactPercent;

  String? _networkFee;
  String? get networkFee => _$this._networkFee;
  set networkFee(covariant String? networkFee) =>
      _$this._networkFee = networkFee;

  AccountKind? _settlementAccount;
  AccountKind? get settlementAccount => _$this._settlementAccount;
  set settlementAccount(covariant AccountKind? settlementAccount) =>
      _$this._settlementAccount = settlementAccount;

  String? _settlementAccountLabel;
  String? get settlementAccountLabel => _$this._settlementAccountLabel;
  set settlementAccountLabel(covariant String? settlementAccountLabel) =>
      _$this._settlementAccountLabel = settlementAccountLabel;

  String? _marginRequired;
  String? get marginRequired => _$this._marginRequired;
  set marginRequired(covariant String? marginRequired) =>
      _$this._marginRequired = marginRequired;

  String? _liquidationPrice;
  String? get liquidationPrice => _$this._liquidationPrice;
  set liquidationPrice(covariant String? liquidationPrice) =>
      _$this._liquidationPrice = liquidationPrice;

  DateTime? _quoteExpiresAt;
  DateTime? get quoteExpiresAt => _$this._quoteExpiresAt;
  set quoteExpiresAt(covariant DateTime? quoteExpiresAt) =>
      _$this._quoteExpiresAt = quoteExpiresAt;

  ListBuilder<KeyValue>? _details;
  ListBuilder<KeyValue> get details =>
      _$this._details ??= ListBuilder<KeyValue>();
  set details(covariant ListBuilder<KeyValue>? details) =>
      _$this._details = details;

  String? _feeAsset;
  String? get feeAsset => _$this._feeAsset;
  set feeAsset(covariant String? feeAsset) => _$this._feeAsset = feeAsset;

  String? _feeNote;
  String? get feeNote => _$this._feeNote;
  set feeNote(covariant String? feeNote) => _$this._feeNote = feeNote;

  $OrderPreviewCommonBuilder() {
    $OrderPreviewCommon._defaults(this);
  }

  $OrderPreviewCommonBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bstocks = $v.bstocks?.toBuilder();
      _approvalMode = $v.approvalMode;
      _approvalAmountRaw = $v.approvalAmountRaw;
      _timeInForce = $v.timeInForce;
      _limitPrice = $v.limitPrice;
      _priceConditionMet = $v.priceConditionMet;
      _fundingMode = $v.fundingMode;
      _fundsReserved = $v.fundsReserved;
      _requiredFundingRaw = $v.requiredFundingRaw;
      _fundingToken = $v.fundingToken;
      _balanceRaw = $v.balanceRaw;
      _allowanceRaw = $v.allowanceRaw;
      _balanceSufficient = $v.balanceSufficient;
      _allowanceSufficient = $v.allowanceSufficient;
      _approvalRequired = $v.approvalRequired;
      _orderRouter = $v.orderRouter;
      _route = $v.route?.toBuilder();
      _cancellationPolicy = $v.cancellationPolicy?.toBuilder();
      _hip3Execution = $v.hip3Execution?.toBuilder();
      _previewId = $v.previewId;
      _symbol = $v.symbol;
      _side = $v.side;
      _type = $v.type;
      _marketPrice = $v.marketPrice;
      _estimatedPrice = $v.estimatedPrice;
      _priceUpdated = $v.priceUpdated;
      _estimatedQuantity = $v.estimatedQuantity;
      _estimatedReceive = $v.estimatedReceive;
      _estimatedReceiveUnit = $v.estimatedReceiveUnit;
      _orderValue = $v.orderValue;
      _fee = $v.fee;
      _feeRate = $v.feeRate;
      _slippagePercent = $v.slippagePercent;
      _orderBookImpactPercent = $v.orderBookImpactPercent;
      _networkFee = $v.networkFee;
      _settlementAccount = $v.settlementAccount;
      _settlementAccountLabel = $v.settlementAccountLabel;
      _marginRequired = $v.marginRequired;
      _liquidationPrice = $v.liquidationPrice;
      _quoteExpiresAt = $v.quoteExpiresAt;
      _details = $v.details?.toBuilder();
      _feeAsset = $v.feeAsset;
      _feeNote = $v.feeNote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $OrderPreviewCommon other) {
    _$v = other as _$$OrderPreviewCommon;
  }

  @override
  void update(void Function($OrderPreviewCommonBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $OrderPreviewCommon build() => _build();

  _$$OrderPreviewCommon _build() {
    _$$OrderPreviewCommon _$result;
    try {
      _$result = _$v ??
          _$$OrderPreviewCommon._(
            bstocks: _bstocks?.build(),
            approvalMode: approvalMode,
            approvalAmountRaw: approvalAmountRaw,
            timeInForce: timeInForce,
            limitPrice: limitPrice,
            priceConditionMet: priceConditionMet,
            fundingMode: fundingMode,
            fundsReserved: fundsReserved,
            requiredFundingRaw: requiredFundingRaw,
            fundingToken: fundingToken,
            balanceRaw: balanceRaw,
            allowanceRaw: allowanceRaw,
            balanceSufficient: balanceSufficient,
            allowanceSufficient: allowanceSufficient,
            approvalRequired: approvalRequired,
            orderRouter: orderRouter,
            route: _route?.build(),
            cancellationPolicy: _cancellationPolicy?.build(),
            hip3Execution: _hip3Execution?.build(),
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'$OrderPreviewCommon', 'previewId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'$OrderPreviewCommon', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'$OrderPreviewCommon', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'$OrderPreviewCommon', 'type'),
            marketPrice: marketPrice,
            estimatedPrice: estimatedPrice,
            priceUpdated: priceUpdated,
            estimatedQuantity: estimatedQuantity,
            estimatedReceive: estimatedReceive,
            estimatedReceiveUnit: estimatedReceiveUnit,
            orderValue: BuiltValueNullFieldError.checkNotNull(
                orderValue, r'$OrderPreviewCommon', 'orderValue'),
            fee: fee,
            feeRate: feeRate,
            slippagePercent: slippagePercent,
            orderBookImpactPercent: orderBookImpactPercent,
            networkFee: networkFee,
            settlementAccount: settlementAccount,
            settlementAccountLabel: settlementAccountLabel,
            marginRequired: marginRequired,
            liquidationPrice: liquidationPrice,
            quoteExpiresAt: quoteExpiresAt,
            details: _details?.build(),
            feeAsset: feeAsset,
            feeNote: feeNote,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bstocks';
        _bstocks?.build();

        _$failedField = 'route';
        _route?.build();
        _$failedField = 'cancellationPolicy';
        _cancellationPolicy?.build();
        _$failedField = 'hip3Execution';
        _hip3Execution?.build();

        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'$OrderPreviewCommon', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
