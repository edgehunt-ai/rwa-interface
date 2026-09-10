// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HoldingGroup extends HoldingGroup {
  @override
  final HoldingStock stock;
  @override
  final String totalValueUsd;
  @override
  final BuiltList<Position> positions;

  factory _$HoldingGroup([void Function(HoldingGroupBuilder)? updates]) =>
      (HoldingGroupBuilder()..update(updates))._build();

  _$HoldingGroup._(
      {required this.stock,
      required this.totalValueUsd,
      required this.positions})
      : super._();
  @override
  HoldingGroup rebuild(void Function(HoldingGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HoldingGroupBuilder toBuilder() => HoldingGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HoldingGroup &&
        stock == other.stock &&
        totalValueUsd == other.totalValueUsd &&
        positions == other.positions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, stock.hashCode);
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HoldingGroup')
          ..add('stock', stock)
          ..add('totalValueUsd', totalValueUsd)
          ..add('positions', positions))
        .toString();
  }
}

class HoldingGroupBuilder
    implements Builder<HoldingGroup, HoldingGroupBuilder> {
  _$HoldingGroup? _$v;

  HoldingStockBuilder? _stock;
  HoldingStockBuilder get stock => _$this._stock ??= HoldingStockBuilder();
  set stock(HoldingStockBuilder? stock) => _$this._stock = stock;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  ListBuilder<Position>? _positions;
  ListBuilder<Position> get positions =>
      _$this._positions ??= ListBuilder<Position>();
  set positions(ListBuilder<Position>? positions) =>
      _$this._positions = positions;

  HoldingGroupBuilder() {
    HoldingGroup._defaults(this);
  }

  HoldingGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stock = $v.stock.toBuilder();
      _totalValueUsd = $v.totalValueUsd;
      _positions = $v.positions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HoldingGroup other) {
    _$v = other as _$HoldingGroup;
  }

  @override
  void update(void Function(HoldingGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HoldingGroup build() => _build();

  _$HoldingGroup _build() {
    _$HoldingGroup _$result;
    try {
      _$result = _$v ??
          _$HoldingGroup._(
            stock: stock.build(),
            totalValueUsd: BuiltValueNullFieldError.checkNotNull(
                totalValueUsd, r'HoldingGroup', 'totalValueUsd'),
            positions: positions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'stock';
        stock.build();

        _$failedField = 'positions';
        positions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'HoldingGroup', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
