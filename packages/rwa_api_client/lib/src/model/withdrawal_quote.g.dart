// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_quote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WithdrawalQuoteAssetEnum _$withdrawalQuoteAssetEnum_USDC =
    const WithdrawalQuoteAssetEnum._('USDC');
const WithdrawalQuoteAssetEnum
    _$withdrawalQuoteAssetEnum_unknownDefaultOpenApi =
    const WithdrawalQuoteAssetEnum._('unknownDefaultOpenApi');

WithdrawalQuoteAssetEnum _$withdrawalQuoteAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$withdrawalQuoteAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$withdrawalQuoteAssetEnum_unknownDefaultOpenApi;
    default:
      return _$withdrawalQuoteAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WithdrawalQuoteAssetEnum> _$withdrawalQuoteAssetEnumValues =
    BuiltSet<WithdrawalQuoteAssetEnum>(const <WithdrawalQuoteAssetEnum>[
  _$withdrawalQuoteAssetEnum_USDC,
  _$withdrawalQuoteAssetEnum_unknownDefaultOpenApi,
]);

Serializer<WithdrawalQuoteAssetEnum> _$withdrawalQuoteAssetEnumSerializer =
    _$WithdrawalQuoteAssetEnumSerializer();

class _$WithdrawalQuoteAssetEnumSerializer
    implements PrimitiveSerializer<WithdrawalQuoteAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WithdrawalQuoteAssetEnum];
  @override
  final String wireName = 'WithdrawalQuoteAssetEnum';

  @override
  Object serialize(Serializers serializers, WithdrawalQuoteAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WithdrawalQuoteAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WithdrawalQuoteAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WithdrawalQuote extends WithdrawalQuote {
  @override
  final String quoteId;
  @override
  final WithdrawalQuoteAssetEnum? asset;
  @override
  final Chain? chain;
  @override
  final String amount;
  @override
  final bool? needsConvert;
  @override
  final String? convertRoute;
  @override
  final String? transferRoute;
  @override
  final bool? needsBridge;
  @override
  final String? bridgeRoute;
  @override
  final String? convertTransferFee;
  @override
  final String? bridgeFee;
  @override
  final String? networkFee;
  @override
  final String totalFee;
  @override
  final String estimatedReceive;
  @override
  final String? estimatedTime;
  @override
  final bool sufficient;
  @override
  final BuiltList<KeyValue>? details;

  factory _$WithdrawalQuote([void Function(WithdrawalQuoteBuilder)? updates]) =>
      (WithdrawalQuoteBuilder()..update(updates))._build();

  _$WithdrawalQuote._(
      {required this.quoteId,
      this.asset,
      this.chain,
      required this.amount,
      this.needsConvert,
      this.convertRoute,
      this.transferRoute,
      this.needsBridge,
      this.bridgeRoute,
      this.convertTransferFee,
      this.bridgeFee,
      this.networkFee,
      required this.totalFee,
      required this.estimatedReceive,
      this.estimatedTime,
      required this.sufficient,
      this.details})
      : super._();
  @override
  WithdrawalQuote rebuild(void Function(WithdrawalQuoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalQuoteBuilder toBuilder() => WithdrawalQuoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WithdrawalQuote &&
        quoteId == other.quoteId &&
        asset == other.asset &&
        chain == other.chain &&
        amount == other.amount &&
        needsConvert == other.needsConvert &&
        convertRoute == other.convertRoute &&
        transferRoute == other.transferRoute &&
        needsBridge == other.needsBridge &&
        bridgeRoute == other.bridgeRoute &&
        convertTransferFee == other.convertTransferFee &&
        bridgeFee == other.bridgeFee &&
        networkFee == other.networkFee &&
        totalFee == other.totalFee &&
        estimatedReceive == other.estimatedReceive &&
        estimatedTime == other.estimatedTime &&
        sufficient == other.sufficient &&
        details == other.details;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quoteId.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, needsConvert.hashCode);
    _$hash = $jc(_$hash, convertRoute.hashCode);
    _$hash = $jc(_$hash, transferRoute.hashCode);
    _$hash = $jc(_$hash, needsBridge.hashCode);
    _$hash = $jc(_$hash, bridgeRoute.hashCode);
    _$hash = $jc(_$hash, convertTransferFee.hashCode);
    _$hash = $jc(_$hash, bridgeFee.hashCode);
    _$hash = $jc(_$hash, networkFee.hashCode);
    _$hash = $jc(_$hash, totalFee.hashCode);
    _$hash = $jc(_$hash, estimatedReceive.hashCode);
    _$hash = $jc(_$hash, estimatedTime.hashCode);
    _$hash = $jc(_$hash, sufficient.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WithdrawalQuote')
          ..add('quoteId', quoteId)
          ..add('asset', asset)
          ..add('chain', chain)
          ..add('amount', amount)
          ..add('needsConvert', needsConvert)
          ..add('convertRoute', convertRoute)
          ..add('transferRoute', transferRoute)
          ..add('needsBridge', needsBridge)
          ..add('bridgeRoute', bridgeRoute)
          ..add('convertTransferFee', convertTransferFee)
          ..add('bridgeFee', bridgeFee)
          ..add('networkFee', networkFee)
          ..add('totalFee', totalFee)
          ..add('estimatedReceive', estimatedReceive)
          ..add('estimatedTime', estimatedTime)
          ..add('sufficient', sufficient)
          ..add('details', details))
        .toString();
  }
}

class WithdrawalQuoteBuilder
    implements Builder<WithdrawalQuote, WithdrawalQuoteBuilder> {
  _$WithdrawalQuote? _$v;

  String? _quoteId;
  String? get quoteId => _$this._quoteId;
  set quoteId(String? quoteId) => _$this._quoteId = quoteId;

  WithdrawalQuoteAssetEnum? _asset;
  WithdrawalQuoteAssetEnum? get asset => _$this._asset;
  set asset(WithdrawalQuoteAssetEnum? asset) => _$this._asset = asset;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  bool? _needsConvert;
  bool? get needsConvert => _$this._needsConvert;
  set needsConvert(bool? needsConvert) => _$this._needsConvert = needsConvert;

  String? _convertRoute;
  String? get convertRoute => _$this._convertRoute;
  set convertRoute(String? convertRoute) => _$this._convertRoute = convertRoute;

  String? _transferRoute;
  String? get transferRoute => _$this._transferRoute;
  set transferRoute(String? transferRoute) =>
      _$this._transferRoute = transferRoute;

  bool? _needsBridge;
  bool? get needsBridge => _$this._needsBridge;
  set needsBridge(bool? needsBridge) => _$this._needsBridge = needsBridge;

  String? _bridgeRoute;
  String? get bridgeRoute => _$this._bridgeRoute;
  set bridgeRoute(String? bridgeRoute) => _$this._bridgeRoute = bridgeRoute;

  String? _convertTransferFee;
  String? get convertTransferFee => _$this._convertTransferFee;
  set convertTransferFee(String? convertTransferFee) =>
      _$this._convertTransferFee = convertTransferFee;

  String? _bridgeFee;
  String? get bridgeFee => _$this._bridgeFee;
  set bridgeFee(String? bridgeFee) => _$this._bridgeFee = bridgeFee;

  String? _networkFee;
  String? get networkFee => _$this._networkFee;
  set networkFee(String? networkFee) => _$this._networkFee = networkFee;

  String? _totalFee;
  String? get totalFee => _$this._totalFee;
  set totalFee(String? totalFee) => _$this._totalFee = totalFee;

  String? _estimatedReceive;
  String? get estimatedReceive => _$this._estimatedReceive;
  set estimatedReceive(String? estimatedReceive) =>
      _$this._estimatedReceive = estimatedReceive;

  String? _estimatedTime;
  String? get estimatedTime => _$this._estimatedTime;
  set estimatedTime(String? estimatedTime) =>
      _$this._estimatedTime = estimatedTime;

  bool? _sufficient;
  bool? get sufficient => _$this._sufficient;
  set sufficient(bool? sufficient) => _$this._sufficient = sufficient;

  ListBuilder<KeyValue>? _details;
  ListBuilder<KeyValue> get details =>
      _$this._details ??= ListBuilder<KeyValue>();
  set details(ListBuilder<KeyValue>? details) => _$this._details = details;

  WithdrawalQuoteBuilder() {
    WithdrawalQuote._defaults(this);
  }

  WithdrawalQuoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quoteId = $v.quoteId;
      _asset = $v.asset;
      _chain = $v.chain;
      _amount = $v.amount;
      _needsConvert = $v.needsConvert;
      _convertRoute = $v.convertRoute;
      _transferRoute = $v.transferRoute;
      _needsBridge = $v.needsBridge;
      _bridgeRoute = $v.bridgeRoute;
      _convertTransferFee = $v.convertTransferFee;
      _bridgeFee = $v.bridgeFee;
      _networkFee = $v.networkFee;
      _totalFee = $v.totalFee;
      _estimatedReceive = $v.estimatedReceive;
      _estimatedTime = $v.estimatedTime;
      _sufficient = $v.sufficient;
      _details = $v.details?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WithdrawalQuote other) {
    _$v = other as _$WithdrawalQuote;
  }

  @override
  void update(void Function(WithdrawalQuoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WithdrawalQuote build() => _build();

  _$WithdrawalQuote _build() {
    _$WithdrawalQuote _$result;
    try {
      _$result = _$v ??
          _$WithdrawalQuote._(
            quoteId: BuiltValueNullFieldError.checkNotNull(
                quoteId, r'WithdrawalQuote', 'quoteId'),
            asset: asset,
            chain: chain,
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'WithdrawalQuote', 'amount'),
            needsConvert: needsConvert,
            convertRoute: convertRoute,
            transferRoute: transferRoute,
            needsBridge: needsBridge,
            bridgeRoute: bridgeRoute,
            convertTransferFee: convertTransferFee,
            bridgeFee: bridgeFee,
            networkFee: networkFee,
            totalFee: BuiltValueNullFieldError.checkNotNull(
                totalFee, r'WithdrawalQuote', 'totalFee'),
            estimatedReceive: BuiltValueNullFieldError.checkNotNull(
                estimatedReceive, r'WithdrawalQuote', 'estimatedReceive'),
            estimatedTime: estimatedTime,
            sufficient: BuiltValueNullFieldError.checkNotNull(
                sufficient, r'WithdrawalQuote', 'sufficient'),
            details: _details?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'details';
        _details?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WithdrawalQuote', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
