// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_allocation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioAllocationDimensionEnum
    _$portfolioAllocationDimensionEnum_network =
    const PortfolioAllocationDimensionEnum._('network');
const PortfolioAllocationDimensionEnum
    _$portfolioAllocationDimensionEnum_unknownDefaultOpenApi =
    const PortfolioAllocationDimensionEnum._('unknownDefaultOpenApi');

PortfolioAllocationDimensionEnum _$portfolioAllocationDimensionEnumValueOf(
    String name) {
  switch (name) {
    case 'network':
      return _$portfolioAllocationDimensionEnum_network;
    case 'unknownDefaultOpenApi':
      return _$portfolioAllocationDimensionEnum_unknownDefaultOpenApi;
    default:
      return _$portfolioAllocationDimensionEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PortfolioAllocationDimensionEnum>
    _$portfolioAllocationDimensionEnumValues = BuiltSet<
        PortfolioAllocationDimensionEnum>(const <PortfolioAllocationDimensionEnum>[
  _$portfolioAllocationDimensionEnum_network,
  _$portfolioAllocationDimensionEnum_unknownDefaultOpenApi,
]);

Serializer<PortfolioAllocationDimensionEnum>
    _$portfolioAllocationDimensionEnumSerializer =
    _$PortfolioAllocationDimensionEnumSerializer();

class _$PortfolioAllocationDimensionEnumSerializer
    implements PrimitiveSerializer<PortfolioAllocationDimensionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'network': 'network',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'network': 'network',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioAllocationDimensionEnum];
  @override
  final String wireName = 'PortfolioAllocationDimensionEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioAllocationDimensionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioAllocationDimensionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioAllocationDimensionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioAllocation extends PortfolioAllocation {
  @override
  final OneOf oneOf;

  factory _$PortfolioAllocation(
          [void Function(PortfolioAllocationBuilder)? updates]) =>
      (PortfolioAllocationBuilder()..update(updates))._build();

  _$PortfolioAllocation._({required this.oneOf}) : super._();
  @override
  PortfolioAllocation rebuild(
          void Function(PortfolioAllocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAllocationBuilder toBuilder() =>
      PortfolioAllocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAllocation && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'PortfolioAllocation')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class PortfolioAllocationBuilder
    implements Builder<PortfolioAllocation, PortfolioAllocationBuilder> {
  _$PortfolioAllocation? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  PortfolioAllocationBuilder() {
    PortfolioAllocation._defaults(this);
  }

  PortfolioAllocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAllocation other) {
    _$v = other as _$PortfolioAllocation;
  }

  @override
  void update(void Function(PortfolioAllocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAllocation build() => _build();

  _$PortfolioAllocation _build() {
    final _$result = _$v ??
        _$PortfolioAllocation._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'PortfolioAllocation', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
