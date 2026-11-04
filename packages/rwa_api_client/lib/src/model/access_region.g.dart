// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_region.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccessRegionSource_Enum _$accessRegionSourceEnum_edge =
    const AccessRegionSource_Enum._('edge');
const AccessRegionSource_Enum _$accessRegionSourceEnum_geoip =
    const AccessRegionSource_Enum._('geoip');
const AccessRegionSource_Enum _$accessRegionSourceEnum_unknown =
    const AccessRegionSource_Enum._('unknown');

AccessRegionSource_Enum _$accessRegionSourceEnumValueOf(String name) {
  switch (name) {
    case 'edge':
      return _$accessRegionSourceEnum_edge;
    case 'geoip':
      return _$accessRegionSourceEnum_geoip;
    case 'unknown':
      return _$accessRegionSourceEnum_unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccessRegionSource_Enum> _$accessRegionSourceEnumValues =
    BuiltSet<AccessRegionSource_Enum>(const <AccessRegionSource_Enum>[
  _$accessRegionSourceEnum_edge,
  _$accessRegionSourceEnum_geoip,
  _$accessRegionSourceEnum_unknown,
]);

Serializer<AccessRegionSource_Enum> _$accessRegionSourceEnumSerializer =
    _$AccessRegionSource_EnumSerializer();

class _$AccessRegionSource_EnumSerializer
    implements PrimitiveSerializer<AccessRegionSource_Enum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'edge': 'edge',
    'geoip': 'geoip',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'edge': 'edge',
    'geoip': 'geoip',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[AccessRegionSource_Enum];
  @override
  final String wireName = 'AccessRegionSource_Enum';

  @override
  Object serialize(Serializers serializers, AccessRegionSource_Enum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AccessRegionSource_Enum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AccessRegionSource_Enum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$AccessRegion extends AccessRegion {
  @override
  final String? countryCode;
  @override
  final AccessRegionSource_Enum source_;
  @override
  final bool restricted;
  @override
  final BuiltList<String> restrictedCountries;
  @override
  final BuiltList<RestrictedRegion> restrictedRegions;

  factory _$AccessRegion([void Function(AccessRegionBuilder)? updates]) =>
      (AccessRegionBuilder()..update(updates))._build();

  _$AccessRegion._(
      {this.countryCode,
      required this.source_,
      required this.restricted,
      required this.restrictedCountries,
      required this.restrictedRegions})
      : super._();
  @override
  AccessRegion rebuild(void Function(AccessRegionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccessRegionBuilder toBuilder() => AccessRegionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccessRegion &&
        countryCode == other.countryCode &&
        source_ == other.source_ &&
        restricted == other.restricted &&
        restrictedCountries == other.restrictedCountries &&
        restrictedRegions == other.restrictedRegions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, countryCode.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, restricted.hashCode);
    _$hash = $jc(_$hash, restrictedCountries.hashCode);
    _$hash = $jc(_$hash, restrictedRegions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccessRegion')
          ..add('countryCode', countryCode)
          ..add('source_', source_)
          ..add('restricted', restricted)
          ..add('restrictedCountries', restrictedCountries)
          ..add('restrictedRegions', restrictedRegions))
        .toString();
  }
}

class AccessRegionBuilder
    implements Builder<AccessRegion, AccessRegionBuilder> {
  _$AccessRegion? _$v;

  String? _countryCode;
  String? get countryCode => _$this._countryCode;
  set countryCode(String? countryCode) => _$this._countryCode = countryCode;

  AccessRegionSource_Enum? _source_;
  AccessRegionSource_Enum? get source_ => _$this._source_;
  set source_(AccessRegionSource_Enum? source_) => _$this._source_ = source_;

  bool? _restricted;
  bool? get restricted => _$this._restricted;
  set restricted(bool? restricted) => _$this._restricted = restricted;

  ListBuilder<String>? _restrictedCountries;
  ListBuilder<String> get restrictedCountries =>
      _$this._restrictedCountries ??= ListBuilder<String>();
  set restrictedCountries(ListBuilder<String>? restrictedCountries) =>
      _$this._restrictedCountries = restrictedCountries;

  ListBuilder<RestrictedRegion>? _restrictedRegions;
  ListBuilder<RestrictedRegion> get restrictedRegions =>
      _$this._restrictedRegions ??= ListBuilder<RestrictedRegion>();
  set restrictedRegions(ListBuilder<RestrictedRegion>? restrictedRegions) =>
      _$this._restrictedRegions = restrictedRegions;

  AccessRegionBuilder() {
    AccessRegion._defaults(this);
  }

  AccessRegionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _countryCode = $v.countryCode;
      _source_ = $v.source_;
      _restricted = $v.restricted;
      _restrictedCountries = $v.restrictedCountries.toBuilder();
      _restrictedRegions = $v.restrictedRegions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccessRegion other) {
    _$v = other as _$AccessRegion;
  }

  @override
  void update(void Function(AccessRegionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccessRegion build() => _build();

  _$AccessRegion _build() {
    _$AccessRegion _$result;
    try {
      _$result = _$v ??
          _$AccessRegion._(
            countryCode: countryCode,
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'AccessRegion', 'source_'),
            restricted: BuiltValueNullFieldError.checkNotNull(
                restricted, r'AccessRegion', 'restricted'),
            restrictedCountries: restrictedCountries.build(),
            restrictedRegions: restrictedRegions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'restrictedCountries';
        restrictedCountries.build();
        _$failedField = 'restrictedRegions';
        restrictedRegions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AccessRegion', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
