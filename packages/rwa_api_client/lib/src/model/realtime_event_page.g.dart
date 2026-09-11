// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_event_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RealtimeEventPage extends RealtimeEventPage {
  @override
  final BuiltList<RealtimeEvent> items;
  @override
  final String nextCursor;
  @override
  final bool hasMore;
  @override
  final bool resyncRequired;

  factory _$RealtimeEventPage(
          [void Function(RealtimeEventPageBuilder)? updates]) =>
      (RealtimeEventPageBuilder()..update(updates))._build();

  _$RealtimeEventPage._(
      {required this.items,
      required this.nextCursor,
      required this.hasMore,
      required this.resyncRequired})
      : super._();
  @override
  RealtimeEventPage rebuild(void Function(RealtimeEventPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RealtimeEventPageBuilder toBuilder() =>
      RealtimeEventPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RealtimeEventPage &&
        items == other.items &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore &&
        resyncRequired == other.resyncRequired;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jc(_$hash, resyncRequired.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RealtimeEventPage')
          ..add('items', items)
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore)
          ..add('resyncRequired', resyncRequired))
        .toString();
  }
}

class RealtimeEventPageBuilder
    implements Builder<RealtimeEventPage, RealtimeEventPageBuilder> {
  _$RealtimeEventPage? _$v;

  ListBuilder<RealtimeEvent>? _items;
  ListBuilder<RealtimeEvent> get items =>
      _$this._items ??= ListBuilder<RealtimeEvent>();
  set items(ListBuilder<RealtimeEvent>? items) => _$this._items = items;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(String? nextCursor) => _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  bool? _resyncRequired;
  bool? get resyncRequired => _$this._resyncRequired;
  set resyncRequired(bool? resyncRequired) =>
      _$this._resyncRequired = resyncRequired;

  RealtimeEventPageBuilder() {
    RealtimeEventPage._defaults(this);
  }

  RealtimeEventPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _resyncRequired = $v.resyncRequired;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RealtimeEventPage other) {
    _$v = other as _$RealtimeEventPage;
  }

  @override
  void update(void Function(RealtimeEventPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RealtimeEventPage build() => _build();

  _$RealtimeEventPage _build() {
    _$RealtimeEventPage _$result;
    try {
      _$result = _$v ??
          _$RealtimeEventPage._(
            items: items.build(),
            nextCursor: BuiltValueNullFieldError.checkNotNull(
                nextCursor, r'RealtimeEventPage', 'nextCursor'),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'RealtimeEventPage', 'hasMore'),
            resyncRequired: BuiltValueNullFieldError.checkNotNull(
                resyncRequired, r'RealtimeEventPage', 'resyncRequired'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RealtimeEventPage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
