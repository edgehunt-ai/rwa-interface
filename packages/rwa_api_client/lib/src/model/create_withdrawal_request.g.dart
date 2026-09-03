// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_withdrawal_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateWithdrawalRequestAssetEnum _$createWithdrawalRequestAssetEnum_USDC =
    const CreateWithdrawalRequestAssetEnum._('USDC');
const CreateWithdrawalRequestAssetEnum
    _$createWithdrawalRequestAssetEnum_unknownDefaultOpenApi =
    const CreateWithdrawalRequestAssetEnum._('unknownDefaultOpenApi');

CreateWithdrawalRequestAssetEnum _$createWithdrawalRequestAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$createWithdrawalRequestAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$createWithdrawalRequestAssetEnum_unknownDefaultOpenApi;
    default:
      return _$createWithdrawalRequestAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateWithdrawalRequestAssetEnum>
    _$createWithdrawalRequestAssetEnumValues = BuiltSet<
        CreateWithdrawalRequestAssetEnum>(const <CreateWithdrawalRequestAssetEnum>[
  _$createWithdrawalRequestAssetEnum_USDC,
  _$createWithdrawalRequestAssetEnum_unknownDefaultOpenApi,
]);

Serializer<CreateWithdrawalRequestAssetEnum>
    _$createWithdrawalRequestAssetEnumSerializer =
    _$CreateWithdrawalRequestAssetEnumSerializer();

class _$CreateWithdrawalRequestAssetEnumSerializer
    implements PrimitiveSerializer<CreateWithdrawalRequestAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateWithdrawalRequestAssetEnum];
  @override
  final String wireName = 'CreateWithdrawalRequestAssetEnum';

  @override
  Object serialize(
          Serializers serializers, CreateWithdrawalRequestAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateWithdrawalRequestAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateWithdrawalRequestAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateWithdrawalRequest extends CreateWithdrawalRequest {
  @override
  final CreateWithdrawalRequestAssetEnum asset;
  @override
  final Chain chain;
  @override
  final String amount;
  @override
  final String address;
  @override
  final String authorizationId;
  @override
  final String? memo;
  @override
  final String quoteId;
  @override
  final bool? saveAddress;
  @override
  final String? addressLabel;

  factory _$CreateWithdrawalRequest(
          [void Function(CreateWithdrawalRequestBuilder)? updates]) =>
      (CreateWithdrawalRequestBuilder()..update(updates))._build();

  _$CreateWithdrawalRequest._(
      {required this.asset,
      required this.chain,
      required this.amount,
      required this.address,
      required this.authorizationId,
      this.memo,
      required this.quoteId,
      this.saveAddress,
      this.addressLabel})
      : super._();
  @override
  CreateWithdrawalRequest rebuild(
          void Function(CreateWithdrawalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateWithdrawalRequestBuilder toBuilder() =>
      CreateWithdrawalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWithdrawalRequest &&
        asset == other.asset &&
        chain == other.chain &&
        amount == other.amount &&
        address == other.address &&
        authorizationId == other.authorizationId &&
        memo == other.memo &&
        quoteId == other.quoteId &&
        saveAddress == other.saveAddress &&
        addressLabel == other.addressLabel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jc(_$hash, quoteId.hashCode);
    _$hash = $jc(_$hash, saveAddress.hashCode);
    _$hash = $jc(_$hash, addressLabel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWithdrawalRequest')
          ..add('asset', asset)
          ..add('chain', chain)
          ..add('amount', amount)
          ..add('address', address)
          ..add('authorizationId', authorizationId)
          ..add('memo', memo)
          ..add('quoteId', quoteId)
          ..add('saveAddress', saveAddress)
          ..add('addressLabel', addressLabel))
        .toString();
  }
}

class CreateWithdrawalRequestBuilder
    implements
        Builder<CreateWithdrawalRequest, CreateWithdrawalRequestBuilder> {
  _$CreateWithdrawalRequest? _$v;

  CreateWithdrawalRequestAssetEnum? _asset;
  CreateWithdrawalRequestAssetEnum? get asset => _$this._asset;
  set asset(CreateWithdrawalRequestAssetEnum? asset) => _$this._asset = asset;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  String? _quoteId;
  String? get quoteId => _$this._quoteId;
  set quoteId(String? quoteId) => _$this._quoteId = quoteId;

  bool? _saveAddress;
  bool? get saveAddress => _$this._saveAddress;
  set saveAddress(bool? saveAddress) => _$this._saveAddress = saveAddress;

  String? _addressLabel;
  String? get addressLabel => _$this._addressLabel;
  set addressLabel(String? addressLabel) => _$this._addressLabel = addressLabel;

  CreateWithdrawalRequestBuilder() {
    CreateWithdrawalRequest._defaults(this);
  }

  CreateWithdrawalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asset = $v.asset;
      _chain = $v.chain;
      _amount = $v.amount;
      _address = $v.address;
      _authorizationId = $v.authorizationId;
      _memo = $v.memo;
      _quoteId = $v.quoteId;
      _saveAddress = $v.saveAddress;
      _addressLabel = $v.addressLabel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWithdrawalRequest other) {
    _$v = other as _$CreateWithdrawalRequest;
  }

  @override
  void update(void Function(CreateWithdrawalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWithdrawalRequest build() => _build();

  _$CreateWithdrawalRequest _build() {
    final _$result = _$v ??
        _$CreateWithdrawalRequest._(
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'CreateWithdrawalRequest', 'asset'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'CreateWithdrawalRequest', 'chain'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'CreateWithdrawalRequest', 'amount'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'CreateWithdrawalRequest', 'address'),
          authorizationId: BuiltValueNullFieldError.checkNotNull(
              authorizationId, r'CreateWithdrawalRequest', 'authorizationId'),
          memo: memo,
          quoteId: BuiltValueNullFieldError.checkNotNull(
              quoteId, r'CreateWithdrawalRequest', 'quoteId'),
          saveAddress: saveAddress,
          addressLabel: addressLabel,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
