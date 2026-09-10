// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_multi_source_trade_intent_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum
    _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_autoMultiSource =
    const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum._(
        'autoMultiSource');
const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum
    _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi =
    const AutoMultiSourceTradeIntentCreateRequestFundingModeEnum._(
        'unknownDefaultOpenApi');

AutoMultiSourceTradeIntentCreateRequestFundingModeEnum
    _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumValueOf(
        String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AutoMultiSourceTradeIntentCreateRequestFundingModeEnum>
    _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumValues = BuiltSet<
        AutoMultiSourceTradeIntentCreateRequestFundingModeEnum>(const <AutoMultiSourceTradeIntentCreateRequestFundingModeEnum>[
  _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_autoMultiSource,
  _$autoMultiSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<AutoMultiSourceTradeIntentCreateRequestFundingModeEnum>
    _$autoMultiSourceTradeIntentCreateRequestFundingModeEnumSerializer =
    _$AutoMultiSourceTradeIntentCreateRequestFundingModeEnumSerializer();

class _$AutoMultiSourceTradeIntentCreateRequestFundingModeEnumSerializer
    implements
        PrimitiveSerializer<
            AutoMultiSourceTradeIntentCreateRequestFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoMultiSource': 'auto_multi_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_multi_source': 'autoMultiSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AutoMultiSourceTradeIntentCreateRequestFundingModeEnum
  ];
  @override
  final String wireName =
      'AutoMultiSourceTradeIntentCreateRequestFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          AutoMultiSourceTradeIntentCreateRequestFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AutoMultiSourceTradeIntentCreateRequestFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AutoMultiSourceTradeIntentCreateRequestFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AutoMultiSourceTradeIntentCreateRequest
    extends AutoMultiSourceTradeIntentCreateRequest {
  @override
  final String previewId;
  @override
  final String authorizationId;
  @override
  final AutoMultiSourceTradeIntentCreateRequestFundingModeEnum fundingMode;
  @override
  final TradeIntentExecutionPolicy executionPolicy;

  factory _$AutoMultiSourceTradeIntentCreateRequest(
          [void Function(AutoMultiSourceTradeIntentCreateRequestBuilder)?
              updates]) =>
      (AutoMultiSourceTradeIntentCreateRequestBuilder()..update(updates))
          ._build();

  _$AutoMultiSourceTradeIntentCreateRequest._(
      {required this.previewId,
      required this.authorizationId,
      required this.fundingMode,
      required this.executionPolicy})
      : super._();
  @override
  AutoMultiSourceTradeIntentCreateRequest rebuild(
          void Function(AutoMultiSourceTradeIntentCreateRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutoMultiSourceTradeIntentCreateRequestBuilder toBuilder() =>
      AutoMultiSourceTradeIntentCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutoMultiSourceTradeIntentCreateRequest &&
        previewId == other.previewId &&
        authorizationId == other.authorizationId &&
        fundingMode == other.fundingMode &&
        executionPolicy == other.executionPolicy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jc(_$hash, executionPolicy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AutoMultiSourceTradeIntentCreateRequest')
          ..add('previewId', previewId)
          ..add('authorizationId', authorizationId)
          ..add('fundingMode', fundingMode)
          ..add('executionPolicy', executionPolicy))
        .toString();
  }
}

class AutoMultiSourceTradeIntentCreateRequestBuilder
    implements
        Builder<AutoMultiSourceTradeIntentCreateRequest,
            AutoMultiSourceTradeIntentCreateRequestBuilder> {
  _$AutoMultiSourceTradeIntentCreateRequest? _$v;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  AutoMultiSourceTradeIntentCreateRequestFundingModeEnum? _fundingMode;
  AutoMultiSourceTradeIntentCreateRequestFundingModeEnum? get fundingMode =>
      _$this._fundingMode;
  set fundingMode(
          AutoMultiSourceTradeIntentCreateRequestFundingModeEnum?
              fundingMode) =>
      _$this._fundingMode = fundingMode;

  TradeIntentExecutionPolicyBuilder? _executionPolicy;
  TradeIntentExecutionPolicyBuilder get executionPolicy =>
      _$this._executionPolicy ??= TradeIntentExecutionPolicyBuilder();
  set executionPolicy(TradeIntentExecutionPolicyBuilder? executionPolicy) =>
      _$this._executionPolicy = executionPolicy;

  AutoMultiSourceTradeIntentCreateRequestBuilder() {
    AutoMultiSourceTradeIntentCreateRequest._defaults(this);
  }

  AutoMultiSourceTradeIntentCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _previewId = $v.previewId;
      _authorizationId = $v.authorizationId;
      _fundingMode = $v.fundingMode;
      _executionPolicy = $v.executionPolicy.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutoMultiSourceTradeIntentCreateRequest other) {
    _$v = other as _$AutoMultiSourceTradeIntentCreateRequest;
  }

  @override
  void update(
      void Function(AutoMultiSourceTradeIntentCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AutoMultiSourceTradeIntentCreateRequest build() => _build();

  _$AutoMultiSourceTradeIntentCreateRequest _build() {
    _$AutoMultiSourceTradeIntentCreateRequest _$result;
    try {
      _$result = _$v ??
          _$AutoMultiSourceTradeIntentCreateRequest._(
            previewId: BuiltValueNullFieldError.checkNotNull(previewId,
                r'AutoMultiSourceTradeIntentCreateRequest', 'previewId'),
            authorizationId: BuiltValueNullFieldError.checkNotNull(
                authorizationId,
                r'AutoMultiSourceTradeIntentCreateRequest',
                'authorizationId'),
            fundingMode: BuiltValueNullFieldError.checkNotNull(fundingMode,
                r'AutoMultiSourceTradeIntentCreateRequest', 'fundingMode'),
            executionPolicy: executionPolicy.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'executionPolicy';
        executionPolicy.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AutoMultiSourceTradeIntentCreateRequest',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
