// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_order_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3OrderActionOperationEnum _$hip3OrderActionOperationEnum_placeOrder =
    const Hip3OrderActionOperationEnum._('placeOrder');
const Hip3OrderActionOperationEnum _$hip3OrderActionOperationEnum_cancelOrder =
    const Hip3OrderActionOperationEnum._('cancelOrder');
const Hip3OrderActionOperationEnum
    _$hip3OrderActionOperationEnum_closePosition =
    const Hip3OrderActionOperationEnum._('closePosition');
const Hip3OrderActionOperationEnum
    _$hip3OrderActionOperationEnum_unknownDefaultOpenApi =
    const Hip3OrderActionOperationEnum._('unknownDefaultOpenApi');

Hip3OrderActionOperationEnum _$hip3OrderActionOperationEnumValueOf(
    String name) {
  switch (name) {
    case 'placeOrder':
      return _$hip3OrderActionOperationEnum_placeOrder;
    case 'cancelOrder':
      return _$hip3OrderActionOperationEnum_cancelOrder;
    case 'closePosition':
      return _$hip3OrderActionOperationEnum_closePosition;
    case 'unknownDefaultOpenApi':
      return _$hip3OrderActionOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OrderActionOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OrderActionOperationEnum>
    _$hip3OrderActionOperationEnumValues =
    BuiltSet<Hip3OrderActionOperationEnum>(const <Hip3OrderActionOperationEnum>[
  _$hip3OrderActionOperationEnum_placeOrder,
  _$hip3OrderActionOperationEnum_cancelOrder,
  _$hip3OrderActionOperationEnum_closePosition,
  _$hip3OrderActionOperationEnum_unknownDefaultOpenApi,
]);

const Hip3OrderActionEnvironmentEnum _$hip3OrderActionEnvironmentEnum_mainnet =
    const Hip3OrderActionEnvironmentEnum._('mainnet');
const Hip3OrderActionEnvironmentEnum _$hip3OrderActionEnvironmentEnum_testnet =
    const Hip3OrderActionEnvironmentEnum._('testnet');
const Hip3OrderActionEnvironmentEnum
    _$hip3OrderActionEnvironmentEnum_unknownDefaultOpenApi =
    const Hip3OrderActionEnvironmentEnum._('unknownDefaultOpenApi');

Hip3OrderActionEnvironmentEnum _$hip3OrderActionEnvironmentEnumValueOf(
    String name) {
  switch (name) {
    case 'mainnet':
      return _$hip3OrderActionEnvironmentEnum_mainnet;
    case 'testnet':
      return _$hip3OrderActionEnvironmentEnum_testnet;
    case 'unknownDefaultOpenApi':
      return _$hip3OrderActionEnvironmentEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OrderActionEnvironmentEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OrderActionEnvironmentEnum>
    _$hip3OrderActionEnvironmentEnumValues = BuiltSet<
        Hip3OrderActionEnvironmentEnum>(const <Hip3OrderActionEnvironmentEnum>[
  _$hip3OrderActionEnvironmentEnum_mainnet,
  _$hip3OrderActionEnvironmentEnum_testnet,
  _$hip3OrderActionEnvironmentEnum_unknownDefaultOpenApi,
]);

const Hip3OrderActionSigningMethodEnum
    _$hip3OrderActionSigningMethodEnum_ethSignTypedDataV4 =
    const Hip3OrderActionSigningMethodEnum._('ethSignTypedDataV4');
const Hip3OrderActionSigningMethodEnum
    _$hip3OrderActionSigningMethodEnum_unknownDefaultOpenApi =
    const Hip3OrderActionSigningMethodEnum._('unknownDefaultOpenApi');

Hip3OrderActionSigningMethodEnum _$hip3OrderActionSigningMethodEnumValueOf(
    String name) {
  switch (name) {
    case 'ethSignTypedDataV4':
      return _$hip3OrderActionSigningMethodEnum_ethSignTypedDataV4;
    case 'unknownDefaultOpenApi':
      return _$hip3OrderActionSigningMethodEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OrderActionSigningMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OrderActionSigningMethodEnum>
    _$hip3OrderActionSigningMethodEnumValues = BuiltSet<
        Hip3OrderActionSigningMethodEnum>(const <Hip3OrderActionSigningMethodEnum>[
  _$hip3OrderActionSigningMethodEnum_ethSignTypedDataV4,
  _$hip3OrderActionSigningMethodEnum_unknownDefaultOpenApi,
]);

const Hip3OrderActionSignatureFormatEnum
    _$hip3OrderActionSignatureFormatEnum_rSV =
    const Hip3OrderActionSignatureFormatEnum._('rSV');
const Hip3OrderActionSignatureFormatEnum
    _$hip3OrderActionSignatureFormatEnum_unknownDefaultOpenApi =
    const Hip3OrderActionSignatureFormatEnum._('unknownDefaultOpenApi');

Hip3OrderActionSignatureFormatEnum _$hip3OrderActionSignatureFormatEnumValueOf(
    String name) {
  switch (name) {
    case 'rSV':
      return _$hip3OrderActionSignatureFormatEnum_rSV;
    case 'unknownDefaultOpenApi':
      return _$hip3OrderActionSignatureFormatEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OrderActionSignatureFormatEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OrderActionSignatureFormatEnum>
    _$hip3OrderActionSignatureFormatEnumValues = BuiltSet<
        Hip3OrderActionSignatureFormatEnum>(const <Hip3OrderActionSignatureFormatEnum>[
  _$hip3OrderActionSignatureFormatEnum_rSV,
  _$hip3OrderActionSignatureFormatEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3OrderActionOperationEnum>
    _$hip3OrderActionOperationEnumSerializer =
    _$Hip3OrderActionOperationEnumSerializer();
Serializer<Hip3OrderActionEnvironmentEnum>
    _$hip3OrderActionEnvironmentEnumSerializer =
    _$Hip3OrderActionEnvironmentEnumSerializer();
Serializer<Hip3OrderActionSigningMethodEnum>
    _$hip3OrderActionSigningMethodEnumSerializer =
    _$Hip3OrderActionSigningMethodEnumSerializer();
Serializer<Hip3OrderActionSignatureFormatEnum>
    _$hip3OrderActionSignatureFormatEnumSerializer =
    _$Hip3OrderActionSignatureFormatEnumSerializer();

class _$Hip3OrderActionOperationEnumSerializer
    implements PrimitiveSerializer<Hip3OrderActionOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'placeOrder': 'place_order',
    'cancelOrder': 'cancel_order',
    'closePosition': 'close_position',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'place_order': 'placeOrder',
    'cancel_order': 'cancelOrder',
    'close_position': 'closePosition',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3OrderActionOperationEnum];
  @override
  final String wireName = 'Hip3OrderActionOperationEnum';

  @override
  Object serialize(Serializers serializers, Hip3OrderActionOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OrderActionOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OrderActionOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OrderActionEnvironmentEnumSerializer
    implements PrimitiveSerializer<Hip3OrderActionEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3OrderActionEnvironmentEnum];
  @override
  final String wireName = 'Hip3OrderActionEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3OrderActionEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OrderActionEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OrderActionEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OrderActionSigningMethodEnumSerializer
    implements PrimitiveSerializer<Hip3OrderActionSigningMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ethSignTypedDataV4': 'eth_signTypedData_v4',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eth_signTypedData_v4': 'ethSignTypedDataV4',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3OrderActionSigningMethodEnum];
  @override
  final String wireName = 'Hip3OrderActionSigningMethodEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3OrderActionSigningMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OrderActionSigningMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OrderActionSigningMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OrderActionSignatureFormatEnumSerializer
    implements PrimitiveSerializer<Hip3OrderActionSignatureFormatEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'rSV': 'r_s_v',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'r_s_v': 'rSV',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3OrderActionSignatureFormatEnum];
  @override
  final String wireName = 'Hip3OrderActionSignatureFormatEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3OrderActionSignatureFormatEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OrderActionSignatureFormatEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OrderActionSignatureFormatEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OrderAction extends Hip3OrderAction {
  @override
  final String actionId;
  @override
  final Hip3OrderActionOperationEnum operation;
  @override
  final Hip3OrderActionEnvironmentEnum environment;
  @override
  final String expectedSigner;
  @override
  final int nonce;
  @override
  final int? expiresAfter;
  @override
  final Hip3OrderActionSigningMethodEnum signingMethod;
  @override
  final Hip3OrderActionSignatureFormatEnum signatureFormat;
  @override
  final Hip3Eip712TypedData signingTypedData;
  @override
  final String signingDigest;
  @override
  final DateTime validUntil;

  factory _$Hip3OrderAction([void Function(Hip3OrderActionBuilder)? updates]) =>
      (Hip3OrderActionBuilder()..update(updates))._build();

  _$Hip3OrderAction._(
      {required this.actionId,
      required this.operation,
      required this.environment,
      required this.expectedSigner,
      required this.nonce,
      this.expiresAfter,
      required this.signingMethod,
      required this.signatureFormat,
      required this.signingTypedData,
      required this.signingDigest,
      required this.validUntil})
      : super._();
  @override
  Hip3OrderAction rebuild(void Function(Hip3OrderActionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OrderActionBuilder toBuilder() => Hip3OrderActionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OrderAction &&
        actionId == other.actionId &&
        operation == other.operation &&
        environment == other.environment &&
        expectedSigner == other.expectedSigner &&
        nonce == other.nonce &&
        expiresAfter == other.expiresAfter &&
        signingMethod == other.signingMethod &&
        signatureFormat == other.signatureFormat &&
        signingTypedData == other.signingTypedData &&
        signingDigest == other.signingDigest &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, actionId.hashCode);
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, expectedSigner.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, expiresAfter.hashCode);
    _$hash = $jc(_$hash, signingMethod.hashCode);
    _$hash = $jc(_$hash, signatureFormat.hashCode);
    _$hash = $jc(_$hash, signingTypedData.hashCode);
    _$hash = $jc(_$hash, signingDigest.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OrderAction')
          ..add('actionId', actionId)
          ..add('operation', operation)
          ..add('environment', environment)
          ..add('expectedSigner', expectedSigner)
          ..add('nonce', nonce)
          ..add('expiresAfter', expiresAfter)
          ..add('signingMethod', signingMethod)
          ..add('signatureFormat', signatureFormat)
          ..add('signingTypedData', signingTypedData)
          ..add('signingDigest', signingDigest)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class Hip3OrderActionBuilder
    implements Builder<Hip3OrderAction, Hip3OrderActionBuilder> {
  _$Hip3OrderAction? _$v;

  String? _actionId;
  String? get actionId => _$this._actionId;
  set actionId(String? actionId) => _$this._actionId = actionId;

  Hip3OrderActionOperationEnum? _operation;
  Hip3OrderActionOperationEnum? get operation => _$this._operation;
  set operation(Hip3OrderActionOperationEnum? operation) =>
      _$this._operation = operation;

  Hip3OrderActionEnvironmentEnum? _environment;
  Hip3OrderActionEnvironmentEnum? get environment => _$this._environment;
  set environment(Hip3OrderActionEnvironmentEnum? environment) =>
      _$this._environment = environment;

  String? _expectedSigner;
  String? get expectedSigner => _$this._expectedSigner;
  set expectedSigner(String? expectedSigner) =>
      _$this._expectedSigner = expectedSigner;

  int? _nonce;
  int? get nonce => _$this._nonce;
  set nonce(int? nonce) => _$this._nonce = nonce;

  int? _expiresAfter;
  int? get expiresAfter => _$this._expiresAfter;
  set expiresAfter(int? expiresAfter) => _$this._expiresAfter = expiresAfter;

  Hip3OrderActionSigningMethodEnum? _signingMethod;
  Hip3OrderActionSigningMethodEnum? get signingMethod => _$this._signingMethod;
  set signingMethod(Hip3OrderActionSigningMethodEnum? signingMethod) =>
      _$this._signingMethod = signingMethod;

  Hip3OrderActionSignatureFormatEnum? _signatureFormat;
  Hip3OrderActionSignatureFormatEnum? get signatureFormat =>
      _$this._signatureFormat;
  set signatureFormat(Hip3OrderActionSignatureFormatEnum? signatureFormat) =>
      _$this._signatureFormat = signatureFormat;

  Hip3Eip712TypedDataBuilder? _signingTypedData;
  Hip3Eip712TypedDataBuilder get signingTypedData =>
      _$this._signingTypedData ??= Hip3Eip712TypedDataBuilder();
  set signingTypedData(Hip3Eip712TypedDataBuilder? signingTypedData) =>
      _$this._signingTypedData = signingTypedData;

  String? _signingDigest;
  String? get signingDigest => _$this._signingDigest;
  set signingDigest(String? signingDigest) =>
      _$this._signingDigest = signingDigest;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  Hip3OrderActionBuilder() {
    Hip3OrderAction._defaults(this);
  }

  Hip3OrderActionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _actionId = $v.actionId;
      _operation = $v.operation;
      _environment = $v.environment;
      _expectedSigner = $v.expectedSigner;
      _nonce = $v.nonce;
      _expiresAfter = $v.expiresAfter;
      _signingMethod = $v.signingMethod;
      _signatureFormat = $v.signatureFormat;
      _signingTypedData = $v.signingTypedData.toBuilder();
      _signingDigest = $v.signingDigest;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OrderAction other) {
    _$v = other as _$Hip3OrderAction;
  }

  @override
  void update(void Function(Hip3OrderActionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OrderAction build() => _build();

  _$Hip3OrderAction _build() {
    _$Hip3OrderAction _$result;
    try {
      _$result = _$v ??
          _$Hip3OrderAction._(
            actionId: BuiltValueNullFieldError.checkNotNull(
                actionId, r'Hip3OrderAction', 'actionId'),
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3OrderAction', 'operation'),
            environment: BuiltValueNullFieldError.checkNotNull(
                environment, r'Hip3OrderAction', 'environment'),
            expectedSigner: BuiltValueNullFieldError.checkNotNull(
                expectedSigner, r'Hip3OrderAction', 'expectedSigner'),
            nonce: BuiltValueNullFieldError.checkNotNull(
                nonce, r'Hip3OrderAction', 'nonce'),
            expiresAfter: expiresAfter,
            signingMethod: BuiltValueNullFieldError.checkNotNull(
                signingMethod, r'Hip3OrderAction', 'signingMethod'),
            signatureFormat: BuiltValueNullFieldError.checkNotNull(
                signatureFormat, r'Hip3OrderAction', 'signatureFormat'),
            signingTypedData: signingTypedData.build(),
            signingDigest: BuiltValueNullFieldError.checkNotNull(
                signingDigest, r'Hip3OrderAction', 'signingDigest'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'Hip3OrderAction', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'signingTypedData';
        signingTypedData.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3OrderAction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
