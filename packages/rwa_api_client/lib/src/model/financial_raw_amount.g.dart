// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_raw_amount.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinancialRawAmountStatusEnum _$financialRawAmountStatusEnum_unknown =
    const FinancialRawAmountStatusEnum._('unknown');

FinancialRawAmountStatusEnum _$financialRawAmountStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'unknown':
      return _$financialRawAmountStatusEnum_unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialRawAmountStatusEnum>
    _$financialRawAmountStatusEnumValues =
    BuiltSet<FinancialRawAmountStatusEnum>(const <FinancialRawAmountStatusEnum>[
  _$financialRawAmountStatusEnum_unknown,
]);

Serializer<FinancialRawAmountStatusEnum>
    _$financialRawAmountStatusEnumSerializer =
    _$FinancialRawAmountStatusEnumSerializer();

class _$FinancialRawAmountStatusEnumSerializer
    implements PrimitiveSerializer<FinancialRawAmountStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[FinancialRawAmountStatusEnum];
  @override
  final String wireName = 'FinancialRawAmountStatusEnum';

  @override
  Object serialize(Serializers serializers, FinancialRawAmountStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialRawAmountStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialRawAmountStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialRawAmount extends FinancialRawAmount {
  @override
  final OneOf oneOf;

  factory _$FinancialRawAmount(
          [void Function(FinancialRawAmountBuilder)? updates]) =>
      (FinancialRawAmountBuilder()..update(updates))._build();

  _$FinancialRawAmount._({required this.oneOf}) : super._();
  @override
  FinancialRawAmount rebuild(
          void Function(FinancialRawAmountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialRawAmountBuilder toBuilder() =>
      FinancialRawAmountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialRawAmount && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'FinancialRawAmount')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FinancialRawAmountBuilder
    implements Builder<FinancialRawAmount, FinancialRawAmountBuilder> {
  _$FinancialRawAmount? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FinancialRawAmountBuilder() {
    FinancialRawAmount._defaults(this);
  }

  FinancialRawAmountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialRawAmount other) {
    _$v = other as _$FinancialRawAmount;
  }

  @override
  void update(void Function(FinancialRawAmountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialRawAmount build() => _build();

  _$FinancialRawAmount _build() {
    final _$result = _$v ??
        _$FinancialRawAmount._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FinancialRawAmount', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
