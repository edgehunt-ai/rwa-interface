// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_supported_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksSupportedTokenExecutionStatusEnum
    _$bstocksSupportedTokenExecutionStatusEnum_discoveryOnly =
    const BstocksSupportedTokenExecutionStatusEnum._('discoveryOnly');
const BstocksSupportedTokenExecutionStatusEnum
    _$bstocksSupportedTokenExecutionStatusEnum_admitted =
    const BstocksSupportedTokenExecutionStatusEnum._('admitted');
const BstocksSupportedTokenExecutionStatusEnum
    _$bstocksSupportedTokenExecutionStatusEnum_unknownDefaultOpenApi =
    const BstocksSupportedTokenExecutionStatusEnum._('unknownDefaultOpenApi');

BstocksSupportedTokenExecutionStatusEnum
    _$bstocksSupportedTokenExecutionStatusEnumValueOf(String name) {
  switch (name) {
    case 'discoveryOnly':
      return _$bstocksSupportedTokenExecutionStatusEnum_discoveryOnly;
    case 'admitted':
      return _$bstocksSupportedTokenExecutionStatusEnum_admitted;
    case 'unknownDefaultOpenApi':
      return _$bstocksSupportedTokenExecutionStatusEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksSupportedTokenExecutionStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksSupportedTokenExecutionStatusEnum>
    _$bstocksSupportedTokenExecutionStatusEnumValues = BuiltSet<
        BstocksSupportedTokenExecutionStatusEnum>(const <BstocksSupportedTokenExecutionStatusEnum>[
  _$bstocksSupportedTokenExecutionStatusEnum_discoveryOnly,
  _$bstocksSupportedTokenExecutionStatusEnum_admitted,
  _$bstocksSupportedTokenExecutionStatusEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksSupportedTokenExecutionStatusEnum>
    _$bstocksSupportedTokenExecutionStatusEnumSerializer =
    _$BstocksSupportedTokenExecutionStatusEnumSerializer();

class _$BstocksSupportedTokenExecutionStatusEnumSerializer
    implements PrimitiveSerializer<BstocksSupportedTokenExecutionStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'discoveryOnly': 'discovery_only',
    'admitted': 'admitted',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'discovery_only': 'discoveryOnly',
    'admitted': 'admitted',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    BstocksSupportedTokenExecutionStatusEnum
  ];
  @override
  final String wireName = 'BstocksSupportedTokenExecutionStatusEnum';

  @override
  Object serialize(Serializers serializers,
          BstocksSupportedTokenExecutionStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksSupportedTokenExecutionStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksSupportedTokenExecutionStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksSupportedToken extends BstocksSupportedToken {
  @override
  final String symbol;
  @override
  final String? underlyingSymbol;
  @override
  final String contractAddress;
  @override
  final String? feedSymbol;
  @override
  final String? asset;
  @override
  final int decimals;
  @override
  final String? multiplier;
  @override
  final int? lastUpdateTime;
  @override
  final int? assetType;
  @override
  final bool displayEnabled;
  @override
  final BstocksSupportedTokenExecutionStatusEnum executionStatus;
  @override
  final bool executionEnabled;

  factory _$BstocksSupportedToken(
          [void Function(BstocksSupportedTokenBuilder)? updates]) =>
      (BstocksSupportedTokenBuilder()..update(updates))._build();

  _$BstocksSupportedToken._(
      {required this.symbol,
      this.underlyingSymbol,
      required this.contractAddress,
      this.feedSymbol,
      this.asset,
      required this.decimals,
      this.multiplier,
      this.lastUpdateTime,
      this.assetType,
      required this.displayEnabled,
      required this.executionStatus,
      required this.executionEnabled})
      : super._();
  @override
  BstocksSupportedToken rebuild(
          void Function(BstocksSupportedTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksSupportedTokenBuilder toBuilder() =>
      BstocksSupportedTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksSupportedToken &&
        symbol == other.symbol &&
        underlyingSymbol == other.underlyingSymbol &&
        contractAddress == other.contractAddress &&
        feedSymbol == other.feedSymbol &&
        asset == other.asset &&
        decimals == other.decimals &&
        multiplier == other.multiplier &&
        lastUpdateTime == other.lastUpdateTime &&
        assetType == other.assetType &&
        displayEnabled == other.displayEnabled &&
        executionStatus == other.executionStatus &&
        executionEnabled == other.executionEnabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, underlyingSymbol.hashCode);
    _$hash = $jc(_$hash, contractAddress.hashCode);
    _$hash = $jc(_$hash, feedSymbol.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jc(_$hash, multiplier.hashCode);
    _$hash = $jc(_$hash, lastUpdateTime.hashCode);
    _$hash = $jc(_$hash, assetType.hashCode);
    _$hash = $jc(_$hash, displayEnabled.hashCode);
    _$hash = $jc(_$hash, executionStatus.hashCode);
    _$hash = $jc(_$hash, executionEnabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksSupportedToken')
          ..add('symbol', symbol)
          ..add('underlyingSymbol', underlyingSymbol)
          ..add('contractAddress', contractAddress)
          ..add('feedSymbol', feedSymbol)
          ..add('asset', asset)
          ..add('decimals', decimals)
          ..add('multiplier', multiplier)
          ..add('lastUpdateTime', lastUpdateTime)
          ..add('assetType', assetType)
          ..add('displayEnabled', displayEnabled)
          ..add('executionStatus', executionStatus)
          ..add('executionEnabled', executionEnabled))
        .toString();
  }
}

class BstocksSupportedTokenBuilder
    implements Builder<BstocksSupportedToken, BstocksSupportedTokenBuilder> {
  _$BstocksSupportedToken? _$v;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _underlyingSymbol;
  String? get underlyingSymbol => _$this._underlyingSymbol;
  set underlyingSymbol(String? underlyingSymbol) =>
      _$this._underlyingSymbol = underlyingSymbol;

  String? _contractAddress;
  String? get contractAddress => _$this._contractAddress;
  set contractAddress(String? contractAddress) =>
      _$this._contractAddress = contractAddress;

  String? _feedSymbol;
  String? get feedSymbol => _$this._feedSymbol;
  set feedSymbol(String? feedSymbol) => _$this._feedSymbol = feedSymbol;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  String? _multiplier;
  String? get multiplier => _$this._multiplier;
  set multiplier(String? multiplier) => _$this._multiplier = multiplier;

  int? _lastUpdateTime;
  int? get lastUpdateTime => _$this._lastUpdateTime;
  set lastUpdateTime(int? lastUpdateTime) =>
      _$this._lastUpdateTime = lastUpdateTime;

  int? _assetType;
  int? get assetType => _$this._assetType;
  set assetType(int? assetType) => _$this._assetType = assetType;

  bool? _displayEnabled;
  bool? get displayEnabled => _$this._displayEnabled;
  set displayEnabled(bool? displayEnabled) =>
      _$this._displayEnabled = displayEnabled;

  BstocksSupportedTokenExecutionStatusEnum? _executionStatus;
  BstocksSupportedTokenExecutionStatusEnum? get executionStatus =>
      _$this._executionStatus;
  set executionStatus(
          BstocksSupportedTokenExecutionStatusEnum? executionStatus) =>
      _$this._executionStatus = executionStatus;

  bool? _executionEnabled;
  bool? get executionEnabled => _$this._executionEnabled;
  set executionEnabled(bool? executionEnabled) =>
      _$this._executionEnabled = executionEnabled;

  BstocksSupportedTokenBuilder() {
    BstocksSupportedToken._defaults(this);
  }

  BstocksSupportedTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symbol = $v.symbol;
      _underlyingSymbol = $v.underlyingSymbol;
      _contractAddress = $v.contractAddress;
      _feedSymbol = $v.feedSymbol;
      _asset = $v.asset;
      _decimals = $v.decimals;
      _multiplier = $v.multiplier;
      _lastUpdateTime = $v.lastUpdateTime;
      _assetType = $v.assetType;
      _displayEnabled = $v.displayEnabled;
      _executionStatus = $v.executionStatus;
      _executionEnabled = $v.executionEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksSupportedToken other) {
    _$v = other as _$BstocksSupportedToken;
  }

  @override
  void update(void Function(BstocksSupportedTokenBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksSupportedToken build() => _build();

  _$BstocksSupportedToken _build() {
    final _$result = _$v ??
        _$BstocksSupportedToken._(
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'BstocksSupportedToken', 'symbol'),
          underlyingSymbol: underlyingSymbol,
          contractAddress: BuiltValueNullFieldError.checkNotNull(
              contractAddress, r'BstocksSupportedToken', 'contractAddress'),
          feedSymbol: feedSymbol,
          asset: asset,
          decimals: BuiltValueNullFieldError.checkNotNull(
              decimals, r'BstocksSupportedToken', 'decimals'),
          multiplier: multiplier,
          lastUpdateTime: lastUpdateTime,
          assetType: assetType,
          displayEnabled: BuiltValueNullFieldError.checkNotNull(
              displayEnabled, r'BstocksSupportedToken', 'displayEnabled'),
          executionStatus: BuiltValueNullFieldError.checkNotNull(
              executionStatus, r'BstocksSupportedToken', 'executionStatus'),
          executionEnabled: BuiltValueNullFieldError.checkNotNull(
              executionEnabled, r'BstocksSupportedToken', 'executionEnabled'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
