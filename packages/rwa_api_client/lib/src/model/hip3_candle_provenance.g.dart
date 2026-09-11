// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_candle_provenance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3CandleProvenance extends Hip3CandleProvenance {
  @override
  final String productId;
  @override
  final Hip3Environment environment;
  @override
  final String source_;
  @override
  final DateTime updatedAt;
  @override
  final DateTime freshUntil;

  factory _$Hip3CandleProvenance(
          [void Function(Hip3CandleProvenanceBuilder)? updates]) =>
      (Hip3CandleProvenanceBuilder()..update(updates))._build();

  _$Hip3CandleProvenance._(
      {required this.productId,
      required this.environment,
      required this.source_,
      required this.updatedAt,
      required this.freshUntil})
      : super._();
  @override
  Hip3CandleProvenance rebuild(
          void Function(Hip3CandleProvenanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3CandleProvenanceBuilder toBuilder() =>
      Hip3CandleProvenanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3CandleProvenance &&
        productId == other.productId &&
        environment == other.environment &&
        source_ == other.source_ &&
        updatedAt == other.updatedAt &&
        freshUntil == other.freshUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, freshUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3CandleProvenance')
          ..add('productId', productId)
          ..add('environment', environment)
          ..add('source_', source_)
          ..add('updatedAt', updatedAt)
          ..add('freshUntil', freshUntil))
        .toString();
  }
}

class Hip3CandleProvenanceBuilder
    implements Builder<Hip3CandleProvenance, Hip3CandleProvenanceBuilder> {
  _$Hip3CandleProvenance? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  Hip3Environment? _environment;
  Hip3Environment? get environment => _$this._environment;
  set environment(Hip3Environment? environment) =>
      _$this._environment = environment;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _freshUntil;
  DateTime? get freshUntil => _$this._freshUntil;
  set freshUntil(DateTime? freshUntil) => _$this._freshUntil = freshUntil;

  Hip3CandleProvenanceBuilder() {
    Hip3CandleProvenance._defaults(this);
  }

  Hip3CandleProvenanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _environment = $v.environment;
      _source_ = $v.source_;
      _updatedAt = $v.updatedAt;
      _freshUntil = $v.freshUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3CandleProvenance other) {
    _$v = other as _$Hip3CandleProvenance;
  }

  @override
  void update(void Function(Hip3CandleProvenanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3CandleProvenance build() => _build();

  _$Hip3CandleProvenance _build() {
    final _$result = _$v ??
        _$Hip3CandleProvenance._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3CandleProvenance', 'productId'),
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'Hip3CandleProvenance', 'environment'),
          source_: BuiltValueNullFieldError.checkNotNull(
              source_, r'Hip3CandleProvenance', 'source_'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'Hip3CandleProvenance', 'updatedAt'),
          freshUntil: BuiltValueNullFieldError.checkNotNull(
              freshUntil, r'Hip3CandleProvenance', 'freshUntil'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
