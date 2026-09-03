// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_quote_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WithdrawalQuoteRequestAssetEnum _$withdrawalQuoteRequestAssetEnum_USDC =
    const WithdrawalQuoteRequestAssetEnum._('USDC');
const WithdrawalQuoteRequestAssetEnum
    _$withdrawalQuoteRequestAssetEnum_unknownDefaultOpenApi =
    const WithdrawalQuoteRequestAssetEnum._('unknownDefaultOpenApi');

WithdrawalQuoteRequestAssetEnum _$withdrawalQuoteRequestAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$withdrawalQuoteRequestAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$withdrawalQuoteRequestAssetEnum_unknownDefaultOpenApi;
    default:
      return _$withdrawalQuoteRequestAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<WithdrawalQuoteRequestAssetEnum>
    _$withdrawalQuoteRequestAssetEnumValues = BuiltSet<
        WithdrawalQuoteRequestAssetEnum>(const <WithdrawalQuoteRequestAssetEnum>[
  _$withdrawalQuoteRequestAssetEnum_USDC,
  _$withdrawalQuoteRequestAssetEnum_unknownDefaultOpenApi,
]);

Serializer<WithdrawalQuoteRequestAssetEnum>
    _$withdrawalQuoteRequestAssetEnumSerializer =
    _$WithdrawalQuoteRequestAssetEnumSerializer();

class _$WithdrawalQuoteRequestAssetEnumSerializer
    implements PrimitiveSerializer<WithdrawalQuoteRequestAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[WithdrawalQuoteRequestAssetEnum];
  @override
  final String wireName = 'WithdrawalQuoteRequestAssetEnum';

  @override
  Object serialize(
          Serializers serializers, WithdrawalQuoteRequestAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  WithdrawalQuoteRequestAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      WithdrawalQuoteRequestAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$WithdrawalQuoteRequest extends WithdrawalQuoteRequest {
  @override
  final WithdrawalQuoteRequestAssetEnum asset;
  @override
  final Chain chain;
  @override
  final String amount;
  @override
  final String address;

  factory _$WithdrawalQuoteRequest(
          [void Function(WithdrawalQuoteRequestBuilder)? updates]) =>
      (WithdrawalQuoteRequestBuilder()..update(updates))._build();

  _$WithdrawalQuoteRequest._(
      {required this.asset,
      required this.chain,
      required this.amount,
      required this.address})
      : super._();
  @override
  WithdrawalQuoteRequest rebuild(
          void Function(WithdrawalQuoteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalQuoteRequestBuilder toBuilder() =>
      WithdrawalQuoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WithdrawalQuoteRequest &&
        asset == other.asset &&
        chain == other.chain &&
        amount == other.amount &&
        address == other.address;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WithdrawalQuoteRequest')
          ..add('asset', asset)
          ..add('chain', chain)
          ..add('amount', amount)
          ..add('address', address))
        .toString();
  }
}

class WithdrawalQuoteRequestBuilder
    implements Builder<WithdrawalQuoteRequest, WithdrawalQuoteRequestBuilder> {
  _$WithdrawalQuoteRequest? _$v;

  WithdrawalQuoteRequestAssetEnum? _asset;
  WithdrawalQuoteRequestAssetEnum? get asset => _$this._asset;
  set asset(WithdrawalQuoteRequestAssetEnum? asset) => _$this._asset = asset;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  WithdrawalQuoteRequestBuilder() {
    WithdrawalQuoteRequest._defaults(this);
  }

  WithdrawalQuoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asset = $v.asset;
      _chain = $v.chain;
      _amount = $v.amount;
      _address = $v.address;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WithdrawalQuoteRequest other) {
    _$v = other as _$WithdrawalQuoteRequest;
  }

  @override
  void update(void Function(WithdrawalQuoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WithdrawalQuoteRequest build() => _build();

  _$WithdrawalQuoteRequest _build() {
    final _$result = _$v ??
        _$WithdrawalQuoteRequest._(
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'WithdrawalQuoteRequest', 'asset'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'WithdrawalQuoteRequest', 'chain'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'WithdrawalQuoteRequest', 'amount'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'WithdrawalQuoteRequest', 'address'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
