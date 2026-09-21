// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_fee_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksFeeAssetChainIdEnum _$bstocksFeeAssetChainIdEnum_number56 =
    const BstocksFeeAssetChainIdEnum._('number56');
const BstocksFeeAssetChainIdEnum _$bstocksFeeAssetChainIdEnum_number97 =
    const BstocksFeeAssetChainIdEnum._('number97');
const BstocksFeeAssetChainIdEnum _$bstocksFeeAssetChainIdEnum_number31337 =
    const BstocksFeeAssetChainIdEnum._('number31337');
const BstocksFeeAssetChainIdEnum
    _$bstocksFeeAssetChainIdEnum_unknownDefaultOpenApi =
    const BstocksFeeAssetChainIdEnum._('unknownDefaultOpenApi');

BstocksFeeAssetChainIdEnum _$bstocksFeeAssetChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$bstocksFeeAssetChainIdEnum_number56;
    case 'number97':
      return _$bstocksFeeAssetChainIdEnum_number97;
    case 'number31337':
      return _$bstocksFeeAssetChainIdEnum_number31337;
    case 'unknownDefaultOpenApi':
      return _$bstocksFeeAssetChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$bstocksFeeAssetChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<BstocksFeeAssetChainIdEnum> _$bstocksFeeAssetChainIdEnumValues =
    BuiltSet<BstocksFeeAssetChainIdEnum>(const <BstocksFeeAssetChainIdEnum>[
  _$bstocksFeeAssetChainIdEnum_number56,
  _$bstocksFeeAssetChainIdEnum_number97,
  _$bstocksFeeAssetChainIdEnum_number31337,
  _$bstocksFeeAssetChainIdEnum_unknownDefaultOpenApi,
]);

Serializer<BstocksFeeAssetChainIdEnum> _$bstocksFeeAssetChainIdEnumSerializer =
    _$BstocksFeeAssetChainIdEnumSerializer();

class _$BstocksFeeAssetChainIdEnumSerializer
    implements PrimitiveSerializer<BstocksFeeAssetChainIdEnum> {
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
  final Iterable<Type> types = const <Type>[BstocksFeeAssetChainIdEnum];
  @override
  final String wireName = 'BstocksFeeAssetChainIdEnum';

  @override
  Object serialize(Serializers serializers, BstocksFeeAssetChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksFeeAssetChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksFeeAssetChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BstocksFeeAsset extends BstocksFeeAsset {
  @override
  final BstocksFeeAssetChainIdEnum chainId;
  @override
  final String symbol;
  @override
  final String? tokenContract;
  @override
  final int decimals;
  @override
  final bool native_;

  factory _$BstocksFeeAsset([void Function(BstocksFeeAssetBuilder)? updates]) =>
      (BstocksFeeAssetBuilder()..update(updates))._build();

  _$BstocksFeeAsset._(
      {required this.chainId,
      required this.symbol,
      this.tokenContract,
      required this.decimals,
      required this.native_})
      : super._();
  @override
  BstocksFeeAsset rebuild(void Function(BstocksFeeAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksFeeAssetBuilder toBuilder() => BstocksFeeAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksFeeAsset &&
        chainId == other.chainId &&
        symbol == other.symbol &&
        tokenContract == other.tokenContract &&
        decimals == other.decimals &&
        native_ == other.native_;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, symbol.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jc(_$hash, native_.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksFeeAsset')
          ..add('chainId', chainId)
          ..add('symbol', symbol)
          ..add('tokenContract', tokenContract)
          ..add('decimals', decimals)
          ..add('native_', native_))
        .toString();
  }
}

class BstocksFeeAssetBuilder
    implements Builder<BstocksFeeAsset, BstocksFeeAssetBuilder> {
  _$BstocksFeeAsset? _$v;

  BstocksFeeAssetChainIdEnum? _chainId;
  BstocksFeeAssetChainIdEnum? get chainId => _$this._chainId;
  set chainId(BstocksFeeAssetChainIdEnum? chainId) => _$this._chainId = chainId;

  String? _symbol;
  String? get symbol => _$this._symbol;
  set symbol(String? symbol) => _$this._symbol = symbol;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  bool? _native_;
  bool? get native_ => _$this._native_;
  set native_(bool? native_) => _$this._native_ = native_;

  BstocksFeeAssetBuilder() {
    BstocksFeeAsset._defaults(this);
  }

  BstocksFeeAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chainId = $v.chainId;
      _symbol = $v.symbol;
      _tokenContract = $v.tokenContract;
      _decimals = $v.decimals;
      _native_ = $v.native_;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksFeeAsset other) {
    _$v = other as _$BstocksFeeAsset;
  }

  @override
  void update(void Function(BstocksFeeAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksFeeAsset build() => _build();

  _$BstocksFeeAsset _build() {
    final _$result = _$v ??
        _$BstocksFeeAsset._(
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'BstocksFeeAsset', 'chainId'),
          symbol: BuiltValueNullFieldError.checkNotNull(
              symbol, r'BstocksFeeAsset', 'symbol'),
          tokenContract: tokenContract,
          decimals: BuiltValueNullFieldError.checkNotNull(
              decimals, r'BstocksFeeAsset', 'decimals'),
          native_: BuiltValueNullFieldError.checkNotNull(
              native_, r'BstocksFeeAsset', 'native_'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
