// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_sessions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListSessions200Response extends ListSessions200Response {
  @override
  final BuiltList<SessionInfo> items;
  @override
  final BuiltList<EndedSessionInfo>? ended;

  factory _$ListSessions200Response(
          [void Function(ListSessions200ResponseBuilder)? updates]) =>
      (ListSessions200ResponseBuilder()..update(updates))._build();

  _$ListSessions200Response._({required this.items, this.ended}) : super._();
  @override
  ListSessions200Response rebuild(
          void Function(ListSessions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListSessions200ResponseBuilder toBuilder() =>
      ListSessions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListSessions200Response &&
        items == other.items &&
        ended == other.ended;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, ended.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListSessions200Response')
          ..add('items', items)
          ..add('ended', ended))
        .toString();
  }
}

class ListSessions200ResponseBuilder
    implements
        Builder<ListSessions200Response, ListSessions200ResponseBuilder> {
  _$ListSessions200Response? _$v;

  ListBuilder<SessionInfo>? _items;
  ListBuilder<SessionInfo> get items =>
      _$this._items ??= ListBuilder<SessionInfo>();
  set items(ListBuilder<SessionInfo>? items) => _$this._items = items;

  ListBuilder<EndedSessionInfo>? _ended;
  ListBuilder<EndedSessionInfo> get ended =>
      _$this._ended ??= ListBuilder<EndedSessionInfo>();
  set ended(ListBuilder<EndedSessionInfo>? ended) => _$this._ended = ended;

  ListSessions200ResponseBuilder() {
    ListSessions200Response._defaults(this);
  }

  ListSessions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _ended = $v.ended?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListSessions200Response other) {
    _$v = other as _$ListSessions200Response;
  }

  @override
  void update(void Function(ListSessions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListSessions200Response build() => _build();

  _$ListSessions200Response _build() {
    _$ListSessions200Response _$result;
    try {
      _$result = _$v ??
          _$ListSessions200Response._(
            items: items.build(),
            ended: _ended?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'ended';
        _ended?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ListSessions200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
