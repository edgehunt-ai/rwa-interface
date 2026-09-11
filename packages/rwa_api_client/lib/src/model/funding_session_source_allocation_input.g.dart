// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session_source_allocation_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSessionSourceAllocationInput
    extends FundingSessionSourceAllocationInput {
  @override
  final String sourcePositionId;
  @override
  final String inputAmount;

  factory _$FundingSessionSourceAllocationInput(
          [void Function(FundingSessionSourceAllocationInputBuilder)?
              updates]) =>
      (FundingSessionSourceAllocationInputBuilder()..update(updates))._build();

  _$FundingSessionSourceAllocationInput._(
      {required this.sourcePositionId, required this.inputAmount})
      : super._();
  @override
  FundingSessionSourceAllocationInput rebuild(
          void Function(FundingSessionSourceAllocationInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionSourceAllocationInputBuilder toBuilder() =>
      FundingSessionSourceAllocationInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSessionSourceAllocationInput &&
        sourcePositionId == other.sourcePositionId &&
        inputAmount == other.inputAmount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sourcePositionId.hashCode);
    _$hash = $jc(_$hash, inputAmount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSessionSourceAllocationInput')
          ..add('sourcePositionId', sourcePositionId)
          ..add('inputAmount', inputAmount))
        .toString();
  }
}

class FundingSessionSourceAllocationInputBuilder
    implements
        Builder<FundingSessionSourceAllocationInput,
            FundingSessionSourceAllocationInputBuilder> {
  _$FundingSessionSourceAllocationInput? _$v;

  String? _sourcePositionId;
  String? get sourcePositionId => _$this._sourcePositionId;
  set sourcePositionId(String? sourcePositionId) =>
      _$this._sourcePositionId = sourcePositionId;

  String? _inputAmount;
  String? get inputAmount => _$this._inputAmount;
  set inputAmount(String? inputAmount) => _$this._inputAmount = inputAmount;

  FundingSessionSourceAllocationInputBuilder() {
    FundingSessionSourceAllocationInput._defaults(this);
  }

  FundingSessionSourceAllocationInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sourcePositionId = $v.sourcePositionId;
      _inputAmount = $v.inputAmount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSessionSourceAllocationInput other) {
    _$v = other as _$FundingSessionSourceAllocationInput;
  }

  @override
  void update(
      void Function(FundingSessionSourceAllocationInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSessionSourceAllocationInput build() => _build();

  _$FundingSessionSourceAllocationInput _build() {
    final _$result = _$v ??
        _$FundingSessionSourceAllocationInput._(
          sourcePositionId: BuiltValueNullFieldError.checkNotNull(
              sourcePositionId,
              r'FundingSessionSourceAllocationInput',
              'sourcePositionId'),
          inputAmount: BuiltValueNullFieldError.checkNotNull(inputAmount,
              r'FundingSessionSourceAllocationInput', 'inputAmount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
