// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_app_versions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListAppVersions200Response extends ListAppVersions200Response {
  @override
  final BuiltList<AppVersionInfo> platforms;

  factory _$ListAppVersions200Response(
          [void Function(ListAppVersions200ResponseBuilder)? updates]) =>
      (ListAppVersions200ResponseBuilder()..update(updates))._build();

  _$ListAppVersions200Response._({required this.platforms}) : super._();
  @override
  ListAppVersions200Response rebuild(
          void Function(ListAppVersions200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListAppVersions200ResponseBuilder toBuilder() =>
      ListAppVersions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListAppVersions200Response && platforms == other.platforms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, platforms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListAppVersions200Response')
          ..add('platforms', platforms))
        .toString();
  }
}

class ListAppVersions200ResponseBuilder
    implements
        Builder<ListAppVersions200Response, ListAppVersions200ResponseBuilder> {
  _$ListAppVersions200Response? _$v;

  ListBuilder<AppVersionInfo>? _platforms;
  ListBuilder<AppVersionInfo> get platforms =>
      _$this._platforms ??= ListBuilder<AppVersionInfo>();
  set platforms(ListBuilder<AppVersionInfo>? platforms) =>
      _$this._platforms = platforms;

  ListAppVersions200ResponseBuilder() {
    ListAppVersions200Response._defaults(this);
  }

  ListAppVersions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _platforms = $v.platforms.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListAppVersions200Response other) {
    _$v = other as _$ListAppVersions200Response;
  }

  @override
  void update(void Function(ListAppVersions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListAppVersions200Response build() => _build();

  _$ListAppVersions200Response _build() {
    _$ListAppVersions200Response _$result;
    try {
      _$result = _$v ??
          _$ListAppVersions200Response._(
            platforms: platforms.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'platforms';
        platforms.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ListAppVersions200Response', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
