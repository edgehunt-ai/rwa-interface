// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_manage_tp_sl_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ManageTpSlActionRequestOperationEnum
    _$hip3ManageTpSlActionRequestOperationEnum_manageTpsl =
    const Hip3ManageTpSlActionRequestOperationEnum._('manageTpsl');

Hip3ManageTpSlActionRequestOperationEnum
    _$hip3ManageTpSlActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'manageTpsl':
      return _$hip3ManageTpSlActionRequestOperationEnum_manageTpsl;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ManageTpSlActionRequestOperationEnum>
    _$hip3ManageTpSlActionRequestOperationEnumValues = BuiltSet<
        Hip3ManageTpSlActionRequestOperationEnum>(const <Hip3ManageTpSlActionRequestOperationEnum>[
  _$hip3ManageTpSlActionRequestOperationEnum_manageTpsl,
]);

Serializer<Hip3ManageTpSlActionRequestOperationEnum>
    _$hip3ManageTpSlActionRequestOperationEnumSerializer =
    _$Hip3ManageTpSlActionRequestOperationEnumSerializer();

class _$Hip3ManageTpSlActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ManageTpSlActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'manageTpsl': 'manage_tpsl',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'manage_tpsl': 'manageTpsl',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ManageTpSlActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3ManageTpSlActionRequestOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3ManageTpSlActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ManageTpSlActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ManageTpSlActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ManageTpSlActionRequest extends Hip3ManageTpSlActionRequest {
  @override
  final Hip3ManageTpSlActionRequestOperationEnum operation;
  @override
  final String positionId;
  @override
  final String positionVersion;
  @override
  final BuiltList<Hip3ProtectionChange> changes;

  factory _$Hip3ManageTpSlActionRequest(
          [void Function(Hip3ManageTpSlActionRequestBuilder)? updates]) =>
      (Hip3ManageTpSlActionRequestBuilder()..update(updates))._build();

  _$Hip3ManageTpSlActionRequest._(
      {required this.operation,
      required this.positionId,
      required this.positionVersion,
      required this.changes})
      : super._();
  @override
  Hip3ManageTpSlActionRequest rebuild(
          void Function(Hip3ManageTpSlActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ManageTpSlActionRequestBuilder toBuilder() =>
      Hip3ManageTpSlActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ManageTpSlActionRequest &&
        operation == other.operation &&
        positionId == other.positionId &&
        positionVersion == other.positionVersion &&
        changes == other.changes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, positionVersion.hashCode);
    _$hash = $jc(_$hash, changes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ManageTpSlActionRequest')
          ..add('operation', operation)
          ..add('positionId', positionId)
          ..add('positionVersion', positionVersion)
          ..add('changes', changes))
        .toString();
  }
}

class Hip3ManageTpSlActionRequestBuilder
    implements
        Builder<Hip3ManageTpSlActionRequest,
            Hip3ManageTpSlActionRequestBuilder> {
  _$Hip3ManageTpSlActionRequest? _$v;

  Hip3ManageTpSlActionRequestOperationEnum? _operation;
  Hip3ManageTpSlActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3ManageTpSlActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _positionVersion;
  String? get positionVersion => _$this._positionVersion;
  set positionVersion(String? positionVersion) =>
      _$this._positionVersion = positionVersion;

  ListBuilder<Hip3ProtectionChange>? _changes;
  ListBuilder<Hip3ProtectionChange> get changes =>
      _$this._changes ??= ListBuilder<Hip3ProtectionChange>();
  set changes(ListBuilder<Hip3ProtectionChange>? changes) =>
      _$this._changes = changes;

  Hip3ManageTpSlActionRequestBuilder() {
    Hip3ManageTpSlActionRequest._defaults(this);
  }

  Hip3ManageTpSlActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _positionId = $v.positionId;
      _positionVersion = $v.positionVersion;
      _changes = $v.changes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ManageTpSlActionRequest other) {
    _$v = other as _$Hip3ManageTpSlActionRequest;
  }

  @override
  void update(void Function(Hip3ManageTpSlActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ManageTpSlActionRequest build() => _build();

  _$Hip3ManageTpSlActionRequest _build() {
    _$Hip3ManageTpSlActionRequest _$result;
    try {
      _$result = _$v ??
          _$Hip3ManageTpSlActionRequest._(
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3ManageTpSlActionRequest', 'operation'),
            positionId: BuiltValueNullFieldError.checkNotNull(
                positionId, r'Hip3ManageTpSlActionRequest', 'positionId'),
            positionVersion: BuiltValueNullFieldError.checkNotNull(
                positionVersion,
                r'Hip3ManageTpSlActionRequest',
                'positionVersion'),
            changes: changes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changes';
        changes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ManageTpSlActionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
