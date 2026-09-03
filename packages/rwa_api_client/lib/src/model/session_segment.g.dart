// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_segment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionSegment extends SessionSegment {
  @override
  final SessionKind session;
  @override
  final String? label;
  @override
  final DateTime start;
  @override
  final DateTime end;

  factory _$SessionSegment([void Function(SessionSegmentBuilder)? updates]) =>
      (SessionSegmentBuilder()..update(updates))._build();

  _$SessionSegment._(
      {required this.session,
      this.label,
      required this.start,
      required this.end})
      : super._();
  @override
  SessionSegment rebuild(void Function(SessionSegmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionSegmentBuilder toBuilder() => SessionSegmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionSegment &&
        session == other.session &&
        label == other.label &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, session.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionSegment')
          ..add('session', session)
          ..add('label', label)
          ..add('start', start)
          ..add('end', end))
        .toString();
  }
}

class SessionSegmentBuilder
    implements Builder<SessionSegment, SessionSegmentBuilder> {
  _$SessionSegment? _$v;

  SessionKind? _session;
  SessionKind? get session => _$this._session;
  set session(SessionKind? session) => _$this._session = session;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  DateTime? _start;
  DateTime? get start => _$this._start;
  set start(DateTime? start) => _$this._start = start;

  DateTime? _end;
  DateTime? get end => _$this._end;
  set end(DateTime? end) => _$this._end = end;

  SessionSegmentBuilder() {
    SessionSegment._defaults(this);
  }

  SessionSegmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _session = $v.session;
      _label = $v.label;
      _start = $v.start;
      _end = $v.end;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionSegment other) {
    _$v = other as _$SessionSegment;
  }

  @override
  void update(void Function(SessionSegmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionSegment build() => _build();

  _$SessionSegment _build() {
    final _$result = _$v ??
        _$SessionSegment._(
          session: BuiltValueNullFieldError.checkNotNull(
              session, r'SessionSegment', 'session'),
          label: label,
          start: BuiltValueNullFieldError.checkNotNull(
              start, r'SessionSegment', 'start'),
          end: BuiltValueNullFieldError.checkNotNull(
              end, r'SessionSegment', 'end'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
