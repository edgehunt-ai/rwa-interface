// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_cancel_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionCancelChangeOperationEnum
    _$hip3ProtectionCancelChangeOperationEnum_cancel =
    const Hip3ProtectionCancelChangeOperationEnum._('cancel');

Hip3ProtectionCancelChangeOperationEnum
    _$hip3ProtectionCancelChangeOperationEnumValueOf(String name) {
  switch (name) {
    case 'cancel':
      return _$hip3ProtectionCancelChangeOperationEnum_cancel;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionCancelChangeOperationEnum>
    _$hip3ProtectionCancelChangeOperationEnumValues = BuiltSet<
        Hip3ProtectionCancelChangeOperationEnum>(const <Hip3ProtectionCancelChangeOperationEnum>[
  _$hip3ProtectionCancelChangeOperationEnum_cancel,
]);

Serializer<Hip3ProtectionCancelChangeOperationEnum>
    _$hip3ProtectionCancelChangeOperationEnumSerializer =
    _$Hip3ProtectionCancelChangeOperationEnumSerializer();

class _$Hip3ProtectionCancelChangeOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionCancelChangeOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cancel': 'cancel',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cancel': 'cancel',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ProtectionCancelChangeOperationEnum
  ];
  @override
  final String wireName = 'Hip3ProtectionCancelChangeOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3ProtectionCancelChangeOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionCancelChangeOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionCancelChangeOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionCancelChange extends Hip3ProtectionCancelChange {
  @override
  final Hip3ProtectionCancelChangeOperationEnum operation;
  @override
  final String orderId;

  factory _$Hip3ProtectionCancelChange(
          [void Function(Hip3ProtectionCancelChangeBuilder)? updates]) =>
      (Hip3ProtectionCancelChangeBuilder()..update(updates))._build();

  _$Hip3ProtectionCancelChange._(
      {required this.operation, required this.orderId})
      : super._();
  @override
  Hip3ProtectionCancelChange rebuild(
          void Function(Hip3ProtectionCancelChangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionCancelChangeBuilder toBuilder() =>
      Hip3ProtectionCancelChangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionCancelChange &&
        operation == other.operation &&
        orderId == other.orderId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionCancelChange')
          ..add('operation', operation)
          ..add('orderId', orderId))
        .toString();
  }
}

class Hip3ProtectionCancelChangeBuilder
    implements
        Builder<Hip3ProtectionCancelChange, Hip3ProtectionCancelChangeBuilder> {
  _$Hip3ProtectionCancelChange? _$v;

  Hip3ProtectionCancelChangeOperationEnum? _operation;
  Hip3ProtectionCancelChangeOperationEnum? get operation => _$this._operation;
  set operation(Hip3ProtectionCancelChangeOperationEnum? operation) =>
      _$this._operation = operation;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  Hip3ProtectionCancelChangeBuilder() {
    Hip3ProtectionCancelChange._defaults(this);
  }

  Hip3ProtectionCancelChangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _orderId = $v.orderId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionCancelChange other) {
    _$v = other as _$Hip3ProtectionCancelChange;
  }

  @override
  void update(void Function(Hip3ProtectionCancelChangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionCancelChange build() => _build();

  _$Hip3ProtectionCancelChange _build() {
    final _$result = _$v ??
        _$Hip3ProtectionCancelChange._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3ProtectionCancelChange', 'operation'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'Hip3ProtectionCancelChange', 'orderId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
