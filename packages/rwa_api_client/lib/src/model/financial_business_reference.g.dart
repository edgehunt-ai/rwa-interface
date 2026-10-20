// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_business_reference.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialBusinessReference extends FinancialBusinessReference {
  @override
  final String type;
  @override
  final String id;

  factory _$FinancialBusinessReference(
          [void Function(FinancialBusinessReferenceBuilder)? updates]) =>
      (FinancialBusinessReferenceBuilder()..update(updates))._build();

  _$FinancialBusinessReference._({required this.type, required this.id})
      : super._();
  @override
  FinancialBusinessReference rebuild(
          void Function(FinancialBusinessReferenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialBusinessReferenceBuilder toBuilder() =>
      FinancialBusinessReferenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialBusinessReference &&
        type == other.type &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialBusinessReference')
          ..add('type', type)
          ..add('id', id))
        .toString();
  }
}

class FinancialBusinessReferenceBuilder
    implements
        Builder<FinancialBusinessReference, FinancialBusinessReferenceBuilder> {
  _$FinancialBusinessReference? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  FinancialBusinessReferenceBuilder() {
    FinancialBusinessReference._defaults(this);
  }

  FinancialBusinessReferenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialBusinessReference other) {
    _$v = other as _$FinancialBusinessReference;
  }

  @override
  void update(void Function(FinancialBusinessReferenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialBusinessReference build() => _build();

  _$FinancialBusinessReference _build() {
    final _$result = _$v ??
        _$FinancialBusinessReference._(
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'FinancialBusinessReference', 'type'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'FinancialBusinessReference', 'id'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
