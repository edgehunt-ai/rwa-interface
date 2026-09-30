// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_open_order_margin_estimate.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PortfolioOpenOrderMarginEstimateStatusEnum
    _$portfolioOpenOrderMarginEstimateStatusEnum_available =
    const PortfolioOpenOrderMarginEstimateStatusEnum._('available');
const PortfolioOpenOrderMarginEstimateStatusEnum
    _$portfolioOpenOrderMarginEstimateStatusEnum_unavailable =
    const PortfolioOpenOrderMarginEstimateStatusEnum._('unavailable');

PortfolioOpenOrderMarginEstimateStatusEnum
    _$portfolioOpenOrderMarginEstimateStatusEnumValueOf(String name) {
  switch (name) {
    case 'available':
      return _$portfolioOpenOrderMarginEstimateStatusEnum_available;
    case 'unavailable':
      return _$portfolioOpenOrderMarginEstimateStatusEnum_unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PortfolioOpenOrderMarginEstimateStatusEnum>
    _$portfolioOpenOrderMarginEstimateStatusEnumValues = BuiltSet<
        PortfolioOpenOrderMarginEstimateStatusEnum>(const <PortfolioOpenOrderMarginEstimateStatusEnum>[
  _$portfolioOpenOrderMarginEstimateStatusEnum_available,
  _$portfolioOpenOrderMarginEstimateStatusEnum_unavailable,
]);

Serializer<PortfolioOpenOrderMarginEstimateStatusEnum>
    _$portfolioOpenOrderMarginEstimateStatusEnumSerializer =
    _$PortfolioOpenOrderMarginEstimateStatusEnumSerializer();

class _$PortfolioOpenOrderMarginEstimateStatusEnumSerializer
    implements PrimitiveSerializer<PortfolioOpenOrderMarginEstimateStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PortfolioOpenOrderMarginEstimateStatusEnum
  ];
  @override
  final String wireName = 'PortfolioOpenOrderMarginEstimateStatusEnum';

  @override
  Object serialize(Serializers serializers,
          PortfolioOpenOrderMarginEstimateStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PortfolioOpenOrderMarginEstimateStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PortfolioOpenOrderMarginEstimateStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PortfolioOpenOrderMarginEstimate
    extends PortfolioOpenOrderMarginEstimate {
  @override
  final PortfolioOpenOrderMarginEstimateStatusEnum status;
  @override
  final String? amountUsd;
  @override
  final int? orderCount;

  factory _$PortfolioOpenOrderMarginEstimate(
          [void Function(PortfolioOpenOrderMarginEstimateBuilder)? updates]) =>
      (PortfolioOpenOrderMarginEstimateBuilder()..update(updates))._build();

  _$PortfolioOpenOrderMarginEstimate._(
      {required this.status, this.amountUsd, this.orderCount})
      : super._();
  @override
  PortfolioOpenOrderMarginEstimate rebuild(
          void Function(PortfolioOpenOrderMarginEstimateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioOpenOrderMarginEstimateBuilder toBuilder() =>
      PortfolioOpenOrderMarginEstimateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioOpenOrderMarginEstimate &&
        status == other.status &&
        amountUsd == other.amountUsd &&
        orderCount == other.orderCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, amountUsd.hashCode);
    _$hash = $jc(_$hash, orderCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioOpenOrderMarginEstimate')
          ..add('status', status)
          ..add('amountUsd', amountUsd)
          ..add('orderCount', orderCount))
        .toString();
  }
}

class PortfolioOpenOrderMarginEstimateBuilder
    implements
        Builder<PortfolioOpenOrderMarginEstimate,
            PortfolioOpenOrderMarginEstimateBuilder> {
  _$PortfolioOpenOrderMarginEstimate? _$v;

  PortfolioOpenOrderMarginEstimateStatusEnum? _status;
  PortfolioOpenOrderMarginEstimateStatusEnum? get status => _$this._status;
  set status(PortfolioOpenOrderMarginEstimateStatusEnum? status) =>
      _$this._status = status;

  String? _amountUsd;
  String? get amountUsd => _$this._amountUsd;
  set amountUsd(String? amountUsd) => _$this._amountUsd = amountUsd;

  int? _orderCount;
  int? get orderCount => _$this._orderCount;
  set orderCount(int? orderCount) => _$this._orderCount = orderCount;

  PortfolioOpenOrderMarginEstimateBuilder() {
    PortfolioOpenOrderMarginEstimate._defaults(this);
  }

  PortfolioOpenOrderMarginEstimateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _amountUsd = $v.amountUsd;
      _orderCount = $v.orderCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioOpenOrderMarginEstimate other) {
    _$v = other as _$PortfolioOpenOrderMarginEstimate;
  }

  @override
  void update(void Function(PortfolioOpenOrderMarginEstimateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioOpenOrderMarginEstimate build() => _build();

  _$PortfolioOpenOrderMarginEstimate _build() {
    final _$result = _$v ??
        _$PortfolioOpenOrderMarginEstimate._(
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'PortfolioOpenOrderMarginEstimate', 'status'),
          amountUsd: amountUsd,
          orderCount: orderCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
