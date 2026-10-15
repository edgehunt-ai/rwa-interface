// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_cross_margin_pool.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioCrossMarginPoolStatusEnum
    _$portfolioCrossMarginPoolStatusEnum_available =
    const PortfolioCrossMarginPoolStatusEnum._('available');
const PortfolioCrossMarginPoolStatusEnum
    _$portfolioCrossMarginPoolStatusEnum_unavailable =
    const PortfolioCrossMarginPoolStatusEnum._('unavailable');

PortfolioCrossMarginPoolStatusEnum _$portfolioCrossMarginPoolStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'available':
      return _$portfolioCrossMarginPoolStatusEnum_available;
    case 'unavailable':
      return _$portfolioCrossMarginPoolStatusEnum_unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioCrossMarginPoolStatusEnum>
    _$portfolioCrossMarginPoolStatusEnumValues = BuiltSet<
        PortfolioCrossMarginPoolStatusEnum>(const <PortfolioCrossMarginPoolStatusEnum>[
  _$portfolioCrossMarginPoolStatusEnum_available,
  _$portfolioCrossMarginPoolStatusEnum_unavailable,
]);

const PortfolioCrossMarginPoolAssetEnum
    _$portfolioCrossMarginPoolAssetEnum_USDC =
    const PortfolioCrossMarginPoolAssetEnum._('USDC');

PortfolioCrossMarginPoolAssetEnum _$portfolioCrossMarginPoolAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$portfolioCrossMarginPoolAssetEnum_USDC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioCrossMarginPoolAssetEnum>
    _$portfolioCrossMarginPoolAssetEnumValues = BuiltSet<
        PortfolioCrossMarginPoolAssetEnum>(const <PortfolioCrossMarginPoolAssetEnum>[
  _$portfolioCrossMarginPoolAssetEnum_USDC,
]);

Serializer<PortfolioCrossMarginPoolStatusEnum>
    _$portfolioCrossMarginPoolStatusEnumSerializer =
    _$PortfolioCrossMarginPoolStatusEnumSerializer();
Serializer<PortfolioCrossMarginPoolAssetEnum>
    _$portfolioCrossMarginPoolAssetEnumSerializer =
    _$PortfolioCrossMarginPoolAssetEnumSerializer();

class _$PortfolioCrossMarginPoolStatusEnumSerializer
    implements PrimitiveSerializer<PortfolioCrossMarginPoolStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioCrossMarginPoolStatusEnum];
  @override
  final String wireName = 'PortfolioCrossMarginPoolStatusEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioCrossMarginPoolStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioCrossMarginPoolStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioCrossMarginPoolStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioCrossMarginPoolAssetEnumSerializer
    implements PrimitiveSerializer<PortfolioCrossMarginPoolAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
  };

  @override
  final Iterable<Type> types = const <Type>[PortfolioCrossMarginPoolAssetEnum];
  @override
  final String wireName = 'PortfolioCrossMarginPoolAssetEnum';

  @override
  Object serialize(
          Serializers serializers, PortfolioCrossMarginPoolAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioCrossMarginPoolAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioCrossMarginPoolAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioCrossMarginPool extends PortfolioCrossMarginPool {
  @override
  final PortfolioCrossMarginPoolStatusEnum status;
  @override
  final PortfolioCrossMarginPoolAssetEnum asset;
  @override
  final String? quantity;
  @override
  final String? valueUsd;

  factory _$PortfolioCrossMarginPool(
          [void Function(PortfolioCrossMarginPoolBuilder)? updates]) =>
      (PortfolioCrossMarginPoolBuilder()..update(updates))._build();

  _$PortfolioCrossMarginPool._(
      {required this.status, required this.asset, this.quantity, this.valueUsd})
      : super._();
  @override
  PortfolioCrossMarginPool rebuild(
          void Function(PortfolioCrossMarginPoolBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioCrossMarginPoolBuilder toBuilder() =>
      PortfolioCrossMarginPoolBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioCrossMarginPool &&
        status == other.status &&
        asset == other.asset &&
        quantity == other.quantity &&
        valueUsd == other.valueUsd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioCrossMarginPool')
          ..add('status', status)
          ..add('asset', asset)
          ..add('quantity', quantity)
          ..add('valueUsd', valueUsd))
        .toString();
  }
}

class PortfolioCrossMarginPoolBuilder
    implements
        Builder<PortfolioCrossMarginPool, PortfolioCrossMarginPoolBuilder> {
  _$PortfolioCrossMarginPool? _$v;

  PortfolioCrossMarginPoolStatusEnum? _status;
  PortfolioCrossMarginPoolStatusEnum? get status => _$this._status;
  set status(PortfolioCrossMarginPoolStatusEnum? status) =>
      _$this._status = status;

  PortfolioCrossMarginPoolAssetEnum? _asset;
  PortfolioCrossMarginPoolAssetEnum? get asset => _$this._asset;
  set asset(PortfolioCrossMarginPoolAssetEnum? asset) => _$this._asset = asset;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  PortfolioCrossMarginPoolBuilder() {
    PortfolioCrossMarginPool._defaults(this);
  }

  PortfolioCrossMarginPoolBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _asset = $v.asset;
      _quantity = $v.quantity;
      _valueUsd = $v.valueUsd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioCrossMarginPool other) {
    _$v = other as _$PortfolioCrossMarginPool;
  }

  @override
  void update(void Function(PortfolioCrossMarginPoolBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioCrossMarginPool build() => _build();

  _$PortfolioCrossMarginPool _build() {
    final _$result = _$v ??
        _$PortfolioCrossMarginPool._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PortfolioCrossMarginPool', 'status'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'PortfolioCrossMarginPool', 'asset'),
          quantity: quantity,
          valueUsd: valueUsd,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
