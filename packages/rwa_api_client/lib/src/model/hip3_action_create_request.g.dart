// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_action_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ActionCreateRequestOperationEnum
    _$hip3ActionCreateRequestOperationEnum_manageTpsl =
    const Hip3ActionCreateRequestOperationEnum._('manageTpsl');

Hip3ActionCreateRequestOperationEnum
    _$hip3ActionCreateRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'manageTpsl':
      return _$hip3ActionCreateRequestOperationEnum_manageTpsl;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3ActionCreateRequestOperationEnum>
    _$hip3ActionCreateRequestOperationEnumValues = BuiltSet<
        Hip3ActionCreateRequestOperationEnum>(const <Hip3ActionCreateRequestOperationEnum>[
  _$hip3ActionCreateRequestOperationEnum_manageTpsl,
]);

Serializer<Hip3ActionCreateRequestOperationEnum>
    _$hip3ActionCreateRequestOperationEnumSerializer =
    _$Hip3ActionCreateRequestOperationEnumSerializer();

class _$Hip3ActionCreateRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ActionCreateRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'manageTpsl': 'manage_tpsl',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'manage_tpsl': 'manageTpsl',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ActionCreateRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3ActionCreateRequestOperationEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ActionCreateRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ActionCreateRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ActionCreateRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ActionCreateRequest extends Hip3ActionCreateRequest {
  @override
  final OneOf oneOf;

  factory _$Hip3ActionCreateRequest(
          [void Function(Hip3ActionCreateRequestBuilder)? updates]) =>
      (Hip3ActionCreateRequestBuilder()..update(updates))._build();

  _$Hip3ActionCreateRequest._({required this.oneOf}) : super._();
  @override
  Hip3ActionCreateRequest rebuild(
          void Function(Hip3ActionCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ActionCreateRequestBuilder toBuilder() =>
      Hip3ActionCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ActionCreateRequest && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'Hip3ActionCreateRequest')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class Hip3ActionCreateRequestBuilder
    implements
        Builder<Hip3ActionCreateRequest, Hip3ActionCreateRequestBuilder> {
  _$Hip3ActionCreateRequest? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  Hip3ActionCreateRequestBuilder() {
    Hip3ActionCreateRequest._defaults(this);
  }

  Hip3ActionCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ActionCreateRequest other) {
    _$v = other as _$Hip3ActionCreateRequest;
  }

  @override
  void update(void Function(Hip3ActionCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ActionCreateRequest build() => _build();

  _$Hip3ActionCreateRequest _build() {
    final _$result = _$v ??
        _$Hip3ActionCreateRequest._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'Hip3ActionCreateRequest', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
