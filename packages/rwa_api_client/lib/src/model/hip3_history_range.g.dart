// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_history_range.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3HistoryRange extends Hip3HistoryRange {
  @override
  final DateTime from;
  @override
  final DateTime to;

  factory _$Hip3HistoryRange(
          [void Function(Hip3HistoryRangeBuilder)? updates]) =>
      (Hip3HistoryRangeBuilder()..update(updates))._build();

  _$Hip3HistoryRange._({required this.from, required this.to}) : super._();
  @override
  Hip3HistoryRange rebuild(void Function(Hip3HistoryRangeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3HistoryRangeBuilder toBuilder() =>
      Hip3HistoryRangeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3HistoryRange && from == other.from && to == other.to;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3HistoryRange')
          ..add('from', from)
          ..add('to', to))
        .toString();
  }
}

class Hip3HistoryRangeBuilder
    implements Builder<Hip3HistoryRange, Hip3HistoryRangeBuilder> {
  _$Hip3HistoryRange? _$v;

  DateTime? _from;
  DateTime? get from => _$this._from;
  set from(DateTime? from) => _$this._from = from;

  DateTime? _to;
  DateTime? get to => _$this._to;
  set to(DateTime? to) => _$this._to = to;

  Hip3HistoryRangeBuilder() {
    Hip3HistoryRange._defaults(this);
  }

  Hip3HistoryRangeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _from = $v.from;
      _to = $v.to;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3HistoryRange other) {
    _$v = other as _$Hip3HistoryRange;
  }

  @override
  void update(void Function(Hip3HistoryRangeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3HistoryRange build() => _build();

  _$Hip3HistoryRange _build() {
    final _$result = _$v ??
        _$Hip3HistoryRange._(
          from: BuiltValueNullFieldError.checkNotNull(
              from, r'Hip3HistoryRange', 'from'),
          to: BuiltValueNullFieldError.checkNotNull(
              to, r'Hip3HistoryRange', 'to'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
