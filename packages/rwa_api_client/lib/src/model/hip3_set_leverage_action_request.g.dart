// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_set_leverage_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3SetLeverageActionRequestOperationEnum
    _$hip3SetLeverageActionRequestOperationEnum_setLeverage =
    const Hip3SetLeverageActionRequestOperationEnum._('setLeverage');
const Hip3SetLeverageActionRequestOperationEnum
    _$hip3SetLeverageActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3SetLeverageActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3SetLeverageActionRequestOperationEnum
    _$hip3SetLeverageActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'setLeverage':
      return _$hip3SetLeverageActionRequestOperationEnum_setLeverage;
    case 'unknownDefaultOpenApi':
      return _$hip3SetLeverageActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3SetLeverageActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3SetLeverageActionRequestOperationEnum>
    _$hip3SetLeverageActionRequestOperationEnumValues = BuiltSet<
        Hip3SetLeverageActionRequestOperationEnum>(const <Hip3SetLeverageActionRequestOperationEnum>[
  _$hip3SetLeverageActionRequestOperationEnum_setLeverage,
  _$hip3SetLeverageActionRequestOperationEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3SetLeverageActionRequestOperationEnum>
    _$hip3SetLeverageActionRequestOperationEnumSerializer =
    _$Hip3SetLeverageActionRequestOperationEnumSerializer();

class _$Hip3SetLeverageActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3SetLeverageActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'setLeverage': 'set_leverage',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'set_leverage': 'setLeverage',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3SetLeverageActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3SetLeverageActionRequestOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3SetLeverageActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3SetLeverageActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3SetLeverageActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3SetLeverageActionRequest extends Hip3SetLeverageActionRequest {
  @override
  final Hip3SetLeverageActionRequestOperationEnum operation;
  @override
  final String contextId;
  @override
  final String leverage;
  @override
  final MarginMode marginMode;

  factory _$Hip3SetLeverageActionRequest(
          [void Function(Hip3SetLeverageActionRequestBuilder)? updates]) =>
      (Hip3SetLeverageActionRequestBuilder()..update(updates))._build();

  _$Hip3SetLeverageActionRequest._(
      {required this.operation,
      required this.contextId,
      required this.leverage,
      required this.marginMode})
      : super._();
  @override
  Hip3SetLeverageActionRequest rebuild(
          void Function(Hip3SetLeverageActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3SetLeverageActionRequestBuilder toBuilder() =>
      Hip3SetLeverageActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3SetLeverageActionRequest &&
        operation == other.operation &&
        contextId == other.contextId &&
        leverage == other.leverage &&
        marginMode == other.marginMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, contextId.hashCode);
    _$hash = $jc(_$hash, leverage.hashCode);
    _$hash = $jc(_$hash, marginMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3SetLeverageActionRequest')
          ..add('operation', operation)
          ..add('contextId', contextId)
          ..add('leverage', leverage)
          ..add('marginMode', marginMode))
        .toString();
  }
}

class Hip3SetLeverageActionRequestBuilder
    implements
        Builder<Hip3SetLeverageActionRequest,
            Hip3SetLeverageActionRequestBuilder> {
  _$Hip3SetLeverageActionRequest? _$v;

  Hip3SetLeverageActionRequestOperationEnum? _operation;
  Hip3SetLeverageActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3SetLeverageActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _contextId;
  String? get contextId => _$this._contextId;
  set contextId(String? contextId) => _$this._contextId = contextId;

  String? _leverage;
  String? get leverage => _$this._leverage;
  set leverage(String? leverage) => _$this._leverage = leverage;

  MarginMode? _marginMode;
  MarginMode? get marginMode => _$this._marginMode;
  set marginMode(MarginMode? marginMode) => _$this._marginMode = marginMode;

  Hip3SetLeverageActionRequestBuilder() {
    Hip3SetLeverageActionRequest._defaults(this);
  }

  Hip3SetLeverageActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _contextId = $v.contextId;
      _leverage = $v.leverage;
      _marginMode = $v.marginMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3SetLeverageActionRequest other) {
    _$v = other as _$Hip3SetLeverageActionRequest;
  }

  @override
  void update(void Function(Hip3SetLeverageActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3SetLeverageActionRequest build() => _build();

  _$Hip3SetLeverageActionRequest _build() {
    final _$result = _$v ??
        _$Hip3SetLeverageActionRequest._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3SetLeverageActionRequest', 'operation'),
          contextId: BuiltValueNullFieldError.checkNotNull(
              contextId, r'Hip3SetLeverageActionRequest', 'contextId'),
          leverage: BuiltValueNullFieldError.checkNotNull(
              leverage, r'Hip3SetLeverageActionRequest', 'leverage'),
          marginMode: BuiltValueNullFieldError.checkNotNull(
              marginMode, r'Hip3SetLeverageActionRequest', 'marginMode'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
