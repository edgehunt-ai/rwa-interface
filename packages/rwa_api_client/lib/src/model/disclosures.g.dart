// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disclosures.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Disclosures extends Disclosures {
  @override
  final DisclosuresAlwaysOn? alwaysOn;
  @override
  final BuiltList<DisclosuresSessionsInner>? sessions;
  @override
  final BuiltList<KeyValue>? riskNotices;

  factory _$Disclosures([void Function(DisclosuresBuilder)? updates]) =>
      (DisclosuresBuilder()..update(updates))._build();

  _$Disclosures._({this.alwaysOn, this.sessions, this.riskNotices}) : super._();
  @override
  Disclosures rebuild(void Function(DisclosuresBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DisclosuresBuilder toBuilder() => DisclosuresBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Disclosures &&
        alwaysOn == other.alwaysOn &&
        sessions == other.sessions &&
        riskNotices == other.riskNotices;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, alwaysOn.hashCode);
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jc(_$hash, riskNotices.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Disclosures')
          ..add('alwaysOn', alwaysOn)
          ..add('sessions', sessions)
          ..add('riskNotices', riskNotices))
        .toString();
  }
}

class DisclosuresBuilder implements Builder<Disclosures, DisclosuresBuilder> {
  _$Disclosures? _$v;

  DisclosuresAlwaysOnBuilder? _alwaysOn;
  DisclosuresAlwaysOnBuilder get alwaysOn =>
      _$this._alwaysOn ??= DisclosuresAlwaysOnBuilder();
  set alwaysOn(DisclosuresAlwaysOnBuilder? alwaysOn) =>
      _$this._alwaysOn = alwaysOn;

  ListBuilder<DisclosuresSessionsInner>? _sessions;
  ListBuilder<DisclosuresSessionsInner> get sessions =>
      _$this._sessions ??= ListBuilder<DisclosuresSessionsInner>();
  set sessions(ListBuilder<DisclosuresSessionsInner>? sessions) =>
      _$this._sessions = sessions;

  ListBuilder<KeyValue>? _riskNotices;
  ListBuilder<KeyValue> get riskNotices =>
      _$this._riskNotices ??= ListBuilder<KeyValue>();
  set riskNotices(ListBuilder<KeyValue>? riskNotices) =>
      _$this._riskNotices = riskNotices;

  DisclosuresBuilder() {
    Disclosures._defaults(this);
  }

  DisclosuresBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _alwaysOn = $v.alwaysOn?.toBuilder();
      _sessions = $v.sessions?.toBuilder();
      _riskNotices = $v.riskNotices?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Disclosures other) {
    _$v = other as _$Disclosures;
  }

  @override
  void update(void Function(DisclosuresBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Disclosures build() => _build();

  _$Disclosures _build() {
    _$Disclosures _$result;
    try {
      _$result = _$v ??
          _$Disclosures._(
            alwaysOn: _alwaysOn?.build(),
            sessions: _sessions?.build(),
            riskNotices: _riskNotices?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'alwaysOn';
        _alwaysOn?.build();
        _$failedField = 'sessions';
        _sessions?.build();
        _$failedField = 'riskNotices';
        _riskNotices?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Disclosures', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
