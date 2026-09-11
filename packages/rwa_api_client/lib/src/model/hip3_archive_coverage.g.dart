// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_archive_coverage.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3ArchiveCoverage extends Hip3ArchiveCoverage {
  @override
  final BuiltList<Hip3HistoryRange> coveredRanges;
  @override
  final BuiltList<Hip3HistoryRange> missingRanges;

  factory _$Hip3ArchiveCoverage(
          [void Function(Hip3ArchiveCoverageBuilder)? updates]) =>
      (Hip3ArchiveCoverageBuilder()..update(updates))._build();

  _$Hip3ArchiveCoverage._(
      {required this.coveredRanges, required this.missingRanges})
      : super._();
  @override
  Hip3ArchiveCoverage rebuild(
          void Function(Hip3ArchiveCoverageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3ArchiveCoverageBuilder toBuilder() =>
      Hip3ArchiveCoverageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3ArchiveCoverage &&
        coveredRanges == other.coveredRanges &&
        missingRanges == other.missingRanges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, coveredRanges.hashCode);
    _$hash = $jc(_$hash, missingRanges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3ArchiveCoverage')
          ..add('coveredRanges', coveredRanges)
          ..add('missingRanges', missingRanges))
        .toString();
  }
}

class Hip3ArchiveCoverageBuilder
    implements Builder<Hip3ArchiveCoverage, Hip3ArchiveCoverageBuilder> {
  _$Hip3ArchiveCoverage? _$v;

  ListBuilder<Hip3HistoryRange>? _coveredRanges;
  ListBuilder<Hip3HistoryRange> get coveredRanges =>
      _$this._coveredRanges ??= ListBuilder<Hip3HistoryRange>();
  set coveredRanges(ListBuilder<Hip3HistoryRange>? coveredRanges) =>
      _$this._coveredRanges = coveredRanges;

  ListBuilder<Hip3HistoryRange>? _missingRanges;
  ListBuilder<Hip3HistoryRange> get missingRanges =>
      _$this._missingRanges ??= ListBuilder<Hip3HistoryRange>();
  set missingRanges(ListBuilder<Hip3HistoryRange>? missingRanges) =>
      _$this._missingRanges = missingRanges;

  Hip3ArchiveCoverageBuilder() {
    Hip3ArchiveCoverage._defaults(this);
  }

  Hip3ArchiveCoverageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _coveredRanges = $v.coveredRanges.toBuilder();
      _missingRanges = $v.missingRanges.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3ArchiveCoverage other) {
    _$v = other as _$Hip3ArchiveCoverage;
  }

  @override
  void update(void Function(Hip3ArchiveCoverageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3ArchiveCoverage build() => _build();

  _$Hip3ArchiveCoverage _build() {
    _$Hip3ArchiveCoverage _$result;
    try {
      _$result = _$v ??
          _$Hip3ArchiveCoverage._(
            coveredRanges: coveredRanges.build(),
            missingRanges: missingRanges.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coveredRanges';
        coveredRanges.build();
        _$failedField = 'missingRanges';
        missingRanges.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3ArchiveCoverage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
