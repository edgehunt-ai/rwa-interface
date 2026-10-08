// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_order_capacity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Hip3OrderCapacity extends Hip3OrderCapacity {
  @override
  final Hip3OrderCapacitySide long;
  @override
  final Hip3OrderCapacitySide short;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$Hip3OrderCapacity(
          [void Function(Hip3OrderCapacityBuilder)? updates]) =>
      (Hip3OrderCapacityBuilder()..update(updates))._build();

  _$Hip3OrderCapacity._(
      {required this.long,
      required this.short,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  Hip3OrderCapacity rebuild(void Function(Hip3OrderCapacityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OrderCapacityBuilder toBuilder() =>
      Hip3OrderCapacityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OrderCapacity &&
        long == other.long &&
        short == other.short &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, long.hashCode);
    _$hash = $jc(_$hash, short.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3OrderCapacity')
          ..add('long', long)
          ..add('short', short)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class Hip3OrderCapacityBuilder
    implements Builder<Hip3OrderCapacity, Hip3OrderCapacityBuilder> {
  _$Hip3OrderCapacity? _$v;

  Hip3OrderCapacitySideBuilder? _long;
  Hip3OrderCapacitySideBuilder get long =>
      _$this._long ??= Hip3OrderCapacitySideBuilder();
  set long(Hip3OrderCapacitySideBuilder? long) => _$this._long = long;

  Hip3OrderCapacitySideBuilder? _short;
  Hip3OrderCapacitySideBuilder get short =>
      _$this._short ??= Hip3OrderCapacitySideBuilder();
  set short(Hip3OrderCapacitySideBuilder? short) => _$this._short = short;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  Hip3OrderCapacityBuilder() {
    Hip3OrderCapacity._defaults(this);
  }

  Hip3OrderCapacityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _long = $v.long.toBuilder();
      _short = $v.short.toBuilder();
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OrderCapacity other) {
    _$v = other as _$Hip3OrderCapacity;
  }

  @override
  void update(void Function(Hip3OrderCapacityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OrderCapacity build() => _build();

  _$Hip3OrderCapacity _build() {
    _$Hip3OrderCapacity _$result;
    try {
      _$result = _$v ??
          _$Hip3OrderCapacity._(
            long: long.build(),
            short: short.build(),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'Hip3OrderCapacity', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'Hip3OrderCapacity', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'long';
        long.build();
        _$failedField = 'short';
        short.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3OrderCapacity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
