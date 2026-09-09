// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_eip712_field.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Eip712FieldNameEnum _$hip3Eip712FieldNameEnum_source_ =
    const Hip3Eip712FieldNameEnum._('source_');
const Hip3Eip712FieldNameEnum _$hip3Eip712FieldNameEnum_connectionId =
    const Hip3Eip712FieldNameEnum._('connectionId');
const Hip3Eip712FieldNameEnum _$hip3Eip712FieldNameEnum_unknownDefaultOpenApi =
    const Hip3Eip712FieldNameEnum._('unknownDefaultOpenApi');

Hip3Eip712FieldNameEnum _$hip3Eip712FieldNameEnumValueOf(String name) {
  switch (name) {
    case 'source_':
      return _$hip3Eip712FieldNameEnum_source_;
    case 'connectionId':
      return _$hip3Eip712FieldNameEnum_connectionId;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712FieldNameEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712FieldNameEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712FieldNameEnum> _$hip3Eip712FieldNameEnumValues =
    BuiltSet<Hip3Eip712FieldNameEnum>(const <Hip3Eip712FieldNameEnum>[
  _$hip3Eip712FieldNameEnum_source_,
  _$hip3Eip712FieldNameEnum_connectionId,
  _$hip3Eip712FieldNameEnum_unknownDefaultOpenApi,
]);

const Hip3Eip712FieldTypeEnum _$hip3Eip712FieldTypeEnum_string =
    const Hip3Eip712FieldTypeEnum._('string');
const Hip3Eip712FieldTypeEnum _$hip3Eip712FieldTypeEnum_bytes32 =
    const Hip3Eip712FieldTypeEnum._('bytes32');
const Hip3Eip712FieldTypeEnum _$hip3Eip712FieldTypeEnum_unknownDefaultOpenApi =
    const Hip3Eip712FieldTypeEnum._('unknownDefaultOpenApi');

Hip3Eip712FieldTypeEnum _$hip3Eip712FieldTypeEnumValueOf(String name) {
  switch (name) {
    case 'string':
      return _$hip3Eip712FieldTypeEnum_string;
    case 'bytes32':
      return _$hip3Eip712FieldTypeEnum_bytes32;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712FieldTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712FieldTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712FieldTypeEnum> _$hip3Eip712FieldTypeEnumValues =
    BuiltSet<Hip3Eip712FieldTypeEnum>(const <Hip3Eip712FieldTypeEnum>[
  _$hip3Eip712FieldTypeEnum_string,
  _$hip3Eip712FieldTypeEnum_bytes32,
  _$hip3Eip712FieldTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3Eip712FieldNameEnum> _$hip3Eip712FieldNameEnumSerializer =
    _$Hip3Eip712FieldNameEnumSerializer();
Serializer<Hip3Eip712FieldTypeEnum> _$hip3Eip712FieldTypeEnumSerializer =
    _$Hip3Eip712FieldTypeEnumSerializer();

class _$Hip3Eip712FieldNameEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712FieldNameEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'source_': 'source',
    'connectionId': 'connectionId',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'source': 'source_',
    'connectionId': 'connectionId',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712FieldNameEnum];
  @override
  final String wireName = 'Hip3Eip712FieldNameEnum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712FieldNameEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712FieldNameEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712FieldNameEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712FieldTypeEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712FieldTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'string': 'string',
    'bytes32': 'bytes32',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'string': 'string',
    'bytes32': 'bytes32',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712FieldTypeEnum];
  @override
  final String wireName = 'Hip3Eip712FieldTypeEnum';

  @override
  Object serialize(Serializers serializers, Hip3Eip712FieldTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712FieldTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712FieldTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712Field extends Hip3Eip712Field {
  @override
  final Hip3Eip712FieldNameEnum name;
  @override
  final Hip3Eip712FieldTypeEnum type;

  factory _$Hip3Eip712Field([void Function(Hip3Eip712FieldBuilder)? updates]) =>
      (Hip3Eip712FieldBuilder()..update(updates))._build();

  _$Hip3Eip712Field._({required this.name, required this.type}) : super._();
  @override
  Hip3Eip712Field rebuild(void Function(Hip3Eip712FieldBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3Eip712FieldBuilder toBuilder() => Hip3Eip712FieldBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Eip712Field && name == other.name && type == other.type;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Eip712Field')
          ..add('name', name)
          ..add('type', type))
        .toString();
  }
}

class Hip3Eip712FieldBuilder
    implements Builder<Hip3Eip712Field, Hip3Eip712FieldBuilder> {
  _$Hip3Eip712Field? _$v;

  Hip3Eip712FieldNameEnum? _name;
  Hip3Eip712FieldNameEnum? get name => _$this._name;
  set name(Hip3Eip712FieldNameEnum? name) => _$this._name = name;

  Hip3Eip712FieldTypeEnum? _type;
  Hip3Eip712FieldTypeEnum? get type => _$this._type;
  set type(Hip3Eip712FieldTypeEnum? type) => _$this._type = type;

  Hip3Eip712FieldBuilder() {
    Hip3Eip712Field._defaults(this);
  }

  Hip3Eip712FieldBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Eip712Field other) {
    _$v = other as _$Hip3Eip712Field;
  }

  @override
  void update(void Function(Hip3Eip712FieldBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Eip712Field build() => _build();

  _$Hip3Eip712Field _build() {
    final _$result = _$v ??
        _$Hip3Eip712Field._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'Hip3Eip712Field', 'name'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'Hip3Eip712Field', 'type'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
