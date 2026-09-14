// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_asset_identity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourceAssetIdentity extends FundingSourceAssetIdentity {
  @override
  final String assetId;
  @override
  final String namespace;
  @override
  final String network;
  @override
  final int chainId;
  @override
  final String token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final String provenance;

  factory _$FundingSourceAssetIdentity(
          [void Function(FundingSourceAssetIdentityBuilder)? updates]) =>
      (FundingSourceAssetIdentityBuilder()..update(updates))._build();

  _$FundingSourceAssetIdentity._(
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
  FundingSourceAssetIdentity rebuild(
          void Function(FundingSourceAssetIdentityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceAssetIdentityBuilder toBuilder() =>
      FundingSourceAssetIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceAssetIdentity &&
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
    return (newBuiltValueToStringHelper(r'FundingSourceAssetIdentity')
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

class FundingSourceAssetIdentityBuilder
    implements
        Builder<FundingSourceAssetIdentity, FundingSourceAssetIdentityBuilder> {
  _$FundingSourceAssetIdentity? _$v;

  String? _assetId;
  String? get assetId => _$this._assetId;
  set assetId(String? assetId) => _$this._assetId = assetId;

  String? _namespace;
  String? get namespace => _$this._namespace;
  set namespace(String? namespace) => _$this._namespace = namespace;

  String? _network;
  String? get network => _$this._network;
  set network(String? network) => _$this._network = network;

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

  String? _provenance;
  String? get provenance => _$this._provenance;
  set provenance(String? provenance) => _$this._provenance = provenance;

  FundingSourceAssetIdentityBuilder() {
    FundingSourceAssetIdentity._defaults(this);
  }

  FundingSourceAssetIdentityBuilder get _$this {
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
  void replace(FundingSourceAssetIdentity other) {
    _$v = other as _$FundingSourceAssetIdentity;
  }

  @override
  void update(void Function(FundingSourceAssetIdentityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceAssetIdentity build() => _build();

  _$FundingSourceAssetIdentity _build() {
    final _$result = _$v ??
        _$FundingSourceAssetIdentity._(
          assetId: BuiltValueNullFieldError.checkNotNull(
              assetId, r'FundingSourceAssetIdentity', 'assetId'),
          namespace: BuiltValueNullFieldError.checkNotNull(
              namespace, r'FundingSourceAssetIdentity', 'namespace'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'FundingSourceAssetIdentity', 'network'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'FundingSourceAssetIdentity', 'chainId'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'FundingSourceAssetIdentity', 'token'),
          tokenContract: BuiltValueNullFieldError.checkNotNull(
              tokenContract, r'FundingSourceAssetIdentity', 'tokenContract'),
          tokenDecimals: BuiltValueNullFieldError.checkNotNull(
              tokenDecimals, r'FundingSourceAssetIdentity', 'tokenDecimals'),
          provenance: BuiltValueNullFieldError.checkNotNull(
              provenance, r'FundingSourceAssetIdentity', 'provenance'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
