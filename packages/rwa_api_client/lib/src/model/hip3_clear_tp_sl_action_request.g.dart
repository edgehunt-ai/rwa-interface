// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_clear_tp_sl_action_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3ClearTpSlActionRequestOperationEnum
    _$hip3ClearTpSlActionRequestOperationEnum_clearTpsl =
    const Hip3ClearTpSlActionRequestOperationEnum._('clearTpsl');
const Hip3ClearTpSlActionRequestOperationEnum
    _$hip3ClearTpSlActionRequestOperationEnum_unknownDefaultOpenApi =
    const Hip3ClearTpSlActionRequestOperationEnum._('unknownDefaultOpenApi');

Hip3ClearTpSlActionRequestOperationEnum
    _$hip3ClearTpSlActionRequestOperationEnumValueOf(String name) {
  switch (name) {
    case 'clearTpsl':
      return _$hip3ClearTpSlActionRequestOperationEnum_clearTpsl;
    case 'unknownDefaultOpenApi':
      return _$hip3ClearTpSlActionRequestOperationEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ClearTpSlActionRequestOperationEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ClearTpSlActionRequestOperationEnum>
    _$hip3ClearTpSlActionRequestOperationEnumValues = BuiltSet<
        Hip3ClearTpSlActionRequestOperationEnum>(const <Hip3ClearTpSlActionRequestOperationEnum>[
  _$hip3ClearTpSlActionRequestOperationEnum_clearTpsl,
  _$hip3ClearTpSlActionRequestOperationEnum_unknownDefaultOpenApi,
]);

const Hip3ClearTpSlActionRequestScopeEnum
    _$hip3ClearTpSlActionRequestScopeEnum_takeProfit =
    const Hip3ClearTpSlActionRequestScopeEnum._('takeProfit');
const Hip3ClearTpSlActionRequestScopeEnum
    _$hip3ClearTpSlActionRequestScopeEnum_stopLoss =
    const Hip3ClearTpSlActionRequestScopeEnum._('stopLoss');
const Hip3ClearTpSlActionRequestScopeEnum
    _$hip3ClearTpSlActionRequestScopeEnum_both =
    const Hip3ClearTpSlActionRequestScopeEnum._('both');
const Hip3ClearTpSlActionRequestScopeEnum
    _$hip3ClearTpSlActionRequestScopeEnum_unknownDefaultOpenApi =
    const Hip3ClearTpSlActionRequestScopeEnum._('unknownDefaultOpenApi');

Hip3ClearTpSlActionRequestScopeEnum
    _$hip3ClearTpSlActionRequestScopeEnumValueOf(String name) {
  switch (name) {
    case 'takeProfit':
      return _$hip3ClearTpSlActionRequestScopeEnum_takeProfit;
    case 'stopLoss':
      return _$hip3ClearTpSlActionRequestScopeEnum_stopLoss;
    case 'both':
      return _$hip3ClearTpSlActionRequestScopeEnum_both;
    case 'unknownDefaultOpenApi':
      return _$hip3ClearTpSlActionRequestScopeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3ClearTpSlActionRequestScopeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3ClearTpSlActionRequestScopeEnum>
    _$hip3ClearTpSlActionRequestScopeEnumValues = BuiltSet<
        Hip3ClearTpSlActionRequestScopeEnum>(const <Hip3ClearTpSlActionRequestScopeEnum>[
  _$hip3ClearTpSlActionRequestScopeEnum_takeProfit,
  _$hip3ClearTpSlActionRequestScopeEnum_stopLoss,
  _$hip3ClearTpSlActionRequestScopeEnum_both,
  _$hip3ClearTpSlActionRequestScopeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3ClearTpSlActionRequestOperationEnum>
    _$hip3ClearTpSlActionRequestOperationEnumSerializer =
    _$Hip3ClearTpSlActionRequestOperationEnumSerializer();
Serializer<Hip3ClearTpSlActionRequestScopeEnum>
    _$hip3ClearTpSlActionRequestScopeEnumSerializer =
    _$Hip3ClearTpSlActionRequestScopeEnumSerializer();

class _$Hip3ClearTpSlActionRequestOperationEnumSerializer
    implements PrimitiveSerializer<Hip3ClearTpSlActionRequestOperationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'clearTpsl': 'clear_tpsl',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'clear_tpsl': 'clearTpsl',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ClearTpSlActionRequestOperationEnum
  ];
  @override
  final String wireName = 'Hip3ClearTpSlActionRequestOperationEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3ClearTpSlActionRequestOperationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ClearTpSlActionRequestOperationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ClearTpSlActionRequestOperationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ClearTpSlActionRequestScopeEnumSerializer
    implements PrimitiveSerializer<Hip3ClearTpSlActionRequestScopeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'takeProfit': 'take_profit',
    'stopLoss': 'stop_loss',
    'both': 'both',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'take_profit': 'takeProfit',
    'stop_loss': 'stopLoss',
    'both': 'both',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3ClearTpSlActionRequestScopeEnum
  ];
  @override
  final String wireName = 'Hip3ClearTpSlActionRequestScopeEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3ClearTpSlActionRequestScopeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3ClearTpSlActionRequestScopeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3ClearTpSlActionRequestScopeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3ClearTpSlActionRequest extends Hip3ClearTpSlActionRequest {
  @override
  final Hip3ClearTpSlActionRequestOperationEnum operation;
  @override
  final String positionId;
  @override
  final String positionVersion;
  @override
  final Hip3ClearTpSlActionRequestScopeEnum scope;

  factory _$Hip3ClearTpSlActionRequest(
          [void Function(Hip3ClearTpSlActionRequestBuilder)? updates]) =>
      (Hip3ClearTpSlActionRequestBuilder()..update(updates))._build();

  _$Hip3ClearTpSlActionRequest._(
      {required this.operation,
      required this.positionId,
      required this.positionVersion,
      required this.scope})
      : super._();
  @override
  Hip3ClearTpSlActionRequest rebuild(
          void Function(Hip3ClearTpSlActionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ClearTpSlActionRequestBuilder toBuilder() =>
      Hip3ClearTpSlActionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ClearTpSlActionRequest &&
        operation == other.operation &&
        positionId == other.positionId &&
        positionVersion == other.positionVersion &&
        scope == other.scope;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, operation.hashCode);
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, positionVersion.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ClearTpSlActionRequest')
          ..add('operation', operation)
          ..add('positionId', positionId)
          ..add('positionVersion', positionVersion)
          ..add('scope', scope))
        .toString();
  }
}

class Hip3ClearTpSlActionRequestBuilder
    implements
        Builder<Hip3ClearTpSlActionRequest, Hip3ClearTpSlActionRequestBuilder> {
  _$Hip3ClearTpSlActionRequest? _$v;

  Hip3ClearTpSlActionRequestOperationEnum? _operation;
  Hip3ClearTpSlActionRequestOperationEnum? get operation => _$this._operation;
  set operation(Hip3ClearTpSlActionRequestOperationEnum? operation) =>
      _$this._operation = operation;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _positionVersion;
  String? get positionVersion => _$this._positionVersion;
  set positionVersion(String? positionVersion) =>
      _$this._positionVersion = positionVersion;

  Hip3ClearTpSlActionRequestScopeEnum? _scope;
  Hip3ClearTpSlActionRequestScopeEnum? get scope => _$this._scope;
  set scope(Hip3ClearTpSlActionRequestScopeEnum? scope) =>
      _$this._scope = scope;

  Hip3ClearTpSlActionRequestBuilder() {
    Hip3ClearTpSlActionRequest._defaults(this);
  }

  Hip3ClearTpSlActionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _operation = $v.operation;
      _positionId = $v.positionId;
      _positionVersion = $v.positionVersion;
      _scope = $v.scope;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ClearTpSlActionRequest other) {
    _$v = other as _$Hip3ClearTpSlActionRequest;
  }

  @override
  void update(void Function(Hip3ClearTpSlActionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ClearTpSlActionRequest build() => _build();

  _$Hip3ClearTpSlActionRequest _build() {
    final _$result = _$v ??
        _$Hip3ClearTpSlActionRequest._(
          operation: BuiltValueNullFieldError.checkNotNull(
              operation, r'Hip3ClearTpSlActionRequest', 'operation'),
          positionId: BuiltValueNullFieldError.checkNotNull(
              positionId, r'Hip3ClearTpSlActionRequest', 'positionId'),
          positionVersion: BuiltValueNullFieldError.checkNotNull(
              positionVersion,
              r'Hip3ClearTpSlActionRequest',
              'positionVersion'),
          scope: BuiltValueNullFieldError.checkNotNull(
              scope, r'Hip3ClearTpSlActionRequest', 'scope'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
