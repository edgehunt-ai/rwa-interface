// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disclosures_sessions_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DisclosuresSessionsInner extends DisclosuresSessionsInner {
  @override
  final SessionKind? session;
  @override
  final String? title;
  @override
  final String? body;

  factory _$DisclosuresSessionsInner(
          [void Function(DisclosuresSessionsInnerBuilder)? updates]) =>
      (DisclosuresSessionsInnerBuilder()..update(updates))._build();

  _$DisclosuresSessionsInner._({this.session, this.title, this.body})
      : super._();
  @override
  DisclosuresSessionsInner rebuild(
          void Function(DisclosuresSessionsInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DisclosuresSessionsInnerBuilder toBuilder() =>
      DisclosuresSessionsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DisclosuresSessionsInner &&
        session == other.session &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, session.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DisclosuresSessionsInner')
          ..add('session', session)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class DisclosuresSessionsInnerBuilder
    implements
        Builder<DisclosuresSessionsInner, DisclosuresSessionsInnerBuilder> {
  _$DisclosuresSessionsInner? _$v;

  SessionKind? _session;
  SessionKind? get session => _$this._session;
  set session(SessionKind? session) => _$this._session = session;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  DisclosuresSessionsInnerBuilder() {
    DisclosuresSessionsInner._defaults(this);
  }

  DisclosuresSessionsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _session = $v.session;
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DisclosuresSessionsInner other) {
    _$v = other as _$DisclosuresSessionsInner;
  }

  @override
  void update(void Function(DisclosuresSessionsInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DisclosuresSessionsInner build() => _build();

  _$DisclosuresSessionsInner _build() {
    final _$result = _$v ??
        _$DisclosuresSessionsInner._(
          session: session,
          title: title,
          body: body,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
