// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perp_order_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PerpOrderPreviewKindEnum _$perpOrderPreviewKindEnum_perp =
    const PerpOrderPreviewKindEnum._('perp');
const PerpOrderPreviewKindEnum
    _$perpOrderPreviewKindEnum_unknownDefaultOpenApi =
    const PerpOrderPreviewKindEnum._('unknownDefaultOpenApi');

PerpOrderPreviewKindEnum _$perpOrderPreviewKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$perpOrderPreviewKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$perpOrderPreviewKindEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderPreviewKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderPreviewKindEnum> _$perpOrderPreviewKindEnumValues =
    BuiltSet<PerpOrderPreviewKindEnum>(const <PerpOrderPreviewKindEnum>[
  _$perpOrderPreviewKindEnum_perp,
  _$perpOrderPreviewKindEnum_unknownDefaultOpenApi,
]);

const PerpOrderPreviewNetworkEnum _$perpOrderPreviewNetworkEnum_arbitrum =
    const PerpOrderPreviewNetworkEnum._('arbitrum');
const PerpOrderPreviewNetworkEnum
    _$perpOrderPreviewNetworkEnum_unknownDefaultOpenApi =
    const PerpOrderPreviewNetworkEnum._('unknownDefaultOpenApi');

PerpOrderPreviewNetworkEnum _$perpOrderPreviewNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$perpOrderPreviewNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$perpOrderPreviewNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderPreviewNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderPreviewNetworkEnum>
    _$perpOrderPreviewNetworkEnumValues =
    BuiltSet<PerpOrderPreviewNetworkEnum>(const <PerpOrderPreviewNetworkEnum>[
  _$perpOrderPreviewNetworkEnum_arbitrum,
  _$perpOrderPreviewNetworkEnum_unknownDefaultOpenApi,
]);

const PerpOrderPreviewSettlementAssetEnum
    _$perpOrderPreviewSettlementAssetEnum_USDC =
    const PerpOrderPreviewSettlementAssetEnum._('USDC');
const PerpOrderPreviewSettlementAssetEnum
    _$perpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi =
    const PerpOrderPreviewSettlementAssetEnum._('unknownDefaultOpenApi');

PerpOrderPreviewSettlementAssetEnum
    _$perpOrderPreviewSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$perpOrderPreviewSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$perpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$perpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PerpOrderPreviewSettlementAssetEnum>
    _$perpOrderPreviewSettlementAssetEnumValues = BuiltSet<
        PerpOrderPreviewSettlementAssetEnum>(const <PerpOrderPreviewSettlementAssetEnum>[
  _$perpOrderPreviewSettlementAssetEnum_USDC,
  _$perpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<PerpOrderPreviewKindEnum> _$perpOrderPreviewKindEnumSerializer =
    _$PerpOrderPreviewKindEnumSerializer();
Serializer<PerpOrderPreviewNetworkEnum>
    _$perpOrderPreviewNetworkEnumSerializer =
    _$PerpOrderPreviewNetworkEnumSerializer();
Serializer<PerpOrderPreviewSettlementAssetEnum>
    _$perpOrderPreviewSettlementAssetEnumSerializer =
    _$PerpOrderPreviewSettlementAssetEnumSerializer();

class _$PerpOrderPreviewKindEnumSerializer
    implements PrimitiveSerializer<PerpOrderPreviewKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderPreviewKindEnum];
  @override
  final String wireName = 'PerpOrderPreviewKindEnum';

  @override
  Object serialize(Serializers serializers, PerpOrderPreviewKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderPreviewKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderPreviewKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderPreviewNetworkEnumSerializer
    implements PrimitiveSerializer<PerpOrderPreviewNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PerpOrderPreviewNetworkEnum];
  @override
  final String wireName = 'PerpOrderPreviewNetworkEnum';

  @override
  Object serialize(Serializers serializers, PerpOrderPreviewNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderPreviewNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderPreviewNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderPreviewSettlementAssetEnumSerializer
    implements PrimitiveSerializer<PerpOrderPreviewSettlementAssetEnum> {
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
    PerpOrderPreviewSettlementAssetEnum
  ];
  @override
  final String wireName = 'PerpOrderPreviewSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, PerpOrderPreviewSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PerpOrderPreviewSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PerpOrderPreviewSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PerpOrderPreview extends PerpOrderPreview {
  @override
  final PerpOrderPreviewSettlementAssetEnum settlementAsset;
  @override
  final PerpOrderPreviewKindEnum kind;
  @override
  final PerpOrderPreviewNetworkEnum network;
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

  factory _$PerpOrderPreview(
          [void Function(PerpOrderPreviewBuilder)? updates]) =>
      (PerpOrderPreviewBuilder()..update(updates))._build();

  _$PerpOrderPreview._(
      {required this.settlementAsset,
      required this.kind,
      required this.network,
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
  PerpOrderPreview rebuild(void Function(PerpOrderPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PerpOrderPreviewBuilder toBuilder() =>
      PerpOrderPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PerpOrderPreview &&
        settlementAsset == other.settlementAsset &&
        kind == other.kind &&
        network == other.network &&
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
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
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
    return (newBuiltValueToStringHelper(r'PerpOrderPreview')
          ..add('settlementAsset', settlementAsset)
          ..add('kind', kind)
          ..add('network', network)
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

class PerpOrderPreviewBuilder
    implements
        Builder<PerpOrderPreview, PerpOrderPreviewBuilder>,
        OrderPreviewCommonBuilder {
  _$PerpOrderPreview? _$v;

  PerpOrderPreviewSettlementAssetEnum? _settlementAsset;
  PerpOrderPreviewSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(
          covariant PerpOrderPreviewSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  PerpOrderPreviewKindEnum? _kind;
  PerpOrderPreviewKindEnum? get kind => _$this._kind;
  set kind(covariant PerpOrderPreviewKindEnum? kind) => _$this._kind = kind;

  PerpOrderPreviewNetworkEnum? _network;
  PerpOrderPreviewNetworkEnum? get network => _$this._network;
  set network(covariant PerpOrderPreviewNetworkEnum? network) =>
      _$this._network = network;

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

  PerpOrderPreviewBuilder() {
    PerpOrderPreview._defaults(this);
  }

  PerpOrderPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _settlementAsset = $v.settlementAsset;
      _kind = $v.kind;
      _network = $v.network;
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
  void replace(covariant PerpOrderPreview other) {
    _$v = other as _$PerpOrderPreview;
  }

  @override
  void update(void Function(PerpOrderPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PerpOrderPreview build() => _build();

  _$PerpOrderPreview _build() {
    _$PerpOrderPreview _$result;
    try {
      _$result = _$v ??
          _$PerpOrderPreview._(
            settlementAsset: BuiltValueNullFieldError.checkNotNull(
                settlementAsset, r'PerpOrderPreview', 'settlementAsset'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'PerpOrderPreview', 'kind'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'PerpOrderPreview', 'network'),
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'PerpOrderPreview', 'previewId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'PerpOrderPreview', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'PerpOrderPreview', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'PerpOrderPreview', 'type'),
            marketPrice: marketPrice,
            estimatedPrice: estimatedPrice,
            priceUpdated: priceUpdated,
            estimatedQuantity: estimatedQuantity,
            estimatedReceive: estimatedReceive,
            estimatedReceiveUnit: estimatedReceiveUnit,
            orderValue: BuiltValueNullFieldError.checkNotNull(
                orderValue, r'PerpOrderPreview', 'orderValue'),
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
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PerpOrderPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
