// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_asset_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourceAssetCatalog extends FundingSourceAssetCatalog {
  @override
  final OneOf oneOf;

  factory _$FundingSourceAssetCatalog(
          [void Function(FundingSourceAssetCatalogBuilder)? updates]) =>
      (FundingSourceAssetCatalogBuilder()..update(updates))._build();

  _$FundingSourceAssetCatalog._({required this.oneOf}) : super._();
  @override
  FundingSourceAssetCatalog rebuild(
          void Function(FundingSourceAssetCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceAssetCatalogBuilder toBuilder() =>
      FundingSourceAssetCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceAssetCatalog && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSourceAssetCatalog')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FundingSourceAssetCatalogBuilder
    implements
        Builder<FundingSourceAssetCatalog, FundingSourceAssetCatalogBuilder> {
  _$FundingSourceAssetCatalog? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FundingSourceAssetCatalogBuilder() {
    FundingSourceAssetCatalog._defaults(this);
  }

  FundingSourceAssetCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSourceAssetCatalog other) {
    _$v = other as _$FundingSourceAssetCatalog;
  }

  @override
  void update(void Function(FundingSourceAssetCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceAssetCatalog build() => _build();

  _$FundingSourceAssetCatalog _build() {
    final _$result = _$v ??
        _$FundingSourceAssetCatalog._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FundingSourceAssetCatalog', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
