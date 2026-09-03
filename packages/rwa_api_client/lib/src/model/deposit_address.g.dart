// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_address.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositAddressTokenEnum _$depositAddressTokenEnum_USDC =
    const DepositAddressTokenEnum._('USDC');
const DepositAddressTokenEnum _$depositAddressTokenEnum_unknownDefaultOpenApi =
    const DepositAddressTokenEnum._('unknownDefaultOpenApi');

DepositAddressTokenEnum _$depositAddressTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$depositAddressTokenEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$depositAddressTokenEnum_unknownDefaultOpenApi;
    default:
      return _$depositAddressTokenEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositAddressTokenEnum> _$depositAddressTokenEnumValues =
    BuiltSet<DepositAddressTokenEnum>(const <DepositAddressTokenEnum>[
  _$depositAddressTokenEnum_USDC,
  _$depositAddressTokenEnum_unknownDefaultOpenApi,
]);

Serializer<DepositAddressTokenEnum> _$depositAddressTokenEnumSerializer =
    _$DepositAddressTokenEnumSerializer();

class _$DepositAddressTokenEnumSerializer
    implements PrimitiveSerializer<DepositAddressTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositAddressTokenEnum];
  @override
  final String wireName = 'DepositAddressTokenEnum';

  @override
  Object serialize(Serializers serializers, DepositAddressTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositAddressTokenEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositAddressTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositAddress extends DepositAddress {
  @override
  final Chain chain;
  @override
  final DepositAddressTokenEnum token;
  @override
  final String address;
  @override
  final String? memo;
  @override
  final String? qrPayload;
  @override
  final String? minDeposit;
  @override
  final int? confirmationsRequired;
  @override
  final AccountKind? creditedTo;
  @override
  final String? warning;

  factory _$DepositAddress([void Function(DepositAddressBuilder)? updates]) =>
      (DepositAddressBuilder()..update(updates))._build();

  _$DepositAddress._(
      {required this.chain,
      required this.token,
      required this.address,
      this.memo,
      this.qrPayload,
      this.minDeposit,
      this.confirmationsRequired,
      this.creditedTo,
      this.warning})
      : super._();
  @override
  DepositAddress rebuild(void Function(DepositAddressBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositAddressBuilder toBuilder() => DepositAddressBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositAddress &&
        chain == other.chain &&
        token == other.token &&
        address == other.address &&
        memo == other.memo &&
        qrPayload == other.qrPayload &&
        minDeposit == other.minDeposit &&
        confirmationsRequired == other.confirmationsRequired &&
        creditedTo == other.creditedTo &&
        warning == other.warning;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jc(_$hash, qrPayload.hashCode);
    _$hash = $jc(_$hash, minDeposit.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, warning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositAddress')
          ..add('chain', chain)
          ..add('token', token)
          ..add('address', address)
          ..add('memo', memo)
          ..add('qrPayload', qrPayload)
          ..add('minDeposit', minDeposit)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('creditedTo', creditedTo)
          ..add('warning', warning))
        .toString();
  }
}

class DepositAddressBuilder
    implements Builder<DepositAddress, DepositAddressBuilder> {
  _$DepositAddress? _$v;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  DepositAddressTokenEnum? _token;
  DepositAddressTokenEnum? get token => _$this._token;
  set token(DepositAddressTokenEnum? token) => _$this._token = token;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(String? memo) => _$this._memo = memo;

  String? _qrPayload;
  String? get qrPayload => _$this._qrPayload;
  set qrPayload(String? qrPayload) => _$this._qrPayload = qrPayload;

  String? _minDeposit;
  String? get minDeposit => _$this._minDeposit;
  set minDeposit(String? minDeposit) => _$this._minDeposit = minDeposit;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  AccountKind? _creditedTo;
  AccountKind? get creditedTo => _$this._creditedTo;
  set creditedTo(AccountKind? creditedTo) => _$this._creditedTo = creditedTo;

  String? _warning;
  String? get warning => _$this._warning;
  set warning(String? warning) => _$this._warning = warning;

  DepositAddressBuilder() {
    DepositAddress._defaults(this);
  }

  DepositAddressBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _token = $v.token;
      _address = $v.address;
      _memo = $v.memo;
      _qrPayload = $v.qrPayload;
      _minDeposit = $v.minDeposit;
      _confirmationsRequired = $v.confirmationsRequired;
      _creditedTo = $v.creditedTo;
      _warning = $v.warning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositAddress other) {
    _$v = other as _$DepositAddress;
  }

  @override
  void update(void Function(DepositAddressBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositAddress build() => _build();

  _$DepositAddress _build() {
    final _$result = _$v ??
        _$DepositAddress._(
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'DepositAddress', 'chain'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'DepositAddress', 'token'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'DepositAddress', 'address'),
          memo: memo,
          qrPayload: qrPayload,
          minDeposit: minDeposit,
          confirmationsRequired: confirmationsRequired,
          creditedTo: creditedTo,
          warning: warning,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
