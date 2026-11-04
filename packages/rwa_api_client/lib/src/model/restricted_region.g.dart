// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restricted_region.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RestrictedRegion extends RestrictedRegion {
  @override
  final String countryCode;
  @override
  final String name;

  factory _$RestrictedRegion(
          [void Function(RestrictedRegionBuilder)? updates]) =>
      (RestrictedRegionBuilder()..update(updates))._build();

  _$RestrictedRegion._({required this.countryCode, required this.name})
      : super._();
  @override
  RestrictedRegion rebuild(void Function(RestrictedRegionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RestrictedRegionBuilder toBuilder() =>
      RestrictedRegionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RestrictedRegion &&
        countryCode == other.countryCode &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, countryCode.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RestrictedRegion')
          ..add('countryCode', countryCode)
          ..add('name', name))
        .toString();
  }
}

class RestrictedRegionBuilder
    implements Builder<RestrictedRegion, RestrictedRegionBuilder> {
  _$RestrictedRegion? _$v;

  String? _countryCode;
  String? get countryCode => _$this._countryCode;
  set countryCode(String? countryCode) => _$this._countryCode = countryCode;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  RestrictedRegionBuilder() {
    RestrictedRegion._defaults(this);
  }

  RestrictedRegionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _countryCode = $v.countryCode;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RestrictedRegion other) {
    _$v = other as _$RestrictedRegion;
  }

  @override
  void update(void Function(RestrictedRegionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RestrictedRegion build() => _build();

  _$RestrictedRegion _build() {
    final _$result = _$v ??
        _$RestrictedRegion._(
          countryCode: BuiltValueNullFieldError.checkNotNull(
              countryCode, r'RestrictedRegion', 'countryCode'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'RestrictedRegion', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
