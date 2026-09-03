// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_catalog.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingCatalog extends FundingCatalog {
  @override
  final BuiltList<FundingRail> rails;
  @override
  final DateTime updatedAt;

  factory _$FundingCatalog([void Function(FundingCatalogBuilder)? updates]) =>
      (FundingCatalogBuilder()..update(updates))._build();

  _$FundingCatalog._({required this.rails, required this.updatedAt})
      : super._();
  @override
  FundingCatalog rebuild(void Function(FundingCatalogBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingCatalogBuilder toBuilder() => FundingCatalogBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingCatalog &&
        rails == other.rails &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rails.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingCatalog')
          ..add('rails', rails)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class FundingCatalogBuilder
    implements Builder<FundingCatalog, FundingCatalogBuilder> {
  _$FundingCatalog? _$v;

  ListBuilder<FundingRail>? _rails;
  ListBuilder<FundingRail> get rails =>
      _$this._rails ??= ListBuilder<FundingRail>();
  set rails(ListBuilder<FundingRail>? rails) => _$this._rails = rails;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  FundingCatalogBuilder() {
    FundingCatalog._defaults(this);
  }

  FundingCatalogBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rails = $v.rails.toBuilder();
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingCatalog other) {
    _$v = other as _$FundingCatalog;
  }

  @override
  void update(void Function(FundingCatalogBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingCatalog build() => _build();

  _$FundingCatalog _build() {
    _$FundingCatalog _$result;
    try {
      _$result = _$v ??
          _$FundingCatalog._(
            rails: rails.build(),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'FundingCatalog', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'rails';
        rails.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingCatalog', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
