// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_financial_asset_identity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KnownFinancialAssetIdentityStatusEnum
    _$knownFinancialAssetIdentityStatusEnum_known =
    const KnownFinancialAssetIdentityStatusEnum._('known');

KnownFinancialAssetIdentityStatusEnum
    _$knownFinancialAssetIdentityStatusEnumValueOf(String name) {
  switch (name) {
    case 'known':
      return _$knownFinancialAssetIdentityStatusEnum_known;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialAssetIdentityStatusEnum>
    _$knownFinancialAssetIdentityStatusEnumValues = BuiltSet<
        KnownFinancialAssetIdentityStatusEnum>(const <KnownFinancialAssetIdentityStatusEnum>[
  _$knownFinancialAssetIdentityStatusEnum_known,
]);

const KnownFinancialAssetIdentityNamespaceEnum
    _$knownFinancialAssetIdentityNamespaceEnum_eip155 =
    const KnownFinancialAssetIdentityNamespaceEnum._('eip155');
const KnownFinancialAssetIdentityNamespaceEnum
    _$knownFinancialAssetIdentityNamespaceEnum_hyperliquid =
    const KnownFinancialAssetIdentityNamespaceEnum._('hyperliquid');

KnownFinancialAssetIdentityNamespaceEnum
    _$knownFinancialAssetIdentityNamespaceEnumValueOf(String name) {
  switch (name) {
    case 'eip155':
      return _$knownFinancialAssetIdentityNamespaceEnum_eip155;
    case 'hyperliquid':
      return _$knownFinancialAssetIdentityNamespaceEnum_hyperliquid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialAssetIdentityNamespaceEnum>
    _$knownFinancialAssetIdentityNamespaceEnumValues = BuiltSet<
        KnownFinancialAssetIdentityNamespaceEnum>(const <KnownFinancialAssetIdentityNamespaceEnum>[
  _$knownFinancialAssetIdentityNamespaceEnum_eip155,
  _$knownFinancialAssetIdentityNamespaceEnum_hyperliquid,
]);

const KnownFinancialAssetIdentityEnvironmentEnum
    _$knownFinancialAssetIdentityEnvironmentEnum_mainnet =
    const KnownFinancialAssetIdentityEnvironmentEnum._('mainnet');
const KnownFinancialAssetIdentityEnvironmentEnum
    _$knownFinancialAssetIdentityEnvironmentEnum_testnet =
    const KnownFinancialAssetIdentityEnvironmentEnum._('testnet');

KnownFinancialAssetIdentityEnvironmentEnum
    _$knownFinancialAssetIdentityEnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$knownFinancialAssetIdentityEnvironmentEnum_mainnet;
    case 'testnet':
      return _$knownFinancialAssetIdentityEnvironmentEnum_testnet;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialAssetIdentityEnvironmentEnum>
    _$knownFinancialAssetIdentityEnvironmentEnumValues = BuiltSet<
        KnownFinancialAssetIdentityEnvironmentEnum>(const <KnownFinancialAssetIdentityEnvironmentEnum>[
  _$knownFinancialAssetIdentityEnvironmentEnum_mainnet,
  _$knownFinancialAssetIdentityEnvironmentEnum_testnet,
]);

Serializer<KnownFinancialAssetIdentityStatusEnum>
    _$knownFinancialAssetIdentityStatusEnumSerializer =
    _$KnownFinancialAssetIdentityStatusEnumSerializer();
Serializer<KnownFinancialAssetIdentityNamespaceEnum>
    _$knownFinancialAssetIdentityNamespaceEnumSerializer =
    _$KnownFinancialAssetIdentityNamespaceEnumSerializer();
Serializer<KnownFinancialAssetIdentityEnvironmentEnum>
    _$knownFinancialAssetIdentityEnvironmentEnumSerializer =
    _$KnownFinancialAssetIdentityEnvironmentEnumSerializer();

class _$KnownFinancialAssetIdentityStatusEnumSerializer
    implements PrimitiveSerializer<KnownFinancialAssetIdentityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'known': 'known',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'known': 'known',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KnownFinancialAssetIdentityStatusEnum
  ];
  @override
  final String wireName = 'KnownFinancialAssetIdentityStatusEnum';

  @override
  Object serialize(
          Serializers serializers, KnownFinancialAssetIdentityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialAssetIdentityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialAssetIdentityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialAssetIdentityNamespaceEnumSerializer
    implements PrimitiveSerializer<KnownFinancialAssetIdentityNamespaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KnownFinancialAssetIdentityNamespaceEnum
  ];
  @override
  final String wireName = 'KnownFinancialAssetIdentityNamespaceEnum';

  @override
  Object serialize(Serializers serializers,
          KnownFinancialAssetIdentityNamespaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialAssetIdentityNamespaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialAssetIdentityNamespaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialAssetIdentityEnvironmentEnumSerializer
    implements PrimitiveSerializer<KnownFinancialAssetIdentityEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KnownFinancialAssetIdentityEnvironmentEnum
  ];
  @override
  final String wireName = 'KnownFinancialAssetIdentityEnvironmentEnum';

  @override
  Object serialize(Serializers serializers,
          KnownFinancialAssetIdentityEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialAssetIdentityEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialAssetIdentityEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialAssetIdentity extends KnownFinancialAssetIdentity {
  @override
  final KnownFinancialAssetIdentityStatusEnum status;
  @override
  final String assetId;
  @override
  final KnownFinancialAssetIdentityNamespaceEnum namespace;
  @override
  final KnownFinancialAssetIdentityEnvironmentEnum? environment;
  @override
  final Chain network;
  @override
  final int chainId;
  @override
  final String token;
  @override
  final String? tokenContract;
  @override
  final int? tokenDecimals;
  @override
  final FundingAssetProvenance? provenance;

  factory _$KnownFinancialAssetIdentity(
          [void Function(KnownFinancialAssetIdentityBuilder)? updates]) =>
      (KnownFinancialAssetIdentityBuilder()..update(updates))._build();

  _$KnownFinancialAssetIdentity._(
      {required this.status,
      required this.assetId,
      required this.namespace,
      this.environment,
      required this.network,
      required this.chainId,
      required this.token,
      this.tokenContract,
      this.tokenDecimals,
      this.provenance})
      : super._();
  @override
  KnownFinancialAssetIdentity rebuild(
          void Function(KnownFinancialAssetIdentityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnownFinancialAssetIdentityBuilder toBuilder() =>
      KnownFinancialAssetIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnownFinancialAssetIdentity &&
        status == other.status &&
        assetId == other.assetId &&
        namespace == other.namespace &&
        environment == other.environment &&
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
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, assetId.hashCode);
    _$hash = $jc(_$hash, namespace.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
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
    return (newBuiltValueToStringHelper(r'KnownFinancialAssetIdentity')
          ..add('status', status)
          ..add('assetId', assetId)
          ..add('namespace', namespace)
          ..add('environment', environment)
          ..add('network', network)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('provenance', provenance))
        .toString();
  }
}

class KnownFinancialAssetIdentityBuilder
    implements
        Builder<KnownFinancialAssetIdentity,
            KnownFinancialAssetIdentityBuilder> {
  _$KnownFinancialAssetIdentity? _$v;

  KnownFinancialAssetIdentityStatusEnum? _status;
  KnownFinancialAssetIdentityStatusEnum? get status => _$this._status;
  set status(KnownFinancialAssetIdentityStatusEnum? status) =>
      _$this._status = status;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  KnownFinancialAssetIdentityNamespaceEnum? _namespace;
  KnownFinancialAssetIdentityNamespaceEnum? get namespace => _$this._namespace;
  set namespace(KnownFinancialAssetIdentityNamespaceEnum? namespace) =>
      _$this._namespace = namespace;

  KnownFinancialAssetIdentityEnvironmentEnum? _environment;
  KnownFinancialAssetIdentityEnvironmentEnum? get environment =>
      _$this._environment;
  set environment(KnownFinancialAssetIdentityEnvironmentEnum? environment) =>
      _$this._environment = environment;

  Chain? _network;
  Chain? get network => _$this._network;
  set network(Chain? network) => _$this._network = network;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

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

  KnownFinancialAssetIdentityBuilder() {
    KnownFinancialAssetIdentity._defaults(this);
  }

  KnownFinancialAssetIdentityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _assetId = $v.assetId;
      _namespace = $v.namespace;
      _environment = $v.environment;
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
  void replace(KnownFinancialAssetIdentity other) {
    _$v = other as _$KnownFinancialAssetIdentity;
  }

  @override
  void update(void Function(KnownFinancialAssetIdentityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnownFinancialAssetIdentity build() => _build();

  _$KnownFinancialAssetIdentity _build() {
    final _$result = _$v ??
        _$KnownFinancialAssetIdentity._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'KnownFinancialAssetIdentity', 'status'),
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'KnownFinancialAssetIdentity', 'assetId'),
          namespace: BuiltValueNullFieldError.checkNotNull(
              namespace, r'KnownFinancialAssetIdentity', 'namespace'),
          environment: environment,
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'KnownFinancialAssetIdentity', 'network'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'KnownFinancialAssetIdentity', 'chainId'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'KnownFinancialAssetIdentity', 'token'),
          tokenContract: tokenContract,
          tokenDecimals: tokenDecimals,
          provenance: provenance,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
