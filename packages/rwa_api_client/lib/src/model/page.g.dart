// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class PageBuilder {
  void replace(Page other);
  void update(void Function(PageBuilder) updates);
  String? get nextCursor;
  set nextCursor(String? nextCursor);

  bool? get hasMore;
  set hasMore(bool? hasMore);
}

class _$$Page extends $Page {
  @override
  final String? nextCursor;
  @override
  final bool hasMore;

  factory _$$Page([void Function($PageBuilder)? updates]) =>
      ($PageBuilder()..update(updates))._build();

  _$$Page._({this.nextCursor, required this.hasMore}) : super._();
  @override
  $Page rebuild(void Function($PageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $PageBuilder toBuilder() => $PageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $Page &&
        nextCursor == other.nextCursor &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$Page')
          ..add('nextCursor', nextCursor)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class $PageBuilder implements Builder<$Page, $PageBuilder>, PageBuilder {
  _$$Page? _$v;

  String? _nextCursor;
  String? get nextCursor => _$this._nextCursor;
  set nextCursor(covariant String? nextCursor) =>
      _$this._nextCursor = nextCursor;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(covariant bool? hasMore) => _$this._hasMore = hasMore;

  $PageBuilder() {
    $Page._defaults(this);
  }

  $PageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nextCursor = $v.nextCursor;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $Page other) {
    _$v = other as _$$Page;
  }

  @override
  void update(void Function($PageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $Page build() => _build();

  _$$Page _build() {
    final _$result = _$v ??
        _$$Page._(
          nextCursor: nextCursor,
          hasMore: BuiltValueNullFieldError.checkNotNull(
              hasMore, r'$Page', 'hasMore'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
