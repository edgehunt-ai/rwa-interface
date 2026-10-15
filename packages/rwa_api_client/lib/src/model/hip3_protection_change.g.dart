// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_protection_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ProtectionChangeOperationEnum
    _$hip3ProtectionChangeOperationEnum_cancel =
    const Hip3ProtectionChangeOperationEnum._('cancel');

Hip3ProtectionChangeOperationEnum _$hip3ProtectionChangeOperationEnumValueOf(
    String name) {
  switch (name) {
    case 'cancel':
      return _$hip3ProtectionChangeOperationEnum_cancel;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ProtectionChangeOperationEnum>
    _$hip3ProtectionChangeOperationEnumValues = BuiltSet<
        Hip3ProtectionChangeOperationEnum>(const <Hip3ProtectionChangeOperationEnum>[
  _$hip3ProtectionChangeOperationEnum_cancel,
]);

Serializer<Hip3ProtectionChangeOperationEnum>
    _$hip3ProtectionChangeOperationEnumSerializer =
    _$Hip3ProtectionChangeOperationEnumSerializer();

class _$Hip3ProtectionChangeOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ProtectionChangeOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'cancel': 'cancel',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'cancel': 'cancel',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3ProtectionChangeOperationEnum];
  @override
  final String wireName = 'Hip3ProtectionChangeOperationEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ProtectionChangeOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ProtectionChangeOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ProtectionChangeOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ProtectionChange extends Hip3ProtectionChange {
  @override
  final OneOf oneOf;

  factory _$Hip3ProtectionChange(
          [void Function(Hip3ProtectionChangeBuilder)? updates]) =>
      (Hip3ProtectionChangeBuilder()..update(updates))._build();

  _$Hip3ProtectionChange._({required this.oneOf}) : super._();
  @override
  Hip3ProtectionChange rebuild(
          void Function(Hip3ProtectionChangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ProtectionChangeBuilder toBuilder() =>
      Hip3ProtectionChangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ProtectionChange && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ProtectionChange')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class Hip3ProtectionChangeBuilder
    implements Builder<Hip3ProtectionChange, Hip3ProtectionChangeBuilder> {
  _$Hip3ProtectionChange? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  Hip3ProtectionChangeBuilder() {
    Hip3ProtectionChange._defaults(this);
  }

  Hip3ProtectionChangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ProtectionChange other) {
    _$v = other as _$Hip3ProtectionChange;
  }

  @override
  void update(void Function(Hip3ProtectionChangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ProtectionChange build() => _build();

  _$Hip3ProtectionChange _build() {
    final _$result = _$v ??
        _$Hip3ProtectionChange._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'Hip3ProtectionChange', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
