// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_perp_order_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LegacyPerpOrderPreviewKindEnum _$legacyPerpOrderPreviewKindEnum_perp =
    const LegacyPerpOrderPreviewKindEnum._('perp');
const LegacyPerpOrderPreviewKindEnum
    _$legacyPerpOrderPreviewKindEnum_unknownDefaultOpenApi =
    const LegacyPerpOrderPreviewKindEnum._('unknownDefaultOpenApi');

LegacyPerpOrderPreviewKindEnum _$legacyPerpOrderPreviewKindEnumValueOf(
    String name) {
  switch (name) {
    case 'perp':
      return _$legacyPerpOrderPreviewKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpOrderPreviewKindEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpOrderPreviewKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpOrderPreviewKindEnum>
    _$legacyPerpOrderPreviewKindEnumValues = BuiltSet<
        LegacyPerpOrderPreviewKindEnum>(const <LegacyPerpOrderPreviewKindEnum>[
  _$legacyPerpOrderPreviewKindEnum_perp,
  _$legacyPerpOrderPreviewKindEnum_unknownDefaultOpenApi,
]);

const LegacyPerpOrderPreviewNetworkEnum
    _$legacyPerpOrderPreviewNetworkEnum_arbitrum =
    const LegacyPerpOrderPreviewNetworkEnum._('arbitrum');
const LegacyPerpOrderPreviewNetworkEnum
    _$legacyPerpOrderPreviewNetworkEnum_unknownDefaultOpenApi =
    const LegacyPerpOrderPreviewNetworkEnum._('unknownDefaultOpenApi');

LegacyPerpOrderPreviewNetworkEnum _$legacyPerpOrderPreviewNetworkEnumValueOf(
    String name) {
  switch (name) {
    case 'arbitrum':
      return _$legacyPerpOrderPreviewNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpOrderPreviewNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpOrderPreviewNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpOrderPreviewNetworkEnum>
    _$legacyPerpOrderPreviewNetworkEnumValues = BuiltSet<
        LegacyPerpOrderPreviewNetworkEnum>(const <LegacyPerpOrderPreviewNetworkEnum>[
  _$legacyPerpOrderPreviewNetworkEnum_arbitrum,
  _$legacyPerpOrderPreviewNetworkEnum_unknownDefaultOpenApi,
]);

const LegacyPerpOrderPreviewSettlementAssetEnum
    _$legacyPerpOrderPreviewSettlementAssetEnum_USDC =
    const LegacyPerpOrderPreviewSettlementAssetEnum._('USDC');
const LegacyPerpOrderPreviewSettlementAssetEnum
    _$legacyPerpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi =
    const LegacyPerpOrderPreviewSettlementAssetEnum._('unknownDefaultOpenApi');

LegacyPerpOrderPreviewSettlementAssetEnum
    _$legacyPerpOrderPreviewSettlementAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$legacyPerpOrderPreviewSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$legacyPerpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$legacyPerpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<LegacyPerpOrderPreviewSettlementAssetEnum>
    _$legacyPerpOrderPreviewSettlementAssetEnumValues = BuiltSet<
        LegacyPerpOrderPreviewSettlementAssetEnum>(const <LegacyPerpOrderPreviewSettlementAssetEnum>[
  _$legacyPerpOrderPreviewSettlementAssetEnum_USDC,
  _$legacyPerpOrderPreviewSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<LegacyPerpOrderPreviewKindEnum>
    _$legacyPerpOrderPreviewKindEnumSerializer =
    _$LegacyPerpOrderPreviewKindEnumSerializer();
Serializer<LegacyPerpOrderPreviewNetworkEnum>
    _$legacyPerpOrderPreviewNetworkEnumSerializer =
    _$LegacyPerpOrderPreviewNetworkEnumSerializer();
Serializer<LegacyPerpOrderPreviewSettlementAssetEnum>
    _$legacyPerpOrderPreviewSettlementAssetEnumSerializer =
    _$LegacyPerpOrderPreviewSettlementAssetEnumSerializer();

class _$LegacyPerpOrderPreviewKindEnumSerializer
    implements PrimitiveSerializer<LegacyPerpOrderPreviewKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyPerpOrderPreviewKindEnum];
  @override
  final String wireName = 'LegacyPerpOrderPreviewKindEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyPerpOrderPreviewKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpOrderPreviewKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpOrderPreviewKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpOrderPreviewNetworkEnumSerializer
    implements PrimitiveSerializer<LegacyPerpOrderPreviewNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[LegacyPerpOrderPreviewNetworkEnum];
  @override
  final String wireName = 'LegacyPerpOrderPreviewNetworkEnum';

  @override
  Object serialize(
          Serializers serializers, LegacyPerpOrderPreviewNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpOrderPreviewNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpOrderPreviewNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpOrderPreviewSettlementAssetEnumSerializer
    implements PrimitiveSerializer<LegacyPerpOrderPreviewSettlementAssetEnum> {
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
    LegacyPerpOrderPreviewSettlementAssetEnum
  ];
  @override
  final String wireName = 'LegacyPerpOrderPreviewSettlementAssetEnum';

  @override
  Object serialize(Serializers serializers,
          LegacyPerpOrderPreviewSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  LegacyPerpOrderPreviewSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      LegacyPerpOrderPreviewSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$LegacyPerpOrderPreview extends LegacyPerpOrderPreview {
  @override
  final LegacyPerpOrderPreviewSettlementAssetEnum settlementAsset;
  @override
  final LegacyPerpOrderPreviewKindEnum kind;
  @override
  final LegacyPerpOrderPreviewNetworkEnum network;
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

  factory _$LegacyPerpOrderPreview(
          [void Function(LegacyPerpOrderPreviewBuilder)? updates]) =>
      (LegacyPerpOrderPreviewBuilder()..update(updates))._build();

  _$LegacyPerpOrderPreview._(
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
  LegacyPerpOrderPreview rebuild(
          void Function(LegacyPerpOrderPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LegacyPerpOrderPreviewBuilder toBuilder() =>
      LegacyPerpOrderPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LegacyPerpOrderPreview &&
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
    return (newBuiltValueToStringHelper(r'LegacyPerpOrderPreview')
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

class LegacyPerpOrderPreviewBuilder
    implements
        Builder<LegacyPerpOrderPreview, LegacyPerpOrderPreviewBuilder>,
        OrderPreviewCommonBuilder {
  _$LegacyPerpOrderPreview? _$v;

  LegacyPerpOrderPreviewSettlementAssetEnum? _settlementAsset;
  LegacyPerpOrderPreviewSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(
          covariant LegacyPerpOrderPreviewSettlementAssetEnum?
              settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  LegacyPerpOrderPreviewKindEnum? _kind;
  LegacyPerpOrderPreviewKindEnum? get kind => _$this._kind;
  set kind(covariant LegacyPerpOrderPreviewKindEnum? kind) =>
      _$this._kind = kind;

  LegacyPerpOrderPreviewNetworkEnum? _network;
  LegacyPerpOrderPreviewNetworkEnum? get network => _$this._network;
  set network(covariant LegacyPerpOrderPreviewNetworkEnum? network) =>
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

  LegacyPerpOrderPreviewBuilder() {
    LegacyPerpOrderPreview._defaults(this);
  }

  LegacyPerpOrderPreviewBuilder get _$this {
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
  void replace(covariant LegacyPerpOrderPreview other) {
    _$v = other as _$LegacyPerpOrderPreview;
  }

  @override
  void update(void Function(LegacyPerpOrderPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LegacyPerpOrderPreview build() => _build();

  _$LegacyPerpOrderPreview _build() {
    _$LegacyPerpOrderPreview _$result;
    try {
      _$result = _$v ??
          _$LegacyPerpOrderPreview._(
            settlementAsset: BuiltValueNullFieldError.checkNotNull(
                settlementAsset, r'LegacyPerpOrderPreview', 'settlementAsset'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'LegacyPerpOrderPreview', 'kind'),
            network: BuiltValueNullFieldError.checkNotNull(
                network, r'LegacyPerpOrderPreview', 'network'),
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'LegacyPerpOrderPreview', 'previewId'),
            symbol: BuiltValueNullFieldError.checkNotNull(
                symbol, r'LegacyPerpOrderPreview', 'symbol'),
            side: BuiltValueNullFieldError.checkNotNull(
                side, r'LegacyPerpOrderPreview', 'side'),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'LegacyPerpOrderPreview', 'type'),
            marketPrice: marketPrice,
            estimatedPrice: estimatedPrice,
            priceUpdated: priceUpdated,
            estimatedQuantity: estimatedQuantity,
            estimatedReceive: estimatedReceive,
            estimatedReceiveUnit: estimatedReceiveUnit,
            orderValue: BuiltValueNullFieldError.checkNotNull(
                orderValue, r'LegacyPerpOrderPreview', 'orderValue'),
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
            r'LegacyPerpOrderPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
