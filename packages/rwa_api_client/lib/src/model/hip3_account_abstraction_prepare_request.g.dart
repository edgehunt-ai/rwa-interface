// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_account_abstraction_prepare_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3AccountAbstractionPrepareRequestTargetModeEnum
    _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unifiedAccount =
    const Hip3AccountAbstractionPrepareRequestTargetModeEnum._(
        'unifiedAccount');
const Hip3AccountAbstractionPrepareRequestTargetModeEnum
    _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unknownDefaultOpenApi =
    const Hip3AccountAbstractionPrepareRequestTargetModeEnum._(
        'unknownDefaultOpenApi');

Hip3AccountAbstractionPrepareRequestTargetModeEnum
    _$hip3AccountAbstractionPrepareRequestTargetModeEnumValueOf(String name) {
  switch (name) {
    case 'unifiedAccount':
      return _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unifiedAccount;
    case 'unknownDefaultOpenApi':
      return _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3AccountAbstractionPrepareRequestTargetModeEnum>
    _$hip3AccountAbstractionPrepareRequestTargetModeEnumValues = BuiltSet<
        Hip3AccountAbstractionPrepareRequestTargetModeEnum>(const <Hip3AccountAbstractionPrepareRequestTargetModeEnum>[
  _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unifiedAccount,
  _$hip3AccountAbstractionPrepareRequestTargetModeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3AccountAbstractionPrepareRequestTargetModeEnum>
    _$hip3AccountAbstractionPrepareRequestTargetModeEnumSerializer =
    _$Hip3AccountAbstractionPrepareRequestTargetModeEnumSerializer();

class _$Hip3AccountAbstractionPrepareRequestTargetModeEnumSerializer
    implements
        PrimitiveSerializer<
            Hip3AccountAbstractionPrepareRequestTargetModeEnum> {
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
    Hip3AccountAbstractionPrepareRequestTargetModeEnum
  ];
  @override
  final String wireName = 'Hip3AccountAbstractionPrepareRequestTargetModeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3AccountAbstractionPrepareRequestTargetModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3AccountAbstractionPrepareRequestTargetModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3AccountAbstractionPrepareRequestTargetModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3AccountAbstractionPrepareRequest
    extends Hip3AccountAbstractionPrepareRequest {
  @override
  final Hip3AccountAbstractionPrepareRequestTargetModeEnum targetMode;

  factory _$Hip3AccountAbstractionPrepareRequest(
          [void Function(Hip3AccountAbstractionPrepareRequestBuilder)?
              updates]) =>
      (Hip3AccountAbstractionPrepareRequestBuilder()..update(updates))._build();

  _$Hip3AccountAbstractionPrepareRequest._({required this.targetMode})
      : super._();
  @override
  Hip3AccountAbstractionPrepareRequest rebuild(
          void Function(Hip3AccountAbstractionPrepareRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3AccountAbstractionPrepareRequestBuilder toBuilder() =>
      Hip3AccountAbstractionPrepareRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3AccountAbstractionPrepareRequest &&
        targetMode == other.targetMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, targetMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3AccountAbstractionPrepareRequest')
          ..add('targetMode', targetMode))
        .toString();
  }
}

class Hip3AccountAbstractionPrepareRequestBuilder
    implements
        Builder<Hip3AccountAbstractionPrepareRequest,
            Hip3AccountAbstractionPrepareRequestBuilder> {
  _$Hip3AccountAbstractionPrepareRequest? _$v;

  Hip3AccountAbstractionPrepareRequestTargetModeEnum? _targetMode;
  Hip3AccountAbstractionPrepareRequestTargetModeEnum? get targetMode =>
      _$this._targetMode;
  set targetMode(
          Hip3AccountAbstractionPrepareRequestTargetModeEnum? targetMode) =>
      _$this._targetMode = targetMode;

  Hip3AccountAbstractionPrepareRequestBuilder() {
    Hip3AccountAbstractionPrepareRequest._defaults(this);
  }

  Hip3AccountAbstractionPrepareRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetMode = $v.targetMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3AccountAbstractionPrepareRequest other) {
    _$v = other as _$Hip3AccountAbstractionPrepareRequest;
  }

  @override
  void update(
      void Function(Hip3AccountAbstractionPrepareRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3AccountAbstractionPrepareRequest build() => _build();

  _$Hip3AccountAbstractionPrepareRequest _build() {
    final _$result = _$v ??
        _$Hip3AccountAbstractionPrepareRequest._(
          targetMode: BuiltValueNullFieldError.checkNotNull(targetMode,
              r'Hip3AccountAbstractionPrepareRequest', 'targetMode'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
