//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_cross_liquidation_impact.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_collateral_risk_preview.g.dart';

/// 复用订单 Cross 强平估算，对同 USDC 抵押的所有 Cross 仓位模拟资金变化（包含 native 与其他 DEX）。 不会自动补充逐仓保证金。假定仓位及市场不变，结果仅为估算。 转入正数按最低预计到账额，到账后才生效；转出负数按 HL 总扣减額（包含从 HL 收取的费用）。 available + 空列表才表示没有受影响仓位；partial 表示部分仓位缺少价格/计算证据；unavailable 表示无法观察或估算。 valid_until 过期后应刷新，不能沿用资金会话的 24 小时有效期。 
///
/// Properties:
/// * [status] 
/// * [collateralAsset] 
/// * [sharedMarginDelta] - 十进制字符串，避免浮点误差
/// * [observedAt] 
/// * [validUntil] 
/// * [crossLiquidationImpacts] 
/// * [unavailableReason] 
@BuiltValue()
abstract class Hip3CollateralRiskPreview implements Built<Hip3CollateralRiskPreview, Hip3CollateralRiskPreviewBuilder> {
  @BuiltValueField(wireName: r'status')
  Hip3CollateralRiskPreviewStatusEnum get status;
  // enum statusEnum {  available,  partial,  unavailable,  };

  @BuiltValueField(wireName: r'collateral_asset')
  Hip3CollateralRiskPreviewCollateralAssetEnum get collateralAsset;
  // enum collateralAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'shared_margin_delta')
  String get sharedMarginDelta;

  @BuiltValueField(wireName: r'observed_at')
  DateTime? get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime? get validUntil;

  @BuiltValueField(wireName: r'cross_liquidation_impacts')
  BuiltList<Hip3CrossLiquidationImpact> get crossLiquidationImpacts;

  @BuiltValueField(wireName: r'unavailable_reason')
  Hip3CollateralRiskPreviewUnavailableReasonEnum? get unavailableReason;
  // enum unavailableReasonEnum {  liquidation_observation_unavailable,  liquidation_observation_expired,  liquidation_calculation_unavailable,  unsupported_account_mode,  funding_estimate_expired,  };

  Hip3CollateralRiskPreview._();

  factory Hip3CollateralRiskPreview([void updates(Hip3CollateralRiskPreviewBuilder b)]) = _$Hip3CollateralRiskPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3CollateralRiskPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3CollateralRiskPreview> get serializer => _$Hip3CollateralRiskPreviewSerializer();
}

class _$Hip3CollateralRiskPreviewSerializer implements PrimitiveSerializer<Hip3CollateralRiskPreview> {
  @override
  final Iterable<Type> types = const [Hip3CollateralRiskPreview, _$Hip3CollateralRiskPreview];

  @override
  final String wireName = r'Hip3CollateralRiskPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3CollateralRiskPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3CollateralRiskPreviewStatusEnum),
    );
    yield r'collateral_asset';
    yield serializers.serialize(
      object.collateralAsset,
      specifiedType: const FullType(Hip3CollateralRiskPreviewCollateralAssetEnum),
    );
    yield r'shared_margin_delta';
    yield serializers.serialize(
      object.sharedMarginDelta,
      specifiedType: const FullType(String),
    );
    yield r'observed_at';
    yield object.observedAt == null ? null : serializers.serialize(
      object.observedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'valid_until';
    yield object.validUntil == null ? null : serializers.serialize(
      object.validUntil,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'cross_liquidation_impacts';
    yield serializers.serialize(
      object.crossLiquidationImpacts,
      specifiedType: const FullType(BuiltList, [FullType(Hip3CrossLiquidationImpact)]),
    );
    yield r'unavailable_reason';
    yield object.unavailableReason == null ? null : serializers.serialize(
      object.unavailableReason,
      specifiedType: const FullType.nullable(Hip3CollateralRiskPreviewUnavailableReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3CollateralRiskPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3CollateralRiskPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CollateralRiskPreviewStatusEnum),
          ) as Hip3CollateralRiskPreviewStatusEnum;
          result.status = valueDes;
          break;
        case r'collateral_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CollateralRiskPreviewCollateralAssetEnum),
          ) as Hip3CollateralRiskPreviewCollateralAssetEnum;
          result.collateralAsset = valueDes;
          break;
        case r'shared_margin_delta':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sharedMarginDelta = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.observedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        case r'cross_liquidation_impacts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3CrossLiquidationImpact)]),
          ) as BuiltList<Hip3CrossLiquidationImpact>;
          result.crossLiquidationImpacts.replace(valueDes);
          break;
        case r'unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3CollateralRiskPreviewUnavailableReasonEnum),
          ) as Hip3CollateralRiskPreviewUnavailableReasonEnum?;
          if (valueDes == null) continue;
          result.unavailableReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3CollateralRiskPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3CollateralRiskPreviewBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class Hip3CollateralRiskPreviewStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const Hip3CollateralRiskPreviewStatusEnum available = _$hip3CollateralRiskPreviewStatusEnum_available;
  @BuiltValueEnumConst(wireName: r'partial')
  static const Hip3CollateralRiskPreviewStatusEnum partial = _$hip3CollateralRiskPreviewStatusEnum_partial;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const Hip3CollateralRiskPreviewStatusEnum unavailable = _$hip3CollateralRiskPreviewStatusEnum_unavailable;

  static Serializer<Hip3CollateralRiskPreviewStatusEnum> get serializer => _$hip3CollateralRiskPreviewStatusEnumSerializer;

  const Hip3CollateralRiskPreviewStatusEnum._(String name): super(name);

  static BuiltSet<Hip3CollateralRiskPreviewStatusEnum> get values => _$hip3CollateralRiskPreviewStatusEnumValues;
  static Hip3CollateralRiskPreviewStatusEnum valueOf(String name) => _$hip3CollateralRiskPreviewStatusEnumValueOf(name);
}

class Hip3CollateralRiskPreviewCollateralAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3CollateralRiskPreviewCollateralAssetEnum USDC = _$hip3CollateralRiskPreviewCollateralAssetEnum_USDC;

  static Serializer<Hip3CollateralRiskPreviewCollateralAssetEnum> get serializer => _$hip3CollateralRiskPreviewCollateralAssetEnumSerializer;

  const Hip3CollateralRiskPreviewCollateralAssetEnum._(String name): super(name);

  static BuiltSet<Hip3CollateralRiskPreviewCollateralAssetEnum> get values => _$hip3CollateralRiskPreviewCollateralAssetEnumValues;
  static Hip3CollateralRiskPreviewCollateralAssetEnum valueOf(String name) => _$hip3CollateralRiskPreviewCollateralAssetEnumValueOf(name);
}

class Hip3CollateralRiskPreviewUnavailableReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'liquidation_observation_unavailable')
  static const Hip3CollateralRiskPreviewUnavailableReasonEnum liquidationObservationUnavailable = _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationUnavailable;
  @BuiltValueEnumConst(wireName: r'liquidation_observation_expired')
  static const Hip3CollateralRiskPreviewUnavailableReasonEnum liquidationObservationExpired = _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationObservationExpired;
  @BuiltValueEnumConst(wireName: r'liquidation_calculation_unavailable')
  static const Hip3CollateralRiskPreviewUnavailableReasonEnum liquidationCalculationUnavailable = _$hip3CollateralRiskPreviewUnavailableReasonEnum_liquidationCalculationUnavailable;
  @BuiltValueEnumConst(wireName: r'unsupported_account_mode')
  static const Hip3CollateralRiskPreviewUnavailableReasonEnum unsupportedAccountMode = _$hip3CollateralRiskPreviewUnavailableReasonEnum_unsupportedAccountMode;
  @BuiltValueEnumConst(wireName: r'funding_estimate_expired')
  static const Hip3CollateralRiskPreviewUnavailableReasonEnum fundingEstimateExpired = _$hip3CollateralRiskPreviewUnavailableReasonEnum_fundingEstimateExpired;

  static Serializer<Hip3CollateralRiskPreviewUnavailableReasonEnum> get serializer => _$hip3CollateralRiskPreviewUnavailableReasonEnumSerializer;

  const Hip3CollateralRiskPreviewUnavailableReasonEnum._(String name): super(name);

  static BuiltSet<Hip3CollateralRiskPreviewUnavailableReasonEnum> get values => _$hip3CollateralRiskPreviewUnavailableReasonEnumValues;
  static Hip3CollateralRiskPreviewUnavailableReasonEnum valueOf(String name) => _$hip3CollateralRiskPreviewUnavailableReasonEnumValueOf(name);
}

