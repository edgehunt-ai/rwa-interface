// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_eip712_typed_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3Eip712TypedDataPrimaryTypeEnum
    _$hip3Eip712TypedDataPrimaryTypeEnum_agent =
    const Hip3Eip712TypedDataPrimaryTypeEnum._('agent');
const Hip3Eip712TypedDataPrimaryTypeEnum
    _$hip3Eip712TypedDataPrimaryTypeEnum_unknownDefaultOpenApi =
    const Hip3Eip712TypedDataPrimaryTypeEnum._('unknownDefaultOpenApi');

Hip3Eip712TypedDataPrimaryTypeEnum _$hip3Eip712TypedDataPrimaryTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'agent':
      return _$hip3Eip712TypedDataPrimaryTypeEnum_agent;
    case 'unknownDefaultOpenApi':
      return _$hip3Eip712TypedDataPrimaryTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3Eip712TypedDataPrimaryTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3Eip712TypedDataPrimaryTypeEnum>
    _$hip3Eip712TypedDataPrimaryTypeEnumValues = BuiltSet<
        Hip3Eip712TypedDataPrimaryTypeEnum>(const <Hip3Eip712TypedDataPrimaryTypeEnum>[
  _$hip3Eip712TypedDataPrimaryTypeEnum_agent,
  _$hip3Eip712TypedDataPrimaryTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3Eip712TypedDataPrimaryTypeEnum>
    _$hip3Eip712TypedDataPrimaryTypeEnumSerializer =
    _$Hip3Eip712TypedDataPrimaryTypeEnumSerializer();

class _$Hip3Eip712TypedDataPrimaryTypeEnumSerializer
    implements PrimitiveSerializer<Hip3Eip712TypedDataPrimaryTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'agent': 'Agent',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Agent': 'agent',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3Eip712TypedDataPrimaryTypeEnum];
  @override
  final String wireName = 'Hip3Eip712TypedDataPrimaryTypeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3Eip712TypedDataPrimaryTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3Eip712TypedDataPrimaryTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3Eip712TypedDataPrimaryTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3Eip712TypedData extends Hip3Eip712TypedData {
  @override
  final Hip3Eip712Domain domain;
  @override
  final Hip3Eip712Types types;
  @override
  final Hip3Eip712TypedDataPrimaryTypeEnum primaryType;
  @override
  final Hip3Eip712Message message;

  factory _$Hip3Eip712TypedData(
          [void Function(Hip3Eip712TypedDataBuilder)? updates]) =>
      (Hip3Eip712TypedDataBuilder()..update(updates))._build();

  _$Hip3Eip712TypedData._(
      {required this.domain,
      required this.types,
      required this.primaryType,
      required this.message})
      : super._();
  @override
  Hip3Eip712TypedData rebuild(
          void Function(Hip3Eip712TypedDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3Eip712TypedDataBuilder toBuilder() =>
      Hip3Eip712TypedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3Eip712TypedData &&
        domain == other.domain &&
        types == other.types &&
        primaryType == other.primaryType &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, domain.hashCode);
    _$hash = $jc(_$hash, types.hashCode);
    _$hash = $jc(_$hash, primaryType.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3Eip712TypedData')
          ..add('domain', domain)
          ..add('types', types)
          ..add('primaryType', primaryType)
          ..add('message', message))
        .toString();
  }
}

class Hip3Eip712TypedDataBuilder
    implements Builder<Hip3Eip712TypedData, Hip3Eip712TypedDataBuilder> {
  _$Hip3Eip712TypedData? _$v;

  Hip3Eip712DomainBuilder? _domain;
  Hip3Eip712DomainBuilder get domain =>
      _$this._domain ??= Hip3Eip712DomainBuilder();
  set domain(Hip3Eip712DomainBuilder? domain) => _$this._domain = domain;

  Hip3Eip712TypesBuilder? _types;
  Hip3Eip712TypesBuilder get types =>
      _$this._types ??= Hip3Eip712TypesBuilder();
  set types(Hip3Eip712TypesBuilder? types) => _$this._types = types;

  Hip3Eip712TypedDataPrimaryTypeEnum? _primaryType;
  Hip3Eip712TypedDataPrimaryTypeEnum? get primaryType => _$this._primaryType;
  set primaryType(Hip3Eip712TypedDataPrimaryTypeEnum? primaryType) =>
      _$this._primaryType = primaryType;

  Hip3Eip712MessageBuilder? _message;
  Hip3Eip712MessageBuilder get message =>
      _$this._message ??= Hip3Eip712MessageBuilder();
  set message(Hip3Eip712MessageBuilder? message) => _$this._message = message;

  Hip3Eip712TypedDataBuilder() {
    Hip3Eip712TypedData._defaults(this);
  }

  Hip3Eip712TypedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _domain = $v.domain.toBuilder();
      _types = $v.types.toBuilder();
      _primaryType = $v.primaryType;
      _message = $v.message.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3Eip712TypedData other) {
    _$v = other as _$Hip3Eip712TypedData;
  }

  @override
  void update(void Function(Hip3Eip712TypedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3Eip712TypedData build() => _build();

  _$Hip3Eip712TypedData _build() {
    _$Hip3Eip712TypedData _$result;
    try {
      _$result = _$v ??
          _$Hip3Eip712TypedData._(
            domain: domain.build(),
            types: types.build(),
            primaryType: BuiltValueNullFieldError.checkNotNull(
                primaryType, r'Hip3Eip712TypedData', 'primaryType'),
            message: message.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'domain';
        domain.build();
        _$failedField = 'types';
        types.build();

        _$failedField = 'message';
        message.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3Eip712TypedData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
