// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_challenge.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ChallengeNetworkEnum _$hip3ChallengeNetworkEnum_arbitrum =
    const Hip3ChallengeNetworkEnum._('arbitrum');
const Hip3ChallengeNetworkEnum
    _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi =
    const Hip3ChallengeNetworkEnum._('unknownDefaultOpenApi');

Hip3ChallengeNetworkEnum _$hip3ChallengeNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$hip3ChallengeNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ChallengeNetworkEnum> _$hip3ChallengeNetworkEnumValues =
    BuiltSet<Hip3ChallengeNetworkEnum>(const <Hip3ChallengeNetworkEnum>[
  _$hip3ChallengeNetworkEnum_arbitrum,
  _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi,
]);

const Hip3ChallengeSettlementAssetEnum _$hip3ChallengeSettlementAssetEnum_USDC =
    const Hip3ChallengeSettlementAssetEnum._('USDC');
const Hip3ChallengeSettlementAssetEnum
    _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi =
    const Hip3ChallengeSettlementAssetEnum._('unknownDefaultOpenApi');

Hip3ChallengeSettlementAssetEnum _$hip3ChallengeSettlementAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$hip3ChallengeSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ChallengeSettlementAssetEnum>
    _$hip3ChallengeSettlementAssetEnumValues = BuiltSet<
        Hip3ChallengeSettlementAssetEnum>(const <Hip3ChallengeSettlementAssetEnum>[
  _$hip3ChallengeSettlementAssetEnum_USDC,
  _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi,
]);

const Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnum_pendingSignature =
    const Hip3ChallengeStatusEnum._('pendingSignature');
const Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnum_completed =
    const Hip3ChallengeStatusEnum._('completed');
const Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnum_expired =
    const Hip3ChallengeStatusEnum._('expired');
const Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnum_failed =
    const Hip3ChallengeStatusEnum._('failed');
const Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnum_unknownDefaultOpenApi =
    const Hip3ChallengeStatusEnum._('unknownDefaultOpenApi');

Hip3ChallengeStatusEnum _$hip3ChallengeStatusEnumValueOf(String name) {
  switch (name) {
    case 'pendingSignature':
      return _$hip3ChallengeStatusEnum_pendingSignature;
    case 'completed':
      return _$hip3ChallengeStatusEnum_completed;
    case 'expired':
      return _$hip3ChallengeStatusEnum_expired;
    case 'failed':
      return _$hip3ChallengeStatusEnum_failed;
    case 'unknownDefaultOpenApi':
      return _$hip3ChallengeStatusEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ChallengeStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ChallengeStatusEnum> _$hip3ChallengeStatusEnumValues =
    BuiltSet<Hip3ChallengeStatusEnum>(const <Hip3ChallengeStatusEnum>[
  _$hip3ChallengeStatusEnum_pendingSignature,
  _$hip3ChallengeStatusEnum_completed,
  _$hip3ChallengeStatusEnum_expired,
  _$hip3ChallengeStatusEnum_failed,
  _$hip3ChallengeStatusEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ChallengeNetworkEnum> _$hip3ChallengeNetworkEnumSerializer =
    _$Hip3ChallengeNetworkEnumSerializer();
Serializer<Hip3ChallengeSettlementAssetEnum>
    _$hip3ChallengeSettlementAssetEnumSerializer =
    _$Hip3ChallengeSettlementAssetEnumSerializer();
Serializer<Hip3ChallengeStatusEnum> _$hip3ChallengeStatusEnumSerializer =
    _$Hip3ChallengeStatusEnumSerializer();

class _$Hip3ChallengeNetworkEnumSerializer
    implements PrimitiveSerializer<Hip3ChallengeNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ChallengeNetworkEnum];
  @override
  final String wireName = 'Hip3ChallengeNetworkEnum';

  @override
  Object serialize(Serializers serializers, Hip3ChallengeNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ChallengeNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ChallengeNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ChallengeSettlementAssetEnumSerializer
    implements PrimitiveSerializer<Hip3ChallengeSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ChallengeSettlementAssetEnum];
  @override
  final String wireName = 'Hip3ChallengeSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ChallengeSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ChallengeSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ChallengeSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ChallengeStatusEnumSerializer
    implements PrimitiveSerializer<Hip3ChallengeStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pendingSignature': 'pending_signature',
    'completed': 'completed',
    'expired': 'expired',
    'failed': 'failed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending_signature': 'pendingSignature',
    'completed': 'completed',
    'expired': 'expired',
    'failed': 'failed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ChallengeStatusEnum];
  @override
  final String wireName = 'Hip3ChallengeStatusEnum';

  @override
  Object serialize(Serializers serializers, Hip3ChallengeStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ChallengeStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ChallengeStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Challenge extends Hip3Challenge {
  @override
  final String challengeId;
  @override
  final Hip3ChallengeNetworkEnum network;
  @override
  final Hip3ChallengeSettlementAssetEnum? settlementAsset;
  @override
  final Hip3ChallengeStatusEnum status;
  @override
  final String message;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;

  factory _$Hip3Challenge([void Function(Hip3ChallengeBuilder)? updates]) =>
      (Hip3ChallengeBuilder()..update(updates))._build();

  _$Hip3Challenge._(
      {required this.challengeId,
      required this.network,
      this.settlementAsset,
      required this.status,
      required this.message,
      required this.createdAt,
      required this.expiresAt})
      : super._();
  @override
  Hip3Challenge rebuild(void Function(Hip3ChallengeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ChallengeBuilder toBuilder() => Hip3ChallengeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Challenge &&
        challengeId == other.challengeId &&
        network == other.network &&
        settlementAsset == other.settlementAsset &&
        status == other.status &&
        message == other.message &&
        createdAt == other.createdAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challengeId.hashCode);
    _$hash = $jc(_$hash, network.hashCode);
    _$hash = $jc(_$hash, settlementAsset.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Challenge')
          ..add('challengeId', challengeId)
          ..add('network', network)
          ..add('settlementAsset', settlementAsset)
          ..add('status', status)
          ..add('message', message)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class Hip3ChallengeBuilder
    implements Builder<Hip3Challenge, Hip3ChallengeBuilder> {
  _$Hip3Challenge? _$v;

  String? _challengeId;
  String? get challengeId => _$this._challengeId;
  set challengeId(String? challengeId) => _$this._challengeId = challengeId;

  Hip3ChallengeNetworkEnum? _network;
  Hip3ChallengeNetworkEnum? get network => _$this._network;
  set network(Hip3ChallengeNetworkEnum? network) => _$this._network = network;

  Hip3ChallengeSettlementAssetEnum? _settlementAsset;
  Hip3ChallengeSettlementAssetEnum? get settlementAsset =>
      _$this._settlementAsset;
  set settlementAsset(Hip3ChallengeSettlementAssetEnum? settlementAsset) =>
      _$this._settlementAsset = settlementAsset;

  Hip3ChallengeStatusEnum? _status;
  Hip3ChallengeStatusEnum? get status => _$this._status;
  set status(Hip3ChallengeStatusEnum? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  Hip3ChallengeBuilder() {
    Hip3Challenge._defaults(this);
  }

  Hip3ChallengeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challengeId = $v.challengeId;
      _network = $v.network;
      _settlementAsset = $v.settlementAsset;
      _status = $v.status;
      _message = $v.message;
      _createdAt = $v.createdAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Challenge other) {
    _$v = other as _$Hip3Challenge;
  }

  @override
  void update(void Function(Hip3ChallengeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Challenge build() => _build();

  _$Hip3Challenge _build() {
    final _$result = _$v ??
        _$Hip3Challenge._(
          challengeId: BuiltValueNullFieldError.checkNotNull(
              challengeId, r'Hip3Challenge', 'challengeId'),
          network: BuiltValueNullFieldError.checkNotNull(
              network, r'Hip3Challenge', 'network'),
          settlementAsset: settlementAsset,
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Hip3Challenge', 'status'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'Hip3Challenge', 'message'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Hip3Challenge', 'createdAt'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Hip3Challenge', 'expiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
