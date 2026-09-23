//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_cross_liquidation_impact.g.dart';

/// Hip3CrossLiquidationImpact
///
/// Properties:
/// * [productId] 
/// * [side] 
/// * [beforeLiquidationPrice] - 十进制字符串，避免浮点误差
/// * [afterLiquidationPrice] - 十进制字符串，避免浮点误差
/// * [unavailableReason] 
@BuiltValue()
abstract class Hip3CrossLiquidationImpact implements Built<Hip3CrossLiquidationImpact, Hip3CrossLiquidationImpactBuilder> {
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'side')
  Hip3CrossLiquidationImpactSideEnum get side;
  // enum sideEnum {  long,  short,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'before_liquidation_price')
  String? get beforeLiquidationPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'after_liquidation_price')
  String? get afterLiquidationPrice;

  @BuiltValueField(wireName: r'unavailable_reason')
  Hip3CrossLiquidationImpactUnavailableReasonEnum? get unavailableReason;
  // enum unavailableReasonEnum {  current_liquidation_price_unavailable,  liquidation_calculation_unavailable,  liquidation_price_out_of_range,  };

  Hip3CrossLiquidationImpact._();

  factory Hip3CrossLiquidationImpact([void updates(Hip3CrossLiquidationImpactBuilder b)]) = _$Hip3CrossLiquidationImpact;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3CrossLiquidationImpactBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3CrossLiquidationImpact> get serializer => _$Hip3CrossLiquidationImpactSerializer();
}

class _$Hip3CrossLiquidationImpactSerializer implements PrimitiveSerializer<Hip3CrossLiquidationImpact> {
  @override
  final Iterable<Type> types = const [Hip3CrossLiquidationImpact, _$Hip3CrossLiquidationImpact];

  @override
  final String wireName = r'Hip3CrossLiquidationImpact';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3CrossLiquidationImpact object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(Hip3CrossLiquidationImpactSideEnum),
    );
    yield r'before_liquidation_price';
    yield object.beforeLiquidationPrice == null ? null : serializers.serialize(
      object.beforeLiquidationPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'after_liquidation_price';
    yield object.afterLiquidationPrice == null ? null : serializers.serialize(
      object.afterLiquidationPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'unavailable_reason';
    yield object.unavailableReason == null ? null : serializers.serialize(
      object.unavailableReason,
      specifiedType: const FullType.nullable(Hip3CrossLiquidationImpactUnavailableReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3CrossLiquidationImpact object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3CrossLiquidationImpactBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CrossLiquidationImpactSideEnum),
          ) as Hip3CrossLiquidationImpactSideEnum;
          result.side = valueDes;
          break;
        case r'before_liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.beforeLiquidationPrice = valueDes;
          break;
        case r'after_liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.afterLiquidationPrice = valueDes;
          break;
        case r'unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3CrossLiquidationImpactUnavailableReasonEnum),
          ) as Hip3CrossLiquidationImpactUnavailableReasonEnum?;
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
  Hip3CrossLiquidationImpact deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3CrossLiquidationImpactBuilder();
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

class Hip3CrossLiquidationImpactSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const Hip3CrossLiquidationImpactSideEnum long = _$hip3CrossLiquidationImpactSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const Hip3CrossLiquidationImpactSideEnum short = _$hip3CrossLiquidationImpactSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3CrossLiquidationImpactSideEnum unknownDefaultOpenApi = _$hip3CrossLiquidationImpactSideEnum_unknownDefaultOpenApi;

  static Serializer<Hip3CrossLiquidationImpactSideEnum> get serializer => _$hip3CrossLiquidationImpactSideEnumSerializer;

  const Hip3CrossLiquidationImpactSideEnum._(String name): super(name);

  static BuiltSet<Hip3CrossLiquidationImpactSideEnum> get values => _$hip3CrossLiquidationImpactSideEnumValues;
  static Hip3CrossLiquidationImpactSideEnum valueOf(String name) => _$hip3CrossLiquidationImpactSideEnumValueOf(name);
}

class Hip3CrossLiquidationImpactUnavailableReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'current_liquidation_price_unavailable')
  static const Hip3CrossLiquidationImpactUnavailableReasonEnum currentLiquidationPriceUnavailable = _$hip3CrossLiquidationImpactUnavailableReasonEnum_currentLiquidationPriceUnavailable;
  @BuiltValueEnumConst(wireName: r'liquidation_calculation_unavailable')
  static const Hip3CrossLiquidationImpactUnavailableReasonEnum liquidationCalculationUnavailable = _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationCalculationUnavailable;
  @BuiltValueEnumConst(wireName: r'liquidation_price_out_of_range')
  static const Hip3CrossLiquidationImpactUnavailableReasonEnum liquidationPriceOutOfRange = _$hip3CrossLiquidationImpactUnavailableReasonEnum_liquidationPriceOutOfRange;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3CrossLiquidationImpactUnavailableReasonEnum unknownDefaultOpenApi = _$hip3CrossLiquidationImpactUnavailableReasonEnum_unknownDefaultOpenApi;

  static Serializer<Hip3CrossLiquidationImpactUnavailableReasonEnum> get serializer => _$hip3CrossLiquidationImpactUnavailableReasonEnumSerializer;

  const Hip3CrossLiquidationImpactUnavailableReasonEnum._(String name): super(name);

  static BuiltSet<Hip3CrossLiquidationImpactUnavailableReasonEnum> get values => _$hip3CrossLiquidationImpactUnavailableReasonEnumValues;
  static Hip3CrossLiquidationImpactUnavailableReasonEnum valueOf(String name) => _$hip3CrossLiquidationImpactUnavailableReasonEnumValueOf(name);
}

