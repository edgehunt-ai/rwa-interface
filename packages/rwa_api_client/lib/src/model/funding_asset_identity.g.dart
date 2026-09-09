// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_asset_identity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingAssetIdentityNamespaceEnum
    _$fundingAssetIdentityNamespaceEnum_eip155 =
    const FundingAssetIdentityNamespaceEnum._('eip155');
const FundingAssetIdentityNamespaceEnum
    _$fundingAssetIdentityNamespaceEnum_hyperliquid =
    const FundingAssetIdentityNamespaceEnum._('hyperliquid');
const FundingAssetIdentityNamespaceEnum
    _$fundingAssetIdentityNamespaceEnum_unknownDefaultOpenApi =
    const FundingAssetIdentityNamespaceEnum._('unknownDefaultOpenApi');

FundingAssetIdentityNamespaceEnum _$fundingAssetIdentityNamespaceEnumValueOf(
    String name) {
  switch (name) {
    case 'eip155':
      return _$fundingAssetIdentityNamespaceEnum_eip155;
    case 'hyperliquid':
      return _$fundingAssetIdentityNamespaceEnum_hyperliquid;
    case 'unknownDefaultOpenApi':
      return _$fundingAssetIdentityNamespaceEnum_unknownDefaultOpenApi;
    default:
      return _$fundingAssetIdentityNamespaceEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingAssetIdentityNamespaceEnum>
    _$fundingAssetIdentityNamespaceEnumValues = BuiltSet<
        FundingAssetIdentityNamespaceEnum>(const <FundingAssetIdentityNamespaceEnum>[
  _$fundingAssetIdentityNamespaceEnum_eip155,
  _$fundingAssetIdentityNamespaceEnum_hyperliquid,
  _$fundingAssetIdentityNamespaceEnum_unknownDefaultOpenApi,
]);

const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_number1 =
    const FundingAssetIdentityChainIdEnum._('number1');
const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_number56 =
    const FundingAssetIdentityChainIdEnum._('number56');
const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_number1337 =
    const FundingAssetIdentityChainIdEnum._('number1337');
const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_number8453 =
    const FundingAssetIdentityChainIdEnum._('number8453');
const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_number42161 =
    const FundingAssetIdentityChainIdEnum._('number42161');
const FundingAssetIdentityChainIdEnum
    _$fundingAssetIdentityChainIdEnum_unknownDefaultOpenApi =
    const FundingAssetIdentityChainIdEnum._('unknownDefaultOpenApi');

FundingAssetIdentityChainIdEnum _$fundingAssetIdentityChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$fundingAssetIdentityChainIdEnum_number1;
    case 'number56':
      return _$fundingAssetIdentityChainIdEnum_number56;
    case 'number1337':
      return _$fundingAssetIdentityChainIdEnum_number1337;
    case 'number8453':
      return _$fundingAssetIdentityChainIdEnum_number8453;
    case 'number42161':
      return _$fundingAssetIdentityChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$fundingAssetIdentityChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$fundingAssetIdentityChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingAssetIdentityChainIdEnum>
    _$fundingAssetIdentityChainIdEnumValues = BuiltSet<
        FundingAssetIdentityChainIdEnum>(const <FundingAssetIdentityChainIdEnum>[
  _$fundingAssetIdentityChainIdEnum_number1,
  _$fundingAssetIdentityChainIdEnum_number56,
  _$fundingAssetIdentityChainIdEnum_number1337,
  _$fundingAssetIdentityChainIdEnum_number8453,
  _$fundingAssetIdentityChainIdEnum_number42161,
  _$fundingAssetIdentityChainIdEnum_unknownDefaultOpenApi,
]);

Serializer<FundingAssetIdentityNamespaceEnum>
    _$fundingAssetIdentityNamespaceEnumSerializer =
    _$FundingAssetIdentityNamespaceEnumSerializer();
Serializer<FundingAssetIdentityChainIdEnum>
    _$fundingAssetIdentityChainIdEnumSerializer =
    _$FundingAssetIdentityChainIdEnumSerializer();

class _$FundingAssetIdentityNamespaceEnumSerializer
    implements PrimitiveSerializer<FundingAssetIdentityNamespaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingAssetIdentityNamespaceEnum];
  @override
  final String wireName = 'FundingAssetIdentityNamespaceEnum';

  @override
  Object serialize(
          Serializers serializers, FundingAssetIdentityNamespaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingAssetIdentityNamespaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingAssetIdentityNamespaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingAssetIdentityChainIdEnumSerializer
    implements PrimitiveSerializer<FundingAssetIdentityChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
    'number56': 56,
    'number1337': 1337,
    'number8453': 8453,
    'number42161': 42161,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
    56: 'number56',
    1337: 'number1337',
    8453: 'number8453',
    42161: 'number42161',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[FundingAssetIdentityChainIdEnum];
  @override
  final String wireName = 'FundingAssetIdentityChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, FundingAssetIdentityChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingAssetIdentityChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingAssetIdentityChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingAssetIdentity extends FundingAssetIdentity {
  @override
  final String assetId;
  @override
  final FundingAssetIdentityNamespaceEnum namespace;
  @override
  final Chain network;
  @override
  final FundingAssetIdentityChainIdEnum chainId;
  @override
  final String token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final FundingAssetProvenance provenance;

  factory _$FundingAssetIdentity(
          [void Function(FundingAssetIdentityBuilder)? updates]) =>
      (FundingAssetIdentityBuilder()..update(updates))._build();

  _$FundingAssetIdentity._(
      {required this.assetId,
      required this.namespace,
      required this.network,
      required this.chainId,
      required this.token,
      required this.tokenContract,
      required this.tokenDecimals,
      required this.provenance})
      : super._();
  @override
  FundingAssetIdentity rebuild(
          void Function(FundingAssetIdentityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingAssetIdentityBuilder toBuilder() =>
      FundingAssetIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingAssetIdentity &&
        assetId == other.assetId &&
        namespace == other.namespace &&
        network == other.network &&
        chainId == other.chainId &&
        token == other.token &&
        tokenContract == other.tokenContract &&
        tokenDecimals == other.tokenDecimals &&
        provenance == other.provenance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, namespace.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, tokenDecimals.hashCode);
    _$hash = $jc(_$hash, provenance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingAssetIdentity')
          ..add('assetId', assetId)
          ..add('namespace', namespace)
          ..add('network', network)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('provenance', provenance))
        .toString();
  }
}

class FundingAssetIdentityBuilder
    implements Builder<FundingAssetIdentity, FundingAssetIdentityBuilder> {
  _$FundingAssetIdentity? _$v;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  FundingAssetIdentityNamespaceEnum? _namespace;
  FundingAssetIdentityNamespaceEnum? get namespace => _$this._namespace;
  set namespace(FundingAssetIdentityNamespaceEnum? namespace) =>
      _$this._namespace = namespace;

  Chain? _network;
  Chain? get network => _$this._network;
  set network(Chain? network) => _$this._network = network;

  FundingAssetIdentityChainIdEnum? _chainId;
  FundingAssetIdentityChainIdEnum? get chainId => _$this._chainId;
  set chainId(FundingAssetIdentityChainIdEnum? chainId) =>
      _$this._chainId = chainId;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _tokenDecimals;
  int? get tokenDecimals => _$this._tokenDecimals;
  set tokenDecimals(int? tokenDecimals) =>
      _$this._tokenDecimals = tokenDecimals;

  FundingAssetProvenance? _provenance;
  FundingAssetProvenance? get provenance => _$this._provenance;
  set provenance(FundingAssetProvenance? provenance) =>
      _$this._provenance = provenance;

  FundingAssetIdentityBuilder() {
    FundingAssetIdentity._defaults(this);
  }

  FundingAssetIdentityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assetId = $v.assetId;
      _namespace = $v.namespace;
      _network = $v.network;
      _chainId = $v.chainId;
      _token = $v.token;
      _tokenContract = $v.tokenContract;
      _tokenDecimals = $v.tokenDecimals;
      _provenance = $v.provenance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingAssetIdentity other) {
    _$v = other as _$FundingAssetIdentity;
  }

  @override
  void update(void Function(FundingAssetIdentityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingAssetIdentity build() => _build();

  _$FundingAssetIdentity _build() {
    final _$result = _$v ??
        _$FundingAssetIdentity._(
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'FundingAssetIdentity', 'assetId'),
          namespace: BuiltValueNullFieldError.checkNotNull(
              namespace, r'FundingAssetIdentity', 'namespace'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'FundingAssetIdentity', 'network'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'FundingAssetIdentity', 'chainId'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'FundingAssetIdentity', 'token'),
          tokenContract: BuiltValueNullFieldError.checkNotNull(
              tokenContract, r'FundingAssetIdentity', 'tokenContract'),
          tokenDecimals: BuiltValueNullFieldError.checkNotNull(
              tokenDecimals, r'FundingAssetIdentity', 'tokenDecimals'),
          provenance: BuiltValueNullFieldError.checkNotNull(
              provenance, r'FundingAssetIdentity', 'provenance'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
