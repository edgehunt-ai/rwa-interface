// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_asset.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourceAsset extends FundingSourceAsset {
  @override
  final FundingSourceAssetIdentity identity;
  @override
  final FundingRouteCapabilityMatrix routeCapabilities;

  factory _$FundingSourceAsset(
          [void Function(FundingSourceAssetBuilder)? updates]) =>
      (FundingSourceAssetBuilder()..update(updates))._build();

  _$FundingSourceAsset._(
      {required this.identity, required this.routeCapabilities})
      : super._();
  @override
  FundingSourceAsset rebuild(
          void Function(FundingSourceAssetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceAssetBuilder toBuilder() =>
      FundingSourceAssetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceAsset &&
        identity == other.identity &&
        routeCapabilities == other.routeCapabilities;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, identity.hashCode);
    _$hash = $jc(_$hash, routeCapabilities.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSourceAsset')
          ..add('identity', identity)
          ..add('routeCapabilities', routeCapabilities))
        .toString();
  }
}

class FundingSourceAssetBuilder
    implements Builder<FundingSourceAsset, FundingSourceAssetBuilder> {
  _$FundingSourceAsset? _$v;

  FundingSourceAssetIdentityBuilder? _identity;
  FundingSourceAssetIdentityBuilder get identity =>
      _$this._identity ??= FundingSourceAssetIdentityBuilder();
  set identity(FundingSourceAssetIdentityBuilder? identity) =>
      _$this._identity = identity;

  FundingRouteCapabilityMatrixBuilder? _routeCapabilities;
  FundingRouteCapabilityMatrixBuilder get routeCapabilities =>
      _$this._routeCapabilities ??= FundingRouteCapabilityMatrixBuilder();
  set routeCapabilities(
          FundingRouteCapabilityMatrixBuilder? routeCapabilities) =>
      _$this._routeCapabilities = routeCapabilities;

  FundingSourceAssetBuilder() {
    FundingSourceAsset._defaults(this);
  }

  FundingSourceAssetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _identity = $v.identity.toBuilder();
      _routeCapabilities = $v.routeCapabilities.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSourceAsset other) {
    _$v = other as _$FundingSourceAsset;
  }

  @override
  void update(void Function(FundingSourceAssetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceAsset build() => _build();

  _$FundingSourceAsset _build() {
    _$FundingSourceAsset _$result;
    try {
      _$result = _$v ??
          _$FundingSourceAsset._(
            identity: identity.build(),
            routeCapabilities: routeCapabilities.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'identity';
        identity.build();
        _$failedField = 'routeCapabilities';
        routeCapabilities.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSourceAsset', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
