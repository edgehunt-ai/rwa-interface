// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction_preparation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionPreparationTargetModeEnum
    _$hip3AccountAbstractionPreparationTargetModeEnum_unifiedAccount =
    const Hip3AccountAbstractionPreparationTargetModeEnum._('unifiedAccount');
const Hip3AccountAbstractionPreparationTargetModeEnum
    _$hip3AccountAbstractionPreparationTargetModeEnum_unknownDefaultOpenApi =
    const Hip3AccountAbstractionPreparationTargetModeEnum._(
        'unknownDefaultOpenApi');

Hip3AccountAbstractionPreparationTargetModeEnum
    _$hip3AccountAbstractionPreparationTargetModeEnumValueOf(String name) {
  switch (name) {
    case 'unifiedAccount':
      return _$hip3AccountAbstractionPreparationTargetModeEnum_unifiedAccount;
    case 'unknownDefaultOpenApi':
      return _$hip3AccountAbstractionPreparationTargetModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3AccountAbstractionPreparationTargetModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AccountAbstractionPreparationTargetModeEnum>
    _$hip3AccountAbstractionPreparationTargetModeEnumValues = BuiltSet<
        Hip3AccountAbstractionPreparationTargetModeEnum>(const <Hip3AccountAbstractionPreparationTargetModeEnum>[
  _$hip3AccountAbstractionPreparationTargetModeEnum_unifiedAccount,
  _$hip3AccountAbstractionPreparationTargetModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3AccountAbstractionPreparationTargetModeEnum>
    _$hip3AccountAbstractionPreparationTargetModeEnumSerializer =
    _$Hip3AccountAbstractionPreparationTargetModeEnumSerializer();

class _$Hip3AccountAbstractionPreparationTargetModeEnumSerializer
    implements
        PrimitiveSerializer<Hip3AccountAbstractionPreparationTargetModeEnum> {
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
    Hip3AccountAbstractionPreparationTargetModeEnum
  ];
  @override
  final String wireName = 'Hip3AccountAbstractionPreparationTargetModeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3AccountAbstractionPreparationTargetModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionPreparationTargetModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionPreparationTargetModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3AccountAbstractionPreparation
    extends Hip3AccountAbstractionPreparation {
  @override
  final String ownerAddress;
  @override
  final Hip3AccountAbstractionMode currentMode;
  @override
  final Hip3AccountAbstractionPreparationTargetModeEnum targetMode;
  @override
  final Hip3AccountAbstractionExecutionMethod executionMethod;
  @override
  final int nonce;
  @override
  final String payloadHash;
  @override
  final String? typedDataJson;
  @override
  final DateTime expiresAt;

  factory _$Hip3AccountAbstractionPreparation(
          [void Function(Hip3AccountAbstractionPreparationBuilder)? updates]) =>
      (Hip3AccountAbstractionPreparationBuilder()..update(updates))._build();

  _$Hip3AccountAbstractionPreparation._(
      {required this.ownerAddress,
      required this.currentMode,
      required this.targetMode,
      required this.executionMethod,
      required this.nonce,
      required this.payloadHash,
      this.typedDataJson,
      required this.expiresAt})
      : super._();
  @override
  Hip3AccountAbstractionPreparation rebuild(
          void Function(Hip3AccountAbstractionPreparationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3AccountAbstractionPreparationBuilder toBuilder() =>
      Hip3AccountAbstractionPreparationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3AccountAbstractionPreparation &&
        ownerAddress == other.ownerAddress &&
        currentMode == other.currentMode &&
        targetMode == other.targetMode &&
        executionMethod == other.executionMethod &&
        nonce == other.nonce &&
        payloadHash == other.payloadHash &&
        typedDataJson == other.typedDataJson &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ownerAddress.hashCode);
    _$hash = $jc(_$hash, currentMode.hashCode);
    _$hash = $jc(_$hash, targetMode.hashCode);
    _$hash = $jc(_$hash, executionMethod.hashCode);
    _$hash = $jc(_$hash, nonce.hashCode);
    _$hash = $jc(_$hash, payloadHash.hashCode);
    _$hash = $jc(_$hash, typedDataJson.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3AccountAbstractionPreparation')
          ..add('ownerAddress', ownerAddress)
          ..add('currentMode', currentMode)
          ..add('targetMode', targetMode)
          ..add('executionMethod', executionMethod)
          ..add('nonce', nonce)
          ..add('payloadHash', payloadHash)
          ..add('typedDataJson', typedDataJson)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class Hip3AccountAbstractionPreparationBuilder
    implements
        Builder<Hip3AccountAbstractionPreparation,
            Hip3AccountAbstractionPreparationBuilder> {
  _$Hip3AccountAbstractionPreparation? _$v;

  String? _ownerAddress;
  String? get ownerAddress => _$this._ownerAddress;
  set ownerAddress(String? ownerAddress) => _$this._ownerAddress = ownerAddress;

  Hip3AccountAbstractionMode? _currentMode;
  Hip3AccountAbstractionMode? get currentMode => _$this._currentMode;
  set currentMode(Hip3AccountAbstractionMode? currentMode) =>
      _$this._currentMode = currentMode;

  Hip3AccountAbstractionPreparationTargetModeEnum? _targetMode;
  Hip3AccountAbstractionPreparationTargetModeEnum? get targetMode =>
      _$this._targetMode;
  set targetMode(Hip3AccountAbstractionPreparationTargetModeEnum? targetMode) =>
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

  String? _typedDataJson;
  String? get typedDataJson => _$this._typedDataJson;
  set typedDataJson(String? typedDataJson) =>
      _$this._typedDataJson = typedDataJson;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  Hip3AccountAbstractionPreparationBuilder() {
    Hip3AccountAbstractionPreparation._defaults(this);
  }

  Hip3AccountAbstractionPreparationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ownerAddress = $v.ownerAddress;
      _currentMode = $v.currentMode;
      _targetMode = $v.targetMode;
      _executionMethod = $v.executionMethod;
      _nonce = $v.nonce;
      _payloadHash = $v.payloadHash;
      _typedDataJson = $v.typedDataJson;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3AccountAbstractionPreparation other) {
    _$v = other as _$Hip3AccountAbstractionPreparation;
  }

  @override
  void update(
      void Function(Hip3AccountAbstractionPreparationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3AccountAbstractionPreparation build() => _build();

  _$Hip3AccountAbstractionPreparation _build() {
    final _$result = _$v ??
        _$Hip3AccountAbstractionPreparation._(
          ownerAddress: BuiltValueNullFieldError.checkNotNull(ownerAddress,
              r'Hip3AccountAbstractionPreparation', 'ownerAddress'),
          currentMode: BuiltValueNullFieldError.checkNotNull(
              currentMode, r'Hip3AccountAbstractionPreparation', 'currentMode'),
          targetMode: BuiltValueNullFieldError.checkNotNull(
              targetMode, r'Hip3AccountAbstractionPreparation', 'targetMode'),
          executionMethod: BuiltValueNullFieldError.checkNotNull(
              executionMethod,
              r'Hip3AccountAbstractionPreparation',
              'executionMethod'),
          nonce: BuiltValueNullFieldError.checkNotNull(
              nonce, r'Hip3AccountAbstractionPreparation', 'nonce'),
          payloadHash: BuiltValueNullFieldError.checkNotNull(
              payloadHash, r'Hip3AccountAbstractionPreparation', 'payloadHash'),
          typedDataJson: typedDataJson,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt, r'Hip3AccountAbstractionPreparation', 'expiresAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
