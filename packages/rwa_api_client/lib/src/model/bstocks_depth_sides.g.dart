// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_depth_sides.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BstocksDepthSides extends BstocksDepthSides {
  @override
  final BstocksDepthSideState bids;
  @override
  final BstocksDepthSideState asks;

  factory _$BstocksDepthSides(
          [void Function(BstocksDepthSidesBuilder)? updates]) =>
      (BstocksDepthSidesBuilder()..update(updates))._build();

  _$BstocksDepthSides._({required this.bids, required this.asks}) : super._();
  @override
  BstocksDepthSides rebuild(void Function(BstocksDepthSidesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BstocksDepthSidesBuilder toBuilder() =>
      BstocksDepthSidesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BstocksDepthSides &&
        bids == other.bids &&
        asks == other.asks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, bids.hashCode);
    _$hash = $jc(_$hash, asks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BstocksDepthSides')
          ..add('bids', bids)
          ..add('asks', asks))
        .toString();
  }
}

class BstocksDepthSidesBuilder
    implements Builder<BstocksDepthSides, BstocksDepthSidesBuilder> {
  _$BstocksDepthSides? _$v;

  BstocksDepthSideStateBuilder? _bids;
  BstocksDepthSideStateBuilder get bids =>
      _$this._bids ??= BstocksDepthSideStateBuilder();
  set bids(BstocksDepthSideStateBuilder? bids) => _$this._bids = bids;

  BstocksDepthSideStateBuilder? _asks;
  BstocksDepthSideStateBuilder get asks =>
      _$this._asks ??= BstocksDepthSideStateBuilder();
  set asks(BstocksDepthSideStateBuilder? asks) => _$this._asks = asks;

  BstocksDepthSidesBuilder() {
    BstocksDepthSides._defaults(this);
  }

  BstocksDepthSidesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _bids = $v.bids.toBuilder();
      _asks = $v.asks.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BstocksDepthSides other) {
    _$v = other as _$BstocksDepthSides;
  }

  @override
  void update(void Function(BstocksDepthSidesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BstocksDepthSides build() => _build();

  _$BstocksDepthSides _build() {
    _$BstocksDepthSides _$result;
    try {
      _$result = _$v ??
          _$BstocksDepthSides._(
            bids: bids.build(),
            asks: asks.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bids';
        bids.build();
        _$failedField = 'asks';
        asks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BstocksDepthSides', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
