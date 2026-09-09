// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_step_signing_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3StepSigningPayloadSigningMethodEnum
    _$hip3StepSigningPayloadSigningMethodEnum_ethSignTypedDataV4 =
    const Hip3StepSigningPayloadSigningMethodEnum._('ethSignTypedDataV4');
const Hip3StepSigningPayloadSigningMethodEnum
    _$hip3StepSigningPayloadSigningMethodEnum_unknownDefaultOpenApi =
    const Hip3StepSigningPayloadSigningMethodEnum._('unknownDefaultOpenApi');

Hip3StepSigningPayloadSigningMethodEnum
    _$hip3StepSigningPayloadSigningMethodEnumValueOf(String name) {
  switch (name) {
    case 'ethSignTypedDataV4':
      return _$hip3StepSigningPayloadSigningMethodEnum_ethSignTypedDataV4;
    case 'unknownDefaultOpenApi':
      return _$hip3StepSigningPayloadSigningMethodEnum_unknownDefaultOpenApi;
    default:
      return _$hip3StepSigningPayloadSigningMethodEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3StepSigningPayloadSigningMethodEnum>
    _$hip3StepSigningPayloadSigningMethodEnumValues = BuiltSet<
        Hip3StepSigningPayloadSigningMethodEnum>(const <Hip3StepSigningPayloadSigningMethodEnum>[
  _$hip3StepSigningPayloadSigningMethodEnum_ethSignTypedDataV4,
  _$hip3StepSigningPayloadSigningMethodEnum_unknownDefaultOpenApi,
]);

const Hip3StepSigningPayloadSignatureFormatEnum
    _$hip3StepSigningPayloadSignatureFormatEnum_rSV =
    const Hip3StepSigningPayloadSignatureFormatEnum._('rSV');
const Hip3StepSigningPayloadSignatureFormatEnum
    _$hip3StepSigningPayloadSignatureFormatEnum_unknownDefaultOpenApi =
    const Hip3StepSigningPayloadSignatureFormatEnum._('unknownDefaultOpenApi');

Hip3StepSigningPayloadSignatureFormatEnum
    _$hip3StepSigningPayloadSignatureFormatEnumValueOf(String name) {
  switch (name) {
    case 'rSV':
      return _$hip3StepSigningPayloadSignatureFormatEnum_rSV;
    case 'unknownDefaultOpenApi':
      return _$hip3StepSigningPayloadSignatureFormatEnum_unknownDefaultOpenApi;
    default:
      return _$hip3StepSigningPayloadSignatureFormatEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3StepSigningPayloadSignatureFormatEnum>
    _$hip3StepSigningPayloadSignatureFormatEnumValues = BuiltSet<
        Hip3StepSigningPayloadSignatureFormatEnum>(const <Hip3StepSigningPayloadSignatureFormatEnum>[
  _$hip3StepSigningPayloadSignatureFormatEnum_rSV,
  _$hip3StepSigningPayloadSignatureFormatEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3StepSigningPayloadSigningMethodEnum>
    _$hip3StepSigningPayloadSigningMethodEnumSerializer =
    _$Hip3StepSigningPayloadSigningMethodEnumSerializer();
Serializer<Hip3StepSigningPayloadSignatureFormatEnum>
    _$hip3StepSigningPayloadSignatureFormatEnumSerializer =
    _$Hip3StepSigningPayloadSignatureFormatEnumSerializer();

class _$Hip3StepSigningPayloadSigningMethodEnumSerializer
    implements PrimitiveSerializer<Hip3StepSigningPayloadSigningMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ethSignTypedDataV4': 'eth_signTypedData_v4',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eth_signTypedData_v4': 'ethSignTypedDataV4',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3StepSigningPayloadSigningMethodEnum
  ];
  @override
  final String wireName = 'Hip3StepSigningPayloadSigningMethodEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3StepSigningPayloadSigningMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3StepSigningPayloadSigningMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3StepSigningPayloadSigningMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3StepSigningPayloadSignatureFormatEnumSerializer
    implements PrimitiveSerializer<Hip3StepSigningPayloadSignatureFormatEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'rSV': 'r_s_v',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'r_s_v': 'rSV',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3StepSigningPayloadSignatureFormatEnum
  ];
  @override
  final String wireName = 'Hip3StepSigningPayloadSignatureFormatEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3StepSigningPayloadSignatureFormatEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3StepSigningPayloadSignatureFormatEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3StepSigningPayloadSignatureFormatEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3StepSigningPayload extends Hip3StepSigningPayload {
  @override
  final String expectedSigner;
  @override
  final Hip3StepSigningPayloadSigningMethodEnum signingMethod;
  @override
  final Hip3StepSigningPayloadSignatureFormatEnum signatureFormat;
  @override
  final Hip3Eip712TypedData signingTypedData;
  @override
  final String signingDigest;
  @override
  final int nonce;
  @override
  final int expiresAfter;
  @override
  final DateTime validUntil;

  factory _$Hip3StepSigningPayload(
          [void Function(Hip3StepSigningPayloadBuilder)? updates]) =>
      (Hip3StepSigningPayloadBuilder()..update(updates))._build();

  _$Hip3StepSigningPayload._(
      {required this.expectedSigner,
      required this.signingMethod,
      required this.signatureFormat,
      required this.signingTypedData,
      required this.signingDigest,
      required this.nonce,
      required this.expiresAfter,
      required this.validUntil})
      : super._();
  @override
  Hip3StepSigningPayload rebuild(
          void Function(Hip3StepSigningPayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3StepSigningPayloadBuilder toBuilder() =>
      Hip3StepSigningPayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3StepSigningPayload &&
        expectedSigner == other.expectedSigner &&
        signingMethod == other.signingMethod &&
        signatureFormat == other.signatureFormat &&
        signingTypedData == other.signingTypedData &&
        signingDigest == other.signingDigest &&
        nonce == other.nonce &&
        expiresAfter == other.expiresAfter &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, expectedSigner.hashCode);
    _$hash = $jc(_$hash, signingMethod.hashCode);
    _$hash = $jc(_$hash, signatureFormat.hashCode);
    _$hash = $jc(_$hash, signingTypedData.hashCode);
    _$hash = $jc(_$hash, signingDigest.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, expiresAfter.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3StepSigningPayload')
          ..add('expectedSigner', expectedSigner)
          ..add('signingMethod', signingMethod)
          ..add('signatureFormat', signatureFormat)
          ..add('signingTypedData', signingTypedData)
          ..add('signingDigest', signingDigest)
          ..add('nonce', nonce)
          ..add('expiresAfter', expiresAfter)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class Hip3StepSigningPayloadBuilder
    implements Builder<Hip3StepSigningPayload, Hip3StepSigningPayloadBuilder> {
  _$Hip3StepSigningPayload? _$v;

  String? _expectedSigner;
  String? get expectedSigner => _$this._expectedSigner;
  set expectedSigner(String? expectedSigner) =>
      _$this._expectedSigner = expectedSigner;

  Hip3StepSigningPayloadSigningMethodEnum? _signingMethod;
  Hip3StepSigningPayloadSigningMethodEnum? get signingMethod =>
      _$this._signingMethod;
  set signingMethod(Hip3StepSigningPayloadSigningMethodEnum? signingMethod) =>
      _$this._signingMethod = signingMethod;

  Hip3StepSigningPayloadSignatureFormatEnum? _signatureFormat;
  Hip3StepSigningPayloadSignatureFormatEnum? get signatureFormat =>
      _$this._signatureFormat;
  set signatureFormat(
          Hip3StepSigningPayloadSignatureFormatEnum? signatureFormat) =>
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

  int? _nonce;
  int? get nonce => _$this._nonce;
  set nonce(int? nonce) => _$this._nonce = nonce;

  int? _expiresAfter;
  int? get expiresAfter => _$this._expiresAfter;
  set expiresAfter(int? expiresAfter) => _$this._expiresAfter = expiresAfter;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  Hip3StepSigningPayloadBuilder() {
    Hip3StepSigningPayload._defaults(this);
  }

  Hip3StepSigningPayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _expectedSigner = $v.expectedSigner;
      _signingMethod = $v.signingMethod;
      _signatureFormat = $v.signatureFormat;
      _signingTypedData = $v.signingTypedData.toBuilder();
      _signingDigest = $v.signingDigest;
      _nonce = $v.nonce;
      _expiresAfter = $v.expiresAfter;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3StepSigningPayload other) {
    _$v = other as _$Hip3StepSigningPayload;
  }

  @override
  void update(void Function(Hip3StepSigningPayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3StepSigningPayload build() => _build();

  _$Hip3StepSigningPayload _build() {
    _$Hip3StepSigningPayload _$result;
    try {
      _$result = _$v ??
          _$Hip3StepSigningPayload._(
            expectedSigner: BuiltValueNullFieldError.checkNotNull(
                expectedSigner, r'Hip3StepSigningPayload', 'expectedSigner'),
            signingMethod: BuiltValueNullFieldError.checkNotNull(
                signingMethod, r'Hip3StepSigningPayload', 'signingMethod'),
            signatureFormat: BuiltValueNullFieldError.checkNotNull(
                signatureFormat, r'Hip3StepSigningPayload', 'signatureFormat'),
            signingTypedData: signingTypedData.build(),
            signingDigest: BuiltValueNullFieldError.checkNotNull(
                signingDigest, r'Hip3StepSigningPayload', 'signingDigest'),
            nonce: BuiltValueNullFieldError.checkNotNull(
                nonce, r'Hip3StepSigningPayload', 'nonce'),
            expiresAfter: BuiltValueNullFieldError.checkNotNull(
                expiresAfter, r'Hip3StepSigningPayload', 'expiresAfter'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'Hip3StepSigningPayload', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'signingTypedData';
        signingTypedData.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3StepSigningPayload', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
