// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3WithdrawalCreateRequestPayoutChainIdEnum
    _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number56 =
    const Hip3WithdrawalCreateRequestPayoutChainIdEnum._('number56');
const Hip3WithdrawalCreateRequestPayoutChainIdEnum
    _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number42161 =
    const Hip3WithdrawalCreateRequestPayoutChainIdEnum._('number42161');
const Hip3WithdrawalCreateRequestPayoutChainIdEnum
    _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number421614 =
    const Hip3WithdrawalCreateRequestPayoutChainIdEnum._('number421614');

Hip3WithdrawalCreateRequestPayoutChainIdEnum
    _$hip3WithdrawalCreateRequestPayoutChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number56;
    case 'number42161':
      return _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number42161;
    case 'number421614':
      return _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number421614;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalCreateRequestPayoutChainIdEnum>
    _$hip3WithdrawalCreateRequestPayoutChainIdEnumValues = BuiltSet<
        Hip3WithdrawalCreateRequestPayoutChainIdEnum>(const <Hip3WithdrawalCreateRequestPayoutChainIdEnum>[
  _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number56,
  _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number42161,
  _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number421614,
]);

const Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnum_auto =
    const Hip3WithdrawalCreateRequestRailEnum._('auto');
const Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnum_bridge2 =
    const Hip3WithdrawalCreateRequestRailEnum._('bridge2');
const Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnum_float =
    const Hip3WithdrawalCreateRequestRailEnum._('float');
const Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnum_relay =
    const Hip3WithdrawalCreateRequestRailEnum._('relay');

Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnumValueOf(String name) {
  switch (name) {
    case 'auto':
      return _$hip3WithdrawalCreateRequestRailEnum_auto;
    case 'bridge2':
      return _$hip3WithdrawalCreateRequestRailEnum_bridge2;
    case 'float':
      return _$hip3WithdrawalCreateRequestRailEnum_float;
    case 'relay':
      return _$hip3WithdrawalCreateRequestRailEnum_relay;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3WithdrawalCreateRequestRailEnum>
    _$hip3WithdrawalCreateRequestRailEnumValues = BuiltSet<
        Hip3WithdrawalCreateRequestRailEnum>(const <Hip3WithdrawalCreateRequestRailEnum>[
  _$hip3WithdrawalCreateRequestRailEnum_auto,
  _$hip3WithdrawalCreateRequestRailEnum_bridge2,
  _$hip3WithdrawalCreateRequestRailEnum_float,
  _$hip3WithdrawalCreateRequestRailEnum_relay,
]);

Serializer<Hip3WithdrawalCreateRequestPayoutChainIdEnum>
    _$hip3WithdrawalCreateRequestPayoutChainIdEnumSerializer =
    _$Hip3WithdrawalCreateRequestPayoutChainIdEnumSerializer();
Serializer<Hip3WithdrawalCreateRequestRailEnum>
    _$hip3WithdrawalCreateRequestRailEnumSerializer =
    _$Hip3WithdrawalCreateRequestRailEnumSerializer();

class _$Hip3WithdrawalCreateRequestPayoutChainIdEnumSerializer
    implements
        PrimitiveSerializer<Hip3WithdrawalCreateRequestPayoutChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number42161': 42161,
    'number421614': 421614,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    42161: 'number42161',
    421614: 'number421614',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3WithdrawalCreateRequestPayoutChainIdEnum
  ];
  @override
  final String wireName = 'Hip3WithdrawalCreateRequestPayoutChainIdEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3WithdrawalCreateRequestPayoutChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalCreateRequestPayoutChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalCreateRequestPayoutChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalCreateRequestRailEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalCreateRequestRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'auto': 'auto',
    'bridge2': 'bridge2',
    'float': 'float',
    'relay': 'relay',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto': 'auto',
    'bridge2': 'bridge2',
    'float': 'float',
    'relay': 'relay',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3WithdrawalCreateRequestRailEnum
  ];
  @override
  final String wireName = 'Hip3WithdrawalCreateRequestRailEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3WithdrawalCreateRequestRailEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3WithdrawalCreateRequestRailEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3WithdrawalCreateRequestRailEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3WithdrawalCreateRequest extends Hip3WithdrawalCreateRequest {
  @override
  final String amount;
  @override
  final Hip3WithdrawalCreateRequestPayoutChainIdEnum? payoutChainId;
  @override
  final Hip3WithdrawalCreateRequestRailEnum? rail;

  factory _$Hip3WithdrawalCreateRequest(
          [void Function(Hip3WithdrawalCreateRequestBuilder)? updates]) =>
      (Hip3WithdrawalCreateRequestBuilder()..update(updates))._build();

  _$Hip3WithdrawalCreateRequest._(
      {required this.amount, this.payoutChainId, this.rail})
      : super._();
  @override
  Hip3WithdrawalCreateRequest rebuild(
          void Function(Hip3WithdrawalCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3WithdrawalCreateRequestBuilder toBuilder() =>
      Hip3WithdrawalCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3WithdrawalCreateRequest &&
        amount == other.amount &&
        payoutChainId == other.payoutChainId &&
        rail == other.rail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, payoutChainId.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalCreateRequest')
          ..add('amount', amount)
          ..add('payoutChainId', payoutChainId)
          ..add('rail', rail))
        .toString();
  }
}

class Hip3WithdrawalCreateRequestBuilder
    implements
        Builder<Hip3WithdrawalCreateRequest,
            Hip3WithdrawalCreateRequestBuilder> {
  _$Hip3WithdrawalCreateRequest? _$v;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  Hip3WithdrawalCreateRequestPayoutChainIdEnum? _payoutChainId;
  Hip3WithdrawalCreateRequestPayoutChainIdEnum? get payoutChainId =>
      _$this._payoutChainId;
  set payoutChainId(
          Hip3WithdrawalCreateRequestPayoutChainIdEnum? payoutChainId) =>
      _$this._payoutChainId = payoutChainId;

  Hip3WithdrawalCreateRequestRailEnum? _rail;
  Hip3WithdrawalCreateRequestRailEnum? get rail => _$this._rail;
  set rail(Hip3WithdrawalCreateRequestRailEnum? rail) => _$this._rail = rail;

  Hip3WithdrawalCreateRequestBuilder() {
    Hip3WithdrawalCreateRequest._defaults(this);
  }

  Hip3WithdrawalCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _payoutChainId = $v.payoutChainId;
      _rail = $v.rail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3WithdrawalCreateRequest other) {
    _$v = other as _$Hip3WithdrawalCreateRequest;
  }

  @override
  void update(void Function(Hip3WithdrawalCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3WithdrawalCreateRequest build() => _build();

  _$Hip3WithdrawalCreateRequest _build() {
    final _$result = _$v ??
        _$Hip3WithdrawalCreateRequest._(
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Hip3WithdrawalCreateRequest', 'amount'),
          payoutChainId: payoutChainId,
          rail: rail,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
