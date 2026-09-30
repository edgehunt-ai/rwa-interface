// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_allocation_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioAllocationValue extends PortfolioAllocationValue {
  @override
  final PortfolioAvailabilityStatus status;
  @override
  final String? valueUsd;
  @override
  final int unvaluedAssetCount;

  factory _$PortfolioAllocationValue(
          [void Function(PortfolioAllocationValueBuilder)? updates]) =>
      (PortfolioAllocationValueBuilder()..update(updates))._build();

  _$PortfolioAllocationValue._(
      {required this.status, this.valueUsd, required this.unvaluedAssetCount})
      : super._();
  @override
  PortfolioAllocationValue rebuild(
          void Function(PortfolioAllocationValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAllocationValueBuilder toBuilder() =>
      PortfolioAllocationValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAllocationValue &&
        status == other.status &&
        valueUsd == other.valueUsd &&
        unvaluedAssetCount == other.unvaluedAssetCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, unvaluedAssetCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAllocationValue')
          ..add('status', status)
          ..add('valueUsd', valueUsd)
          ..add('unvaluedAssetCount', unvaluedAssetCount))
        .toString();
  }
}

class PortfolioAllocationValueBuilder
    implements
        Builder<PortfolioAllocationValue, PortfolioAllocationValueBuilder> {
  _$PortfolioAllocationValue? _$v;

  PortfolioAvailabilityStatus? _status;
  PortfolioAvailabilityStatus? get status => _$this._status;
  set status(PortfolioAvailabilityStatus? status) => _$this._status = status;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  int? _unvaluedAssetCount;
  int? get unvaluedAssetCount => _$this._unvaluedAssetCount;
  set unvaluedAssetCount(int? unvaluedAssetCount) =>
      _$this._unvaluedAssetCount = unvaluedAssetCount;

  PortfolioAllocationValueBuilder() {
    PortfolioAllocationValue._defaults(this);
  }

  PortfolioAllocationValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _valueUsd = $v.valueUsd;
      _unvaluedAssetCount = $v.unvaluedAssetCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAllocationValue other) {
    _$v = other as _$PortfolioAllocationValue;
  }

  @override
  void update(void Function(PortfolioAllocationValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAllocationValue build() => _build();

  _$PortfolioAllocationValue _build() {
    final _$result = _$v ??
        _$PortfolioAllocationValue._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PortfolioAllocationValue', 'status'),
          valueUsd: valueUsd,
          unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
              unvaluedAssetCount,
              r'PortfolioAllocationValue',
              'unvaluedAssetCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
