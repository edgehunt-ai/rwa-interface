// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_evm_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderEvmActionKindEnum _$orderEvmActionKindEnum_erc20Approval =
    const OrderEvmActionKindEnum._('erc20Approval');
const OrderEvmActionKindEnum _$orderEvmActionKindEnum_spotSwap =
    const OrderEvmActionKindEnum._('spotSwap');
const OrderEvmActionKindEnum _$orderEvmActionKindEnum_unknownDefaultOpenApi =
    const OrderEvmActionKindEnum._('unknownDefaultOpenApi');

OrderEvmActionKindEnum _$orderEvmActionKindEnumValueOf(String name) {
  switch (name) {
    case 'erc20Approval':
      return _$orderEvmActionKindEnum_erc20Approval;
    case 'spotSwap':
      return _$orderEvmActionKindEnum_spotSwap;
    case 'unknownDefaultOpenApi':
      return _$orderEvmActionKindEnum_unknownDefaultOpenApi;
    default:
      return _$orderEvmActionKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderEvmActionKindEnum> _$orderEvmActionKindEnumValues =
    BuiltSet<OrderEvmActionKindEnum>(const <OrderEvmActionKindEnum>[
  _$orderEvmActionKindEnum_erc20Approval,
  _$orderEvmActionKindEnum_spotSwap,
  _$orderEvmActionKindEnum_unknownDefaultOpenApi,
]);

const OrderEvmActionChainIdEnum _$orderEvmActionChainIdEnum_number56 =
    const OrderEvmActionChainIdEnum._('number56');
const OrderEvmActionChainIdEnum _$orderEvmActionChainIdEnum_number97 =
    const OrderEvmActionChainIdEnum._('number97');
const OrderEvmActionChainIdEnum _$orderEvmActionChainIdEnum_number31337 =
    const OrderEvmActionChainIdEnum._('number31337');
const OrderEvmActionChainIdEnum
    _$orderEvmActionChainIdEnum_unknownDefaultOpenApi =
    const OrderEvmActionChainIdEnum._('unknownDefaultOpenApi');

OrderEvmActionChainIdEnum _$orderEvmActionChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$orderEvmActionChainIdEnum_number56;
    case 'number97':
      return _$orderEvmActionChainIdEnum_number97;
    case 'number31337':
      return _$orderEvmActionChainIdEnum_number31337;
    case 'unknownDefaultOpenApi':
      return _$orderEvmActionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$orderEvmActionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderEvmActionChainIdEnum> _$orderEvmActionChainIdEnumValues =
    BuiltSet<OrderEvmActionChainIdEnum>(const <OrderEvmActionChainIdEnum>[
  _$orderEvmActionChainIdEnum_number56,
  _$orderEvmActionChainIdEnum_number97,
  _$orderEvmActionChainIdEnum_number31337,
  _$orderEvmActionChainIdEnum_unknownDefaultOpenApi,
]);

const OrderEvmActionValueEnum _$orderEvmActionValueEnum_n0x0 =
    const OrderEvmActionValueEnum._('n0x0');
const OrderEvmActionValueEnum _$orderEvmActionValueEnum_unknownDefaultOpenApi =
    const OrderEvmActionValueEnum._('unknownDefaultOpenApi');

OrderEvmActionValueEnum _$orderEvmActionValueEnumValueOf(String name) {
  switch (name) {
    case 'n0x0':
      return _$orderEvmActionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$orderEvmActionValueEnum_unknownDefaultOpenApi;
    default:
      return _$orderEvmActionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderEvmActionValueEnum> _$orderEvmActionValueEnumValues =
    BuiltSet<OrderEvmActionValueEnum>(const <OrderEvmActionValueEnum>[
  _$orderEvmActionValueEnum_n0x0,
  _$orderEvmActionValueEnum_unknownDefaultOpenApi,
]);

Serializer<OrderEvmActionKindEnum> _$orderEvmActionKindEnumSerializer =
    _$OrderEvmActionKindEnumSerializer();
Serializer<OrderEvmActionChainIdEnum> _$orderEvmActionChainIdEnumSerializer =
    _$OrderEvmActionChainIdEnumSerializer();
Serializer<OrderEvmActionValueEnum> _$orderEvmActionValueEnumSerializer =
    _$OrderEvmActionValueEnumSerializer();

class _$OrderEvmActionKindEnumSerializer
    implements PrimitiveSerializer<OrderEvmActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erc20Approval': 'erc20_approval',
    'spotSwap': 'spot_swap',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erc20_approval': 'erc20Approval',
    'spot_swap': 'spotSwap',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderEvmActionKindEnum];
  @override
  final String wireName = 'OrderEvmActionKindEnum';

  @override
  Object serialize(Serializers serializers, OrderEvmActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderEvmActionKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderEvmActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderEvmActionChainIdEnumSerializer
    implements PrimitiveSerializer<OrderEvmActionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number97': 97,
    'number31337': 31337,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    97: 'number97',
    31337: 'number31337',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderEvmActionChainIdEnum];
  @override
  final String wireName = 'OrderEvmActionChainIdEnum';

  @override
  Object serialize(Serializers serializers, OrderEvmActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderEvmActionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderEvmActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderEvmActionValueEnumSerializer
    implements PrimitiveSerializer<OrderEvmActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderEvmActionValueEnum];
  @override
  final String wireName = 'OrderEvmActionValueEnum';

  @override
  Object serialize(Serializers serializers, OrderEvmActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderEvmActionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderEvmActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderEvmAction extends OrderEvmAction {
  @override
  final String orderId;
  @override
  final String stepId;
  @override
  final int ordinal;
  @override
  final OrderEvmActionKindEnum kind;
  @override
  final OrderEvmActionChainIdEnum chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final OrderEvmActionValueEnum value;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;
  @override
  final OrderActionGasPayment gasPayment;

  factory _$OrderEvmAction([void Function(OrderEvmActionBuilder)? updates]) =>
      (OrderEvmActionBuilder()..update(updates))._build();

  _$OrderEvmAction._(
      {required this.orderId,
      required this.stepId,
      required this.ordinal,
      required this.kind,
      required this.chainId,
      required this.from,
      required this.to,
      required this.data,
      required this.value,
      required this.payloadHash,
      required this.validUntil,
      required this.gasPayment})
      : super._();
  @override
  OrderEvmAction rebuild(void Function(OrderEvmActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderEvmActionBuilder toBuilder() => OrderEvmActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderEvmAction &&
        orderId == other.orderId &&
        stepId == other.stepId &&
        ordinal == other.ordinal &&
        kind == other.kind &&
        chainId == other.chainId &&
        from == other.from &&
        to == other.to &&
        data == other.data &&
        value == other.value &&
        payloadHash == other.payloadHash &&
        validUntil == other.validUntil &&
        gasPayment == other.gasPayment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, stepId.hashCode);
    _$hash = $jc(_$hash, ordinal.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, gasPayment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderEvmAction')
          ..add('orderId', orderId)
          ..add('stepId', stepId)
          ..add('ordinal', ordinal)
          ..add('kind', kind)
          ..add('chainId', chainId)
          ..add('from', from)
          ..add('to', to)
          ..add('data', data)
          ..add('value', value)
          ..add('payloadHash', payloadHash)
          ..add('validUntil', validUntil)
          ..add('gasPayment', gasPayment))
        .toString();
  }
}

class OrderEvmActionBuilder
    implements Builder<OrderEvmAction, OrderEvmActionBuilder> {
  _$OrderEvmAction? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _stepId;
  String? get stepId => _$this._stepId;
  set stepId(String? stepId) => _$this._stepId = stepId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  OrderEvmActionKindEnum? _kind;
  OrderEvmActionKindEnum? get kind => _$this._kind;
  set kind(OrderEvmActionKindEnum? kind) => _$this._kind = kind;

  OrderEvmActionChainIdEnum? _chainId;
  OrderEvmActionChainIdEnum? get chainId => _$this._chainId;
  set chainId(OrderEvmActionChainIdEnum? chainId) => _$this._chainId = chainId;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  OrderEvmActionValueEnum? _value;
  OrderEvmActionValueEnum? get value => _$this._value;
  set value(OrderEvmActionValueEnum? value) => _$this._value = value;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  OrderActionGasPaymentBuilder? _gasPayment;
  OrderActionGasPaymentBuilder get gasPayment =>
      _$this._gasPayment ??= OrderActionGasPaymentBuilder();
  set gasPayment(OrderActionGasPaymentBuilder? gasPayment) =>
      _$this._gasPayment = gasPayment;

  OrderEvmActionBuilder() {
    OrderEvmAction._defaults(this);
  }

  OrderEvmActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _stepId = $v.stepId;
      _ordinal = $v.ordinal;
      _kind = $v.kind;
      _chainId = $v.chainId;
      _from = $v.from;
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _payloadHash = $v.payloadHash;
      _validUntil = $v.validUntil;
      _gasPayment = $v.gasPayment.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderEvmAction other) {
    _$v = other as _$OrderEvmAction;
  }

  @override
  void update(void Function(OrderEvmActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderEvmAction build() => _build();

  _$OrderEvmAction _build() {
    _$OrderEvmAction _$result;
    try {
      _$result = _$v ??
          _$OrderEvmAction._(
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'OrderEvmAction', 'orderId'),
            stepId: BuiltValueNullFieldError.checkNotNull(
                stepId, r'OrderEvmAction', 'stepId'),
            ordinal: BuiltValueNullFieldError.checkNotNull(
                ordinal, r'OrderEvmAction', 'ordinal'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'OrderEvmAction', 'kind'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'OrderEvmAction', 'chainId'),
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'OrderEvmAction', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'OrderEvmAction', 'to'),
            data: BuiltValueNullFieldError.checkNotNull(
                data, r'OrderEvmAction', 'data'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'OrderEvmAction', 'value'),
            payloadHash: BuiltValueNullFieldError.checkNotNull(
                payloadHash, r'OrderEvmAction', 'payloadHash'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'OrderEvmAction', 'validUntil'),
            gasPayment: gasPayment.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gasPayment';
        gasPayment.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderEvmAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
