// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_modify_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionModifyChangeOperationEnum
    _$hip3ProtectionModifyChangeOperationEnum_modify =
    const Hip3ProtectionModifyChangeOperationEnum._('modify');

Hip3ProtectionModifyChangeOperationEnum
    _$hip3ProtectionModifyChangeOperationEnumValueOf(String name) {
  switch (name) {
    case 'modify':
      return _$hip3ProtectionModifyChangeOperationEnum_modify;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionModifyChangeOperationEnum>
    _$hip3ProtectionModifyChangeOperationEnumValues = BuiltSet<
        Hip3ProtectionModifyChangeOperationEnum>(const <Hip3ProtectionModifyChangeOperationEnum>[
  _$hip3ProtectionModifyChangeOperationEnum_modify,
]);

Serializer<Hip3ProtectionModifyChangeOperationEnum>
    _$hip3ProtectionModifyChangeOperationEnumSerializer =
    _$Hip3ProtectionModifyChangeOperationEnumSerializer();

class _$Hip3ProtectionModifyChangeOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionModifyChangeOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'modify': 'modify',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'modify': 'modify',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ProtectionModifyChangeOperationEnum
  ];
  @override
  final String wireName = 'Hip3ProtectionModifyChangeOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3ProtectionModifyChangeOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionModifyChangeOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionModifyChangeOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionModifyChange extends Hip3ProtectionModifyChange {
  @override
  final Hip3ProtectionModifyChangeOperationEnum operation;
  @override
  final String orderId;
  @override
  final Hip3SingleProtectionSpec? protection;

  factory _$Hip3ProtectionModifyChange(
          [void Function(Hip3ProtectionModifyChangeBuilder)? updates]) =>
      (Hip3ProtectionModifyChangeBuilder()..update(updates))._build();

  _$Hip3ProtectionModifyChange._(
      {required this.operation, required this.orderId, this.protection})
      : super._();
  @override
  Hip3ProtectionModifyChange rebuild(
          void Function(Hip3ProtectionModifyChangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionModifyChangeBuilder toBuilder() =>
      Hip3ProtectionModifyChangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionModifyChange &&
        operation == other.operation &&
        orderId == other.orderId &&
        protection == other.protection;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, protection.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionModifyChange')
          ..add('operation', operation)
          ..add('orderId', orderId)
          ..add('protection', protection))
        .toString();
  }
}

class Hip3ProtectionModifyChangeBuilder
    implements
        Builder<Hip3ProtectionModifyChange, Hip3ProtectionModifyChangeBuilder> {
  _$Hip3ProtectionModifyChange? _$v;

  Hip3ProtectionModifyChangeOperationEnum? _operation;
  Hip3ProtectionModifyChangeOperationEnum? get operation => _$this._operation;
  set operation(Hip3ProtectionModifyChangeOperationEnum? operation) =>
      _$this._operation = operation;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  Hip3SingleProtectionSpecBuilder? _protection;
  Hip3SingleProtectionSpecBuilder get protection =>
      _$this._protection ??= Hip3SingleProtectionSpecBuilder();
  set protection(Hip3SingleProtectionSpecBuilder? protection) =>
      _$this._protection = protection;

  Hip3ProtectionModifyChangeBuilder() {
    Hip3ProtectionModifyChange._defaults(this);
  }

  Hip3ProtectionModifyChangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _orderId = $v.orderId;
      _protection = $v.protection?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionModifyChange other) {
    _$v = other as _$Hip3ProtectionModifyChange;
  }

  @override
  void update(void Function(Hip3ProtectionModifyChangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionModifyChange build() => _build();

  _$Hip3ProtectionModifyChange _build() {
    _$Hip3ProtectionModifyChange _$result;
    try {
      _$result = _$v ??
          _$Hip3ProtectionModifyChange._(
            operation: BuiltValueNullFieldError.checkNotNull(
                operation, r'Hip3ProtectionModifyChange', 'operation'),
            orderId: BuiltValueNullFieldError.checkNotNull(
                orderId, r'Hip3ProtectionModifyChange', 'orderId'),
            protection: _protection?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'protection';
        _protection?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ProtectionModifyChange', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
