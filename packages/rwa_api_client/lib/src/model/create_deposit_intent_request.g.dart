// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_deposit_intent_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateDepositIntentRequestChainEnum
    _$createDepositIntentRequestChainEnum_BSC =
    const CreateDepositIntentRequestChainEnum._('BSC');
const CreateDepositIntentRequestChainEnum
    _$createDepositIntentRequestChainEnum_arbitrum =
    const CreateDepositIntentRequestChainEnum._('arbitrum');
const CreateDepositIntentRequestChainEnum
    _$createDepositIntentRequestChainEnum_unknownDefaultOpenApi =
    const CreateDepositIntentRequestChainEnum._('unknownDefaultOpenApi');

CreateDepositIntentRequestChainEnum
    _$createDepositIntentRequestChainEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$createDepositIntentRequestChainEnum_BSC;
    case 'arbitrum':
      return _$createDepositIntentRequestChainEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$createDepositIntentRequestChainEnum_unknownDefaultOpenApi;
    default:
      return _$createDepositIntentRequestChainEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateDepositIntentRequestChainEnum>
    _$createDepositIntentRequestChainEnumValues = BuiltSet<
        CreateDepositIntentRequestChainEnum>(const <CreateDepositIntentRequestChainEnum>[
  _$createDepositIntentRequestChainEnum_BSC,
  _$createDepositIntentRequestChainEnum_arbitrum,
  _$createDepositIntentRequestChainEnum_unknownDefaultOpenApi,
]);

const CreateDepositIntentRequestTokenEnum
    _$createDepositIntentRequestTokenEnum_USDC =
    const CreateDepositIntentRequestTokenEnum._('USDC');
const CreateDepositIntentRequestTokenEnum
    _$createDepositIntentRequestTokenEnum_unknownDefaultOpenApi =
    const CreateDepositIntentRequestTokenEnum._('unknownDefaultOpenApi');

CreateDepositIntentRequestTokenEnum
    _$createDepositIntentRequestTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$createDepositIntentRequestTokenEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$createDepositIntentRequestTokenEnum_unknownDefaultOpenApi;
    default:
      return _$createDepositIntentRequestTokenEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<CreateDepositIntentRequestTokenEnum>
    _$createDepositIntentRequestTokenEnumValues = BuiltSet<
        CreateDepositIntentRequestTokenEnum>(const <CreateDepositIntentRequestTokenEnum>[
  _$createDepositIntentRequestTokenEnum_USDC,
  _$createDepositIntentRequestTokenEnum_unknownDefaultOpenApi,
]);

Serializer<CreateDepositIntentRequestChainEnum>
    _$createDepositIntentRequestChainEnumSerializer =
    _$CreateDepositIntentRequestChainEnumSerializer();
Serializer<CreateDepositIntentRequestTokenEnum>
    _$createDepositIntentRequestTokenEnumSerializer =
    _$CreateDepositIntentRequestTokenEnumSerializer();

class _$CreateDepositIntentRequestChainEnumSerializer
    implements PrimitiveSerializer<CreateDepositIntentRequestChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'Arbitrum': 'arbitrum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateDepositIntentRequestChainEnum
  ];
  @override
  final String wireName = 'CreateDepositIntentRequestChainEnum';

  @override
  Object serialize(
          Serializers serializers, CreateDepositIntentRequestChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateDepositIntentRequestChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateDepositIntentRequestChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateDepositIntentRequestTokenEnumSerializer
    implements PrimitiveSerializer<CreateDepositIntentRequestTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateDepositIntentRequestTokenEnum
  ];
  @override
  final String wireName = 'CreateDepositIntentRequestTokenEnum';

  @override
  Object serialize(
          Serializers serializers, CreateDepositIntentRequestTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateDepositIntentRequestTokenEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateDepositIntentRequestTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateDepositIntentRequest extends CreateDepositIntentRequest {
  @override
  final CreateDepositIntentRequestChainEnum chain;
  @override
  final CreateDepositIntentRequestTokenEnum token;
  @override
  final String? amount;
  @override
  final DepositMode? mode;

  factory _$CreateDepositIntentRequest(
          [void Function(CreateDepositIntentRequestBuilder)? updates]) =>
      (CreateDepositIntentRequestBuilder()..update(updates))._build();

  _$CreateDepositIntentRequest._(
      {required this.chain, required this.token, this.amount, this.mode})
      : super._();
  @override
  CreateDepositIntentRequest rebuild(
          void Function(CreateDepositIntentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDepositIntentRequestBuilder toBuilder() =>
      CreateDepositIntentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDepositIntentRequest &&
        chain == other.chain &&
        token == other.token &&
        amount == other.amount &&
        mode == other.mode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateDepositIntentRequest')
          ..add('chain', chain)
          ..add('token', token)
          ..add('amount', amount)
          ..add('mode', mode))
        .toString();
  }
}

class CreateDepositIntentRequestBuilder
    implements
        Builder<CreateDepositIntentRequest, CreateDepositIntentRequestBuilder> {
  _$CreateDepositIntentRequest? _$v;

  CreateDepositIntentRequestChainEnum? _chain;
  CreateDepositIntentRequestChainEnum? get chain => _$this._chain;
  set chain(CreateDepositIntentRequestChainEnum? chain) =>
      _$this._chain = chain;

  CreateDepositIntentRequestTokenEnum? _token;
  CreateDepositIntentRequestTokenEnum? get token => _$this._token;
  set token(CreateDepositIntentRequestTokenEnum? token) =>
      _$this._token = token;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  DepositMode? _mode;
  DepositMode? get mode => _$this._mode;
  set mode(DepositMode? mode) => _$this._mode = mode;

  CreateDepositIntentRequestBuilder() {
    CreateDepositIntentRequest._defaults(this);
  }

  CreateDepositIntentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chain = $v.chain;
      _token = $v.token;
      _amount = $v.amount;
      _mode = $v.mode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDepositIntentRequest other) {
    _$v = other as _$CreateDepositIntentRequest;
  }

  @override
  void update(void Function(CreateDepositIntentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDepositIntentRequest build() => _build();

  _$CreateDepositIntentRequest _build() {
    final _$result = _$v ??
        _$CreateDepositIntentRequest._(
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'CreateDepositIntentRequest', 'chain'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'CreateDepositIntentRequest', 'token'),
          amount: amount,
          mode: mode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
