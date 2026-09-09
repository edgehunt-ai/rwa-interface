// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_address_base.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositAddressBaseChainIdEnum _$depositAddressBaseChainIdEnum_number1 =
    const DepositAddressBaseChainIdEnum._('number1');
const DepositAddressBaseChainIdEnum _$depositAddressBaseChainIdEnum_number56 =
    const DepositAddressBaseChainIdEnum._('number56');
const DepositAddressBaseChainIdEnum _$depositAddressBaseChainIdEnum_number8453 =
    const DepositAddressBaseChainIdEnum._('number8453');
const DepositAddressBaseChainIdEnum
    _$depositAddressBaseChainIdEnum_number42161 =
    const DepositAddressBaseChainIdEnum._('number42161');
const DepositAddressBaseChainIdEnum
    _$depositAddressBaseChainIdEnum_unknownDefaultOpenApi =
    const DepositAddressBaseChainIdEnum._('unknownDefaultOpenApi');

DepositAddressBaseChainIdEnum _$depositAddressBaseChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$depositAddressBaseChainIdEnum_number1;
    case 'number56':
      return _$depositAddressBaseChainIdEnum_number56;
    case 'number8453':
      return _$depositAddressBaseChainIdEnum_number8453;
    case 'number42161':
      return _$depositAddressBaseChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$depositAddressBaseChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$depositAddressBaseChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositAddressBaseChainIdEnum>
    _$depositAddressBaseChainIdEnumValues = BuiltSet<
        DepositAddressBaseChainIdEnum>(const <DepositAddressBaseChainIdEnum>[
  _$depositAddressBaseChainIdEnum_number1,
  _$depositAddressBaseChainIdEnum_number56,
  _$depositAddressBaseChainIdEnum_number8453,
  _$depositAddressBaseChainIdEnum_number42161,
  _$depositAddressBaseChainIdEnum_unknownDefaultOpenApi,
]);

Serializer<DepositAddressBaseChainIdEnum>
    _$depositAddressBaseChainIdEnumSerializer =
    _$DepositAddressBaseChainIdEnumSerializer();

class _$DepositAddressBaseChainIdEnumSerializer
    implements PrimitiveSerializer<DepositAddressBaseChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1': 1,
    'number56': 56,
    'number8453': 8453,
    'number42161': 42161,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'number1',
    56: 'number56',
    8453: 'number8453',
    42161: 'number42161',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositAddressBaseChainIdEnum];
  @override
  final String wireName = 'DepositAddressBaseChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, DepositAddressBaseChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositAddressBaseChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositAddressBaseChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

abstract class DepositAddressBaseBuilder {
  void replace(DepositAddressBase other);
  void update(void Function(DepositAddressBaseBuilder) updates);
  String? get chain;
  set chain(String? chain);

  DepositAddressBaseChainIdEnum? get chainId;
  set chainId(DepositAddressBaseChainIdEnum? chainId);

  String? get token;
  set token(String? token);

  String? get tokenContract;
  set tokenContract(String? tokenContract);

  int? get tokenDecimals;
  set tokenDecimals(int? tokenDecimals);

  String? get address;
  set address(String? address);

  String? get memo;
  set memo(String? memo);

  String? get qrPayload;
  set qrPayload(String? qrPayload);

  String? get minDeposit;
  set minDeposit(String? minDeposit);

  int? get confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired);

  int? get estimatedArrivalSeconds;
  set estimatedArrivalSeconds(int? estimatedArrivalSeconds);

  DepositCreditTarget? get creditedTo;
  set creditedTo(DepositCreditTarget? creditedTo);

  String? get warning;
  set warning(String? warning);
}

class _$$DepositAddressBase extends $DepositAddressBase {
  @override
  final String chain;
  @override
  final DepositAddressBaseChainIdEnum chainId;
  @override
  final String token;
  @override
  final String tokenContract;
  @override
  final int tokenDecimals;
  @override
  final String address;
  @override
  final String? memo;
  @override
  final String qrPayload;
  @override
  final String minDeposit;
  @override
  final int confirmationsRequired;
  @override
  final int estimatedArrivalSeconds;
  @override
  final DepositCreditTarget creditedTo;
  @override
  final String warning;

  factory _$$DepositAddressBase(
          [void Function($DepositAddressBaseBuilder)? updates]) =>
      ($DepositAddressBaseBuilder()..update(updates))._build();

  _$$DepositAddressBase._(
      {required this.chain,
      required this.chainId,
      required this.token,
      required this.tokenContract,
      required this.tokenDecimals,
      required this.address,
      this.memo,
      required this.qrPayload,
      required this.minDeposit,
      required this.confirmationsRequired,
      required this.estimatedArrivalSeconds,
      required this.creditedTo,
      required this.warning})
      : super._();
  @override
  $DepositAddressBase rebuild(
          void Function($DepositAddressBaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $DepositAddressBaseBuilder toBuilder() =>
      $DepositAddressBaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $DepositAddressBase &&
        chain == other.chain &&
        chainId == other.chainId &&
        token == other.token &&
        tokenContract == other.tokenContract &&
        tokenDecimals == other.tokenDecimals &&
        address == other.address &&
        memo == other.memo &&
        qrPayload == other.qrPayload &&
        minDeposit == other.minDeposit &&
        confirmationsRequired == other.confirmationsRequired &&
        estimatedArrivalSeconds == other.estimatedArrivalSeconds &&
        creditedTo == other.creditedTo &&
        warning == other.warning;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, tokenDecimals.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, memo.hashCode);
    _$hash = $jc(_$hash, qrPayload.hashCode);
    _$hash = $jc(_$hash, minDeposit.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, estimatedArrivalSeconds.hashCode);
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, warning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$DepositAddressBase')
          ..add('chain', chain)
          ..add('chainId', chainId)
          ..add('token', token)
          ..add('tokenContract', tokenContract)
          ..add('tokenDecimals', tokenDecimals)
          ..add('address', address)
          ..add('memo', memo)
          ..add('qrPayload', qrPayload)
          ..add('minDeposit', minDeposit)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('estimatedArrivalSeconds', estimatedArrivalSeconds)
          ..add('creditedTo', creditedTo)
          ..add('warning', warning))
        .toString();
  }
}

class $DepositAddressBaseBuilder
    implements
        Builder<$DepositAddressBase, $DepositAddressBaseBuilder>,
        DepositAddressBaseBuilder {
  _$$DepositAddressBase? _$v;

  String? _chain;
  String? get chain => _$this._chain;
  set chain(covariant String? chain) => _$this._chain = chain;

  DepositAddressBaseChainIdEnum? _chainId;
  DepositAddressBaseChainIdEnum? get chainId => _$this._chainId;
  set chainId(covariant DepositAddressBaseChainIdEnum? chainId) =>
      _$this._chainId = chainId;

  String? _token;
  String? get token => _$this._token;
  set token(covariant String? token) => _$this._token = token;

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(covariant String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  int? _tokenDecimals;
  int? get tokenDecimals => _$this._tokenDecimals;
  set tokenDecimals(covariant int? tokenDecimals) =>
      _$this._tokenDecimals = tokenDecimals;

  String? _address;
  String? get address => _$this._address;
  set address(covariant String? address) => _$this._address = address;

  String? _memo;
  String? get memo => _$this._memo;
  set memo(covariant String? memo) => _$this._memo = memo;

  String? _qrPayload;
  String? get qrPayload => _$this._qrPayload;
  set qrPayload(covariant String? qrPayload) => _$this._qrPayload = qrPayload;

  String? _minDeposit;
  String? get minDeposit => _$this._minDeposit;
  set minDeposit(covariant String? minDeposit) =>
      _$this._minDeposit = minDeposit;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(covariant int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  int? _estimatedArrivalSeconds;
  int? get estimatedArrivalSeconds => _$this._estimatedArrivalSeconds;
  set estimatedArrivalSeconds(covariant int? estimatedArrivalSeconds) =>
      _$this._estimatedArrivalSeconds = estimatedArrivalSeconds;

  DepositCreditTarget? _creditedTo;
  DepositCreditTarget? get creditedTo => _$this._creditedTo;
  set creditedTo(covariant DepositCreditTarget? creditedTo) =>
      _$this._creditedTo = creditedTo;

  String? _warning;
  String? get warning => _$this._warning;
  set warning(covariant String? warning) => _$this._warning = warning;

  $DepositAddressBaseBuilder() {
    $DepositAddressBase._defaults(this);
  }

  $DepositAddressBaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _chainId = $v.chainId;
      _token = $v.token;
      _tokenContract = $v.tokenContract;
      _tokenDecimals = $v.tokenDecimals;
      _address = $v.address;
      _memo = $v.memo;
      _qrPayload = $v.qrPayload;
      _minDeposit = $v.minDeposit;
      _confirmationsRequired = $v.confirmationsRequired;
      _estimatedArrivalSeconds = $v.estimatedArrivalSeconds;
      _creditedTo = $v.creditedTo;
      _warning = $v.warning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $DepositAddressBase other) {
    _$v = other as _$$DepositAddressBase;
  }

  @override
  void update(void Function($DepositAddressBaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $DepositAddressBase build() => _build();

  _$$DepositAddressBase _build() {
    final _$result = _$v ??
        _$$DepositAddressBase._(
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'$DepositAddressBase', 'chain'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'$DepositAddressBase', 'chainId'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'$DepositAddressBase', 'token'),
          tokenContract: BuiltValueNullFieldError.checkNotNull(
              tokenContract, r'$DepositAddressBase', 'tokenContract'),
          tokenDecimals: BuiltValueNullFieldError.checkNotNull(
              tokenDecimals, r'$DepositAddressBase', 'tokenDecimals'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'$DepositAddressBase', 'address'),
          memo: memo,
          qrPayload: BuiltValueNullFieldError.checkNotNull(
              qrPayload, r'$DepositAddressBase', 'qrPayload'),
          minDeposit: BuiltValueNullFieldError.checkNotNull(
              minDeposit, r'$DepositAddressBase', 'minDeposit'),
          confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
              confirmationsRequired,
              r'$DepositAddressBase',
              'confirmationsRequired'),
          estimatedArrivalSeconds: BuiltValueNullFieldError.checkNotNull(
              estimatedArrivalSeconds,
              r'$DepositAddressBase',
              'estimatedArrivalSeconds'),
          creditedTo: BuiltValueNullFieldError.checkNotNull(
              creditedTo, r'$DepositAddressBase', 'creditedTo'),
          warning: BuiltValueNullFieldError.checkNotNull(
              warning, r'$DepositAddressBase', 'warning'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
