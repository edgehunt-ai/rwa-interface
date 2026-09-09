// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_circuit_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingCircuitSnapshot extends FundingCircuitSnapshot {
  @override
  final FundingGlobalCircuit global;
  @override
  final FundingRailCircuit rail;

  factory _$FundingCircuitSnapshot(
          [void Function(FundingCircuitSnapshotBuilder)? updates]) =>
      (FundingCircuitSnapshotBuilder()..update(updates))._build();

  _$FundingCircuitSnapshot._({required this.global, required this.rail})
      : super._();
  @override
  FundingCircuitSnapshot rebuild(
          void Function(FundingCircuitSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingCircuitSnapshotBuilder toBuilder() =>
      FundingCircuitSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingCircuitSnapshot &&
        global == other.global &&
        rail == other.rail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, global.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingCircuitSnapshot')
          ..add('global', global)
          ..add('rail', rail))
        .toString();
  }
}

class FundingCircuitSnapshotBuilder
    implements Builder<FundingCircuitSnapshot, FundingCircuitSnapshotBuilder> {
  _$FundingCircuitSnapshot? _$v;

  FundingGlobalCircuitBuilder? _global;
  FundingGlobalCircuitBuilder get global =>
      _$this._global ??= FundingGlobalCircuitBuilder();
  set global(FundingGlobalCircuitBuilder? global) => _$this._global = global;

  FundingRailCircuitBuilder? _rail;
  FundingRailCircuitBuilder get rail =>
      _$this._rail ??= FundingRailCircuitBuilder();
  set rail(FundingRailCircuitBuilder? rail) => _$this._rail = rail;

  FundingCircuitSnapshotBuilder() {
    FundingCircuitSnapshot._defaults(this);
  }

  FundingCircuitSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _global = $v.global.toBuilder();
      _rail = $v.rail.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingCircuitSnapshot other) {
    _$v = other as _$FundingCircuitSnapshot;
  }

  @override
  void update(void Function(FundingCircuitSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingCircuitSnapshot build() => _build();

  _$FundingCircuitSnapshot _build() {
    _$FundingCircuitSnapshot _$result;
    try {
      _$result = _$v ??
          _$FundingCircuitSnapshot._(
            global: global.build(),
            rail: rail.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'global';
        global.build();
        _$failedField = 'rail';
        rail.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingCircuitSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
