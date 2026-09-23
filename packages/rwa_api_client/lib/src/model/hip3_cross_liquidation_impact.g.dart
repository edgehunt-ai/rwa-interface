// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_cross_liquidation_impact.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3CrossLiquidationImpactSideEnum
    _$hip3CrossLiquidationImpactSideEnum_long =
    const Hip3CrossLiquidationImpactSideEnum._('long');
const Hip3CrossLiquidationImpactSideEnum
    _$hip3CrossLiquidationImpactSideEnum_short =
    const Hip3CrossLiquidationImpactSideEnum._('short');
const Hip3CrossLiquidationImpactSideEnum
    _$hip3CrossLiquidationImpactSideEnum_unknownDefaultOpenApi =
    const Hip3CrossLiquidationImpactSideEnum._('unknownDefaultOpenApi');

Hip3CrossLiquidationImpactSideEnum _$hip3CrossLiquidationImpactSideEnumValueOf(
    String name) {
  switch (name) {
    case 'long':
      return _$hip3CrossLiquidationImpactSideEnum_long;
    case 'short':
      return _$hip3CrossLiquidationImpactSideEnum_short;
    case 'unknownDefaultOpenApi':
      return _$hip3CrossLiquidationImpactSideEnum_unknownDefaultOpenApi;
    default:
      return _$hip3CrossLiquidationImpactSideEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3CrossLiquidationImpactSideEnum>
    _$hip3CrossLiquidationImpactSideEnumValues = BuiltSet<
        Hip3CrossLiquidationImpactSideEnum>(const <Hip3CrossLiquidationImpactSideEnum>[
  _$hip3CrossLiquidationImpactSideEnum_long,
  _$hip3CrossLiquidationImpactSideEnum_short,
  _$hip3CrossLiquidationImpactSideEnum_unknownDefaultOpenApi,
]);

const Hip3CrossLiquidationImpactUnavailableReasonEnum
    _$hip3CrossLiquidationImpactUnavailableReasonEnum_currentLiquidationPriceUnavailable =
    const Hip3CrossLiquidationImpactUnavailableReasonEnum._(
        'currentLiquidationPriceUnavailable');
const Hip3CrossLiquidationImpactUnavailableReasonEnum
    _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationCalculationUnavailable =
    const Hip3CrossLiquidationImpactUnavailableReasonEnum._(
        'liquidationCalculationUnavailable');
const Hip3CrossLiquidationImpactUnavailableReasonEnum
    _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationPriceOutOfRange =
    const Hip3CrossLiquidationImpactUnavailableReasonEnum._(
        'liquidationPriceOutOfRange');
const Hip3CrossLiquidationImpactUnavailableReasonEnum
    _$hip3CrossLiquidationImpactUnavailableReasonEnum_unknownDefaultOpenApi =
    const Hip3CrossLiquidationImpactUnavailableReasonEnum._(
        'unknownDefaultOpenApi');

Hip3CrossLiquidationImpactUnavailableReasonEnum
    _$hip3CrossLiquidationImpactUnavailableReasonEnumValueOf(String name) {
  switch (name) {
    case 'currentLiquidationPriceUnavailable':
      return _$hip3CrossLiquidationImpactUnavailableReasonEnum_currentLiquidationPriceUnavailable;
    case 'liquidationCalculationUnavailable':
      return _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationCalculationUnavailable;
    case 'liquidationPriceOutOfRange':
      return _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationPriceOutOfRange;
    case 'unknownDefaultOpenApi':
      return _$hip3CrossLiquidationImpactUnavailableReasonEnum_unknownDefaultOpenApi;
    default:
      return _$hip3CrossLiquidationImpactUnavailableReasonEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3CrossLiquidationImpactUnavailableReasonEnum>
    _$hip3CrossLiquidationImpactUnavailableReasonEnumValues = BuiltSet<
        Hip3CrossLiquidationImpactUnavailableReasonEnum>(const <Hip3CrossLiquidationImpactUnavailableReasonEnum>[
  _$hip3CrossLiquidationImpactUnavailableReasonEnum_currentLiquidationPriceUnavailable,
  _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationCalculationUnavailable,
  _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationPriceOutOfRange,
  _$hip3CrossLiquidationImpactUnavailableReasonEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3CrossLiquidationImpactSideEnum>
    _$hip3CrossLiquidationImpactSideEnumSerializer =
    _$Hip3CrossLiquidationImpactSideEnumSerializer();
Serializer<Hip3CrossLiquidationImpactUnavailableReasonEnum>
    _$hip3CrossLiquidationImpactUnavailableReasonEnumSerializer =
    _$Hip3CrossLiquidationImpactUnavailableReasonEnumSerializer();

class _$Hip3CrossLiquidationImpactSideEnumSerializer
    implements PrimitiveSerializer<Hip3CrossLiquidationImpactSideEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'long': 'long',
    'short': 'short',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'long': 'long',
    'short': 'short',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[Hip3CrossLiquidationImpactSideEnum];
  @override
  final String wireName = 'Hip3CrossLiquidationImpactSideEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3CrossLiquidationImpactSideEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CrossLiquidationImpactSideEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CrossLiquidationImpactSideEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CrossLiquidationImpactUnavailableReasonEnumSerializer
    implements
        PrimitiveSerializer<Hip3CrossLiquidationImpactUnavailableReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'currentLiquidationPriceUnavailable':
        'current_liquidation_price_unavailable',
    'liquidationCalculationUnavailable': 'liquidation_calculation_unavailable',
    'liquidationPriceOutOfRange': 'liquidation_price_out_of_range',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'current_liquidation_price_unavailable':
        'currentLiquidationPriceUnavailable',
    'liquidation_calculation_unavailable': 'liquidationCalculationUnavailable',
    'liquidation_price_out_of_range': 'liquidationPriceOutOfRange',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CrossLiquidationImpactUnavailableReasonEnum
  ];
  @override
  final String wireName = 'Hip3CrossLiquidationImpactUnavailableReasonEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3CrossLiquidationImpactUnavailableReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CrossLiquidationImpactUnavailableReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CrossLiquidationImpactUnavailableReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CrossLiquidationImpact extends Hip3CrossLiquidationImpact {
  @override
  final String productId;
  @override
  final Hip3CrossLiquidationImpactSideEnum side;
  @override
  final String? beforeLiquidationPrice;
  @override
  final String? afterLiquidationPrice;
  @override
  final Hip3CrossLiquidationImpactUnavailableReasonEnum? unavailableReason;

  factory _$Hip3CrossLiquidationImpact(
          [void Function(Hip3CrossLiquidationImpactBuilder)? updates]) =>
      (Hip3CrossLiquidationImpactBuilder()..update(updates))._build();

  _$Hip3CrossLiquidationImpact._(
      {required this.productId,
      required this.side,
      this.beforeLiquidationPrice,
      this.afterLiquidationPrice,
      this.unavailableReason})
      : super._();
  @override
  Hip3CrossLiquidationImpact rebuild(
          void Function(Hip3CrossLiquidationImpactBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3CrossLiquidationImpactBuilder toBuilder() =>
      Hip3CrossLiquidationImpactBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3CrossLiquidationImpact &&
        productId == other.productId &&
        side == other.side &&
        beforeLiquidationPrice == other.beforeLiquidationPrice &&
        afterLiquidationPrice == other.afterLiquidationPrice &&
        unavailableReason == other.unavailableReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, side.hashCode);
    _$hash = $jc(_$hash, beforeLiquidationPrice.hashCode);
    _$hash = $jc(_$hash, afterLiquidationPrice.hashCode);
    _$hash = $jc(_$hash, unavailableReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3CrossLiquidationImpact')
          ..add('productId', productId)
          ..add('side', side)
          ..add('beforeLiquidationPrice', beforeLiquidationPrice)
          ..add('afterLiquidationPrice', afterLiquidationPrice)
          ..add('unavailableReason', unavailableReason))
        .toString();
  }
}

class Hip3CrossLiquidationImpactBuilder
    implements
        Builder<Hip3CrossLiquidationImpact, Hip3CrossLiquidationImpactBuilder> {
  _$Hip3CrossLiquidationImpact? _$v;

  String? _productId;
  String? get productId => _$this._productId;
  set productId(String? productId) => _$this._productId = productId;

  Hip3CrossLiquidationImpactSideEnum? _side;
  Hip3CrossLiquidationImpactSideEnum? get side => _$this._side;
  set side(Hip3CrossLiquidationImpactSideEnum? side) => _$this._side = side;

  String? _beforeLiquidationPrice;
  String? get beforeLiquidationPrice => _$this._beforeLiquidationPrice;
  set beforeLiquidationPrice(String? beforeLiquidationPrice) =>
      _$this._beforeLiquidationPrice = beforeLiquidationPrice;

  String? _afterLiquidationPrice;
  String? get afterLiquidationPrice => _$this._afterLiquidationPrice;
  set afterLiquidationPrice(String? afterLiquidationPrice) =>
      _$this._afterLiquidationPrice = afterLiquidationPrice;

  Hip3CrossLiquidationImpactUnavailableReasonEnum? _unavailableReason;
  Hip3CrossLiquidationImpactUnavailableReasonEnum? get unavailableReason =>
      _$this._unavailableReason;
  set unavailableReason(
          Hip3CrossLiquidationImpactUnavailableReasonEnum? unavailableReason) =>
      _$this._unavailableReason = unavailableReason;

  Hip3CrossLiquidationImpactBuilder() {
    Hip3CrossLiquidationImpact._defaults(this);
  }

  Hip3CrossLiquidationImpactBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _side = $v.side;
      _beforeLiquidationPrice = $v.beforeLiquidationPrice;
      _afterLiquidationPrice = $v.afterLiquidationPrice;
      _unavailableReason = $v.unavailableReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3CrossLiquidationImpact other) {
    _$v = other as _$Hip3CrossLiquidationImpact;
  }

  @override
  void update(void Function(Hip3CrossLiquidationImpactBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3CrossLiquidationImpact build() => _build();

  _$Hip3CrossLiquidationImpact _build() {
    final _$result = _$v ??
        _$Hip3CrossLiquidationImpact._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'Hip3CrossLiquidationImpact', 'productId'),
          side: BuiltValueNullFieldError.checkNotNull(
              side, r'Hip3CrossLiquidationImpact', 'side'),
          beforeLiquidationPrice: beforeLiquidationPrice,
          afterLiquidationPrice: afterLiquidationPrice,
          unavailableReason: unavailableReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
