// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_single_source_trade_intent_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum
    _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_autoSingleSource =
    const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum._(
        'autoSingleSource');
const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum
    _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi =
    const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum._(
        'unknownDefaultOpenApi');

AutoSingleSourceTradeIntentCreateRequestFundingModeEnum
    _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumValueOf(
        String name) {
  switch (name) {
    case 'autoSingleSource':
      return _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_autoSingleSource;
    case 'unknownDefaultOpenApi':
      return _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AutoSingleSourceTradeIntentCreateRequestFundingModeEnum>
    _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumValues = BuiltSet<
        AutoSingleSourceTradeIntentCreateRequestFundingModeEnum>(const <AutoSingleSourceTradeIntentCreateRequestFundingModeEnum>[
  _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_autoSingleSource,
  _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<AutoSingleSourceTradeIntentCreateRequestFundingModeEnum>
    _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumSerializer =
    _$AutoSingleSourceTradeIntentCreateRequestFundingModeEnumSerializer();

class _$AutoSingleSourceTradeIntentCreateRequestFundingModeEnumSerializer
    implements
        PrimitiveSerializer<
            AutoSingleSourceTradeIntentCreateRequestFundingModeEnum> {
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
    AutoSingleSourceTradeIntentCreateRequestFundingModeEnum
  ];
  @override
  final String wireName =
      'AutoSingleSourceTradeIntentCreateRequestFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          AutoSingleSourceTradeIntentCreateRequestFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AutoSingleSourceTradeIntentCreateRequestFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AutoSingleSourceTradeIntentCreateRequestFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AutoSingleSourceTradeIntentCreateRequest
    extends AutoSingleSourceTradeIntentCreateRequest {
  @override
  final String previewId;
  @override
  final String authorizationId;
  @override
  final AutoSingleSourceTradeIntentCreateRequestFundingModeEnum fundingMode;
  @override
  final FundingSourceAssetId? sourceAssetId;
  @override
  final TradeIntentExecutionPolicy executionPolicy;

  factory _$AutoSingleSourceTradeIntentCreateRequest(
          [void Function(AutoSingleSourceTradeIntentCreateRequestBuilder)?
              updates]) =>
      (AutoSingleSourceTradeIntentCreateRequestBuilder()..update(updates))
          ._build();

  _$AutoSingleSourceTradeIntentCreateRequest._(
      {required this.previewId,
      required this.authorizationId,
      required this.fundingMode,
      this.sourceAssetId,
      required this.executionPolicy})
      : super._();
  @override
  AutoSingleSourceTradeIntentCreateRequest rebuild(
          void Function(AutoSingleSourceTradeIntentCreateRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutoSingleSourceTradeIntentCreateRequestBuilder toBuilder() =>
      AutoSingleSourceTradeIntentCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutoSingleSourceTradeIntentCreateRequest &&
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
    return (newBuiltValueToStringHelper(
            r'AutoSingleSourceTradeIntentCreateRequest')
          ..add('previewId', previewId)
          ..add('authorizationId', authorizationId)
          ..add('fundingMode', fundingMode)
          ..add('sourceAssetId', sourceAssetId)
          ..add('executionPolicy', executionPolicy))
        .toString();
  }
}

class AutoSingleSourceTradeIntentCreateRequestBuilder
    implements
        Builder<AutoSingleSourceTradeIntentCreateRequest,
            AutoSingleSourceTradeIntentCreateRequestBuilder> {
  _$AutoSingleSourceTradeIntentCreateRequest? _$v;

  String? _previewId;
  String? get previewId => _$this._previewId;
  set previewId(String? previewId) => _$this._previewId = previewId;

  String? _authorizationId;
  String? get authorizationId => _$this._authorizationId;
  set authorizationId(String? authorizationId) =>
      _$this._authorizationId = authorizationId;

  AutoSingleSourceTradeIntentCreateRequestFundingModeEnum? _fundingMode;
  AutoSingleSourceTradeIntentCreateRequestFundingModeEnum? get fundingMode =>
      _$this._fundingMode;
  set fundingMode(
          AutoSingleSourceTradeIntentCreateRequestFundingModeEnum?
              fundingMode) =>
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

  AutoSingleSourceTradeIntentCreateRequestBuilder() {
    AutoSingleSourceTradeIntentCreateRequest._defaults(this);
  }

  AutoSingleSourceTradeIntentCreateRequestBuilder get _$this {
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
  void replace(AutoSingleSourceTradeIntentCreateRequest other) {
    _$v = other as _$AutoSingleSourceTradeIntentCreateRequest;
  }

  @override
  void update(
      void Function(AutoSingleSourceTradeIntentCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AutoSingleSourceTradeIntentCreateRequest build() => _build();

  _$AutoSingleSourceTradeIntentCreateRequest _build() {
    _$AutoSingleSourceTradeIntentCreateRequest _$result;
    try {
      _$result = _$v ??
          _$AutoSingleSourceTradeIntentCreateRequest._(
            previewId: BuiltValueNullFieldError.checkNotNull(previewId,
                r'AutoSingleSourceTradeIntentCreateRequest', 'previewId'),
            authorizationId: BuiltValueNullFieldError.checkNotNull(
                authorizationId,
                r'AutoSingleSourceTradeIntentCreateRequest',
                'authorizationId'),
            fundingMode: BuiltValueNullFieldError.checkNotNull(fundingMode,
                r'AutoSingleSourceTradeIntentCreateRequest', 'fundingMode'),
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
            r'AutoSingleSourceTradeIntentCreateRequest',
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
