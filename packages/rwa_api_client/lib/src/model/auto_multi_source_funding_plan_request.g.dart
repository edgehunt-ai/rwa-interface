// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_multi_source_funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AutoMultiSourceFundingPlanRequestModeEnum
    _$autoMultiSourceFundingPlanRequestModeEnum_autoMultiSource =
    const AutoMultiSourceFundingPlanRequestModeEnum._('autoMultiSource');
const AutoMultiSourceFundingPlanRequestModeEnum
    _$autoMultiSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi =
    const AutoMultiSourceFundingPlanRequestModeEnum._('unknownDefaultOpenApi');

AutoMultiSourceFundingPlanRequestModeEnum
    _$autoMultiSourceFundingPlanRequestModeEnumValueOf(String name) {
  switch (name) {
    case 'autoMultiSource':
      return _$autoMultiSourceFundingPlanRequestModeEnum_autoMultiSource;
    case 'unknownDefaultOpenApi':
      return _$autoMultiSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi;
    default:
      return _$autoMultiSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<AutoMultiSourceFundingPlanRequestModeEnum>
    _$autoMultiSourceFundingPlanRequestModeEnumValues = BuiltSet<
        AutoMultiSourceFundingPlanRequestModeEnum>(const <AutoMultiSourceFundingPlanRequestModeEnum>[
  _$autoMultiSourceFundingPlanRequestModeEnum_autoMultiSource,
  _$autoMultiSourceFundingPlanRequestModeEnum_unknownDefaultOpenApi,
]);

Serializer<AutoMultiSourceFundingPlanRequestModeEnum>
    _$autoMultiSourceFundingPlanRequestModeEnumSerializer =
    _$AutoMultiSourceFundingPlanRequestModeEnumSerializer();

class _$AutoMultiSourceFundingPlanRequestModeEnumSerializer
    implements PrimitiveSerializer<AutoMultiSourceFundingPlanRequestModeEnum> {
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
    AutoMultiSourceFundingPlanRequestModeEnum
  ];
  @override
  final String wireName = 'AutoMultiSourceFundingPlanRequestModeEnum';

  @override
  Object serialize(Serializers serializers,
          AutoMultiSourceFundingPlanRequestModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AutoMultiSourceFundingPlanRequestModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AutoMultiSourceFundingPlanRequestModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AutoMultiSourceFundingPlanRequest
    extends AutoMultiSourceFundingPlanRequest {
  @override
  final String tradePreviewId;
  @override
  final AutoMultiSourceFundingPlanRequestModeEnum mode;
  @override
  final BuiltSet<String>? excludedSourcePositionIds;

  factory _$AutoMultiSourceFundingPlanRequest(
          [void Function(AutoMultiSourceFundingPlanRequestBuilder)? updates]) =>
      (AutoMultiSourceFundingPlanRequestBuilder()..update(updates))._build();

  _$AutoMultiSourceFundingPlanRequest._(
      {required this.tradePreviewId,
      required this.mode,
      this.excludedSourcePositionIds})
      : super._();
  @override
  AutoMultiSourceFundingPlanRequest rebuild(
          void Function(AutoMultiSourceFundingPlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AutoMultiSourceFundingPlanRequestBuilder toBuilder() =>
      AutoMultiSourceFundingPlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AutoMultiSourceFundingPlanRequest &&
        tradePreviewId == other.tradePreviewId &&
        mode == other.mode &&
        excludedSourcePositionIds == other.excludedSourcePositionIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tradePreviewId.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, excludedSourcePositionIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AutoMultiSourceFundingPlanRequest')
          ..add('tradePreviewId', tradePreviewId)
          ..add('mode', mode)
          ..add('excludedSourcePositionIds', excludedSourcePositionIds))
        .toString();
  }
}

class AutoMultiSourceFundingPlanRequestBuilder
    implements
        Builder<AutoMultiSourceFundingPlanRequest,
            AutoMultiSourceFundingPlanRequestBuilder> {
  _$AutoMultiSourceFundingPlanRequest? _$v;

  String? _tradePreviewId;
  String? get tradePreviewId => _$this._tradePreviewId;
  set tradePreviewId(String? tradePreviewId) =>
      _$this._tradePreviewId = tradePreviewId;

  AutoMultiSourceFundingPlanRequestModeEnum? _mode;
  AutoMultiSourceFundingPlanRequestModeEnum? get mode => _$this._mode;
  set mode(AutoMultiSourceFundingPlanRequestModeEnum? mode) =>
      _$this._mode = mode;

  SetBuilder<String>? _excludedSourcePositionIds;
  SetBuilder<String> get excludedSourcePositionIds =>
      _$this._excludedSourcePositionIds ??= SetBuilder<String>();
  set excludedSourcePositionIds(
          SetBuilder<String>? excludedSourcePositionIds) =>
      _$this._excludedSourcePositionIds = excludedSourcePositionIds;

  AutoMultiSourceFundingPlanRequestBuilder() {
    AutoMultiSourceFundingPlanRequest._defaults(this);
  }

  AutoMultiSourceFundingPlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tradePreviewId = $v.tradePreviewId;
      _mode = $v.mode;
      _excludedSourcePositionIds = $v.excludedSourcePositionIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AutoMultiSourceFundingPlanRequest other) {
    _$v = other as _$AutoMultiSourceFundingPlanRequest;
  }

  @override
  void update(
      void Function(AutoMultiSourceFundingPlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AutoMultiSourceFundingPlanRequest build() => _build();

  _$AutoMultiSourceFundingPlanRequest _build() {
    _$AutoMultiSourceFundingPlanRequest _$result;
    try {
      _$result = _$v ??
          _$AutoMultiSourceFundingPlanRequest._(
            tradePreviewId: BuiltValueNullFieldError.checkNotNull(
                tradePreviewId,
                r'AutoMultiSourceFundingPlanRequest',
                'tradePreviewId'),
            mode: BuiltValueNullFieldError.checkNotNull(
                mode, r'AutoMultiSourceFundingPlanRequest', 'mode'),
            excludedSourcePositionIds: _excludedSourcePositionIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'excludedSourcePositionIds';
        _excludedSourcePositionIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AutoMultiSourceFundingPlanRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
