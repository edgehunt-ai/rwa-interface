// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_fee_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalFeeDetailTypeEnum
    _$hip3WithdrawalFeeDetailTypeEnum_withdrawal =
    const Hip3WithdrawalFeeDetailTypeEnum._('withdrawal');
const Hip3WithdrawalFeeDetailTypeEnum
    _$hip3WithdrawalFeeDetailTypeEnum_network =
    const Hip3WithdrawalFeeDetailTypeEnum._('network');

Hip3WithdrawalFeeDetailTypeEnum _$hip3WithdrawalFeeDetailTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'withdrawal':
      return _$hip3WithdrawalFeeDetailTypeEnum_withdrawal;
    case 'network':
      return _$hip3WithdrawalFeeDetailTypeEnum_network;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalFeeDetailTypeEnum>
    _$hip3WithdrawalFeeDetailTypeEnumValues = BuiltSet<
        Hip3WithdrawalFeeDetailTypeEnum>(const <Hip3WithdrawalFeeDetailTypeEnum>[
  _$hip3WithdrawalFeeDetailTypeEnum_withdrawal,
  _$hip3WithdrawalFeeDetailTypeEnum_network,
]);

const Hip3WithdrawalFeeDetailCurrencyEnum
    _$hip3WithdrawalFeeDetailCurrencyEnum_USDC =
    const Hip3WithdrawalFeeDetailCurrencyEnum._('USDC');
const Hip3WithdrawalFeeDetailCurrencyEnum
    _$hip3WithdrawalFeeDetailCurrencyEnum_ETH =
    const Hip3WithdrawalFeeDetailCurrencyEnum._('ETH');

Hip3WithdrawalFeeDetailCurrencyEnum
    _$hip3WithdrawalFeeDetailCurrencyEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$hip3WithdrawalFeeDetailCurrencyEnum_USDC;
    case 'ETH':
      return _$hip3WithdrawalFeeDetailCurrencyEnum_ETH;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalFeeDetailCurrencyEnum>
    _$hip3WithdrawalFeeDetailCurrencyEnumValues = BuiltSet<
        Hip3WithdrawalFeeDetailCurrencyEnum>(const <Hip3WithdrawalFeeDetailCurrencyEnum>[
  _$hip3WithdrawalFeeDetailCurrencyEnum_USDC,
  _$hip3WithdrawalFeeDetailCurrencyEnum_ETH,
]);

const Hip3WithdrawalFeeDetailPayerEnum _$hip3WithdrawalFeeDetailPayerEnum_user =
    const Hip3WithdrawalFeeDetailPayerEnum._('user');
const Hip3WithdrawalFeeDetailPayerEnum
    _$hip3WithdrawalFeeDetailPayerEnum_platform =
    const Hip3WithdrawalFeeDetailPayerEnum._('platform');

Hip3WithdrawalFeeDetailPayerEnum _$hip3WithdrawalFeeDetailPayerEnumValueOf(
    String name) {
  switch (name) {
    case 'user':
      return _$hip3WithdrawalFeeDetailPayerEnum_user;
    case 'platform':
      return _$hip3WithdrawalFeeDetailPayerEnum_platform;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalFeeDetailPayerEnum>
    _$hip3WithdrawalFeeDetailPayerEnumValues = BuiltSet<
        Hip3WithdrawalFeeDetailPayerEnum>(const <Hip3WithdrawalFeeDetailPayerEnum>[
  _$hip3WithdrawalFeeDetailPayerEnum_user,
  _$hip3WithdrawalFeeDetailPayerEnum_platform,
]);

Serializer<Hip3WithdrawalFeeDetailTypeEnum>
    _$hip3WithdrawalFeeDetailTypeEnumSerializer =
    _$Hip3WithdrawalFeeDetailTypeEnumSerializer();
Serializer<Hip3WithdrawalFeeDetailCurrencyEnum>
    _$hip3WithdrawalFeeDetailCurrencyEnumSerializer =
    _$Hip3WithdrawalFeeDetailCurrencyEnumSerializer();
Serializer<Hip3WithdrawalFeeDetailPayerEnum>
    _$hip3WithdrawalFeeDetailPayerEnumSerializer =
    _$Hip3WithdrawalFeeDetailPayerEnumSerializer();

class _$Hip3WithdrawalFeeDetailTypeEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalFeeDetailTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'withdrawal': 'withdrawal',
    'network': 'network',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'withdrawal': 'withdrawal',
    'network': 'network',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalFeeDetailTypeEnum];
  @override
  final String wireName = 'Hip3WithdrawalFeeDetailTypeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalFeeDetailTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalFeeDetailTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalFeeDetailTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalFeeDetailCurrencyEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalFeeDetailCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'ETH': 'ETH',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'ETH': 'ETH',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3WithdrawalFeeDetailCurrencyEnum
  ];
  @override
  final String wireName = 'Hip3WithdrawalFeeDetailCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalFeeDetailCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalFeeDetailCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalFeeDetailCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalFeeDetailPayerEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalFeeDetailPayerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'user': 'user',
    'platform': 'platform',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user': 'user',
    'platform': 'platform',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3WithdrawalFeeDetailPayerEnum];
  @override
  final String wireName = 'Hip3WithdrawalFeeDetailPayerEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalFeeDetailPayerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalFeeDetailPayerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalFeeDetailPayerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalFeeDetail extends Hip3WithdrawalFeeDetail {
  @override
  final Hip3WithdrawalFeeDetailTypeEnum type;
  @override
  final String? amount;
  @override
  final Hip3WithdrawalFeeDetailCurrencyEnum currency;
  @override
  final Hip3WithdrawalFeeDetailPayerEnum payer;

  factory _$Hip3WithdrawalFeeDetail(
          [void Function(Hip3WithdrawalFeeDetailBuilder)? updates]) =>
      (Hip3WithdrawalFeeDetailBuilder()..update(updates))._build();

  _$Hip3WithdrawalFeeDetail._(
      {required this.type,
      this.amount,
      required this.currency,
      required this.payer})
      : super._();
  @override
  Hip3WithdrawalFeeDetail rebuild(
          void Function(Hip3WithdrawalFeeDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalFeeDetailBuilder toBuilder() =>
      Hip3WithdrawalFeeDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3WithdrawalFeeDetail &&
        type == other.type &&
        amount == other.amount &&
        currency == other.currency &&
        payer == other.payer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, payer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalFeeDetail')
          ..add('type', type)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('payer', payer))
        .toString();
  }
}

class Hip3WithdrawalFeeDetailBuilder
    implements
        Builder<Hip3WithdrawalFeeDetail, Hip3WithdrawalFeeDetailBuilder> {
  _$Hip3WithdrawalFeeDetail? _$v;

  Hip3WithdrawalFeeDetailTypeEnum? _type;
  Hip3WithdrawalFeeDetailTypeEnum? get type => _$this._type;
  set type(Hip3WithdrawalFeeDetailTypeEnum? type) => _$this._type = type;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  Hip3WithdrawalFeeDetailCurrencyEnum? _currency;
  Hip3WithdrawalFeeDetailCurrencyEnum? get currency => _$this._currency;
  set currency(Hip3WithdrawalFeeDetailCurrencyEnum? currency) =>
      _$this._currency = currency;

  Hip3WithdrawalFeeDetailPayerEnum? _payer;
  Hip3WithdrawalFeeDetailPayerEnum? get payer => _$this._payer;
  set payer(Hip3WithdrawalFeeDetailPayerEnum? payer) => _$this._payer = payer;

  Hip3WithdrawalFeeDetailBuilder() {
    Hip3WithdrawalFeeDetail._defaults(this);
  }

  Hip3WithdrawalFeeDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _amount = $v.amount;
      _currency = $v.currency;
      _payer = $v.payer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3WithdrawalFeeDetail other) {
    _$v = other as _$Hip3WithdrawalFeeDetail;
  }

  @override
  void update(void Function(Hip3WithdrawalFeeDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3WithdrawalFeeDetail build() => _build();

  _$Hip3WithdrawalFeeDetail _build() {
    final _$result = _$v ??
        _$Hip3WithdrawalFeeDetail._(
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'Hip3WithdrawalFeeDetail', 'type'),
          amount: amount,
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'Hip3WithdrawalFeeDetail', 'currency'),
          payer: BuiltValueNullFieldError.checkNotNull(
              payer, r'Hip3WithdrawalFeeDetail', 'payer'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
