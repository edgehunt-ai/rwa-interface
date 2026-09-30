// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_cross_liquidation_risk.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_available =
    const PortfolioCrossLiquidationRiskStatusEnum._('available');
const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_partial =
    const PortfolioCrossLiquidationRiskStatusEnum._('partial');
const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_unavailable =
    const PortfolioCrossLiquidationRiskStatusEnum._('unavailable');
const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_safe =
    const PortfolioCrossLiquidationRiskStatusEnum._('safe');
const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_liquidationRisk =
    const PortfolioCrossLiquidationRiskStatusEnum._('liquidationRisk');
const PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnum_highLiquidationRisk =
    const PortfolioCrossLiquidationRiskStatusEnum._('highLiquidationRisk');

PortfolioCrossLiquidationRiskStatusEnum
    _$portfolioCrossLiquidationRiskStatusEnumValueOf(String name) {
  switch (name) {
    case 'available':
      return _$portfolioCrossLiquidationRiskStatusEnum_available;
    case 'partial':
      return _$portfolioCrossLiquidationRiskStatusEnum_partial;
    case 'unavailable':
      return _$portfolioCrossLiquidationRiskStatusEnum_unavailable;
    case 'safe':
      return _$portfolioCrossLiquidationRiskStatusEnum_safe;
    case 'liquidationRisk':
      return _$portfolioCrossLiquidationRiskStatusEnum_liquidationRisk;
    case 'highLiquidationRisk':
      return _$portfolioCrossLiquidationRiskStatusEnum_highLiquidationRisk;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioCrossLiquidationRiskStatusEnum>
    _$portfolioCrossLiquidationRiskStatusEnumValues = BuiltSet<
        PortfolioCrossLiquidationRiskStatusEnum>(const <PortfolioCrossLiquidationRiskStatusEnum>[
  _$portfolioCrossLiquidationRiskStatusEnum_available,
  _$portfolioCrossLiquidationRiskStatusEnum_partial,
  _$portfolioCrossLiquidationRiskStatusEnum_unavailable,
  _$portfolioCrossLiquidationRiskStatusEnum_safe,
  _$portfolioCrossLiquidationRiskStatusEnum_liquidationRisk,
  _$portfolioCrossLiquidationRiskStatusEnum_highLiquidationRisk,
]);

Serializer<PortfolioCrossLiquidationRiskStatusEnum>
    _$portfolioCrossLiquidationRiskStatusEnumSerializer =
    _$PortfolioCrossLiquidationRiskStatusEnumSerializer();

class _$PortfolioCrossLiquidationRiskStatusEnumSerializer
    implements PrimitiveSerializer<PortfolioCrossLiquidationRiskStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
    'safe': 'safe',
    'liquidationRisk': 'liquidation_risk',
    'highLiquidationRisk': 'high_liquidation_risk',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
    'safe': 'safe',
    'liquidation_risk': 'liquidationRisk',
    'high_liquidation_risk': 'highLiquidationRisk',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioCrossLiquidationRiskStatusEnum
  ];
  @override
  final String wireName = 'PortfolioCrossLiquidationRiskStatusEnum';

  @override
  Object serialize(Serializers serializers,
          PortfolioCrossLiquidationRiskStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioCrossLiquidationRiskStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioCrossLiquidationRiskStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioCrossLiquidationRisk extends PortfolioCrossLiquidationRisk {
  @override
  final PortfolioCrossLiquidationRiskStatusEnum status;
  @override
  final String? closestDistancePercent;
  @override
  final int? crossPositionCount;

  factory _$PortfolioCrossLiquidationRisk(
          [void Function(PortfolioCrossLiquidationRiskBuilder)? updates]) =>
      (PortfolioCrossLiquidationRiskBuilder()..update(updates))._build();

  _$PortfolioCrossLiquidationRisk._(
      {required this.status,
      this.closestDistancePercent,
      this.crossPositionCount})
      : super._();
  @override
  PortfolioCrossLiquidationRisk rebuild(
          void Function(PortfolioCrossLiquidationRiskBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioCrossLiquidationRiskBuilder toBuilder() =>
      PortfolioCrossLiquidationRiskBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioCrossLiquidationRisk &&
        status == other.status &&
        closestDistancePercent == other.closestDistancePercent &&
        crossPositionCount == other.crossPositionCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, closestDistancePercent.hashCode);
    _$hash = $jc(_$hash, crossPositionCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioCrossLiquidationRisk')
          ..add('status', status)
          ..add('closestDistancePercent', closestDistancePercent)
          ..add('crossPositionCount', crossPositionCount))
        .toString();
  }
}

class PortfolioCrossLiquidationRiskBuilder
    implements
        Builder<PortfolioCrossLiquidationRisk,
            PortfolioCrossLiquidationRiskBuilder> {
  _$PortfolioCrossLiquidationRisk? _$v;

  PortfolioCrossLiquidationRiskStatusEnum? _status;
  PortfolioCrossLiquidationRiskStatusEnum? get status => _$this._status;
  set status(PortfolioCrossLiquidationRiskStatusEnum? status) =>
      _$this._status = status;

  String? _closestDistancePercent;
  String? get closestDistancePercent => _$this._closestDistancePercent;
  set closestDistancePercent(String? closestDistancePercent) =>
      _$this._closestDistancePercent = closestDistancePercent;

  int? _crossPositionCount;
  int? get crossPositionCount => _$this._crossPositionCount;
  set crossPositionCount(int? crossPositionCount) =>
      _$this._crossPositionCount = crossPositionCount;

  PortfolioCrossLiquidationRiskBuilder() {
    PortfolioCrossLiquidationRisk._defaults(this);
  }

  PortfolioCrossLiquidationRiskBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _closestDistancePercent = $v.closestDistancePercent;
      _crossPositionCount = $v.crossPositionCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioCrossLiquidationRisk other) {
    _$v = other as _$PortfolioCrossLiquidationRisk;
  }

  @override
  void update(void Function(PortfolioCrossLiquidationRiskBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioCrossLiquidationRisk build() => _build();

  _$PortfolioCrossLiquidationRisk _build() {
    final _$result = _$v ??
        _$PortfolioCrossLiquidationRisk._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PortfolioCrossLiquidationRisk', 'status'),
          closestDistancePercent: closestDistancePercent,
          crossPositionCount: crossPositionCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
