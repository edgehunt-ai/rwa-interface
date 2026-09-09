// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_single_source_funding_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AutoSingleSourceFundingPlanRequest
    extends AutoSingleSourceFundingPlanRequest {
  @override
  final String tradePreviewId;
  @override
  final FundingPlanMode mode;
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

  FundingPlanMode? _mode;
  FundingPlanMode? get mode => _$this._mode;
  set mode(FundingPlanMode? mode) => _$this._mode = mode;

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
