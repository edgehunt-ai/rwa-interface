// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_accounts200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListAccounts200Response extends ListAccounts200Response {
  @override
  final BuiltList<AccountBalance> items;

  factory _$ListAccounts200Response(
          [void Function(ListAccounts200ResponseBuilder)? updates]) =>
      (ListAccounts200ResponseBuilder()..update(updates))._build();

  _$ListAccounts200Response._({required this.items}) : super._();
  @override
  ListAccounts200Response rebuild(
          void Function(ListAccounts200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListAccounts200ResponseBuilder toBuilder() =>
      ListAccounts200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListAccounts200Response && items == other.items;
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
    return (newBuiltValueToStringHelper(r'ListAccounts200Response')
          ..add('items', items))
        .toString();
  }
}

class ListAccounts200ResponseBuilder
    implements
        Builder<ListAccounts200Response, ListAccounts200ResponseBuilder> {
  _$ListAccounts200Response? _$v;

  ListBuilder<AccountBalance>? _items;
  ListBuilder<AccountBalance> get items =>
      _$this._items ??= ListBuilder<AccountBalance>();
  set items(ListBuilder<AccountBalance>? items) => _$this._items = items;

  ListAccounts200ResponseBuilder() {
    ListAccounts200Response._defaults(this);
  }

  ListAccounts200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListAccounts200Response other) {
    _$v = other as _$ListAccounts200Response;
  }

  @override
  void update(void Function(ListAccounts200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListAccounts200Response build() => _build();

  _$ListAccounts200Response _build() {
    _$ListAccounts200Response _$result;
    try {
      _$result = _$v ??
          _$ListAccounts200Response._(
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ListAccounts200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
