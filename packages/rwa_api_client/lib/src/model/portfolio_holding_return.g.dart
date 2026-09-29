// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_holding_return.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioHoldingReturn extends PortfolioHoldingReturn {
  @override
  final String? amountUsd;
  @override
  final String? percent;

  factory _$PortfolioHoldingReturn(
          [void Function(PortfolioHoldingReturnBuilder)? updates]) =>
      (PortfolioHoldingReturnBuilder()..update(updates))._build();

  _$PortfolioHoldingReturn._({this.amountUsd, this.percent}) : super._();
  @override
  PortfolioHoldingReturn rebuild(
          void Function(PortfolioHoldingReturnBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioHoldingReturnBuilder toBuilder() =>
      PortfolioHoldingReturnBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioHoldingReturn &&
        amountUsd == other.amountUsd &&
        percent == other.percent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, amountUsd.hashCode);
    _$hash = $jc(_$hash, percent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioHoldingReturn')
          ..add('amountUsd', amountUsd)
          ..add('percent', percent))
        .toString();
  }
}

class PortfolioHoldingReturnBuilder
    implements Builder<PortfolioHoldingReturn, PortfolioHoldingReturnBuilder> {
  _$PortfolioHoldingReturn? _$v;

  String? _amountUsd;
  String? get amountUsd => _$this._amountUsd;
  set amountUsd(String? amountUsd) => _$this._amountUsd = amountUsd;

  String? _percent;
  String? get percent => _$this._percent;
  set percent(String? percent) => _$this._percent = percent;

  PortfolioHoldingReturnBuilder() {
    PortfolioHoldingReturn._defaults(this);
  }

  PortfolioHoldingReturnBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amountUsd = $v.amountUsd;
      _percent = $v.percent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioHoldingReturn other) {
    _$v = other as _$PortfolioHoldingReturn;
  }

  @override
  void update(void Function(PortfolioHoldingReturnBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioHoldingReturn build() => _build();

  _$PortfolioHoldingReturn _build() {
    final _$result = _$v ??
        _$PortfolioHoldingReturn._(
          amountUsd: amountUsd,
          percent: percent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
