// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_intent_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnum_autoSingleSource =
    const TradeIntentCreateRequestFundingModeEnum._('autoSingleSource');
const TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi =
    const TradeIntentCreateRequestFundingModeEnum._('unknownDefaultOpenApi');

TradeIntentCreateRequestFundingModeEnum
    _$tradeIntentCreateRequestFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'autoSingleSource':
      return _$tradeIntentCreateRequestFundingModeEnum_autoSingleSource;
    case 'unknownDefaultOpenApi':
      return _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<TradeIntentCreateRequestFundingModeEnum>
    _$tradeIntentCreateRequestFundingModeEnumValues = BuiltSet<
        TradeIntentCreateRequestFundingModeEnum>(const <TradeIntentCreateRequestFundingModeEnum>[
  _$tradeIntentCreateRequestFundingModeEnum_autoSingleSource,
  _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<TradeIntentCreateRequestFundingModeEnum>
    _$tradeIntentCreateRequestFundingModeEnumSerializer =
    _$TradeIntentCreateRequestFundingModeEnumSerializer();

class _$TradeIntentCreateRequestFundingModeEnumSerializer
    implements PrimitiveSerializer<TradeIntentCreateRequestFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'autoSingleSource': 'auto_single_source',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'auto_single_source': 'autoSingleSource',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TradeIntentCreateRequestFundingModeEnum
  ];
  @override
  final String wireName = 'TradeIntentCreateRequestFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          TradeIntentCreateRequestFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TradeIntentCreateRequestFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TradeIntentCreateRequestFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TradeIntentCreateRequest extends TradeIntentCreateRequest {
  @override
  final String previewId;
  @override
  final String authorizationId;
  @override
  final TradeIntentCreateRequestFundingModeEnum fundingMode;
  @override
  final FundingSourceAssetId? sourceAssetId;
  @override
  final TradeIntentExecutionPolicy executionPolicy;

  factory _$TradeIntentCreateRequest(
          [void Function(TradeIntentCreateRequestBuilder)? updates]) =>
      (TradeIntentCreateRequestBuilder()..update(updates))._build();

  _$TradeIntentCreateRequest._(
      {required this.previewId,
      required this.authorizationId,
      required this.fundingMode,
      this.sourceAssetId,
      required this.executionPolicy})
      : super._();
  @override
  TradeIntentCreateRequest rebuild(
          void Function(TradeIntentCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TradeIntentCreateRequestBuilder toBuilder() =>
      TradeIntentCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TradeIntentCreateRequest &&
        previewId == other.previewId &&
        authorizationId == other.authorizationId &&
        fundingMode == other.fundingMode &&
        sourceAssetId == other.sourceAssetId &&
        executionPolicy == other.executionPolicy;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, previewId.hashCode);
    _$hash = $jc(_$hash, authorizationId.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jc(_$hash, sourceAssetId.hashCode);
    _$hash = $jc(_$hash, executionPolicy.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TradeIntentCreateRequest')
          ..add('previewId', previewId)
          ..add('authorizationId', authorizationId)
          ..add('fundingMode', fundingMode)
          ..add('sourceAssetId', sourceAssetId)
          ..add('executionPolicy', executionPolicy))
        .toString();
  }
}

class TradeIntentCreateRequestBuilder
    implements
        Builder<TradeIntentCreateRequest, TradeIntentCreateRequestBuilder> {
  _$TradeIntentCreateRequest? _$v;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  TradeIntentCreateRequestFundingModeEnum? _fundingMode;
  TradeIntentCreateRequestFundingModeEnum? get fundingMode =>
      _$this._fundingMode;
  set fundingMode(TradeIntentCreateRequestFundingModeEnum? fundingMode) =>
      _$this._fundingMode = fundingMode;

  FundingSourceAssetId? _sourceAssetId;
  FundingSourceAssetId? get sourceAssetId => _$this._sourceAssetId;
  set sourceAssetId(FundingSourceAssetId? sourceAssetId) =>
      _$this._sourceAssetId = sourceAssetId;

  TradeIntentExecutionPolicyBuilder? _executionPolicy;
  TradeIntentExecutionPolicyBuilder get executionPolicy =>
      _$this._executionPolicy ??= TradeIntentExecutionPolicyBuilder();
  set executionPolicy(TradeIntentExecutionPolicyBuilder? executionPolicy) =>
      _$this._executionPolicy = executionPolicy;

  TradeIntentCreateRequestBuilder() {
    TradeIntentCreateRequest._defaults(this);
  }

  TradeIntentCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _previewId = $v.previewId;
      _authorizationId = $v.authorizationId;
      _fundingMode = $v.fundingMode;
      _sourceAssetId = $v.sourceAssetId;
      _executionPolicy = $v.executionPolicy.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TradeIntentCreateRequest other) {
    _$v = other as _$TradeIntentCreateRequest;
  }

  @override
  void update(void Function(TradeIntentCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TradeIntentCreateRequest build() => _build();

  _$TradeIntentCreateRequest _build() {
    _$TradeIntentCreateRequest _$result;
    try {
      _$result = _$v ??
          _$TradeIntentCreateRequest._(
            previewId: BuiltValueNullFieldError.checkNotNull(
                previewId, r'TradeIntentCreateRequest', 'previewId'),
            authorizationId: BuiltValueNullFieldError.checkNotNull(
                authorizationId,
                r'TradeIntentCreateRequest',
                'authorizationId'),
            fundingMode: BuiltValueNullFieldError.checkNotNull(
                fundingMode, r'TradeIntentCreateRequest', 'fundingMode'),
            sourceAssetId: sourceAssetId,
            executionPolicy: executionPolicy.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'executionPolicy';
        executionPolicy.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TradeIntentCreateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
