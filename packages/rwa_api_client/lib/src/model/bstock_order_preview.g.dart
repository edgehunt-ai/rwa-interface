// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockOrderPreviewKindEnum _$bstockOrderPreviewKindEnum_bstock =
    const BstockOrderPreviewKindEnum._('bstock');
const BstockOrderPreviewKindEnum
    _$bstockOrderPreviewKindEnum_unknownDefaultOpenApi =
    const BstockOrderPreviewKindEnum._('unknownDefaultOpenApi');

BstockOrderPreviewKindEnum _$bstockOrderPreviewKindEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$bstockOrderPreviewKindEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderPreviewKindEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderPreviewKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderPreviewKindEnum> _$bstockOrderPreviewKindEnumValues =
    BuiltSet<BstockOrderPreviewKindEnum>(const <BstockOrderPreviewKindEnum>[
  _$bstockOrderPreviewKindEnum_bstock,
  _$bstockOrderPreviewKindEnum_unknownDefaultOpenApi,
]);

const BstockOrderPreviewNetworkEnum _$bstockOrderPreviewNetworkEnum_BSC =
    const BstockOrderPreviewNetworkEnum._('BSC');
const BstockOrderPreviewNetworkEnum
    _$bstockOrderPreviewNetworkEnum_unknownDefaultOpenApi =
    const BstockOrderPreviewNetworkEnum._('unknownDefaultOpenApi');

BstockOrderPreviewNetworkEnum _$bstockOrderPreviewNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'BSC':
      return _$bstockOrderPreviewNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderPreviewNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderPreviewNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderPreviewNetworkEnum>
    _$bstockOrderPreviewNetworkEnumValues = BuiltSet<
        BstockOrderPreviewNetworkEnum>(const <BstockOrderPreviewNetworkEnum>[
  _$bstockOrderPreviewNetworkEnum_BSC,
  _$bstockOrderPreviewNetworkEnum_unknownDefaultOpenApi,
]);

const BstockOrderPreviewSettlementAssetEnum
    _$bstockOrderPreviewSettlementAssetEnum_USDC =
    const BstockOrderPreviewSettlementAssetEnum._('USDC');
const BstockOrderPreviewSettlementAssetEnum
    _$bstockOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi =
    const BstockOrderPreviewSettlementAssetEnum._('unknownDefaultOpenApi');

BstockOrderPreviewSettlementAssetEnum
    _$bstockOrderPreviewSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$bstockOrderPreviewSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$bstockOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$bstockOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstockOrderPreviewSettlementAssetEnum>
    _$bstockOrderPreviewSettlementAssetEnumValues = BuiltSet<
        BstockOrderPreviewSettlementAssetEnum>(const <BstockOrderPreviewSettlementAssetEnum>[
  _$bstockOrderPreviewSettlementAssetEnum_USDC,
  _$bstockOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<BstockOrderPreviewKindEnum> _$bstockOrderPreviewKindEnumSerializer =
    _$BstockOrderPreviewKindEnumSerializer();
Serializer<BstockOrderPreviewNetworkEnum>
    _$bstockOrderPreviewNetworkEnumSerializer =
    _$BstockOrderPreviewNetworkEnumSerializer();
Serializer<BstockOrderPreviewSettlementAssetEnum>
    _$bstockOrderPreviewSettlementAssetEnumSerializer =
    _$BstockOrderPreviewSettlementAssetEnumSerializer();

class _$BstockOrderPreviewKindEnumSerializer
    implements PrimitiveSerializer<BstockOrderPreviewKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockOrderPreviewKindEnum];
  @override
  final String wireName = 'BstockOrderPreviewKindEnum';

  @override
  Object serialize(Serializers serializers, BstockOrderPreviewKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderPreviewKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderPreviewKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderPreviewNetworkEnumSerializer
    implements PrimitiveSerializer<BstockOrderPreviewNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockOrderPreviewNetworkEnum];
  @override
  final String wireName = 'BstockOrderPreviewNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, BstockOrderPreviewNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderPreviewNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderPreviewNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderPreviewSettlementAssetEnumSerializer
    implements PrimitiveSerializer<BstockOrderPreviewSettlementAssetEnum> {
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
    BstockOrderPreviewSettlementAssetEnum
  ];
  @override
  final String wireName = 'BstockOrderPreviewSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, BstockOrderPreviewSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderPreviewSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderPreviewSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstockOrderPreview extends BstockOrderPreview {
  @override
  final BstockOrderPreviewSettlementAssetEnum settlementAsset;
  @override
  final BstockOrderPreviewKindEnum kind;
  @override
  final BstockOrderPreviewNetworkEnum network;
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

  factory _$BstockOrderPreview(
          [void Function(BstockOrderPreviewBuilder)? updates]) =>
      (BstockOrderPreviewBuilder()..update(updates))._build();

  _$BstockOrderPreview._(
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
  BstockOrderPreview rebuild(
          void Function(BstockOrderPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstockOrderPreviewBuilder toBuilder() =>
      BstockOrderPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstockOrderPreview &&
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
    return (newBuiltValueToStringHelper(r'BstockOrderPreview')
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

class BstockOrderPreviewBuilder
    implements
        Builder<BstockOrderPreview, BstockOrderPreviewBuilder>,
        OrderPreviewCommonBuilder {
  _$BstockOrderPreview? _$v;

  BstockOrderPreviewSettlementAssetEnum? _settlementAsset;
  BstockOrderPreviewSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(
          covariant BstockOrderPreviewSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  BstockOrderPreviewKindEnum? _kind;
  BstockOrderPreviewKindEnum? get kind => _$this._kind;
  set kind(covariant BstockOrderPreviewKindEnum? kind) => _$this._kind = kind;

  BstockOrderPreviewNetworkEnum? _network;
  BstockOrderPreviewNetworkEnum? get network => _$this._network;
  set network(covariant BstockOrderPreviewNetworkEnum? network) =>
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

  BstockOrderPreviewBuilder() {
    BstockOrderPreview._defaults(this);
  }

  BstockOrderPreviewBuilder get _$this {
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
  void replace(covariant BstockOrderPreview other) {
    _$v = other as _$BstockOrderPreview;
  }

  @override
  void update(void Function(BstockOrderPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstockOrderPreview build() => _build();

  _$BstockOrderPreview _build() {
    _$BstockOrderPreview _$result;
    try {
      _$result = _$v ??
          _$BstockOrderPreview._(
            settlementAsset: BuiltValueNullFieldError.checkNotNull(
                settlementAsset, r'BstockOrderPreview', 'settlementAsset'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'BstockOrderPreview', 'kind'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'BstockOrderPreview', 'network'),
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'BstockOrderPreview', 'previewId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'BstockOrderPreview', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'BstockOrderPreview', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'BstockOrderPreview', 'type'),
            marketPrice: marketPrice,
            estimatedPrice: estimatedPrice,
            priceUpdated: priceUpdated,
            estimatedQuantity: estimatedQuantity,
            estimatedReceive: estimatedReceive,
            estimatedReceiveUnit: estimatedReceiveUnit,
            orderValue: BuiltValueNullFieldError.checkNotNull(
                orderValue, r'BstockOrderPreview', 'orderValue'),
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
            r'BstockOrderPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
