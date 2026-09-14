// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'origin_transaction_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OriginTransactionActionKindEnum
    _$originTransactionActionKindEnum_originTransaction =
    const OriginTransactionActionKindEnum._('originTransaction');
const OriginTransactionActionKindEnum
    _$originTransactionActionKindEnum_unknownDefaultOpenApi =
    const OriginTransactionActionKindEnum._('unknownDefaultOpenApi');

OriginTransactionActionKindEnum _$originTransactionActionKindEnumValueOf(
    String name) {
  switch (name) {
    case 'originTransaction':
      return _$originTransactionActionKindEnum_originTransaction;
    case 'unknownDefaultOpenApi':
      return _$originTransactionActionKindEnum_unknownDefaultOpenApi;
    default:
      return _$originTransactionActionKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OriginTransactionActionKindEnum>
    _$originTransactionActionKindEnumValues = BuiltSet<
        OriginTransactionActionKindEnum>(const <OriginTransactionActionKindEnum>[
  _$originTransactionActionKindEnum_originTransaction,
  _$originTransactionActionKindEnum_unknownDefaultOpenApi,
]);

const OriginTransactionActionChainIdEnum
    _$originTransactionActionChainIdEnum_number1 =
    const OriginTransactionActionChainIdEnum._('number1');
const OriginTransactionActionChainIdEnum
    _$originTransactionActionChainIdEnum_number56 =
    const OriginTransactionActionChainIdEnum._('number56');
const OriginTransactionActionChainIdEnum
    _$originTransactionActionChainIdEnum_number8453 =
    const OriginTransactionActionChainIdEnum._('number8453');
const OriginTransactionActionChainIdEnum
    _$originTransactionActionChainIdEnum_number42161 =
    const OriginTransactionActionChainIdEnum._('number42161');
const OriginTransactionActionChainIdEnum
    _$originTransactionActionChainIdEnum_unknownDefaultOpenApi =
    const OriginTransactionActionChainIdEnum._('unknownDefaultOpenApi');

OriginTransactionActionChainIdEnum _$originTransactionActionChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$originTransactionActionChainIdEnum_number1;
    case 'number56':
      return _$originTransactionActionChainIdEnum_number56;
    case 'number8453':
      return _$originTransactionActionChainIdEnum_number8453;
    case 'number42161':
      return _$originTransactionActionChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$originTransactionActionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$originTransactionActionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OriginTransactionActionChainIdEnum>
    _$originTransactionActionChainIdEnumValues = BuiltSet<
        OriginTransactionActionChainIdEnum>(const <OriginTransactionActionChainIdEnum>[
  _$originTransactionActionChainIdEnum_number1,
  _$originTransactionActionChainIdEnum_number56,
  _$originTransactionActionChainIdEnum_number8453,
  _$originTransactionActionChainIdEnum_number42161,
  _$originTransactionActionChainIdEnum_unknownDefaultOpenApi,
]);

const OriginTransactionActionValueEnum _$originTransactionActionValueEnum_n0x0 =
    const OriginTransactionActionValueEnum._('n0x0');
const OriginTransactionActionValueEnum
    _$originTransactionActionValueEnum_unknownDefaultOpenApi =
    const OriginTransactionActionValueEnum._('unknownDefaultOpenApi');

OriginTransactionActionValueEnum _$originTransactionActionValueEnumValueOf(
    String name) {
  switch (name) {
    case 'n0x0':
      return _$originTransactionActionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$originTransactionActionValueEnum_unknownDefaultOpenApi;
    default:
      return _$originTransactionActionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OriginTransactionActionValueEnum>
    _$originTransactionActionValueEnumValues = BuiltSet<
        OriginTransactionActionValueEnum>(const <OriginTransactionActionValueEnum>[
  _$originTransactionActionValueEnum_n0x0,
  _$originTransactionActionValueEnum_unknownDefaultOpenApi,
]);

Serializer<OriginTransactionActionKindEnum>
    _$originTransactionActionKindEnumSerializer =
    _$OriginTransactionActionKindEnumSerializer();
Serializer<OriginTransactionActionChainIdEnum>
    _$originTransactionActionChainIdEnumSerializer =
    _$OriginTransactionActionChainIdEnumSerializer();
Serializer<OriginTransactionActionValueEnum>
    _$originTransactionActionValueEnumSerializer =
    _$OriginTransactionActionValueEnumSerializer();

class _$OriginTransactionActionKindEnumSerializer
    implements PrimitiveSerializer<OriginTransactionActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'originTransaction': 'origin_transaction',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'origin_transaction': 'originTransaction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OriginTransactionActionKindEnum];
  @override
  final String wireName = 'OriginTransactionActionKindEnum';

  @override
  Object serialize(
          Serializers serializers, OriginTransactionActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OriginTransactionActionKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OriginTransactionActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OriginTransactionActionChainIdEnumSerializer
    implements PrimitiveSerializer<OriginTransactionActionChainIdEnum> {
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
  final Iterable<Type> types = const <Type>[OriginTransactionActionChainIdEnum];
  @override
  final String wireName = 'OriginTransactionActionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, OriginTransactionActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OriginTransactionActionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OriginTransactionActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OriginTransactionActionValueEnumSerializer
    implements PrimitiveSerializer<OriginTransactionActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OriginTransactionActionValueEnum];
  @override
  final String wireName = 'OriginTransactionActionValueEnum';

  @override
  Object serialize(
          Serializers serializers, OriginTransactionActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OriginTransactionActionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OriginTransactionActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OriginTransactionAction extends OriginTransactionAction {
  @override
  final String actionId;
  @override
  final int ordinal;
  @override
  final OriginTransactionActionKindEnum kind;
  @override
  final OriginTransactionActionChainIdEnum chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final OriginTransactionActionValueEnum value;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;
  @override
  final TransferActionStatus status;
  @override
  final GasPaymentQuote? gasPayment;
  @override
  final String recipient;
  @override
  final String refundAddress;

  factory _$OriginTransactionAction(
          [void Function(OriginTransactionActionBuilder)? updates]) =>
      (OriginTransactionActionBuilder()..update(updates))._build();

  _$OriginTransactionAction._(
      {required this.actionId,
      required this.ordinal,
      required this.kind,
      required this.chainId,
      required this.from,
      required this.to,
      required this.data,
      required this.value,
      required this.payloadHash,
      required this.validUntil,
      required this.status,
      this.gasPayment,
      required this.recipient,
      required this.refundAddress})
      : super._();
  @override
  OriginTransactionAction rebuild(
          void Function(OriginTransactionActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OriginTransactionActionBuilder toBuilder() =>
      OriginTransactionActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OriginTransactionAction &&
        actionId == other.actionId &&
        ordinal == other.ordinal &&
        kind == other.kind &&
        chainId == other.chainId &&
        from == other.from &&
        to == other.to &&
        data == other.data &&
        value == other.value &&
        payloadHash == other.payloadHash &&
        validUntil == other.validUntil &&
        status == other.status &&
        gasPayment == other.gasPayment &&
        recipient == other.recipient &&
        refundAddress == other.refundAddress;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, ordinal.hashCode);
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, gasPayment.hashCode);
    _$hash = $jc(_$hash, recipient.hashCode);
    _$hash = $jc(_$hash, refundAddress.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OriginTransactionAction')
          ..add('actionId', actionId)
          ..add('ordinal', ordinal)
          ..add('kind', kind)
          ..add('chainId', chainId)
          ..add('from', from)
          ..add('to', to)
          ..add('data', data)
          ..add('value', value)
          ..add('payloadHash', payloadHash)
          ..add('validUntil', validUntil)
          ..add('status', status)
          ..add('gasPayment', gasPayment)
          ..add('recipient', recipient)
          ..add('refundAddress', refundAddress))
        .toString();
  }
}

class OriginTransactionActionBuilder
    implements
        Builder<OriginTransactionAction, OriginTransactionActionBuilder> {
  _$OriginTransactionAction? _$v;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  OriginTransactionActionKindEnum? _kind;
  OriginTransactionActionKindEnum? get kind => _$this._kind;
  set kind(OriginTransactionActionKindEnum? kind) => _$this._kind = kind;

  OriginTransactionActionChainIdEnum? _chainId;
  OriginTransactionActionChainIdEnum? get chainId => _$this._chainId;
  set chainId(OriginTransactionActionChainIdEnum? chainId) =>
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

  OriginTransactionActionValueEnum? _value;
  OriginTransactionActionValueEnum? get value => _$this._value;
  set value(OriginTransactionActionValueEnum? value) => _$this._value = value;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  TransferActionStatus? _status;
  TransferActionStatus? get status => _$this._status;
  set status(TransferActionStatus? status) => _$this._status = status;

  GasPaymentQuoteBuilder? _gasPayment;
  GasPaymentQuoteBuilder get gasPayment =>
      _$this._gasPayment ??= GasPaymentQuoteBuilder();
  set gasPayment(GasPaymentQuoteBuilder? gasPayment) =>
      _$this._gasPayment = gasPayment;

  String? _recipient;
  String? get recipient => _$this._recipient;
  set recipient(String? recipient) => _$this._recipient = recipient;

  String? _refundAddress;
  String? get refundAddress => _$this._refundAddress;
  set refundAddress(String? refundAddress) =>
      _$this._refundAddress = refundAddress;

  OriginTransactionActionBuilder() {
    OriginTransactionAction._defaults(this);
  }

  OriginTransactionActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actionId = $v.actionId;
      _ordinal = $v.ordinal;
      _kind = $v.kind;
      _chainId = $v.chainId;
      _from = $v.from;
      _to = $v.to;
      _data = $v.data;
      _value = $v.value;
      _payloadHash = $v.payloadHash;
      _validUntil = $v.validUntil;
      _status = $v.status;
      _gasPayment = $v.gasPayment?.toBuilder();
      _recipient = $v.recipient;
      _refundAddress = $v.refundAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OriginTransactionAction other) {
    _$v = other as _$OriginTransactionAction;
  }

  @override
  void update(void Function(OriginTransactionActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OriginTransactionAction build() => _build();

  _$OriginTransactionAction _build() {
    _$OriginTransactionAction _$result;
    try {
      _$result = _$v ??
          _$OriginTransactionAction._(
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'OriginTransactionAction', 'actionId'),
            ordinal: BuiltValueNullFieldError.checkNotNull(
                ordinal, r'OriginTransactionAction', 'ordinal'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'OriginTransactionAction', 'kind'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'OriginTransactionAction', 'chainId'),
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'OriginTransactionAction', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'OriginTransactionAction', 'to'),
            data: BuiltValueNullFieldError.checkNotNull(
                data, r'OriginTransactionAction', 'data'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'OriginTransactionAction', 'value'),
            payloadHash: BuiltValueNullFieldError.checkNotNull(
                payloadHash, r'OriginTransactionAction', 'payloadHash'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'OriginTransactionAction', 'validUntil'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'OriginTransactionAction', 'status'),
            gasPayment: _gasPayment?.build(),
            recipient: BuiltValueNullFieldError.checkNotNull(
                recipient, r'OriginTransactionAction', 'recipient'),
            refundAddress: BuiltValueNullFieldError.checkNotNull(
                refundAddress, r'OriginTransactionAction', 'refundAddress'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gasPayment';
        _gasPayment?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OriginTransactionAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
