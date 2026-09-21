// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_authorization_body.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrivyAuthorizationBodyMethodEnum
    _$privyAuthorizationBodyMethodEnum_ethSendTransaction =
    const PrivyAuthorizationBodyMethodEnum._('ethSendTransaction');
const PrivyAuthorizationBodyMethodEnum
    _$privyAuthorizationBodyMethodEnum_unknownDefaultOpenApi =
    const PrivyAuthorizationBodyMethodEnum._('unknownDefaultOpenApi');

PrivyAuthorizationBodyMethodEnum _$privyAuthorizationBodyMethodEnumValueOf(
    String name) {
  switch (name) {
    case 'ethSendTransaction':
      return _$privyAuthorizationBodyMethodEnum_ethSendTransaction;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationBodyMethodEnum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationBodyMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationBodyMethodEnum>
    _$privyAuthorizationBodyMethodEnumValues = BuiltSet<
        PrivyAuthorizationBodyMethodEnum>(const <PrivyAuthorizationBodyMethodEnum>[
  _$privyAuthorizationBodyMethodEnum_ethSendTransaction,
  _$privyAuthorizationBodyMethodEnum_unknownDefaultOpenApi,
]);

const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon1 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon1');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon56 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon56');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon97 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon97');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon8453 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon8453');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon42161 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon42161');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_eip155Colon421614 =
    const PrivyAuthorizationBodyCaip2Enum._('eip155Colon421614');
const PrivyAuthorizationBodyCaip2Enum
    _$privyAuthorizationBodyCaip2Enum_unknownDefaultOpenApi =
    const PrivyAuthorizationBodyCaip2Enum._('unknownDefaultOpenApi');

PrivyAuthorizationBodyCaip2Enum _$privyAuthorizationBodyCaip2EnumValueOf(
    String name) {
  switch (name) {
    case 'eip155Colon1':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon1;
    case 'eip155Colon56':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon56;
    case 'eip155Colon97':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon97;
    case 'eip155Colon8453':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon8453;
    case 'eip155Colon42161':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon42161;
    case 'eip155Colon421614':
      return _$privyAuthorizationBodyCaip2Enum_eip155Colon421614;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationBodyCaip2Enum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationBodyCaip2Enum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationBodyCaip2Enum>
    _$privyAuthorizationBodyCaip2EnumValues = BuiltSet<
        PrivyAuthorizationBodyCaip2Enum>(const <PrivyAuthorizationBodyCaip2Enum>[
  _$privyAuthorizationBodyCaip2Enum_eip155Colon1,
  _$privyAuthorizationBodyCaip2Enum_eip155Colon56,
  _$privyAuthorizationBodyCaip2Enum_eip155Colon97,
  _$privyAuthorizationBodyCaip2Enum_eip155Colon8453,
  _$privyAuthorizationBodyCaip2Enum_eip155Colon42161,
  _$privyAuthorizationBodyCaip2Enum_eip155Colon421614,
  _$privyAuthorizationBodyCaip2Enum_unknownDefaultOpenApi,
]);

const PrivyAuthorizationBodyChainTypeEnum
    _$privyAuthorizationBodyChainTypeEnum_ethereum =
    const PrivyAuthorizationBodyChainTypeEnum._('ethereum');
const PrivyAuthorizationBodyChainTypeEnum
    _$privyAuthorizationBodyChainTypeEnum_unknownDefaultOpenApi =
    const PrivyAuthorizationBodyChainTypeEnum._('unknownDefaultOpenApi');

PrivyAuthorizationBodyChainTypeEnum
    _$privyAuthorizationBodyChainTypeEnumValueOf(String name) {
  switch (name) {
    case 'ethereum':
      return _$privyAuthorizationBodyChainTypeEnum_ethereum;
    case 'unknownDefaultOpenApi':
      return _$privyAuthorizationBodyChainTypeEnum_unknownDefaultOpenApi;
    default:
      return _$privyAuthorizationBodyChainTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyAuthorizationBodyChainTypeEnum>
    _$privyAuthorizationBodyChainTypeEnumValues = BuiltSet<
        PrivyAuthorizationBodyChainTypeEnum>(const <PrivyAuthorizationBodyChainTypeEnum>[
  _$privyAuthorizationBodyChainTypeEnum_ethereum,
  _$privyAuthorizationBodyChainTypeEnum_unknownDefaultOpenApi,
]);

Serializer<PrivyAuthorizationBodyMethodEnum>
    _$privyAuthorizationBodyMethodEnumSerializer =
    _$PrivyAuthorizationBodyMethodEnumSerializer();
Serializer<PrivyAuthorizationBodyCaip2Enum>
    _$privyAuthorizationBodyCaip2EnumSerializer =
    _$PrivyAuthorizationBodyCaip2EnumSerializer();
Serializer<PrivyAuthorizationBodyChainTypeEnum>
    _$privyAuthorizationBodyChainTypeEnumSerializer =
    _$PrivyAuthorizationBodyChainTypeEnumSerializer();

class _$PrivyAuthorizationBodyMethodEnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationBodyMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ethSendTransaction': 'eth_sendTransaction',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eth_sendTransaction': 'ethSendTransaction',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PrivyAuthorizationBodyMethodEnum];
  @override
  final String wireName = 'PrivyAuthorizationBodyMethodEnum';

  @override
  Object serialize(
          Serializers serializers, PrivyAuthorizationBodyMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationBodyMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationBodyMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationBodyCaip2EnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationBodyCaip2Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eip155Colon1': 'eip155:1',
    'eip155Colon56': 'eip155:56',
    'eip155Colon97': 'eip155:97',
    'eip155Colon8453': 'eip155:8453',
    'eip155Colon42161': 'eip155:42161',
    'eip155Colon421614': 'eip155:421614',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eip155:1': 'eip155Colon1',
    'eip155:56': 'eip155Colon56',
    'eip155:97': 'eip155Colon97',
    'eip155:8453': 'eip155Colon8453',
    'eip155:42161': 'eip155Colon42161',
    'eip155:421614': 'eip155Colon421614',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PrivyAuthorizationBodyCaip2Enum];
  @override
  final String wireName = 'PrivyAuthorizationBodyCaip2Enum';

  @override
  Object serialize(
          Serializers serializers, PrivyAuthorizationBodyCaip2Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationBodyCaip2Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationBodyCaip2Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationBodyChainTypeEnumSerializer
    implements PrimitiveSerializer<PrivyAuthorizationBodyChainTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ethereum': 'ethereum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ethereum': 'ethereum',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PrivyAuthorizationBodyChainTypeEnum
  ];
  @override
  final String wireName = 'PrivyAuthorizationBodyChainTypeEnum';

  @override
  Object serialize(
          Serializers serializers, PrivyAuthorizationBodyChainTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyAuthorizationBodyChainTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyAuthorizationBodyChainTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyAuthorizationBody extends PrivyAuthorizationBody {
  @override
  final PrivyAuthorizationBodyMethodEnum method;
  @override
  final PrivyAuthorizationBodyCaip2Enum caip2;
  @override
  final PrivyAuthorizationBodyChainTypeEnum chainType;
  @override
  final bool sponsor;
  @override
  final String referenceId;
  @override
  final PrivyAuthorizationParams params;

  factory _$PrivyAuthorizationBody(
          [void Function(PrivyAuthorizationBodyBuilder)? updates]) =>
      (PrivyAuthorizationBodyBuilder()..update(updates))._build();

  _$PrivyAuthorizationBody._(
      {required this.method,
      required this.caip2,
      required this.chainType,
      required this.sponsor,
      required this.referenceId,
      required this.params})
      : super._();
  @override
  PrivyAuthorizationBody rebuild(
          void Function(PrivyAuthorizationBodyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyAuthorizationBodyBuilder toBuilder() =>
      PrivyAuthorizationBodyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyAuthorizationBody &&
        method == other.method &&
        caip2 == other.caip2 &&
        chainType == other.chainType &&
        sponsor == other.sponsor &&
        referenceId == other.referenceId &&
        params == other.params;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, caip2.hashCode);
    _$hash = $jc(_$hash, chainType.hashCode);
    _$hash = $jc(_$hash, sponsor.hashCode);
    _$hash = $jc(_$hash, referenceId.hashCode);
    _$hash = $jc(_$hash, params.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyAuthorizationBody')
          ..add('method', method)
          ..add('caip2', caip2)
          ..add('chainType', chainType)
          ..add('sponsor', sponsor)
          ..add('referenceId', referenceId)
          ..add('params', params))
        .toString();
  }
}

class PrivyAuthorizationBodyBuilder
    implements Builder<PrivyAuthorizationBody, PrivyAuthorizationBodyBuilder> {
  _$PrivyAuthorizationBody? _$v;

  PrivyAuthorizationBodyMethodEnum? _method;
  PrivyAuthorizationBodyMethodEnum? get method => _$this._method;
  set method(PrivyAuthorizationBodyMethodEnum? method) =>
      _$this._method = method;

  PrivyAuthorizationBodyCaip2Enum? _caip2;
  PrivyAuthorizationBodyCaip2Enum? get caip2 => _$this._caip2;
  set caip2(PrivyAuthorizationBodyCaip2Enum? caip2) => _$this._caip2 = caip2;

  PrivyAuthorizationBodyChainTypeEnum? _chainType;
  PrivyAuthorizationBodyChainTypeEnum? get chainType => _$this._chainType;
  set chainType(PrivyAuthorizationBodyChainTypeEnum? chainType) =>
      _$this._chainType = chainType;

  bool? _sponsor;
  bool? get sponsor => _$this._sponsor;
  set sponsor(bool? sponsor) => _$this._sponsor = sponsor;

  String? _referenceId;
  String? get referenceId => _$this._referenceId;
  set referenceId(String? referenceId) => _$this._referenceId = referenceId;

  PrivyAuthorizationParamsBuilder? _params;
  PrivyAuthorizationParamsBuilder get params =>
      _$this._params ??= PrivyAuthorizationParamsBuilder();
  set params(PrivyAuthorizationParamsBuilder? params) =>
      _$this._params = params;

  PrivyAuthorizationBodyBuilder() {
    PrivyAuthorizationBody._defaults(this);
  }

  PrivyAuthorizationBodyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _method = $v.method;
      _caip2 = $v.caip2;
      _chainType = $v.chainType;
      _sponsor = $v.sponsor;
      _referenceId = $v.referenceId;
      _params = $v.params.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyAuthorizationBody other) {
    _$v = other as _$PrivyAuthorizationBody;
  }

  @override
  void update(void Function(PrivyAuthorizationBodyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyAuthorizationBody build() => _build();

  _$PrivyAuthorizationBody _build() {
    _$PrivyAuthorizationBody _$result;
    try {
      _$result = _$v ??
          _$PrivyAuthorizationBody._(
            method: BuiltValueNullFieldError.checkNotNull(
                method, r'PrivyAuthorizationBody', 'method'),
            caip2: BuiltValueNullFieldError.checkNotNull(
                caip2, r'PrivyAuthorizationBody', 'caip2'),
            chainType: BuiltValueNullFieldError.checkNotNull(
                chainType, r'PrivyAuthorizationBody', 'chainType'),
            sponsor: BuiltValueNullFieldError.checkNotNull(
                sponsor, r'PrivyAuthorizationBody', 'sponsor'),
            referenceId: BuiltValueNullFieldError.checkNotNull(
                referenceId, r'PrivyAuthorizationBody', 'referenceId'),
            params: params.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'params';
        params.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivyAuthorizationBody', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
