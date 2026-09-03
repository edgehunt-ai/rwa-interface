// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_authorization_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnum_order =
    const WalletAuthorizationRequestPurposeEnum._('order');
const WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnum_transfer =
    const WalletAuthorizationRequestPurposeEnum._('transfer');
const WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnum_withdrawal =
    const WalletAuthorizationRequestPurposeEnum._('withdrawal');
const WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnum_claim =
    const WalletAuthorizationRequestPurposeEnum._('claim');
const WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnum_unknownDefaultOpenApi =
    const WalletAuthorizationRequestPurposeEnum._('unknownDefaultOpenApi');

WalletAuthorizationRequestPurposeEnum
    _$walletAuthorizationRequestPurposeEnumValueOf(String name) {
  switch (name) {
    case 'order':
      return _$walletAuthorizationRequestPurposeEnum_order;
    case 'transfer':
      return _$walletAuthorizationRequestPurposeEnum_transfer;
    case 'withdrawal':
      return _$walletAuthorizationRequestPurposeEnum_withdrawal;
    case 'claim':
      return _$walletAuthorizationRequestPurposeEnum_claim;
    case 'unknownDefaultOpenApi':
      return _$walletAuthorizationRequestPurposeEnum_unknownDefaultOpenApi;
    default:
      return _$walletAuthorizationRequestPurposeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WalletAuthorizationRequestPurposeEnum>
    _$walletAuthorizationRequestPurposeEnumValues = BuiltSet<
        WalletAuthorizationRequestPurposeEnum>(const <WalletAuthorizationRequestPurposeEnum>[
  _$walletAuthorizationRequestPurposeEnum_order,
  _$walletAuthorizationRequestPurposeEnum_transfer,
  _$walletAuthorizationRequestPurposeEnum_withdrawal,
  _$walletAuthorizationRequestPurposeEnum_claim,
  _$walletAuthorizationRequestPurposeEnum_unknownDefaultOpenApi,
]);

Serializer<WalletAuthorizationRequestPurposeEnum>
    _$walletAuthorizationRequestPurposeEnumSerializer =
    _$WalletAuthorizationRequestPurposeEnumSerializer();

class _$WalletAuthorizationRequestPurposeEnumSerializer
    implements PrimitiveSerializer<WalletAuthorizationRequestPurposeEnum> {
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
  final Iterable<Type> types = const <Type>[
    WalletAuthorizationRequestPurposeEnum
  ];
  @override
  final String wireName = 'WalletAuthorizationRequestPurposeEnum';

  @override
  Object serialize(
          Serializers serializers, WalletAuthorizationRequestPurposeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WalletAuthorizationRequestPurposeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WalletAuthorizationRequestPurposeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WalletAuthorizationRequest extends WalletAuthorizationRequest {
  @override
  final WalletAuthorizationRequestPurposeEnum purpose;
  @override
  final String asset;
  @override
  final String amount;
  @override
  final String resourceId;

  factory _$WalletAuthorizationRequest(
          [void Function(WalletAuthorizationRequestBuilder)? updates]) =>
      (WalletAuthorizationRequestBuilder()..update(updates))._build();

  _$WalletAuthorizationRequest._(
      {required this.purpose,
      required this.asset,
      required this.amount,
      required this.resourceId})
      : super._();
  @override
  WalletAuthorizationRequest rebuild(
          void Function(WalletAuthorizationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WalletAuthorizationRequestBuilder toBuilder() =>
      WalletAuthorizationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WalletAuthorizationRequest &&
        purpose == other.purpose &&
        asset == other.asset &&
        amount == other.amount &&
        resourceId == other.resourceId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purpose.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, resourceId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WalletAuthorizationRequest')
          ..add('purpose', purpose)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('resourceId', resourceId))
        .toString();
  }
}

class WalletAuthorizationRequestBuilder
    implements
        Builder<WalletAuthorizationRequest, WalletAuthorizationRequestBuilder> {
  _$WalletAuthorizationRequest? _$v;

  WalletAuthorizationRequestPurposeEnum? _purpose;
  WalletAuthorizationRequestPurposeEnum? get purpose => _$this._purpose;
  set purpose(WalletAuthorizationRequestPurposeEnum? purpose) =>
      _$this._purpose = purpose;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _resourceId;
  String? get resourceId => _$this._resourceId;
  set resourceId(String? resourceId) => _$this._resourceId = resourceId;

  WalletAuthorizationRequestBuilder() {
    WalletAuthorizationRequest._defaults(this);
  }

  WalletAuthorizationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purpose = $v.purpose;
      _asset = $v.asset;
      _amount = $v.amount;
      _resourceId = $v.resourceId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WalletAuthorizationRequest other) {
    _$v = other as _$WalletAuthorizationRequest;
  }

  @override
  void update(void Function(WalletAuthorizationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WalletAuthorizationRequest build() => _build();

  _$WalletAuthorizationRequest _build() {
    final _$result = _$v ??
        _$WalletAuthorizationRequest._(
          purpose: BuiltValueNullFieldError.checkNotNull(
              purpose, r'WalletAuthorizationRequest', 'purpose'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'WalletAuthorizationRequest', 'asset'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'WalletAuthorizationRequest', 'amount'),
          resourceId: BuiltValueNullFieldError.checkNotNull(
              resourceId, r'WalletAuthorizationRequest', 'resourceId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
