// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_session_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MarketSessionInfo extends MarketSessionInfo {
  @override
  final String timezone;
  @override
  final SessionKind current;
  @override
  final String? currentLabel;
  @override
  final String? currentDescription;
  @override
  final SessionKind? nextSession;
  @override
  final DateTime? nextTransitionAt;
  @override
  final int? secondsUntilTransition;
  @override
  final bool? isHoliday;
  @override
  final String? holidayName;
  @override
  final BuiltList<SessionSegment>? segments;

  factory _$MarketSessionInfo(
          [void Function(MarketSessionInfoBuilder)? updates]) =>
      (MarketSessionInfoBuilder()..update(updates))._build();

  _$MarketSessionInfo._(
      {required this.timezone,
      required this.current,
      this.currentLabel,
      this.currentDescription,
      this.nextSession,
      this.nextTransitionAt,
      this.secondsUntilTransition,
      this.isHoliday,
      this.holidayName,
      this.segments})
      : super._();
  @override
  MarketSessionInfo rebuild(void Function(MarketSessionInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MarketSessionInfoBuilder toBuilder() =>
      MarketSessionInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MarketSessionInfo &&
        timezone == other.timezone &&
        current == other.current &&
        currentLabel == other.currentLabel &&
        currentDescription == other.currentDescription &&
        nextSession == other.nextSession &&
        nextTransitionAt == other.nextTransitionAt &&
        secondsUntilTransition == other.secondsUntilTransition &&
        isHoliday == other.isHoliday &&
        holidayName == other.holidayName &&
        segments == other.segments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, timezone.hashCode);
    _$hash = $jc(_$hash, current.hashCode);
    _$hash = $jc(_$hash, currentLabel.hashCode);
    _$hash = $jc(_$hash, currentDescription.hashCode);
    _$hash = $jc(_$hash, nextSession.hashCode);
    _$hash = $jc(_$hash, nextTransitionAt.hashCode);
    _$hash = $jc(_$hash, secondsUntilTransition.hashCode);
    _$hash = $jc(_$hash, isHoliday.hashCode);
    _$hash = $jc(_$hash, holidayName.hashCode);
    _$hash = $jc(_$hash, segments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MarketSessionInfo')
          ..add('timezone', timezone)
          ..add('current', current)
          ..add('currentLabel', currentLabel)
          ..add('currentDescription', currentDescription)
          ..add('nextSession', nextSession)
          ..add('nextTransitionAt', nextTransitionAt)
          ..add('secondsUntilTransition', secondsUntilTransition)
          ..add('isHoliday', isHoliday)
          ..add('holidayName', holidayName)
          ..add('segments', segments))
        .toString();
  }
}

class MarketSessionInfoBuilder
    implements Builder<MarketSessionInfo, MarketSessionInfoBuilder> {
  _$MarketSessionInfo? _$v;

  String? _timezone;
  String? get timezone => _$this._timezone;
  set timezone(String? timezone) => _$this._timezone = timezone;

  SessionKind? _current;
  SessionKind? get current => _$this._current;
  set current(SessionKind? current) => _$this._current = current;

  String? _currentLabel;
  String? get currentLabel => _$this._currentLabel;
  set currentLabel(String? currentLabel) => _$this._currentLabel = currentLabel;

  String? _currentDescription;
  String? get currentDescription => _$this._currentDescription;
  set currentDescription(String? currentDescription) =>
      _$this._currentDescription = currentDescription;

  SessionKind? _nextSession;
  SessionKind? get nextSession => _$this._nextSession;
  set nextSession(SessionKind? nextSession) =>
      _$this._nextSession = nextSession;

  DateTime? _nextTransitionAt;
  DateTime? get nextTransitionAt => _$this._nextTransitionAt;
  set nextTransitionAt(DateTime? nextTransitionAt) =>
      _$this._nextTransitionAt = nextTransitionAt;

  int? _secondsUntilTransition;
  int? get secondsUntilTransition => _$this._secondsUntilTransition;
  set secondsUntilTransition(int? secondsUntilTransition) =>
      _$this._secondsUntilTransition = secondsUntilTransition;

  bool? _isHoliday;
  bool? get isHoliday => _$this._isHoliday;
  set isHoliday(bool? isHoliday) => _$this._isHoliday = isHoliday;

  String? _holidayName;
  String? get holidayName => _$this._holidayName;
  set holidayName(String? holidayName) => _$this._holidayName = holidayName;

  ListBuilder<SessionSegment>? _segments;
  ListBuilder<SessionSegment> get segments =>
      _$this._segments ??= ListBuilder<SessionSegment>();
  set segments(ListBuilder<SessionSegment>? segments) =>
      _$this._segments = segments;

  MarketSessionInfoBuilder() {
    MarketSessionInfo._defaults(this);
  }

  MarketSessionInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timezone = $v.timezone;
      _current = $v.current;
      _currentLabel = $v.currentLabel;
      _currentDescription = $v.currentDescription;
      _nextSession = $v.nextSession;
      _nextTransitionAt = $v.nextTransitionAt;
      _secondsUntilTransition = $v.secondsUntilTransition;
      _isHoliday = $v.isHoliday;
      _holidayName = $v.holidayName;
      _segments = $v.segments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MarketSessionInfo other) {
    _$v = other as _$MarketSessionInfo;
  }

  @override
  void update(void Function(MarketSessionInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MarketSessionInfo build() => _build();

  _$MarketSessionInfo _build() {
    _$MarketSessionInfo _$result;
    try {
      _$result = _$v ??
          _$MarketSessionInfo._(
            timezone: BuiltValueNullFieldError.checkNotNull(
                timezone, r'MarketSessionInfo', 'timezone'),
            current: BuiltValueNullFieldError.checkNotNull(
                current, r'MarketSessionInfo', 'current'),
            currentLabel: currentLabel,
            currentDescription: currentDescription,
            nextSession: nextSession,
            nextTransitionAt: nextTransitionAt,
            secondsUntilTransition: secondsUntilTransition,
            isHoliday: isHoliday,
            holidayName: holidayName,
            segments: _segments?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'segments';
        _segments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MarketSessionInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
