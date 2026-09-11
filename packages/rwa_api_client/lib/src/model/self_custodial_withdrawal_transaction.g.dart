// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_transaction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SelfCustodialWithdrawalTransactionValueEnum
    _$selfCustodialWithdrawalTransactionValueEnum_n0x0 =
    const SelfCustodialWithdrawalTransactionValueEnum._('n0x0');
const SelfCustodialWithdrawalTransactionValueEnum
    _$selfCustodialWithdrawalTransactionValueEnum_unknownDefaultOpenApi =
    const SelfCustodialWithdrawalTransactionValueEnum._(
        'unknownDefaultOpenApi');

SelfCustodialWithdrawalTransactionValueEnum
    _$selfCustodialWithdrawalTransactionValueEnumValueOf(String name) {
  switch (name) {
    case 'n0x0':
      return _$selfCustodialWithdrawalTransactionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$selfCustodialWithdrawalTransactionValueEnum_unknownDefaultOpenApi;
    default:
      return _$selfCustodialWithdrawalTransactionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<SelfCustodialWithdrawalTransactionValueEnum>
    _$selfCustodialWithdrawalTransactionValueEnumValues = BuiltSet<
        SelfCustodialWithdrawalTransactionValueEnum>(const <SelfCustodialWithdrawalTransactionValueEnum>[
  _$selfCustodialWithdrawalTransactionValueEnum_n0x0,
  _$selfCustodialWithdrawalTransactionValueEnum_unknownDefaultOpenApi,
]);

Serializer<SelfCustodialWithdrawalTransactionValueEnum>
    _$selfCustodialWithdrawalTransactionValueEnumSerializer =
    _$SelfCustodialWithdrawalTransactionValueEnumSerializer();

class _$SelfCustodialWithdrawalTransactionValueEnumSerializer
    implements
        PrimitiveSerializer<SelfCustodialWithdrawalTransactionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    SelfCustodialWithdrawalTransactionValueEnum
  ];
  @override
  final String wireName = 'SelfCustodialWithdrawalTransactionValueEnum';

  @override
  Object serialize(Serializers serializers,
          SelfCustodialWithdrawalTransactionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SelfCustodialWithdrawalTransactionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SelfCustodialWithdrawalTransactionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$SelfCustodialWithdrawalTransaction
    extends SelfCustodialWithdrawalTransaction {
  @override
  final SelfCustodialWithdrawalChainId chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final SelfCustodialWithdrawalTransactionValueEnum value;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;

  factory _$SelfCustodialWithdrawalTransaction(
          [void Function(SelfCustodialWithdrawalTransactionBuilder)?
              updates]) =>
      (SelfCustodialWithdrawalTransactionBuilder()..update(updates))._build();

  _$SelfCustodialWithdrawalTransaction._(
      {required this.chainId,
      required this.from,
      required this.to,
      required this.data,
      required this.value,
      required this.payloadHash,
      required this.validUntil})
      : super._();
  @override
  SelfCustodialWithdrawalTransaction rebuild(
          void Function(SelfCustodialWithdrawalTransactionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SelfCustodialWithdrawalTransactionBuilder toBuilder() =>
      SelfCustodialWithdrawalTransactionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SelfCustodialWithdrawalTransaction &&
        chainId == other.chainId &&
        from == other.from &&
        to == other.to &&
        data == other.data &&
        value == other.value &&
        payloadHash == other.payloadHash &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SelfCustodialWithdrawalTransaction')
          ..add('chainId', chainId)
          ..add('from', from)
          ..add('to', to)
          ..add('data', data)
          ..add('value', value)
          ..add('payloadHash', payloadHash)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class SelfCustodialWithdrawalTransactionBuilder
    implements
        Builder<SelfCustodialWithdrawalTransaction,
            SelfCustodialWithdrawalTransactionBuilder> {
  _$SelfCustodialWithdrawalTransaction? _$v;

  SelfCustodialWithdrawalChainId? _chainId;
  SelfCustodialWithdrawalChainId? get chainId => _$this._chainId;
  set chainId(SelfCustodialWithdrawalChainId? chainId) =>
      _$this._chainId = chainId;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  SelfCustodialWithdrawalTransactionValueEnum? _value;
  SelfCustodialWithdrawalTransactionValueEnum? get value => _$this._value;
  set value(SelfCustodialWithdrawalTransactionValueEnum? value) =>
      _$this._value = value;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  SelfCustodialWithdrawalTransactionBuilder() {
    SelfCustodialWithdrawalTransaction._defaults(this);
  }

  SelfCustodialWithdrawalTransactionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chainId = $v.chainId;
      _from = $v.from;
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _payloadHash = $v.payloadHash;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SelfCustodialWithdrawalTransaction other) {
    _$v = other as _$SelfCustodialWithdrawalTransaction;
  }

  @override
  void update(
      void Function(SelfCustodialWithdrawalTransactionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SelfCustodialWithdrawalTransaction build() => _build();

  _$SelfCustodialWithdrawalTransaction _build() {
    final _$result = _$v ??
        _$SelfCustodialWithdrawalTransaction._(
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'SelfCustodialWithdrawalTransaction', 'chainId'),
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'SelfCustodialWithdrawalTransaction', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'SelfCustodialWithdrawalTransaction', 'to'),
          data: BuiltValueNullFieldError.checkNotNull(
              data, r'SelfCustodialWithdrawalTransaction', 'data'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'SelfCustodialWithdrawalTransaction', 'value'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(payloadHash,
              r'SelfCustodialWithdrawalTransaction', 'payloadHash'),
          validUntil: BuiltValueNullFieldError.checkNotNull(
              validUntil, r'SelfCustodialWithdrawalTransaction', 'validUntil'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
