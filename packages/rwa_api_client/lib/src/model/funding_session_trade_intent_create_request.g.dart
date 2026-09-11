// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_trade_intent_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FundingSessionTradeIntentCreateRequestFundingModeEnum
    _$fundingSessionTradeIntentCreateRequestFundingModeEnum_fundingSession =
    const FundingSessionTradeIntentCreateRequestFundingModeEnum._(
        'fundingSession');
const FundingSessionTradeIntentCreateRequestFundingModeEnum
    _$fundingSessionTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi =
    const FundingSessionTradeIntentCreateRequestFundingModeEnum._(
        'unknownDefaultOpenApi');

FundingSessionTradeIntentCreateRequestFundingModeEnum
    _$fundingSessionTradeIntentCreateRequestFundingModeEnumValueOf(
        String name) {
  switch (name) {
    case 'fundingSession':
      return _$fundingSessionTradeIntentCreateRequestFundingModeEnum_fundingSession;
    case 'unknownDefaultOpenApi':
      return _$fundingSessionTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$fundingSessionTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<FundingSessionTradeIntentCreateRequestFundingModeEnum>
    _$fundingSessionTradeIntentCreateRequestFundingModeEnumValues = BuiltSet<
        FundingSessionTradeIntentCreateRequestFundingModeEnum>(const <FundingSessionTradeIntentCreateRequestFundingModeEnum>[
  _$fundingSessionTradeIntentCreateRequestFundingModeEnum_fundingSession,
  _$fundingSessionTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<FundingSessionTradeIntentCreateRequestFundingModeEnum>
    _$fundingSessionTradeIntentCreateRequestFundingModeEnumSerializer =
    _$FundingSessionTradeIntentCreateRequestFundingModeEnumSerializer();

class _$FundingSessionTradeIntentCreateRequestFundingModeEnumSerializer
    implements
        PrimitiveSerializer<
            FundingSessionTradeIntentCreateRequestFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'fundingSession': 'funding_session',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'funding_session': 'fundingSession',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FundingSessionTradeIntentCreateRequestFundingModeEnum
  ];
  @override
  final String wireName =
      'FundingSessionTradeIntentCreateRequestFundingModeEnum';

  @override
  Object serialize(Serializers serializers,
          FundingSessionTradeIntentCreateRequestFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FundingSessionTradeIntentCreateRequestFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FundingSessionTradeIntentCreateRequestFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FundingSessionTradeIntentCreateRequest
    extends FundingSessionTradeIntentCreateRequest {
  @override
  final String fundingSessionId;
  @override
  final int fundingSessionVersion;
  @override
  final TradeIntentExecutionPolicy executionPolicy;
  @override
  final FundingSessionTradeIntentCreateRequestFundingModeEnum fundingMode;

  factory _$FundingSessionTradeIntentCreateRequest(
          [void Function(FundingSessionTradeIntentCreateRequestBuilder)?
              updates]) =>
      (FundingSessionTradeIntentCreateRequestBuilder()..update(updates))
          ._build();

  _$FundingSessionTradeIntentCreateRequest._(
      {required this.fundingSessionId,
      required this.fundingSessionVersion,
      required this.executionPolicy,
      required this.fundingMode})
      : super._();
  @override
  FundingSessionTradeIntentCreateRequest rebuild(
          void Function(FundingSessionTradeIntentCreateRequestBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionTradeIntentCreateRequestBuilder toBuilder() =>
      FundingSessionTradeIntentCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionTradeIntentCreateRequest &&
        fundingSessionId == other.fundingSessionId &&
        fundingSessionVersion == other.fundingSessionVersion &&
        executionPolicy == other.executionPolicy &&
        fundingMode == other.fundingMode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, fundingSessionVersion.hashCode);
    _$hash = $jc(_$hash, executionPolicy.hashCode);
    _$hash = $jc(_$hash, fundingMode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FundingSessionTradeIntentCreateRequest')
          ..add('fundingSessionId', fundingSessionId)
          ..add('fundingSessionVersion', fundingSessionVersion)
          ..add('executionPolicy', executionPolicy)
          ..add('fundingMode', fundingMode))
        .toString();
  }
}

class FundingSessionTradeIntentCreateRequestBuilder
    implements
        Builder<FundingSessionTradeIntentCreateRequest,
            FundingSessionTradeIntentCreateRequestBuilder> {
  _$FundingSessionTradeIntentCreateRequest? _$v;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  int? _fundingSessionVersion;
  int? get fundingSessionVersion => _$this._fundingSessionVersion;
  set fundingSessionVersion(int? fundingSessionVersion) =>
      _$this._fundingSessionVersion = fundingSessionVersion;

  TradeIntentExecutionPolicyBuilder? _executionPolicy;
  TradeIntentExecutionPolicyBuilder get executionPolicy =>
      _$this._executionPolicy ??= TradeIntentExecutionPolicyBuilder();
  set executionPolicy(TradeIntentExecutionPolicyBuilder? executionPolicy) =>
      _$this._executionPolicy = executionPolicy;

  FundingSessionTradeIntentCreateRequestFundingModeEnum? _fundingMode;
  FundingSessionTradeIntentCreateRequestFundingModeEnum? get fundingMode =>
      _$this._fundingMode;
  set fundingMode(
          FundingSessionTradeIntentCreateRequestFundingModeEnum? fundingMode) =>
      _$this._fundingMode = fundingMode;

  FundingSessionTradeIntentCreateRequestBuilder() {
    FundingSessionTradeIntentCreateRequest._defaults(this);
  }

  FundingSessionTradeIntentCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fundingSessionId = $v.fundingSessionId;
      _fundingSessionVersion = $v.fundingSessionVersion;
      _executionPolicy = $v.executionPolicy.toBuilder();
      _fundingMode = $v.fundingMode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionTradeIntentCreateRequest other) {
    _$v = other as _$FundingSessionTradeIntentCreateRequest;
  }

  @override
  void update(
      void Function(FundingSessionTradeIntentCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionTradeIntentCreateRequest build() => _build();

  _$FundingSessionTradeIntentCreateRequest _build() {
    _$FundingSessionTradeIntentCreateRequest _$result;
    try {
      _$result = _$v ??
          _$FundingSessionTradeIntentCreateRequest._(
            fundingSessionId: BuiltValueNullFieldError.checkNotNull(
                fundingSessionId,
                r'FundingSessionTradeIntentCreateRequest',
                'fundingSessionId'),
            fundingSessionVersion: BuiltValueNullFieldError.checkNotNull(
                fundingSessionVersion,
                r'FundingSessionTradeIntentCreateRequest',
                'fundingSessionVersion'),
            executionPolicy: executionPolicy.build(),
            fundingMode: BuiltValueNullFieldError.checkNotNull(fundingMode,
                r'FundingSessionTradeIntentCreateRequest', 'fundingMode'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'executionPolicy';
        executionPolicy.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSessionTradeIntentCreateRequest',
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
