// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_source_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionSourceAllocation extends FundingSessionSourceAllocation {
  @override
  final String sourcePositionId;
  @override
  final String inputAmount;
  @override
  final String estimatedTargetAmount;

  factory _$FundingSessionSourceAllocation(
          [void Function(FundingSessionSourceAllocationBuilder)? updates]) =>
      (FundingSessionSourceAllocationBuilder()..update(updates))._build();

  _$FundingSessionSourceAllocation._(
      {required this.sourcePositionId,
      required this.inputAmount,
      required this.estimatedTargetAmount})
      : super._();
  @override
  FundingSessionSourceAllocation rebuild(
          void Function(FundingSessionSourceAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionSourceAllocationBuilder toBuilder() =>
      FundingSessionSourceAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionSourceAllocation &&
        sourcePositionId == other.sourcePositionId &&
        inputAmount == other.inputAmount &&
        estimatedTargetAmount == other.estimatedTargetAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sourcePositionId.hashCode);
    _$hash = $jc(_$hash, inputAmount.hashCode);
    _$hash = $jc(_$hash, estimatedTargetAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionSourceAllocation')
          ..add('sourcePositionId', sourcePositionId)
          ..add('inputAmount', inputAmount)
          ..add('estimatedTargetAmount', estimatedTargetAmount))
        .toString();
  }
}

class FundingSessionSourceAllocationBuilder
    implements
        Builder<FundingSessionSourceAllocation,
            FundingSessionSourceAllocationBuilder> {
  _$FundingSessionSourceAllocation? _$v;

  String? _sourcePositionId;
  String? get sourcePositionId => _$this._sourcePositionId;
  set sourcePositionId(String? sourcePositionId) =>
      _$this._sourcePositionId = sourcePositionId;

  String? _inputAmount;
  String? get inputAmount => _$this._inputAmount;
  set inputAmount(String? inputAmount) => _$this._inputAmount = inputAmount;

  String? _estimatedTargetAmount;
  String? get estimatedTargetAmount => _$this._estimatedTargetAmount;
  set estimatedTargetAmount(String? estimatedTargetAmount) =>
      _$this._estimatedTargetAmount = estimatedTargetAmount;

  FundingSessionSourceAllocationBuilder() {
    FundingSessionSourceAllocation._defaults(this);
  }

  FundingSessionSourceAllocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sourcePositionId = $v.sourcePositionId;
      _inputAmount = $v.inputAmount;
      _estimatedTargetAmount = $v.estimatedTargetAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionSourceAllocation other) {
    _$v = other as _$FundingSessionSourceAllocation;
  }

  @override
  void update(void Function(FundingSessionSourceAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionSourceAllocation build() => _build();

  _$FundingSessionSourceAllocation _build() {
    final _$result = _$v ??
        _$FundingSessionSourceAllocation._(
          sourcePositionId: BuiltValueNullFieldError.checkNotNull(
              sourcePositionId,
              r'FundingSessionSourceAllocation',
              'sourcePositionId'),
          inputAmount: BuiltValueNullFieldError.checkNotNull(
              inputAmount, r'FundingSessionSourceAllocation', 'inputAmount'),
          estimatedTargetAmount: BuiltValueNullFieldError.checkNotNull(
              estimatedTargetAmount,
              r'FundingSessionSourceAllocation',
              'estimatedTargetAmount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
