// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_obligation_amounts.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialObligationAmounts extends FinancialObligationAmounts {
  @override
  final FinancialAssetIdentity asset;
  @override
  final FinancialRawAmount reserved;
  @override
  final FinancialRawAmount sourceDebited;
  @override
  final FinancialRawAmount inTransit;
  @override
  final FinancialRawAmount credited;
  @override
  final FinancialRawAmount refundDue;
  @override
  final FinancialRawAmount refunded;
  @override
  final FinancialRawAmount actualFee;
  @override
  final FinancialRawAmount released;
  @override
  final FinancialRawAmount compensated;
  @override
  final FinancialRawAmount outstanding;

  factory _$FinancialObligationAmounts(
          [void Function(FinancialObligationAmountsBuilder)? updates]) =>
      (FinancialObligationAmountsBuilder()..update(updates))._build();

  _$FinancialObligationAmounts._(
      {required this.asset,
      required this.reserved,
      required this.sourceDebited,
      required this.inTransit,
      required this.credited,
      required this.refundDue,
      required this.refunded,
      required this.actualFee,
      required this.released,
      required this.compensated,
      required this.outstanding})
      : super._();
  @override
  FinancialObligationAmounts rebuild(
          void Function(FinancialObligationAmountsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialObligationAmountsBuilder toBuilder() =>
      FinancialObligationAmountsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialObligationAmounts &&
        asset == other.asset &&
        reserved == other.reserved &&
        sourceDebited == other.sourceDebited &&
        inTransit == other.inTransit &&
        credited == other.credited &&
        refundDue == other.refundDue &&
        refunded == other.refunded &&
        actualFee == other.actualFee &&
        released == other.released &&
        compensated == other.compensated &&
        outstanding == other.outstanding;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, reserved.hashCode);
    _$hash = $jc(_$hash, sourceDebited.hashCode);
    _$hash = $jc(_$hash, inTransit.hashCode);
    _$hash = $jc(_$hash, credited.hashCode);
    _$hash = $jc(_$hash, refundDue.hashCode);
    _$hash = $jc(_$hash, refunded.hashCode);
    _$hash = $jc(_$hash, actualFee.hashCode);
    _$hash = $jc(_$hash, released.hashCode);
    _$hash = $jc(_$hash, compensated.hashCode);
    _$hash = $jc(_$hash, outstanding.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialObligationAmounts')
          ..add('asset', asset)
          ..add('reserved', reserved)
          ..add('sourceDebited', sourceDebited)
          ..add('inTransit', inTransit)
          ..add('credited', credited)
          ..add('refundDue', refundDue)
          ..add('refunded', refunded)
          ..add('actualFee', actualFee)
          ..add('released', released)
          ..add('compensated', compensated)
          ..add('outstanding', outstanding))
        .toString();
  }
}

class FinancialObligationAmountsBuilder
    implements
        Builder<FinancialObligationAmounts, FinancialObligationAmountsBuilder> {
  _$FinancialObligationAmounts? _$v;

  FinancialAssetIdentityBuilder? _asset;
  FinancialAssetIdentityBuilder get asset =>
      _$this._asset ??= FinancialAssetIdentityBuilder();
  set asset(FinancialAssetIdentityBuilder? asset) => _$this._asset = asset;

  FinancialRawAmountBuilder? _reserved;
  FinancialRawAmountBuilder get reserved =>
      _$this._reserved ??= FinancialRawAmountBuilder();
  set reserved(FinancialRawAmountBuilder? reserved) =>
      _$this._reserved = reserved;

  FinancialRawAmountBuilder? _sourceDebited;
  FinancialRawAmountBuilder get sourceDebited =>
      _$this._sourceDebited ??= FinancialRawAmountBuilder();
  set sourceDebited(FinancialRawAmountBuilder? sourceDebited) =>
      _$this._sourceDebited = sourceDebited;

  FinancialRawAmountBuilder? _inTransit;
  FinancialRawAmountBuilder get inTransit =>
      _$this._inTransit ??= FinancialRawAmountBuilder();
  set inTransit(FinancialRawAmountBuilder? inTransit) =>
      _$this._inTransit = inTransit;

  FinancialRawAmountBuilder? _credited;
  FinancialRawAmountBuilder get credited =>
      _$this._credited ??= FinancialRawAmountBuilder();
  set credited(FinancialRawAmountBuilder? credited) =>
      _$this._credited = credited;

  FinancialRawAmountBuilder? _refundDue;
  FinancialRawAmountBuilder get refundDue =>
      _$this._refundDue ??= FinancialRawAmountBuilder();
  set refundDue(FinancialRawAmountBuilder? refundDue) =>
      _$this._refundDue = refundDue;

  FinancialRawAmountBuilder? _refunded;
  FinancialRawAmountBuilder get refunded =>
      _$this._refunded ??= FinancialRawAmountBuilder();
  set refunded(FinancialRawAmountBuilder? refunded) =>
      _$this._refunded = refunded;

  FinancialRawAmountBuilder? _actualFee;
  FinancialRawAmountBuilder get actualFee =>
      _$this._actualFee ??= FinancialRawAmountBuilder();
  set actualFee(FinancialRawAmountBuilder? actualFee) =>
      _$this._actualFee = actualFee;

  FinancialRawAmountBuilder? _released;
  FinancialRawAmountBuilder get released =>
      _$this._released ??= FinancialRawAmountBuilder();
  set released(FinancialRawAmountBuilder? released) =>
      _$this._released = released;

  FinancialRawAmountBuilder? _compensated;
  FinancialRawAmountBuilder get compensated =>
      _$this._compensated ??= FinancialRawAmountBuilder();
  set compensated(FinancialRawAmountBuilder? compensated) =>
      _$this._compensated = compensated;

  FinancialRawAmountBuilder? _outstanding;
  FinancialRawAmountBuilder get outstanding =>
      _$this._outstanding ??= FinancialRawAmountBuilder();
  set outstanding(FinancialRawAmountBuilder? outstanding) =>
      _$this._outstanding = outstanding;

  FinancialObligationAmountsBuilder() {
    FinancialObligationAmounts._defaults(this);
  }

  FinancialObligationAmountsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _asset = $v.asset.toBuilder();
      _reserved = $v.reserved.toBuilder();
      _sourceDebited = $v.sourceDebited.toBuilder();
      _inTransit = $v.inTransit.toBuilder();
      _credited = $v.credited.toBuilder();
      _refundDue = $v.refundDue.toBuilder();
      _refunded = $v.refunded.toBuilder();
      _actualFee = $v.actualFee.toBuilder();
      _released = $v.released.toBuilder();
      _compensated = $v.compensated.toBuilder();
      _outstanding = $v.outstanding.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialObligationAmounts other) {
    _$v = other as _$FinancialObligationAmounts;
  }

  @override
  void update(void Function(FinancialObligationAmountsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialObligationAmounts build() => _build();

  _$FinancialObligationAmounts _build() {
    _$FinancialObligationAmounts _$result;
    try {
      _$result = _$v ??
          _$FinancialObligationAmounts._(
            asset: asset.build(),
            reserved: reserved.build(),
            sourceDebited: sourceDebited.build(),
            inTransit: inTransit.build(),
            credited: credited.build(),
            refundDue: refundDue.build(),
            refunded: refunded.build(),
            actualFee: actualFee.build(),
            released: released.build(),
            compensated: compensated.build(),
            outstanding: outstanding.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
        _$failedField = 'reserved';
        reserved.build();
        _$failedField = 'sourceDebited';
        sourceDebited.build();
        _$failedField = 'inTransit';
        inTransit.build();
        _$failedField = 'credited';
        credited.build();
        _$failedField = 'refundDue';
        refundDue.build();
        _$failedField = 'refunded';
        refunded.build();
        _$failedField = 'actualFee';
        actualFee.build();
        _$failedField = 'released';
        released.build();
        _$failedField = 'compensated';
        compensated.build();
        _$failedField = 'outstanding';
        outstanding.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinancialObligationAmounts', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
