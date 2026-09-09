// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_set_tp_sl_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3SetTpSlActionRequestOperationEnum
    _$hip3SetTpSlActionRequestOperationEnum_setTpsl =
    const Hip3SetTpSlActionRequestOperationEnum._('setTpsl');
const Hip3SetTpSlActionRequestOperationEnum
    _$hip3SetTpSlActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3SetTpSlActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3SetTpSlActionRequestOperationEnum
    _$hip3SetTpSlActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'setTpsl':
      return _$hip3SetTpSlActionRequestOperationEnum_setTpsl;
    case 'unknownDefaultOpenApi':
      return _$hip3SetTpSlActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3SetTpSlActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3SetTpSlActionRequestOperationEnum>
    _$hip3SetTpSlActionRequestOperationEnumValues = BuiltSet<
        Hip3SetTpSlActionRequestOperationEnum>(const <Hip3SetTpSlActionRequestOperationEnum>[
  _$hip3SetTpSlActionRequestOperationEnum_setTpsl,
  _$hip3SetTpSlActionRequestOperationEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3SetTpSlActionRequestOperationEnum>
    _$hip3SetTpSlActionRequestOperationEnumSerializer =
    _$Hip3SetTpSlActionRequestOperationEnumSerializer();

class _$Hip3SetTpSlActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3SetTpSlActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'setTpsl': 'set_tpsl',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'set_tpsl': 'setTpsl',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3SetTpSlActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3SetTpSlActionRequestOperationEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3SetTpSlActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3SetTpSlActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3SetTpSlActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3SetTpSlActionRequest extends Hip3SetTpSlActionRequest {
  @override
  final Hip3SetTpSlActionRequestOperationEnum operation;
  @override
  final String positionId;
  @override
  final String positionVersion;
  @override
  final Hip3ProtectionSpec protection;

  factory _$Hip3SetTpSlActionRequest(
          [void Function(Hip3SetTpSlActionRequestBuilder)? updates]) =>
      (Hip3SetTpSlActionRequestBuilder()..update(updates))._build();

  _$Hip3SetTpSlActionRequest._(
      {required this.operation,
      required this.positionId,
      required this.positionVersion,
      required this.protection})
      : super._();
  @override
  Hip3SetTpSlActionRequest rebuild(
          void Function(Hip3SetTpSlActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3SetTpSlActionRequestBuilder toBuilder() =>
      Hip3SetTpSlActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3SetTpSlActionRequest &&
        operation == other.operation &&
        positionId == other.positionId &&
        positionVersion == other.positionVersion &&
        protection == other.protection;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, positionVersion.hashCode);
    _$hash = $jc(_$hash, protection.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3SetTpSlActionRequest')
          ..add('operation', operation)
          ..add('positionId', positionId)
          ..add('positionVersion', positionVersion)
          ..add('protection', protection))
        .toString();
  }
}

class Hip3SetTpSlActionRequestBuilder
    implements
        Builder<Hip3SetTpSlActionRequest, Hip3SetTpSlActionRequestBuilder> {
  _$Hip3SetTpSlActionRequest? _$v;

  Hip3SetTpSlActionRequestOperationEnum? _operation;
  Hip3SetTpSlActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3SetTpSlActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _positionVersion;
  String? get positionVersion => _$this._positionVersion;
  set positionVersion(String? positionVersion) =>
      _$this._positionVersion = positionVersion;

  Hip3ProtectionSpecBuilder? _protection;
  Hip3ProtectionSpecBuilder get protection =>
      _$this._protection ??= Hip3ProtectionSpecBuilder();
  set protection(Hip3ProtectionSpecBuilder? protection) =>
      _$this._protection = protection;

  Hip3SetTpSlActionRequestBuilder() {
    Hip3SetTpSlActionRequest._defaults(this);
  }

  Hip3SetTpSlActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _positionId = $v.positionId;
      _positionVersion = $v.positionVersion;
      _protection = $v.protection.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3SetTpSlActionRequest other) {
    _$v = other as _$Hip3SetTpSlActionRequest;
  }

  @override
  void update(void Function(Hip3SetTpSlActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3SetTpSlActionRequest build() => _build();

  _$Hip3SetTpSlActionRequest _build() {
    _$Hip3SetTpSlActionRequest _$result;
    try {
      _$result = _$v ??
          _$Hip3SetTpSlActionRequest._(
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3SetTpSlActionRequest', 'operation'),
            positionId: BuiltValueNullFieldError.checkNotNull(
                positionId, r'Hip3SetTpSlActionRequest', 'positionId'),
            positionVersion: BuiltValueNullFieldError.checkNotNull(
                positionVersion,
                r'Hip3SetTpSlActionRequest',
                'positionVersion'),
            protection: protection.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protection';
        protection.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3SetTpSlActionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
