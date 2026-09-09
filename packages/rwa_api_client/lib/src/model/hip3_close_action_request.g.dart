// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_close_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3CloseActionRequestOperationEnum
    _$hip3CloseActionRequestOperationEnum_closePosition =
    const Hip3CloseActionRequestOperationEnum._('closePosition');
const Hip3CloseActionRequestOperationEnum
    _$hip3CloseActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3CloseActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3CloseActionRequestOperationEnum
    _$hip3CloseActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'closePosition':
      return _$hip3CloseActionRequestOperationEnum_closePosition;
    case 'unknownDefaultOpenApi':
      return _$hip3CloseActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3CloseActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3CloseActionRequestOperationEnum>
    _$hip3CloseActionRequestOperationEnumValues = BuiltSet<
        Hip3CloseActionRequestOperationEnum>(const <Hip3CloseActionRequestOperationEnum>[
  _$hip3CloseActionRequestOperationEnum_closePosition,
  _$hip3CloseActionRequestOperationEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3CloseActionRequestOperationEnum>
    _$hip3CloseActionRequestOperationEnumSerializer =
    _$Hip3CloseActionRequestOperationEnumSerializer();

class _$Hip3CloseActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3CloseActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'closePosition': 'close_position',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'close_position': 'closePosition',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CloseActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3CloseActionRequestOperationEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3CloseActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CloseActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CloseActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CloseActionRequest extends Hip3CloseActionRequest {
  @override
  final Hip3CloseActionRequestOperationEnum operation;
  @override
  final String previewId;

  factory _$Hip3CloseActionRequest(
          [void Function(Hip3CloseActionRequestBuilder)? updates]) =>
      (Hip3CloseActionRequestBuilder()..update(updates))._build();

  _$Hip3CloseActionRequest._({required this.operation, required this.previewId})
      : super._();
  @override
  Hip3CloseActionRequest rebuild(
          void Function(Hip3CloseActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3CloseActionRequestBuilder toBuilder() =>
      Hip3CloseActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3CloseActionRequest &&
        operation == other.operation &&
        previewId == other.previewId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3CloseActionRequest')
          ..add('operation', operation)
          ..add('previewId', previewId))
        .toString();
  }
}

class Hip3CloseActionRequestBuilder
    implements Builder<Hip3CloseActionRequest, Hip3CloseActionRequestBuilder> {
  _$Hip3CloseActionRequest? _$v;

  Hip3CloseActionRequestOperationEnum? _operation;
  Hip3CloseActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3CloseActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  Hip3CloseActionRequestBuilder() {
    Hip3CloseActionRequest._defaults(this);
  }

  Hip3CloseActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _previewId = $v.previewId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3CloseActionRequest other) {
    _$v = other as _$Hip3CloseActionRequest;
  }

  @override
  void update(void Function(Hip3CloseActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3CloseActionRequest build() => _build();

  _$Hip3CloseActionRequest _build() {
    final _$result = _$v ??
        _$Hip3CloseActionRequest._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3CloseActionRequest', 'operation'),
          previewId: BuiltValueNullFieldError.checkNotNull(
              previewId, r'Hip3CloseActionRequest', 'previewId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
