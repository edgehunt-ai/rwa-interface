// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disclosures_always_on.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DisclosuresAlwaysOn extends DisclosuresAlwaysOn {
  @override
  final String? title;
  @override
  final String? body;

  factory _$DisclosuresAlwaysOn(
          [void Function(DisclosuresAlwaysOnBuilder)? updates]) =>
      (DisclosuresAlwaysOnBuilder()..update(updates))._build();

  _$DisclosuresAlwaysOn._({this.title, this.body}) : super._();
  @override
  DisclosuresAlwaysOn rebuild(
          void Function(DisclosuresAlwaysOnBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DisclosuresAlwaysOnBuilder toBuilder() =>
      DisclosuresAlwaysOnBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DisclosuresAlwaysOn &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DisclosuresAlwaysOn')
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class DisclosuresAlwaysOnBuilder
    implements Builder<DisclosuresAlwaysOn, DisclosuresAlwaysOnBuilder> {
  _$DisclosuresAlwaysOn? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  DisclosuresAlwaysOnBuilder() {
    DisclosuresAlwaysOn._defaults(this);
  }

  DisclosuresAlwaysOnBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _body = $v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DisclosuresAlwaysOn other) {
    _$v = other as _$DisclosuresAlwaysOn;
  }

  @override
  void update(void Function(DisclosuresAlwaysOnBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DisclosuresAlwaysOn build() => _build();

  _$DisclosuresAlwaysOn _build() {
    final _$result = _$v ??
        _$DisclosuresAlwaysOn._(
          title: title,
          body: body,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
