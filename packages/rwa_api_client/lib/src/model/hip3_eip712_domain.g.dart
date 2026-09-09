// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_eip712_domain.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Eip712DomainNameEnum _$hip3Eip712DomainNameEnum_exchange =
    const Hip3Eip712DomainNameEnum._('exchange');
const Hip3Eip712DomainNameEnum
    _$hip3Eip712DomainNameEnum_unknownDefaultOpenApi =
    const Hip3Eip712DomainNameEnum._('unknownDefaultOpenApi');

Hip3Eip712DomainNameEnum _$hip3Eip712DomainNameEnumValueOf(String name) {
  switch (name) {
    case 'exchange':
      return _$hip3Eip712DomainNameEnum_exchange;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712DomainNameEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712DomainNameEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712DomainNameEnum> _$hip3Eip712DomainNameEnumValues =
    BuiltSet<Hip3Eip712DomainNameEnum>(const <Hip3Eip712DomainNameEnum>[
  _$hip3Eip712DomainNameEnum_exchange,
  _$hip3Eip712DomainNameEnum_unknownDefaultOpenApi,
]);

const Hip3Eip712DomainVersionEnum _$hip3Eip712DomainVersionEnum_n1 =
    const Hip3Eip712DomainVersionEnum._('n1');
const Hip3Eip712DomainVersionEnum
    _$hip3Eip712DomainVersionEnum_unknownDefaultOpenApi =
    const Hip3Eip712DomainVersionEnum._('unknownDefaultOpenApi');

Hip3Eip712DomainVersionEnum _$hip3Eip712DomainVersionEnumValueOf(String name) {
  switch (name) {
    case 'n1':
      return _$hip3Eip712DomainVersionEnum_n1;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712DomainVersionEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712DomainVersionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712DomainVersionEnum>
    _$hip3Eip712DomainVersionEnumValues =
    BuiltSet<Hip3Eip712DomainVersionEnum>(const <Hip3Eip712DomainVersionEnum>[
  _$hip3Eip712DomainVersionEnum_n1,
  _$hip3Eip712DomainVersionEnum_unknownDefaultOpenApi,
]);

const Hip3Eip712DomainChainIdEnum _$hip3Eip712DomainChainIdEnum_number1337 =
    const Hip3Eip712DomainChainIdEnum._('number1337');
const Hip3Eip712DomainChainIdEnum
    _$hip3Eip712DomainChainIdEnum_unknownDefaultOpenApi =
    const Hip3Eip712DomainChainIdEnum._('unknownDefaultOpenApi');

Hip3Eip712DomainChainIdEnum _$hip3Eip712DomainChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number1337':
      return _$hip3Eip712DomainChainIdEnum_number1337;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712DomainChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712DomainChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712DomainChainIdEnum>
    _$hip3Eip712DomainChainIdEnumValues =
    BuiltSet<Hip3Eip712DomainChainIdEnum>(const <Hip3Eip712DomainChainIdEnum>[
  _$hip3Eip712DomainChainIdEnum_number1337,
  _$hip3Eip712DomainChainIdEnum_unknownDefaultOpenApi,
]);

const Hip3Eip712DomainVerifyingContractEnum
    _$hip3Eip712DomainVerifyingContractEnum_n0x0000000000000000000000000000000000000000 =
    const Hip3Eip712DomainVerifyingContractEnum._(
        'n0x0000000000000000000000000000000000000000');
const Hip3Eip712DomainVerifyingContractEnum
    _$hip3Eip712DomainVerifyingContractEnum_unknownDefaultOpenApi =
    const Hip3Eip712DomainVerifyingContractEnum._('unknownDefaultOpenApi');

Hip3Eip712DomainVerifyingContractEnum
    _$hip3Eip712DomainVerifyingContractEnumValueOf(String name) {
  switch (name) {
    case 'n0x0000000000000000000000000000000000000000':
      return _$hip3Eip712DomainVerifyingContractEnum_n0x0000000000000000000000000000000000000000;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712DomainVerifyingContractEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712DomainVerifyingContractEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712DomainVerifyingContractEnum>
    _$hip3Eip712DomainVerifyingContractEnumValues = BuiltSet<
        Hip3Eip712DomainVerifyingContractEnum>(const <Hip3Eip712DomainVerifyingContractEnum>[
  _$hip3Eip712DomainVerifyingContractEnum_n0x0000000000000000000000000000000000000000,
  _$hip3Eip712DomainVerifyingContractEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3Eip712DomainNameEnum> _$hip3Eip712DomainNameEnumSerializer =
    _$Hip3Eip712DomainNameEnumSerializer();
Serializer<Hip3Eip712DomainVersionEnum>
    _$hip3Eip712DomainVersionEnumSerializer =
    _$Hip3Eip712DomainVersionEnumSerializer();
Serializer<Hip3Eip712DomainChainIdEnum>
    _$hip3Eip712DomainChainIdEnumSerializer =
    _$Hip3Eip712DomainChainIdEnumSerializer();
Serializer<Hip3Eip712DomainVerifyingContractEnum>
    _$hip3Eip712DomainVerifyingContractEnumSerializer =
    _$Hip3Eip712DomainVerifyingContractEnumSerializer();

class _$Hip3Eip712DomainNameEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712DomainNameEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'exchange': 'Exchange',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Exchange': 'exchange',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712DomainNameEnum];
  @override
  final String wireName = 'Hip3Eip712DomainNameEnum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712DomainNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712DomainNameEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712DomainNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712DomainVersionEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712DomainVersionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n1': '1',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '1': 'n1',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712DomainVersionEnum];
  @override
  final String wireName = 'Hip3Eip712DomainVersionEnum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712DomainVersionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712DomainVersionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712DomainVersionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712DomainChainIdEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712DomainChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number1337': 1337,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1337: 'number1337',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712DomainChainIdEnum];
  @override
  final String wireName = 'Hip3Eip712DomainChainIdEnum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712DomainChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712DomainChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712DomainChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712DomainVerifyingContractEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712DomainVerifyingContractEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0x0000000000000000000000000000000000000000':
        '0x0000000000000000000000000000000000000000',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0x0000000000000000000000000000000000000000':
        'n0x0000000000000000000000000000000000000000',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3Eip712DomainVerifyingContractEnum
  ];
  @override
  final String wireName = 'Hip3Eip712DomainVerifyingContractEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3Eip712DomainVerifyingContractEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712DomainVerifyingContractEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712DomainVerifyingContractEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712Domain extends Hip3Eip712Domain {
  @override
  final Hip3Eip712DomainNameEnum name;
  @override
  final Hip3Eip712DomainVersionEnum version;
  @override
  final Hip3Eip712DomainChainIdEnum chainId;
  @override
  final Hip3Eip712DomainVerifyingContractEnum verifyingContract;

  factory _$Hip3Eip712Domain(
          [void Function(Hip3Eip712DomainBuilder)? updates]) =>
      (Hip3Eip712DomainBuilder()..update(updates))._build();

  _$Hip3Eip712Domain._(
      {required this.name,
      required this.version,
      required this.chainId,
      required this.verifyingContract})
      : super._();
  @override
  Hip3Eip712Domain rebuild(void Function(Hip3Eip712DomainBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3Eip712DomainBuilder toBuilder() =>
      Hip3Eip712DomainBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Eip712Domain &&
        name == other.name &&
        version == other.version &&
        chainId == other.chainId &&
        verifyingContract == other.verifyingContract;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, verifyingContract.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Eip712Domain')
          ..add('name', name)
          ..add('version', version)
          ..add('chainId', chainId)
          ..add('verifyingContract', verifyingContract))
        .toString();
  }
}

class Hip3Eip712DomainBuilder
    implements Builder<Hip3Eip712Domain, Hip3Eip712DomainBuilder> {
  _$Hip3Eip712Domain? _$v;

  Hip3Eip712DomainNameEnum? _name;
  Hip3Eip712DomainNameEnum? get name => _$this._name;
  set name(Hip3Eip712DomainNameEnum? name) => _$this._name = name;

  Hip3Eip712DomainVersionEnum? _version;
  Hip3Eip712DomainVersionEnum? get version => _$this._version;
  set version(Hip3Eip712DomainVersionEnum? version) =>
      _$this._version = version;

  Hip3Eip712DomainChainIdEnum? _chainId;
  Hip3Eip712DomainChainIdEnum? get chainId => _$this._chainId;
  set chainId(Hip3Eip712DomainChainIdEnum? chainId) =>
      _$this._chainId = chainId;

  Hip3Eip712DomainVerifyingContractEnum? _verifyingContract;
  Hip3Eip712DomainVerifyingContractEnum? get verifyingContract =>
      _$this._verifyingContract;
  set verifyingContract(
          Hip3Eip712DomainVerifyingContractEnum? verifyingContract) =>
      _$this._verifyingContract = verifyingContract;

  Hip3Eip712DomainBuilder() {
    Hip3Eip712Domain._defaults(this);
  }

  Hip3Eip712DomainBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _version = $v.version;
      _chainId = $v.chainId;
      _verifyingContract = $v.verifyingContract;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Eip712Domain other) {
    _$v = other as _$Hip3Eip712Domain;
  }

  @override
  void update(void Function(Hip3Eip712DomainBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Eip712Domain build() => _build();

  _$Hip3Eip712Domain _build() {
    final _$result = _$v ??
        _$Hip3Eip712Domain._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'Hip3Eip712Domain', 'name'),
          version: BuiltValueNullFieldError.checkNotNull(
              version, r'Hip3Eip712Domain', 'version'),
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'Hip3Eip712Domain', 'chainId'),
          verifyingContract: BuiltValueNullFieldError.checkNotNull(
              verifyingContract, r'Hip3Eip712Domain', 'verifyingContract'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
