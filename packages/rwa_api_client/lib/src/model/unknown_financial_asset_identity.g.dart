// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unknown_financial_asset_identity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UnknownFinancialAssetIdentityStatusEnum
    _$unknownFinancialAssetIdentityStatusEnum_unknown =
    const UnknownFinancialAssetIdentityStatusEnum._('unknown');

UnknownFinancialAssetIdentityStatusEnum
    _$unknownFinancialAssetIdentityStatusEnumValueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknownFinancialAssetIdentityStatusEnum_unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UnknownFinancialAssetIdentityStatusEnum>
    _$unknownFinancialAssetIdentityStatusEnumValues = BuiltSet<
        UnknownFinancialAssetIdentityStatusEnum>(const <UnknownFinancialAssetIdentityStatusEnum>[
  _$unknownFinancialAssetIdentityStatusEnum_unknown,
]);

const UnknownFinancialAssetIdentityNamespaceEnum
    _$unknownFinancialAssetIdentityNamespaceEnum_eip155 =
    const UnknownFinancialAssetIdentityNamespaceEnum._('eip155');
const UnknownFinancialAssetIdentityNamespaceEnum
    _$unknownFinancialAssetIdentityNamespaceEnum_hyperliquid =
    const UnknownFinancialAssetIdentityNamespaceEnum._('hyperliquid');

UnknownFinancialAssetIdentityNamespaceEnum
    _$unknownFinancialAssetIdentityNamespaceEnumValueOf(String name) {
  switch (name) {
    case 'eip155':
      return _$unknownFinancialAssetIdentityNamespaceEnum_eip155;
    case 'hyperliquid':
      return _$unknownFinancialAssetIdentityNamespaceEnum_hyperliquid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UnknownFinancialAssetIdentityNamespaceEnum>
    _$unknownFinancialAssetIdentityNamespaceEnumValues = BuiltSet<
        UnknownFinancialAssetIdentityNamespaceEnum>(const <UnknownFinancialAssetIdentityNamespaceEnum>[
  _$unknownFinancialAssetIdentityNamespaceEnum_eip155,
  _$unknownFinancialAssetIdentityNamespaceEnum_hyperliquid,
]);

const UnknownFinancialAssetIdentityEnvironmentEnum
    _$unknownFinancialAssetIdentityEnvironmentEnum_mainnet =
    const UnknownFinancialAssetIdentityEnvironmentEnum._('mainnet');
const UnknownFinancialAssetIdentityEnvironmentEnum
    _$unknownFinancialAssetIdentityEnvironmentEnum_testnet =
    const UnknownFinancialAssetIdentityEnvironmentEnum._('testnet');

UnknownFinancialAssetIdentityEnvironmentEnum
    _$unknownFinancialAssetIdentityEnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$unknownFinancialAssetIdentityEnvironmentEnum_mainnet;
    case 'testnet':
      return _$unknownFinancialAssetIdentityEnvironmentEnum_testnet;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UnknownFinancialAssetIdentityEnvironmentEnum>
    _$unknownFinancialAssetIdentityEnvironmentEnumValues = BuiltSet<
        UnknownFinancialAssetIdentityEnvironmentEnum>(const <UnknownFinancialAssetIdentityEnvironmentEnum>[
  _$unknownFinancialAssetIdentityEnvironmentEnum_mainnet,
  _$unknownFinancialAssetIdentityEnvironmentEnum_testnet,
]);

Serializer<UnknownFinancialAssetIdentityStatusEnum>
    _$unknownFinancialAssetIdentityStatusEnumSerializer =
    _$UnknownFinancialAssetIdentityStatusEnumSerializer();
Serializer<UnknownFinancialAssetIdentityNamespaceEnum>
    _$unknownFinancialAssetIdentityNamespaceEnumSerializer =
    _$UnknownFinancialAssetIdentityNamespaceEnumSerializer();
Serializer<UnknownFinancialAssetIdentityEnvironmentEnum>
    _$unknownFinancialAssetIdentityEnvironmentEnumSerializer =
    _$UnknownFinancialAssetIdentityEnvironmentEnumSerializer();

class _$UnknownFinancialAssetIdentityStatusEnumSerializer
    implements PrimitiveSerializer<UnknownFinancialAssetIdentityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UnknownFinancialAssetIdentityStatusEnum
  ];
  @override
  final String wireName = 'UnknownFinancialAssetIdentityStatusEnum';

  @override
  Object serialize(Serializers serializers,
          UnknownFinancialAssetIdentityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnknownFinancialAssetIdentityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnknownFinancialAssetIdentityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnknownFinancialAssetIdentityNamespaceEnumSerializer
    implements PrimitiveSerializer<UnknownFinancialAssetIdentityNamespaceEnum> {
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
    UnknownFinancialAssetIdentityNamespaceEnum
  ];
  @override
  final String wireName = 'UnknownFinancialAssetIdentityNamespaceEnum';

  @override
  Object serialize(Serializers serializers,
          UnknownFinancialAssetIdentityNamespaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnknownFinancialAssetIdentityNamespaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnknownFinancialAssetIdentityNamespaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnknownFinancialAssetIdentityEnvironmentEnumSerializer
    implements
        PrimitiveSerializer<UnknownFinancialAssetIdentityEnvironmentEnum> {
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
    UnknownFinancialAssetIdentityEnvironmentEnum
  ];
  @override
  final String wireName = 'UnknownFinancialAssetIdentityEnvironmentEnum';

  @override
  Object serialize(Serializers serializers,
          UnknownFinancialAssetIdentityEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UnknownFinancialAssetIdentityEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UnknownFinancialAssetIdentityEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UnknownFinancialAssetIdentity extends UnknownFinancialAssetIdentity {
  @override
  final UnknownFinancialAssetIdentityStatusEnum status;
  @override
  final String reason;
  @override
  final UnknownFinancialAssetIdentityNamespaceEnum? namespace;
  @override
  final UnknownFinancialAssetIdentityEnvironmentEnum? environment;
  @override
  final Chain? network;
  @override
  final int? chainId;
  @override
  final String? tokenContract;
  @override
  final String? observedAssetRef;

  factory _$UnknownFinancialAssetIdentity(
          [void Function(UnknownFinancialAssetIdentityBuilder)? updates]) =>
      (UnknownFinancialAssetIdentityBuilder()..update(updates))._build();

  _$UnknownFinancialAssetIdentity._(
      {required this.status,
      required this.reason,
      this.namespace,
      this.environment,
      this.network,
      this.chainId,
      this.tokenContract,
      this.observedAssetRef})
      : super._();
  @override
  UnknownFinancialAssetIdentity rebuild(
          void Function(UnknownFinancialAssetIdentityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnknownFinancialAssetIdentityBuilder toBuilder() =>
      UnknownFinancialAssetIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnknownFinancialAssetIdentity &&
        status == other.status &&
        reason == other.reason &&
        namespace == other.namespace &&
        environment == other.environment &&
        network == other.network &&
        chainId == other.chainId &&
        tokenContract == other.tokenContract &&
        observedAssetRef == other.observedAssetRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, namespace.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, observedAssetRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnknownFinancialAssetIdentity')
          ..add('status', status)
          ..add('reason', reason)
          ..add('namespace', namespace)
          ..add('environment', environment)
          ..add('network', network)
          ..add('chainId', chainId)
          ..add('tokenContract', tokenContract)
          ..add('observedAssetRef', observedAssetRef))
        .toString();
  }
}

class UnknownFinancialAssetIdentityBuilder
    implements
        Builder<UnknownFinancialAssetIdentity,
            UnknownFinancialAssetIdentityBuilder> {
  _$UnknownFinancialAssetIdentity? _$v;

  UnknownFinancialAssetIdentityStatusEnum? _status;
  UnknownFinancialAssetIdentityStatusEnum? get status => _$this._status;
  set status(UnknownFinancialAssetIdentityStatusEnum? status) =>
      _$this._status = status;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  UnknownFinancialAssetIdentityNamespaceEnum? _namespace;
  UnknownFinancialAssetIdentityNamespaceEnum? get namespace =>
      _$this._namespace;
  set namespace(UnknownFinancialAssetIdentityNamespaceEnum? namespace) =>
      _$this._namespace = namespace;

  UnknownFinancialAssetIdentityEnvironmentEnum? _environment;
  UnknownFinancialAssetIdentityEnvironmentEnum? get environment =>
      _$this._environment;
  set environment(UnknownFinancialAssetIdentityEnvironmentEnum? environment) =>
      _$this._environment = environment;

  Chain? _network;
  Chain? get network => _$this._network;
  set network(Chain? network) => _$this._network = network;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  String? _observedAssetRef;
  String? get observedAssetRef => _$this._observedAssetRef;
  set observedAssetRef(String? observedAssetRef) =>
      _$this._observedAssetRef = observedAssetRef;

  UnknownFinancialAssetIdentityBuilder() {
    UnknownFinancialAssetIdentity._defaults(this);
  }

  UnknownFinancialAssetIdentityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _reason = $v.reason;
      _namespace = $v.namespace;
      _environment = $v.environment;
      _network = $v.network;
      _chainId = $v.chainId;
      _tokenContract = $v.tokenContract;
      _observedAssetRef = $v.observedAssetRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnknownFinancialAssetIdentity other) {
    _$v = other as _$UnknownFinancialAssetIdentity;
  }

  @override
  void update(void Function(UnknownFinancialAssetIdentityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnknownFinancialAssetIdentity build() => _build();

  _$UnknownFinancialAssetIdentity _build() {
    final _$result = _$v ??
        _$UnknownFinancialAssetIdentity._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'UnknownFinancialAssetIdentity', 'status'),
          reason: BuiltValueNullFieldError.checkNotNull(
              reason, r'UnknownFinancialAssetIdentity', 'reason'),
          namespace: namespace,
          environment: environment,
          network: network,
          chainId: chainId,
          tokenContract: tokenContract,
          observedAssetRef: observedAssetRef,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
