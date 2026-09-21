// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_withdrawal_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

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
    _$hip3WithdrawalCreateRequestRailEnum_unknownDefaultOpenApi =
    const Hip3WithdrawalCreateRequestRailEnum._('unknownDefaultOpenApi');

Hip3WithdrawalCreateRequestRailEnum
    _$hip3WithdrawalCreateRequestRailEnumValueOf(String name) {
  switch (name) {
    case 'auto':
      return _$hip3WithdrawalCreateRequestRailEnum_auto;
    case 'bridge2':
      return _$hip3WithdrawalCreateRequestRailEnum_bridge2;
    case 'float':
      return _$hip3WithdrawalCreateRequestRailEnum_float;
    case 'unknownDefaultOpenApi':
      return _$hip3WithdrawalCreateRequestRailEnum_unknownDefaultOpenApi;
    default:
      return _$hip3WithdrawalCreateRequestRailEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3WithdrawalCreateRequestRailEnum>
    _$hip3WithdrawalCreateRequestRailEnumValues = BuiltSet<
        Hip3WithdrawalCreateRequestRailEnum>(const <Hip3WithdrawalCreateRequestRailEnum>[
  _$hip3WithdrawalCreateRequestRailEnum_auto,
  _$hip3WithdrawalCreateRequestRailEnum_bridge2,
  _$hip3WithdrawalCreateRequestRailEnum_float,
  _$hip3WithdrawalCreateRequestRailEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3WithdrawalCreateRequestRailEnum>
    _$hip3WithdrawalCreateRequestRailEnumSerializer =
    _$Hip3WithdrawalCreateRequestRailEnumSerializer();

class _$Hip3WithdrawalCreateRequestRailEnumSerializer
    implements PrimitiveSerializer<Hip3WithdrawalCreateRequestRailEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'auto': 'auto',
    'bridge2': 'bridge2',
    'float': 'float',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto': 'auto',
    'bridge2': 'bridge2',
    'float': 'float',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
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
  final Hip3WithdrawalCreateRequestRailEnum? rail;

  factory _$Hip3WithdrawalCreateRequest(
          [void Function(Hip3WithdrawalCreateRequestBuilder)? updates]) =>
      (Hip3WithdrawalCreateRequestBuilder()..update(updates))._build();

  _$Hip3WithdrawalCreateRequest._({required this.amount, this.rail})
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
        rail == other.rail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3WithdrawalCreateRequest')
          ..add('amount', amount)
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
          rail: rail,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
