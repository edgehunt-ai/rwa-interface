// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_route_capability_matrix.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingRouteCapabilityMatrix extends FundingRouteCapabilityMatrix {
  @override
  final FundingRouteCapability bstockAcross;
  @override
  final FundingRouteCapability bstockRelay;
  @override
  final FundingRouteCapability perpAcross;
  @override
  final FundingRouteCapability perpRelay;

  factory _$FundingRouteCapabilityMatrix(
          [void Function(FundingRouteCapabilityMatrixBuilder)? updates]) =>
      (FundingRouteCapabilityMatrixBuilder()..update(updates))._build();

  _$FundingRouteCapabilityMatrix._(
      {required this.bstockAcross,
      required this.bstockRelay,
      required this.perpAcross,
      required this.perpRelay})
      : super._();
  @override
  FundingRouteCapabilityMatrix rebuild(
          void Function(FundingRouteCapabilityMatrixBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRouteCapabilityMatrixBuilder toBuilder() =>
      FundingRouteCapabilityMatrixBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRouteCapabilityMatrix &&
        bstockAcross == other.bstockAcross &&
        bstockRelay == other.bstockRelay &&
        perpAcross == other.perpAcross &&
        perpRelay == other.perpRelay;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bstockAcross.hashCode);
    _$hash = $jc(_$hash, bstockRelay.hashCode);
    _$hash = $jc(_$hash, perpAcross.hashCode);
    _$hash = $jc(_$hash, perpRelay.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRouteCapabilityMatrix')
          ..add('bstockAcross', bstockAcross)
          ..add('bstockRelay', bstockRelay)
          ..add('perpAcross', perpAcross)
          ..add('perpRelay', perpRelay))
        .toString();
  }
}

class FundingRouteCapabilityMatrixBuilder
    implements
        Builder<FundingRouteCapabilityMatrix,
            FundingRouteCapabilityMatrixBuilder> {
  _$FundingRouteCapabilityMatrix? _$v;

  FundingRouteCapabilityBuilder? _bstockAcross;
  FundingRouteCapabilityBuilder get bstockAcross =>
      _$this._bstockAcross ??= FundingRouteCapabilityBuilder();
  set bstockAcross(FundingRouteCapabilityBuilder? bstockAcross) =>
      _$this._bstockAcross = bstockAcross;

  FundingRouteCapabilityBuilder? _bstockRelay;
  FundingRouteCapabilityBuilder get bstockRelay =>
      _$this._bstockRelay ??= FundingRouteCapabilityBuilder();
  set bstockRelay(FundingRouteCapabilityBuilder? bstockRelay) =>
      _$this._bstockRelay = bstockRelay;

  FundingRouteCapabilityBuilder? _perpAcross;
  FundingRouteCapabilityBuilder get perpAcross =>
      _$this._perpAcross ??= FundingRouteCapabilityBuilder();
  set perpAcross(FundingRouteCapabilityBuilder? perpAcross) =>
      _$this._perpAcross = perpAcross;

  FundingRouteCapabilityBuilder? _perpRelay;
  FundingRouteCapabilityBuilder get perpRelay =>
      _$this._perpRelay ??= FundingRouteCapabilityBuilder();
  set perpRelay(FundingRouteCapabilityBuilder? perpRelay) =>
      _$this._perpRelay = perpRelay;

  FundingRouteCapabilityMatrixBuilder() {
    FundingRouteCapabilityMatrix._defaults(this);
  }

  FundingRouteCapabilityMatrixBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bstockAcross = $v.bstockAcross.toBuilder();
      _bstockRelay = $v.bstockRelay.toBuilder();
      _perpAcross = $v.perpAcross.toBuilder();
      _perpRelay = $v.perpRelay.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRouteCapabilityMatrix other) {
    _$v = other as _$FundingRouteCapabilityMatrix;
  }

  @override
  void update(void Function(FundingRouteCapabilityMatrixBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRouteCapabilityMatrix build() => _build();

  _$FundingRouteCapabilityMatrix _build() {
    _$FundingRouteCapabilityMatrix _$result;
    try {
      _$result = _$v ??
          _$FundingRouteCapabilityMatrix._(
            bstockAcross: bstockAcross.build(),
            bstockRelay: bstockRelay.build(),
            perpAcross: perpAcross.build(),
            perpRelay: perpRelay.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bstockAcross';
        bstockAcross.build();
        _$failedField = 'bstockRelay';
        bstockRelay.build();
        _$failedField = 'perpAcross';
        perpAcross.build();
        _$failedField = 'perpRelay';
        perpRelay.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingRouteCapabilityMatrix', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
