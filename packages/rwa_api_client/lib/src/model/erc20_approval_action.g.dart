// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'erc20_approval_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Erc20ApprovalActionKindEnum _$erc20ApprovalActionKindEnum_erc20Approval =
    const Erc20ApprovalActionKindEnum._('erc20Approval');
const Erc20ApprovalActionKindEnum
    _$erc20ApprovalActionKindEnum_unknownDefaultOpenApi =
    const Erc20ApprovalActionKindEnum._('unknownDefaultOpenApi');

Erc20ApprovalActionKindEnum _$erc20ApprovalActionKindEnumValueOf(String name) {
  switch (name) {
    case 'erc20Approval':
      return _$erc20ApprovalActionKindEnum_erc20Approval;
    case 'unknownDefaultOpenApi':
      return _$erc20ApprovalActionKindEnum_unknownDefaultOpenApi;
    default:
      return _$erc20ApprovalActionKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Erc20ApprovalActionKindEnum>
    _$erc20ApprovalActionKindEnumValues =
    BuiltSet<Erc20ApprovalActionKindEnum>(const <Erc20ApprovalActionKindEnum>[
  _$erc20ApprovalActionKindEnum_erc20Approval,
  _$erc20ApprovalActionKindEnum_unknownDefaultOpenApi,
]);

const Erc20ApprovalActionChainIdEnum _$erc20ApprovalActionChainIdEnum_number1 =
    const Erc20ApprovalActionChainIdEnum._('number1');
const Erc20ApprovalActionChainIdEnum _$erc20ApprovalActionChainIdEnum_number56 =
    const Erc20ApprovalActionChainIdEnum._('number56');
const Erc20ApprovalActionChainIdEnum
    _$erc20ApprovalActionChainIdEnum_number8453 =
    const Erc20ApprovalActionChainIdEnum._('number8453');
const Erc20ApprovalActionChainIdEnum
    _$erc20ApprovalActionChainIdEnum_number42161 =
    const Erc20ApprovalActionChainIdEnum._('number42161');
const Erc20ApprovalActionChainIdEnum
    _$erc20ApprovalActionChainIdEnum_unknownDefaultOpenApi =
    const Erc20ApprovalActionChainIdEnum._('unknownDefaultOpenApi');

Erc20ApprovalActionChainIdEnum _$erc20ApprovalActionChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number1':
      return _$erc20ApprovalActionChainIdEnum_number1;
    case 'number56':
      return _$erc20ApprovalActionChainIdEnum_number56;
    case 'number8453':
      return _$erc20ApprovalActionChainIdEnum_number8453;
    case 'number42161':
      return _$erc20ApprovalActionChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$erc20ApprovalActionChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$erc20ApprovalActionChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Erc20ApprovalActionChainIdEnum>
    _$erc20ApprovalActionChainIdEnumValues = BuiltSet<
        Erc20ApprovalActionChainIdEnum>(const <Erc20ApprovalActionChainIdEnum>[
  _$erc20ApprovalActionChainIdEnum_number1,
  _$erc20ApprovalActionChainIdEnum_number56,
  _$erc20ApprovalActionChainIdEnum_number8453,
  _$erc20ApprovalActionChainIdEnum_number42161,
  _$erc20ApprovalActionChainIdEnum_unknownDefaultOpenApi,
]);

const Erc20ApprovalActionValueEnum _$erc20ApprovalActionValueEnum_n0x0 =
    const Erc20ApprovalActionValueEnum._('n0x0');
const Erc20ApprovalActionValueEnum
    _$erc20ApprovalActionValueEnum_unknownDefaultOpenApi =
    const Erc20ApprovalActionValueEnum._('unknownDefaultOpenApi');

Erc20ApprovalActionValueEnum _$erc20ApprovalActionValueEnumValueOf(
    String name) {
  switch (name) {
    case 'n0x0':
      return _$erc20ApprovalActionValueEnum_n0x0;
    case 'unknownDefaultOpenApi':
      return _$erc20ApprovalActionValueEnum_unknownDefaultOpenApi;
    default:
      return _$erc20ApprovalActionValueEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Erc20ApprovalActionValueEnum>
    _$erc20ApprovalActionValueEnumValues =
    BuiltSet<Erc20ApprovalActionValueEnum>(const <Erc20ApprovalActionValueEnum>[
  _$erc20ApprovalActionValueEnum_n0x0,
  _$erc20ApprovalActionValueEnum_unknownDefaultOpenApi,
]);

Serializer<Erc20ApprovalActionKindEnum>
    _$erc20ApprovalActionKindEnumSerializer =
    _$Erc20ApprovalActionKindEnumSerializer();
Serializer<Erc20ApprovalActionChainIdEnum>
    _$erc20ApprovalActionChainIdEnumSerializer =
    _$Erc20ApprovalActionChainIdEnumSerializer();
Serializer<Erc20ApprovalActionValueEnum>
    _$erc20ApprovalActionValueEnumSerializer =
    _$Erc20ApprovalActionValueEnumSerializer();

class _$Erc20ApprovalActionKindEnumSerializer
    implements PrimitiveSerializer<Erc20ApprovalActionKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'erc20Approval': 'erc20_approval',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'erc20_approval': 'erc20Approval',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Erc20ApprovalActionKindEnum];
  @override
  final String wireName = 'Erc20ApprovalActionKindEnum';

  @override
  Object serialize(Serializers serializers, Erc20ApprovalActionKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Erc20ApprovalActionKindEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Erc20ApprovalActionKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Erc20ApprovalActionChainIdEnumSerializer
    implements PrimitiveSerializer<Erc20ApprovalActionChainIdEnum> {
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
  final Iterable<Type> types = const <Type>[Erc20ApprovalActionChainIdEnum];
  @override
  final String wireName = 'Erc20ApprovalActionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, Erc20ApprovalActionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Erc20ApprovalActionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Erc20ApprovalActionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Erc20ApprovalActionValueEnumSerializer
    implements PrimitiveSerializer<Erc20ApprovalActionValueEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0': '0x0',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0': 'n0x0',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Erc20ApprovalActionValueEnum];
  @override
  final String wireName = 'Erc20ApprovalActionValueEnum';

  @override
  Object serialize(Serializers serializers, Erc20ApprovalActionValueEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Erc20ApprovalActionValueEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Erc20ApprovalActionValueEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Erc20ApprovalAction extends Erc20ApprovalAction {
  @override
  final String actionId;
  @override
  final int ordinal;
  @override
  final Erc20ApprovalActionKindEnum kind;
  @override
  final Erc20ApprovalActionChainIdEnum chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String data;
  @override
  final Erc20ApprovalActionValueEnum value;
  @override
  final String payloadHash;
  @override
  final DateTime validUntil;
  @override
  final TransferActionStatus status;
  @override
  final GasPaymentQuote? gasPayment;
  @override
  final String tokenContract;
  @override
  final String spender;
  @override
  final String approvalAmount;

  factory _$Erc20ApprovalAction(
          [void Function(Erc20ApprovalActionBuilder)? updates]) =>
      (Erc20ApprovalActionBuilder()..update(updates))._build();

  _$Erc20ApprovalAction._(
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
      required this.tokenContract,
      required this.spender,
      required this.approvalAmount})
      : super._();
  @override
  Erc20ApprovalAction rebuild(
          void Function(Erc20ApprovalActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Erc20ApprovalActionBuilder toBuilder() =>
      Erc20ApprovalActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Erc20ApprovalAction &&
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
        tokenContract == other.tokenContract &&
        spender == other.spender &&
        approvalAmount == other.approvalAmount;
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
    _$hash = $jc(_$hash, tokenContract.hashCode);
    _$hash = $jc(_$hash, spender.hashCode);
    _$hash = $jc(_$hash, approvalAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Erc20ApprovalAction')
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
          ..add('tokenContract', tokenContract)
          ..add('spender', spender)
          ..add('approvalAmount', approvalAmount))
        .toString();
  }
}

class Erc20ApprovalActionBuilder
    implements Builder<Erc20ApprovalAction, Erc20ApprovalActionBuilder> {
  _$Erc20ApprovalAction? _$v;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  int? _ordinal;
  int? get ordinal => _$this._ordinal;
  set ordinal(int? ordinal) => _$this._ordinal = ordinal;

  Erc20ApprovalActionKindEnum? _kind;
  Erc20ApprovalActionKindEnum? get kind => _$this._kind;
  set kind(Erc20ApprovalActionKindEnum? kind) => _$this._kind = kind;

  Erc20ApprovalActionChainIdEnum? _chainId;
  Erc20ApprovalActionChainIdEnum? get chainId => _$this._chainId;
  set chainId(Erc20ApprovalActionChainIdEnum? chainId) =>
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

  Erc20ApprovalActionValueEnum? _value;
  Erc20ApprovalActionValueEnum? get value => _$this._value;
  set value(Erc20ApprovalActionValueEnum? value) => _$this._value = value;

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

  String? _tokenContract;
  String? get tokenContract => _$this._tokenContract;
  set tokenContract(String? tokenContract) =>
      _$this._tokenContract = tokenContract;

  String? _spender;
  String? get spender => _$this._spender;
  set spender(String? spender) => _$this._spender = spender;

  String? _approvalAmount;
  String? get approvalAmount => _$this._approvalAmount;
  set approvalAmount(String? approvalAmount) =>
      _$this._approvalAmount = approvalAmount;

  Erc20ApprovalActionBuilder() {
    Erc20ApprovalAction._defaults(this);
  }

  Erc20ApprovalActionBuilder get _$this {
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
      _tokenContract = $v.tokenContract;
      _spender = $v.spender;
      _approvalAmount = $v.approvalAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Erc20ApprovalAction other) {
    _$v = other as _$Erc20ApprovalAction;
  }

  @override
  void update(void Function(Erc20ApprovalActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Erc20ApprovalAction build() => _build();

  _$Erc20ApprovalAction _build() {
    _$Erc20ApprovalAction _$result;
    try {
      _$result = _$v ??
          _$Erc20ApprovalAction._(
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'Erc20ApprovalAction', 'actionId'),
            ordinal: BuiltValueNullFieldError.checkNotNull(
                ordinal, r'Erc20ApprovalAction', 'ordinal'),
            kind: BuiltValueNullFieldError.checkNotNull(
                kind, r'Erc20ApprovalAction', 'kind'),
            chainId: BuiltValueNullFieldError.checkNotNull(
                chainId, r'Erc20ApprovalAction', 'chainId'),
            from: BuiltValueNullFieldError.checkNotNull(
                from, r'Erc20ApprovalAction', 'from'),
            to: BuiltValueNullFieldError.checkNotNull(
                to, r'Erc20ApprovalAction', 'to'),
            data: BuiltValueNullFieldError.checkNotNull(
                data, r'Erc20ApprovalAction', 'data'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'Erc20ApprovalAction', 'value'),
            payloadHash: BuiltValueNullFieldError.checkNotNull(
                payloadHash, r'Erc20ApprovalAction', 'payloadHash'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'Erc20ApprovalAction', 'validUntil'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Erc20ApprovalAction', 'status'),
            gasPayment: _gasPayment?.build(),
            tokenContract: BuiltValueNullFieldError.checkNotNull(
                tokenContract, r'Erc20ApprovalAction', 'tokenContract'),
            spender: BuiltValueNullFieldError.checkNotNull(
                spender, r'Erc20ApprovalAction', 'spender'),
            approvalAmount: BuiltValueNullFieldError.checkNotNull(
                approvalAmount, r'Erc20ApprovalAction', 'approvalAmount'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'gasPayment';
        _gasPayment?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Erc20ApprovalAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
