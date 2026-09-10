// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionPlanRequest extends FundingSessionPlanRequest {
  @override
  final String fundingSessionId;
  @override
  final int selectionVersion;

  factory _$FundingSessionPlanRequest(
          [void Function(FundingSessionPlanRequestBuilder)? updates]) =>
      (FundingSessionPlanRequestBuilder()..update(updates))._build();

  _$FundingSessionPlanRequest._(
      {required this.fundingSessionId, required this.selectionVersion})
      : super._();
  @override
  FundingSessionPlanRequest rebuild(
          void Function(FundingSessionPlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionPlanRequestBuilder toBuilder() =>
      FundingSessionPlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionPlanRequest &&
        fundingSessionId == other.fundingSessionId &&
        selectionVersion == other.selectionVersion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, selectionVersion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionPlanRequest')
          ..add('fundingSessionId', fundingSessionId)
          ..add('selectionVersion', selectionVersion))
        .toString();
  }
}

class FundingSessionPlanRequestBuilder
    implements
        Builder<FundingSessionPlanRequest, FundingSessionPlanRequestBuilder> {
  _$FundingSessionPlanRequest? _$v;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  int? _selectionVersion;
  int? get selectionVersion => _$this._selectionVersion;
  set selectionVersion(int? selectionVersion) =>
      _$this._selectionVersion = selectionVersion;

  FundingSessionPlanRequestBuilder() {
    FundingSessionPlanRequest._defaults(this);
  }

  FundingSessionPlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fundingSessionId = $v.fundingSessionId;
      _selectionVersion = $v.selectionVersion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionPlanRequest other) {
    _$v = other as _$FundingSessionPlanRequest;
  }

  @override
  void update(void Function(FundingSessionPlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionPlanRequest build() => _build();

  _$FundingSessionPlanRequest _build() {
    final _$result = _$v ??
        _$FundingSessionPlanRequest._(
          fundingSessionId: BuiltValueNullFieldError.checkNotNull(
              fundingSessionId,
              r'FundingSessionPlanRequest',
              'fundingSessionId'),
          selectionVersion: BuiltValueNullFieldError.checkNotNull(
              selectionVersion,
              r'FundingSessionPlanRequest',
              'selectionVersion'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
