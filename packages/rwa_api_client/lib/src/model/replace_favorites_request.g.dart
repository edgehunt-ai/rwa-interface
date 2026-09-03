// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replace_favorites_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReplaceFavoritesRequest extends ReplaceFavoritesRequest {
  @override
  final BuiltList<ProductRef> items;

  factory _$ReplaceFavoritesRequest(
          [void Function(ReplaceFavoritesRequestBuilder)? updates]) =>
      (ReplaceFavoritesRequestBuilder()..update(updates))._build();

  _$ReplaceFavoritesRequest._({required this.items}) : super._();
  @override
  ReplaceFavoritesRequest rebuild(
          void Function(ReplaceFavoritesRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplaceFavoritesRequestBuilder toBuilder() =>
      ReplaceFavoritesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReplaceFavoritesRequest && items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReplaceFavoritesRequest')
          ..add('items', items))
        .toString();
  }
}

class ReplaceFavoritesRequestBuilder
    implements
        Builder<ReplaceFavoritesRequest, ReplaceFavoritesRequestBuilder> {
  _$ReplaceFavoritesRequest? _$v;

  ListBuilder<ProductRef>? _items;
  ListBuilder<ProductRef> get items =>
      _$this._items ??= ListBuilder<ProductRef>();
  set items(ListBuilder<ProductRef>? items) => _$this._items = items;

  ReplaceFavoritesRequestBuilder() {
    ReplaceFavoritesRequest._defaults(this);
  }

  ReplaceFavoritesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReplaceFavoritesRequest other) {
    _$v = other as _$ReplaceFavoritesRequest;
  }

  @override
  void update(void Function(ReplaceFavoritesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReplaceFavoritesRequest build() => _build();

  _$ReplaceFavoritesRequest _build() {
    _$ReplaceFavoritesRequest _$result;
    try {
      _$result = _$v ??
          _$ReplaceFavoritesRequest._(
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ReplaceFavoritesRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
