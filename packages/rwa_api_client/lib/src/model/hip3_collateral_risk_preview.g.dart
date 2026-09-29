// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_collateral_risk_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3CollateralRiskPreviewStatusEnum
    _$hip3CollateralRiskPreviewStatusEnum_available =
    const Hip3CollateralRiskPreviewStatusEnum._('available');
const Hip3CollateralRiskPreviewStatusEnum
    _$hip3CollateralRiskPreviewStatusEnum_partial =
    const Hip3CollateralRiskPreviewStatusEnum._('partial');
const Hip3CollateralRiskPreviewStatusEnum
    _$hip3CollateralRiskPreviewStatusEnum_unavailable =
    const Hip3CollateralRiskPreviewStatusEnum._('unavailable');

Hip3CollateralRiskPreviewStatusEnum
    _$hip3CollateralRiskPreviewStatusEnumValueOf(String name) {
  switch (name) {
    case 'available':
      return _$hip3CollateralRiskPreviewStatusEnum_available;
    case 'partial':
      return _$hip3CollateralRiskPreviewStatusEnum_partial;
    case 'unavailable':
      return _$hip3CollateralRiskPreviewStatusEnum_unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3CollateralRiskPreviewStatusEnum>
    _$hip3CollateralRiskPreviewStatusEnumValues = BuiltSet<
        Hip3CollateralRiskPreviewStatusEnum>(const <Hip3CollateralRiskPreviewStatusEnum>[
  _$hip3CollateralRiskPreviewStatusEnum_available,
  _$hip3CollateralRiskPreviewStatusEnum_partial,
  _$hip3CollateralRiskPreviewStatusEnum_unavailable,
]);

const Hip3CollateralRiskPreviewCollateralAssetEnum
    _$hip3CollateralRiskPreviewCollateralAssetEnum_USDC =
    const Hip3CollateralRiskPreviewCollateralAssetEnum._('USDC');

Hip3CollateralRiskPreviewCollateralAssetEnum
    _$hip3CollateralRiskPreviewCollateralAssetEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$hip3CollateralRiskPreviewCollateralAssetEnum_USDC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3CollateralRiskPreviewCollateralAssetEnum>
    _$hip3CollateralRiskPreviewCollateralAssetEnumValues = BuiltSet<
        Hip3CollateralRiskPreviewCollateralAssetEnum>(const <Hip3CollateralRiskPreviewCollateralAssetEnum>[
  _$hip3CollateralRiskPreviewCollateralAssetEnum_USDC,
]);

const Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationUnavailable =
    const Hip3CollateralRiskPreviewUnavailableReasonEnum._(
        'liquidationObservationUnavailable');
const Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationExpired =
    const Hip3CollateralRiskPreviewUnavailableReasonEnum._(
        'liquidationObservationExpired');
const Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationCalculationUnavailable =
    const Hip3CollateralRiskPreviewUnavailableReasonEnum._(
        'liquidationCalculationUnavailable');
const Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnum_unsupportedAccountMode =
    const Hip3CollateralRiskPreviewUnavailableReasonEnum._(
        'unsupportedAccountMode');
const Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnum_fundingEstimateExpired =
    const Hip3CollateralRiskPreviewUnavailableReasonEnum._(
        'fundingEstimateExpired');

Hip3CollateralRiskPreviewUnavailableReasonEnum
    _$hip3CollateralRiskPreviewUnavailableReasonEnumValueOf(String name) {
  switch (name) {
    case 'liquidationObservationUnavailable':
      return _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationUnavailable;
    case 'liquidationObservationExpired':
      return _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationExpired;
    case 'liquidationCalculationUnavailable':
      return _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationCalculationUnavailable;
    case 'unsupportedAccountMode':
      return _$hip3CollateralRiskPreviewUnavailableReasonEnum_unsupportedAccountMode;
    case 'fundingEstimateExpired':
      return _$hip3CollateralRiskPreviewUnavailableReasonEnum_fundingEstimateExpired;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3CollateralRiskPreviewUnavailableReasonEnum>
    _$hip3CollateralRiskPreviewUnavailableReasonEnumValues = BuiltSet<
        Hip3CollateralRiskPreviewUnavailableReasonEnum>(const <Hip3CollateralRiskPreviewUnavailableReasonEnum>[
  _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationUnavailable,
  _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationExpired,
  _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationCalculationUnavailable,
  _$hip3CollateralRiskPreviewUnavailableReasonEnum_unsupportedAccountMode,
  _$hip3CollateralRiskPreviewUnavailableReasonEnum_fundingEstimateExpired,
]);

Serializer<Hip3CollateralRiskPreviewStatusEnum>
    _$hip3CollateralRiskPreviewStatusEnumSerializer =
    _$Hip3CollateralRiskPreviewStatusEnumSerializer();
Serializer<Hip3CollateralRiskPreviewCollateralAssetEnum>
    _$hip3CollateralRiskPreviewCollateralAssetEnumSerializer =
    _$Hip3CollateralRiskPreviewCollateralAssetEnumSerializer();
Serializer<Hip3CollateralRiskPreviewUnavailableReasonEnum>
    _$hip3CollateralRiskPreviewUnavailableReasonEnumSerializer =
    _$Hip3CollateralRiskPreviewUnavailableReasonEnumSerializer();

class _$Hip3CollateralRiskPreviewStatusEnumSerializer
    implements PrimitiveSerializer<Hip3CollateralRiskPreviewStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'available': 'available',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CollateralRiskPreviewStatusEnum
  ];
  @override
  final String wireName = 'Hip3CollateralRiskPreviewStatusEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3CollateralRiskPreviewStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CollateralRiskPreviewStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CollateralRiskPreviewStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CollateralRiskPreviewCollateralAssetEnumSerializer
    implements
        PrimitiveSerializer<Hip3CollateralRiskPreviewCollateralAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CollateralRiskPreviewCollateralAssetEnum
  ];
  @override
  final String wireName = 'Hip3CollateralRiskPreviewCollateralAssetEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3CollateralRiskPreviewCollateralAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CollateralRiskPreviewCollateralAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CollateralRiskPreviewCollateralAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CollateralRiskPreviewUnavailableReasonEnumSerializer
    implements
        PrimitiveSerializer<Hip3CollateralRiskPreviewUnavailableReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'liquidationObservationUnavailable': 'liquidation_observation_unavailable',
    'liquidationObservationExpired': 'liquidation_observation_expired',
    'liquidationCalculationUnavailable': 'liquidation_calculation_unavailable',
    'unsupportedAccountMode': 'unsupported_account_mode',
    'fundingEstimateExpired': 'funding_estimate_expired',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'liquidation_observation_unavailable': 'liquidationObservationUnavailable',
    'liquidation_observation_expired': 'liquidationObservationExpired',
    'liquidation_calculation_unavailable': 'liquidationCalculationUnavailable',
    'unsupported_account_mode': 'unsupportedAccountMode',
    'funding_estimate_expired': 'fundingEstimateExpired',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3CollateralRiskPreviewUnavailableReasonEnum
  ];
  @override
  final String wireName = 'Hip3CollateralRiskPreviewUnavailableReasonEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3CollateralRiskPreviewUnavailableReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3CollateralRiskPreviewUnavailableReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3CollateralRiskPreviewUnavailableReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3CollateralRiskPreview extends Hip3CollateralRiskPreview {
  @override
  final Hip3CollateralRiskPreviewStatusEnum status;
  @override
  final Hip3CollateralRiskPreviewCollateralAssetEnum collateralAsset;
  @override
  final String sharedMarginDelta;
  @override
  final DateTime? observedAt;
  @override
  final DateTime? validUntil;
  @override
  final BuiltList<Hip3CrossLiquidationImpact> crossLiquidationImpacts;
  @override
  final Hip3CollateralRiskPreviewUnavailableReasonEnum? unavailableReason;

  factory _$Hip3CollateralRiskPreview(
          [void Function(Hip3CollateralRiskPreviewBuilder)? updates]) =>
      (Hip3CollateralRiskPreviewBuilder()..update(updates))._build();

  _$Hip3CollateralRiskPreview._(
      {required this.status,
      required this.collateralAsset,
      required this.sharedMarginDelta,
      this.observedAt,
      this.validUntil,
      required this.crossLiquidationImpacts,
      this.unavailableReason})
      : super._();
  @override
  Hip3CollateralRiskPreview rebuild(
          void Function(Hip3CollateralRiskPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3CollateralRiskPreviewBuilder toBuilder() =>
      Hip3CollateralRiskPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3CollateralRiskPreview &&
        status == other.status &&
        collateralAsset == other.collateralAsset &&
        sharedMarginDelta == other.sharedMarginDelta &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil &&
        crossLiquidationImpacts == other.crossLiquidationImpacts &&
        unavailableReason == other.unavailableReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, collateralAsset.hashCode);
    _$hash = $jc(_$hash, sharedMarginDelta.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, crossLiquidationImpacts.hashCode);
    _$hash = $jc(_$hash, unavailableReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3CollateralRiskPreview')
          ..add('status', status)
          ..add('collateralAsset', collateralAsset)
          ..add('sharedMarginDelta', sharedMarginDelta)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil)
          ..add('crossLiquidationImpacts', crossLiquidationImpacts)
          ..add('unavailableReason', unavailableReason))
        .toString();
  }
}

class Hip3CollateralRiskPreviewBuilder
    implements
        Builder<Hip3CollateralRiskPreview, Hip3CollateralRiskPreviewBuilder> {
  _$Hip3CollateralRiskPreview? _$v;

  Hip3CollateralRiskPreviewStatusEnum? _status;
  Hip3CollateralRiskPreviewStatusEnum? get status => _$this._status;
  set status(Hip3CollateralRiskPreviewStatusEnum? status) =>
      _$this._status = status;

  Hip3CollateralRiskPreviewCollateralAssetEnum? _collateralAsset;
  Hip3CollateralRiskPreviewCollateralAssetEnum? get collateralAsset =>
      _$this._collateralAsset;
  set collateralAsset(
          Hip3CollateralRiskPreviewCollateralAssetEnum? collateralAsset) =>
      _$this._collateralAsset = collateralAsset;

  String? _sharedMarginDelta;
  String? get sharedMarginDelta => _$this._sharedMarginDelta;
  set sharedMarginDelta(String? sharedMarginDelta) =>
      _$this._sharedMarginDelta = sharedMarginDelta;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  ListBuilder<Hip3CrossLiquidationImpact>? _crossLiquidationImpacts;
  ListBuilder<Hip3CrossLiquidationImpact> get crossLiquidationImpacts =>
      _$this._crossLiquidationImpacts ??=
          ListBuilder<Hip3CrossLiquidationImpact>();
  set crossLiquidationImpacts(
          ListBuilder<Hip3CrossLiquidationImpact>? crossLiquidationImpacts) =>
      _$this._crossLiquidationImpacts = crossLiquidationImpacts;

  Hip3CollateralRiskPreviewUnavailableReasonEnum? _unavailableReason;
  Hip3CollateralRiskPreviewUnavailableReasonEnum? get unavailableReason =>
      _$this._unavailableReason;
  set unavailableReason(
          Hip3CollateralRiskPreviewUnavailableReasonEnum? unavailableReason) =>
      _$this._unavailableReason = unavailableReason;

  Hip3CollateralRiskPreviewBuilder() {
    Hip3CollateralRiskPreview._defaults(this);
  }

  Hip3CollateralRiskPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _collateralAsset = $v.collateralAsset;
      _sharedMarginDelta = $v.sharedMarginDelta;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _crossLiquidationImpacts = $v.crossLiquidationImpacts.toBuilder();
      _unavailableReason = $v.unavailableReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3CollateralRiskPreview other) {
    _$v = other as _$Hip3CollateralRiskPreview;
  }

  @override
  void update(void Function(Hip3CollateralRiskPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3CollateralRiskPreview build() => _build();

  _$Hip3CollateralRiskPreview _build() {
    _$Hip3CollateralRiskPreview _$result;
    try {
      _$result = _$v ??
          _$Hip3CollateralRiskPreview._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'Hip3CollateralRiskPreview', 'status'),
            collateralAsset: BuiltValueNullFieldError.checkNotNull(
                collateralAsset,
                r'Hip3CollateralRiskPreview',
                'collateralAsset'),
            sharedMarginDelta: BuiltValueNullFieldError.checkNotNull(
                sharedMarginDelta,
                r'Hip3CollateralRiskPreview',
                'sharedMarginDelta'),
            observedAt: observedAt,
            validUntil: validUntil,
            crossLiquidationImpacts: crossLiquidationImpacts.build(),
            unavailableReason: unavailableReason,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'crossLiquidationImpacts';
        crossLiquidationImpacts.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Hip3CollateralRiskPreview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
