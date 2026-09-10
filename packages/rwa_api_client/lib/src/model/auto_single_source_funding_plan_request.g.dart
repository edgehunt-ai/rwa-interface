// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_single_source_funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AutoSingleSourceFundingPlanRequestModeEnum
    _$autoSingleSourceFundingPlanRequestModeEnum_autoSingleSource =
    const AutoSingleSourceFundingPlanRequestModeEnum._('autoSingleSource');
const AutoSingleSourceFundingPlanRequestModeEnum
    _$autoSingleSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi =
    const AutoSingleSourceFundingPlanRequestModeEnum._('unknownDefaultOpenApi');

AutoSingleSourceFundingPlanRequestModeEnum
    _$autoSingleSourceFundingPlanRequestModeEnumValueOf(String name) {
  switch (name) {
    case 'autoSingleSource':
      return _$autoSingleSourceFundingPlanRequestModeEnum_autoSingleSource;
    case 'unknownDefaultOpenApi':
      return _$autoSingleSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi;
    default:
      return _$autoSingleSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AutoSingleSourceFundingPlanRequestModeEnum>
    _$autoSingleSourceFundingPlanRequestModeEnumValues = BuiltSet<
        AutoSingleSourceFundingPlanRequestModeEnum>(const <AutoSingleSourceFundingPlanRequestModeEnum>[
  _$autoSingleSourceFundingPlanRequestModeEnum_autoSingleSource,
  _$autoSingleSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi,
]);

Serializer<AutoSingleSourceFundingPlanRequestModeEnum>
    _$autoSingleSourceFundingPlanRequestModeEnumSerializer =
    _$AutoSingleSourceFundingPlanRequestModeEnumSerializer();

class _$AutoSingleSourceFundingPlanRequestModeEnumSerializer
    implements PrimitiveSerializer<AutoSingleSourceFundingPlanRequestModeEnum> {
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
    AutoSingleSourceFundingPlanRequestModeEnum
  ];
  @override
  final String wireName = 'AutoSingleSourceFundingPlanRequestModeEnum';

  @override
  Object serialize(Serializers serializers,
          AutoSingleSourceFundingPlanRequestModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AutoSingleSourceFundingPlanRequestModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AutoSingleSourceFundingPlanRequestModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AutoSingleSourceFundingPlanRequest
    extends AutoSingleSourceFundingPlanRequest {
  @override
  final String tradePreviewId;
  @override
  final AutoSingleSourceFundingPlanRequestModeEnum mode;
  @override
  final FundingSourceAssetId? sourceAssetId;

  factory _$AutoSingleSourceFundingPlanRequest(
          [void Function(AutoSingleSourceFundingPlanRequestBuilder)?
              updates]) =>
      (AutoSingleSourceFundingPlanRequestBuilder()..update(updates))._build();

  _$AutoSingleSourceFundingPlanRequest._(
      {required this.tradePreviewId, required this.mode, this.sourceAssetId})
      : super._();
  @override
  AutoSingleSourceFundingPlanRequest rebuild(
          void Function(AutoSingleSourceFundingPlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutoSingleSourceFundingPlanRequestBuilder toBuilder() =>
      AutoSingleSourceFundingPlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutoSingleSourceFundingPlanRequest &&
        tradePreviewId == other.tradePreviewId &&
        mode == other.mode &&
        sourceAssetId == other.sourceAssetId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tradePreviewId.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, sourceAssetId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AutoSingleSourceFundingPlanRequest')
          ..add('tradePreviewId', tradePreviewId)
          ..add('mode', mode)
          ..add('sourceAssetId', sourceAssetId))
        .toString();
  }
}

class AutoSingleSourceFundingPlanRequestBuilder
    implements
        Builder<AutoSingleSourceFundingPlanRequest,
            AutoSingleSourceFundingPlanRequestBuilder> {
  _$AutoSingleSourceFundingPlanRequest? _$v;

  String? _tradePreviewId;
  String? get tradePreviewId => _$this._tradePreviewId;
  set tradePreviewId(String? tradePreviewId) =>
      _$this._tradePreviewId = tradePreviewId;

  AutoSingleSourceFundingPlanRequestModeEnum? _mode;
  AutoSingleSourceFundingPlanRequestModeEnum? get mode => _$this._mode;
  set mode(AutoSingleSourceFundingPlanRequestModeEnum? mode) =>
      _$this._mode = mode;

  FundingSourceAssetId? _sourceAssetId;
  FundingSourceAssetId? get sourceAssetId => _$this._sourceAssetId;
  set sourceAssetId(FundingSourceAssetId? sourceAssetId) =>
      _$this._sourceAssetId = sourceAssetId;

  AutoSingleSourceFundingPlanRequestBuilder() {
    AutoSingleSourceFundingPlanRequest._defaults(this);
  }

  AutoSingleSourceFundingPlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tradePreviewId = $v.tradePreviewId;
      _mode = $v.mode;
      _sourceAssetId = $v.sourceAssetId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutoSingleSourceFundingPlanRequest other) {
    _$v = other as _$AutoSingleSourceFundingPlanRequest;
  }

  @override
  void update(
      void Function(AutoSingleSourceFundingPlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AutoSingleSourceFundingPlanRequest build() => _build();

  _$AutoSingleSourceFundingPlanRequest _build() {
    final _$result = _$v ??
        _$AutoSingleSourceFundingPlanRequest._(
          tradePreviewId: BuiltValueNullFieldError.checkNotNull(tradePreviewId,
              r'AutoSingleSourceFundingPlanRequest', 'tradePreviewId'),
          mode: BuiltValueNullFieldError.checkNotNull(
              mode, r'AutoSingleSourceFundingPlanRequest', 'mode'),
          sourceAssetId: sourceAssetId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
