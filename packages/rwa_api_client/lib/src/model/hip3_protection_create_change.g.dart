// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_create_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionCreateChangeOperationEnum
    _$hip3ProtectionCreateChangeOperationEnum_create =
    const Hip3ProtectionCreateChangeOperationEnum._('create');

Hip3ProtectionCreateChangeOperationEnum
    _$hip3ProtectionCreateChangeOperationEnumValueOf(String name) {
  switch (name) {
    case 'create':
      return _$hip3ProtectionCreateChangeOperationEnum_create;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionCreateChangeOperationEnum>
    _$hip3ProtectionCreateChangeOperationEnumValues = BuiltSet<
        Hip3ProtectionCreateChangeOperationEnum>(const <Hip3ProtectionCreateChangeOperationEnum>[
  _$hip3ProtectionCreateChangeOperationEnum_create,
]);

Serializer<Hip3ProtectionCreateChangeOperationEnum>
    _$hip3ProtectionCreateChangeOperationEnumSerializer =
    _$Hip3ProtectionCreateChangeOperationEnumSerializer();

class _$Hip3ProtectionCreateChangeOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionCreateChangeOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'create': 'create',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'create': 'create',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ProtectionCreateChangeOperationEnum
  ];
  @override
  final String wireName = 'Hip3ProtectionCreateChangeOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3ProtectionCreateChangeOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionCreateChangeOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionCreateChangeOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionCreateChange extends Hip3ProtectionCreateChange {
  @override
  final Hip3ProtectionCreateChangeOperationEnum operation;
  @override
  final Hip3SingleProtectionSpec? protection;

  factory _$Hip3ProtectionCreateChange(
          [void Function(Hip3ProtectionCreateChangeBuilder)? updates]) =>
      (Hip3ProtectionCreateChangeBuilder()..update(updates))._build();

  _$Hip3ProtectionCreateChange._({required this.operation, this.protection})
      : super._();
  @override
  Hip3ProtectionCreateChange rebuild(
          void Function(Hip3ProtectionCreateChangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionCreateChangeBuilder toBuilder() =>
      Hip3ProtectionCreateChangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionCreateChange &&
        operation == other.operation &&
        protection == other.protection;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, protection.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionCreateChange')
          ..add('operation', operation)
          ..add('protection', protection))
        .toString();
  }
}

class Hip3ProtectionCreateChangeBuilder
    implements
        Builder<Hip3ProtectionCreateChange, Hip3ProtectionCreateChangeBuilder> {
  _$Hip3ProtectionCreateChange? _$v;

  Hip3ProtectionCreateChangeOperationEnum? _operation;
  Hip3ProtectionCreateChangeOperationEnum? get operation => _$this._operation;
  set operation(Hip3ProtectionCreateChangeOperationEnum? operation) =>
      _$this._operation = operation;

  Hip3SingleProtectionSpecBuilder? _protection;
  Hip3SingleProtectionSpecBuilder get protection =>
      _$this._protection ??= Hip3SingleProtectionSpecBuilder();
  set protection(Hip3SingleProtectionSpecBuilder? protection) =>
      _$this._protection = protection;

  Hip3ProtectionCreateChangeBuilder() {
    Hip3ProtectionCreateChange._defaults(this);
  }

  Hip3ProtectionCreateChangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _protection = $v.protection?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionCreateChange other) {
    _$v = other as _$Hip3ProtectionCreateChange;
  }

  @override
  void update(void Function(Hip3ProtectionCreateChangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionCreateChange build() => _build();

  _$Hip3ProtectionCreateChange _build() {
    _$Hip3ProtectionCreateChange _$result;
    try {
      _$result = _$v ??
          _$Hip3ProtectionCreateChange._(
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3ProtectionCreateChange', 'operation'),
            protection: _protection?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protection';
        _protection?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ProtectionCreateChange', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
