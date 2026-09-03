// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_authorization.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletAuthorizationPurposeEnum _$walletAuthorizationPurposeEnum_order =
    const WalletAuthorizationPurposeEnum._('order');
const WalletAuthorizationPurposeEnum _$walletAuthorizationPurposeEnum_transfer =
    const WalletAuthorizationPurposeEnum._('transfer');
const WalletAuthorizationPurposeEnum
    _$walletAuthorizationPurposeEnum_withdrawal =
    const WalletAuthorizationPurposeEnum._('withdrawal');
const WalletAuthorizationPurposeEnum _$walletAuthorizationPurposeEnum_claim =
    const WalletAuthorizationPurposeEnum._('claim');
const WalletAuthorizationPurposeEnum
    _$walletAuthorizationPurposeEnum_unknownDefaultOpenApi =
    const WalletAuthorizationPurposeEnum._('unknownDefaultOpenApi');

WalletAuthorizationPurposeEnum _$walletAuthorizationPurposeEnumValueOf(
    String name) {
  switch (name) {
    case 'order':
      return _$walletAuthorizationPurposeEnum_order;
    case 'transfer':
      return _$walletAuthorizationPurposeEnum_transfer;
    case 'withdrawal':
      return _$walletAuthorizationPurposeEnum_withdrawal;
    case 'claim':
      return _$walletAuthorizationPurposeEnum_claim;
    case 'unknownDefaultOpenApi':
      return _$walletAuthorizationPurposeEnum_unknownDefaultOpenApi;
    default:
      return _$walletAuthorizationPurposeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletAuthorizationPurposeEnum>
    _$walletAuthorizationPurposeEnumValues = BuiltSet<
        WalletAuthorizationPurposeEnum>(const <WalletAuthorizationPurposeEnum>[
  _$walletAuthorizationPurposeEnum_order,
  _$walletAuthorizationPurposeEnum_transfer,
  _$walletAuthorizationPurposeEnum_withdrawal,
  _$walletAuthorizationPurposeEnum_claim,
  _$walletAuthorizationPurposeEnum_unknownDefaultOpenApi,
]);

const WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnum_pending =
    const WalletAuthorizationStatusEnum._('pending');
const WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnum_authorized =
    const WalletAuthorizationStatusEnum._('authorized');
const WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnum_consumed =
    const WalletAuthorizationStatusEnum._('consumed');
const WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnum_expired =
    const WalletAuthorizationStatusEnum._('expired');
const WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnum_failed =
    const WalletAuthorizationStatusEnum._('failed');
const WalletAuthorizationStatusEnum
    _$walletAuthorizationStatusEnum_unknownDefaultOpenApi =
    const WalletAuthorizationStatusEnum._('unknownDefaultOpenApi');

WalletAuthorizationStatusEnum _$walletAuthorizationStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'pending':
      return _$walletAuthorizationStatusEnum_pending;
    case 'authorized':
      return _$walletAuthorizationStatusEnum_authorized;
    case 'consumed':
      return _$walletAuthorizationStatusEnum_consumed;
    case 'expired':
      return _$walletAuthorizationStatusEnum_expired;
    case 'failed':
      return _$walletAuthorizationStatusEnum_failed;
    case 'unknownDefaultOpenApi':
      return _$walletAuthorizationStatusEnum_unknownDefaultOpenApi;
    default:
      return _$walletAuthorizationStatusEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletAuthorizationStatusEnum>
    _$walletAuthorizationStatusEnumValues = BuiltSet<
        WalletAuthorizationStatusEnum>(const <WalletAuthorizationStatusEnum>[
  _$walletAuthorizationStatusEnum_pending,
  _$walletAuthorizationStatusEnum_authorized,
  _$walletAuthorizationStatusEnum_consumed,
  _$walletAuthorizationStatusEnum_expired,
  _$walletAuthorizationStatusEnum_failed,
  _$walletAuthorizationStatusEnum_unknownDefaultOpenApi,
]);

Serializer<WalletAuthorizationPurposeEnum>
    _$walletAuthorizationPurposeEnumSerializer =
    _$WalletAuthorizationPurposeEnumSerializer();
Serializer<WalletAuthorizationStatusEnum>
    _$walletAuthorizationStatusEnumSerializer =
    _$WalletAuthorizationStatusEnumSerializer();

class _$WalletAuthorizationPurposeEnumSerializer
    implements PrimitiveSerializer<WalletAuthorizationPurposeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'order': 'order',
    'transfer': 'transfer',
    'withdrawal': 'withdrawal',
    'claim': 'claim',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order': 'order',
    'transfer': 'transfer',
    'withdrawal': 'withdrawal',
    'claim': 'claim',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletAuthorizationPurposeEnum];
  @override
  final String wireName = 'WalletAuthorizationPurposeEnum';

  @override
  Object serialize(
          Serializers serializers, WalletAuthorizationPurposeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletAuthorizationPurposeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletAuthorizationPurposeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WalletAuthorizationStatusEnumSerializer
    implements PrimitiveSerializer<WalletAuthorizationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'authorized': 'authorized',
    'consumed': 'consumed',
    'expired': 'expired',
    'failed': 'failed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'authorized': 'authorized',
    'consumed': 'consumed',
    'expired': 'expired',
    'failed': 'failed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WalletAuthorizationStatusEnum];
  @override
  final String wireName = 'WalletAuthorizationStatusEnum';

  @override
  Object serialize(
          Serializers serializers, WalletAuthorizationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletAuthorizationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletAuthorizationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WalletAuthorization extends WalletAuthorization {
  @override
  final String authorizationId;
  @override
  final String walletId;
  @override
  final WalletAuthorizationPurposeEnum purpose;
  @override
  final WalletAuthorizationStatusEnum status;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiresAt;

  factory _$WalletAuthorization(
          [void Function(WalletAuthorizationBuilder)? updates]) =>
      (WalletAuthorizationBuilder()..update(updates))._build();

  _$WalletAuthorization._(
      {required this.authorizationId,
      required this.walletId,
      required this.purpose,
      required this.status,
      required this.createdAt,
      required this.expiresAt})
      : super._();
  @override
  WalletAuthorization rebuild(
          void Function(WalletAuthorizationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletAuthorizationBuilder toBuilder() =>
      WalletAuthorizationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletAuthorization &&
        authorizationId == other.authorizationId &&
        walletId == other.walletId &&
        purpose == other.purpose &&
        status == other.status &&
        createdAt == other.createdAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletAuthorization')
          ..add('authorizationId', authorizationId)
          ..add('walletId', walletId)
          ..add('purpose', purpose)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class WalletAuthorizationBuilder
    implements Builder<WalletAuthorization, WalletAuthorizationBuilder> {
  _$WalletAuthorization? _$v;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  WalletAuthorizationPurposeEnum? _purpose;
  WalletAuthorizationPurposeEnum? get purpose => _$this._purpose;
  set purpose(WalletAuthorizationPurposeEnum? purpose) =>
      _$this._purpose = purpose;

  WalletAuthorizationStatusEnum? _status;
  WalletAuthorizationStatusEnum? get status => _$this._status;
  set status(WalletAuthorizationStatusEnum? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  WalletAuthorizationBuilder() {
    WalletAuthorization._defaults(this);
  }

  WalletAuthorizationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorizationId = $v.authorizationId;
      _walletId = $v.walletId;
      _purpose = $v.purpose;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletAuthorization other) {
    _$v = other as _$WalletAuthorization;
  }

  @override
  void update(void Function(WalletAuthorizationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletAuthorization build() => _build();

  _$WalletAuthorization _build() {
    final _$result = _$v ??
        _$WalletAuthorization._(
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId, r'WalletAuthorization', 'authorizationId'),
          walletId: BuiltValueNullFieldError.checkNotNull(
              walletId, r'WalletAuthorization', 'walletId'),
          purpose: BuiltValueNullFieldError.checkNotNull(
              purpose, r'WalletAuthorization', 'purpose'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'WalletAuthorization', 'status'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'WalletAuthorization', 'createdAt'),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'WalletAuthorization', 'expiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
