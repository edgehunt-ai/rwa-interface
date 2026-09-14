// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction_execute_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionExecuteRequestTargetModeEnum
    _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unifiedAccount =
    const Hip3AccountAbstractionExecuteRequestTargetModeEnum._(
        'unifiedAccount');
const Hip3AccountAbstractionExecuteRequestTargetModeEnum
    _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unknownDefaultOpenApi =
    const Hip3AccountAbstractionExecuteRequestTargetModeEnum._(
        'unknownDefaultOpenApi');

Hip3AccountAbstractionExecuteRequestTargetModeEnum
    _$hip3AccountAbstractionExecuteRequestTargetModeEnumValueOf(String name) {
  switch (name) {
    case 'unifiedAccount':
      return _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unifiedAccount;
    case 'unknownDefaultOpenApi':
      return _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AccountAbstractionExecuteRequestTargetModeEnum>
    _$hip3AccountAbstractionExecuteRequestTargetModeEnumValues = BuiltSet<
        Hip3AccountAbstractionExecuteRequestTargetModeEnum>(const <Hip3AccountAbstractionExecuteRequestTargetModeEnum>[
  _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unifiedAccount,
  _$hip3AccountAbstractionExecuteRequestTargetModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3AccountAbstractionExecuteRequestTargetModeEnum>
    _$hip3AccountAbstractionExecuteRequestTargetModeEnumSerializer =
    _$Hip3AccountAbstractionExecuteRequestTargetModeEnumSerializer();

class _$Hip3AccountAbstractionExecuteRequestTargetModeEnumSerializer
    implements
        PrimitiveSerializer<
            Hip3AccountAbstractionExecuteRequestTargetModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unifiedAccount': 'unifiedAccount',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unifiedAccount': 'unifiedAccount',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3AccountAbstractionExecuteRequestTargetModeEnum
  ];
  @override
  final String wireName = 'Hip3AccountAbstractionExecuteRequestTargetModeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3AccountAbstractionExecuteRequestTargetModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionExecuteRequestTargetModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionExecuteRequestTargetModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3AccountAbstractionExecuteRequest
    extends Hip3AccountAbstractionExecuteRequest {
  @override
  final Hip3AccountAbstractionExecuteRequestTargetModeEnum targetMode;
  @override
  final Hip3AccountAbstractionExecutionMethod executionMethod;
  @override
  final int nonce;
  @override
  final String payloadHash;
  @override
  final String? signature;

  factory _$Hip3AccountAbstractionExecuteRequest(
          [void Function(Hip3AccountAbstractionExecuteRequestBuilder)?
              updates]) =>
      (Hip3AccountAbstractionExecuteRequestBuilder()..update(updates))._build();

  _$Hip3AccountAbstractionExecuteRequest._(
      {required this.targetMode,
      required this.executionMethod,
      required this.nonce,
      required this.payloadHash,
      this.signature})
      : super._();
  @override
  Hip3AccountAbstractionExecuteRequest rebuild(
          void Function(Hip3AccountAbstractionExecuteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3AccountAbstractionExecuteRequestBuilder toBuilder() =>
      Hip3AccountAbstractionExecuteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3AccountAbstractionExecuteRequest &&
        targetMode == other.targetMode &&
        executionMethod == other.executionMethod &&
        nonce == other.nonce &&
        payloadHash == other.payloadHash &&
        signature == other.signature;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, targetMode.hashCode);
    _$hash = $jc(_$hash, executionMethod.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, signature.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3AccountAbstractionExecuteRequest')
          ..add('targetMode', targetMode)
          ..add('executionMethod', executionMethod)
          ..add('nonce', nonce)
          ..add('payloadHash', payloadHash)
          ..add('signature', signature))
        .toString();
  }
}

class Hip3AccountAbstractionExecuteRequestBuilder
    implements
        Builder<Hip3AccountAbstractionExecuteRequest,
            Hip3AccountAbstractionExecuteRequestBuilder> {
  _$Hip3AccountAbstractionExecuteRequest? _$v;

  Hip3AccountAbstractionExecuteRequestTargetModeEnum? _targetMode;
  Hip3AccountAbstractionExecuteRequestTargetModeEnum? get targetMode =>
      _$this._targetMode;
  set targetMode(
          Hip3AccountAbstractionExecuteRequestTargetModeEnum? targetMode) =>
      _$this._targetMode = targetMode;

  Hip3AccountAbstractionExecutionMethod? _executionMethod;
  Hip3AccountAbstractionExecutionMethod? get executionMethod =>
      _$this._executionMethod;
  set executionMethod(Hip3AccountAbstractionExecutionMethod? executionMethod) =>
      _$this._executionMethod = executionMethod;

  int? _nonce;
  int? get nonce => _$this._nonce;
  set nonce(int? nonce) => _$this._nonce = nonce;

  String? _payloadHash;
  String? get payloadHash => _$this._payloadHash;
  set payloadHash(String? payloadHash) => _$this._payloadHash = payloadHash;

  String? _signature;
  String? get signature => _$this._signature;
  set signature(String? signature) => _$this._signature = signature;

  Hip3AccountAbstractionExecuteRequestBuilder() {
    Hip3AccountAbstractionExecuteRequest._defaults(this);
  }

  Hip3AccountAbstractionExecuteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetMode = $v.targetMode;
      _executionMethod = $v.executionMethod;
      _nonce = $v.nonce;
      _payloadHash = $v.payloadHash;
      _signature = $v.signature;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3AccountAbstractionExecuteRequest other) {
    _$v = other as _$Hip3AccountAbstractionExecuteRequest;
  }

  @override
  void update(
      void Function(Hip3AccountAbstractionExecuteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3AccountAbstractionExecuteRequest build() => _build();

  _$Hip3AccountAbstractionExecuteRequest _build() {
    final _$result = _$v ??
        _$Hip3AccountAbstractionExecuteRequest._(
          targetMode: BuiltValueNullFieldError.checkNotNull(targetMode,
              r'Hip3AccountAbstractionExecuteRequest', 'targetMode'),
          executionMethod: BuiltValueNullFieldError.checkNotNull(
              executionMethod,
              r'Hip3AccountAbstractionExecuteRequest',
              'executionMethod'),
          nonce: BuiltValueNullFieldError.checkNotNull(
              nonce, r'Hip3AccountAbstractionExecuteRequest', 'nonce'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(payloadHash,
              r'Hip3AccountAbstractionExecuteRequest', 'payloadHash'),
          signature: signature,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
