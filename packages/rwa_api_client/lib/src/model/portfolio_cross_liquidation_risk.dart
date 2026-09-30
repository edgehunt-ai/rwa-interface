//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_cross_liquidation_risk.g.dart';

/// PortfolioCrossLiquidationRisk
///
/// Properties:
/// * [status] 
/// * [closestDistancePercent] - 距离最近的 Cross 仓位强平价与标记价的百分比差；多空分别按强平方向计算。
/// * [crossPositionCount] 
@BuiltValue()
abstract class PortfolioCrossLiquidationRisk implements Built<PortfolioCrossLiquidationRisk, PortfolioCrossLiquidationRiskBuilder> {
  @BuiltValueField(wireName: r'status')
  PortfolioCrossLiquidationRiskStatusEnum get status;
  // enum statusEnum {  available,  partial,  unavailable,  safe,  liquidation_risk,  high_liquidation_risk,  };

  /// 距离最近的 Cross 仓位强平价与标记价的百分比差；多空分别按强平方向计算。
  @BuiltValueField(wireName: r'closest_distance_percent')
  String? get closestDistancePercent;

  @BuiltValueField(wireName: r'cross_position_count')
  int? get crossPositionCount;

  PortfolioCrossLiquidationRisk._();

  factory PortfolioCrossLiquidationRisk([void updates(PortfolioCrossLiquidationRiskBuilder b)]) = _$PortfolioCrossLiquidationRisk;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioCrossLiquidationRiskBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioCrossLiquidationRisk> get serializer => _$PortfolioCrossLiquidationRiskSerializer();
}

class _$PortfolioCrossLiquidationRiskSerializer implements PrimitiveSerializer<PortfolioCrossLiquidationRisk> {
  @override
  final Iterable<Type> types = const [PortfolioCrossLiquidationRisk, _$PortfolioCrossLiquidationRisk];

  @override
  final String wireName = r'PortfolioCrossLiquidationRisk';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioCrossLiquidationRisk object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioCrossLiquidationRiskStatusEnum),
    );
    yield r'closest_distance_percent';
    yield object.closestDistancePercent == null ? null : serializers.serialize(
      object.closestDistancePercent,
      specifiedType: const FullType.nullable(String),
    );
    if (object.crossPositionCount != null) {
      yield r'cross_position_count';
      yield serializers.serialize(
        object.crossPositionCount,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioCrossLiquidationRisk object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioCrossLiquidationRiskBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioCrossLiquidationRiskStatusEnum),
          ) as PortfolioCrossLiquidationRiskStatusEnum;
          result.status = valueDes;
          break;
        case r'closest_distance_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.closestDistancePercent = valueDes;
          break;
        case r'cross_position_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.crossPositionCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioCrossLiquidationRisk deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioCrossLiquidationRiskBuilder();
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

class PortfolioCrossLiquidationRiskStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const PortfolioCrossLiquidationRiskStatusEnum available = _$portfolioCrossLiquidationRiskStatusEnum_available;
  @BuiltValueEnumConst(wireName: r'partial')
  static const PortfolioCrossLiquidationRiskStatusEnum partial = _$portfolioCrossLiquidationRiskStatusEnum_partial;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioCrossLiquidationRiskStatusEnum unavailable = _$portfolioCrossLiquidationRiskStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'safe')
  static const PortfolioCrossLiquidationRiskStatusEnum safe = _$portfolioCrossLiquidationRiskStatusEnum_safe;
  @BuiltValueEnumConst(wireName: r'liquidation_risk')
  static const PortfolioCrossLiquidationRiskStatusEnum liquidationRisk = _$portfolioCrossLiquidationRiskStatusEnum_liquidationRisk;
  @BuiltValueEnumConst(wireName: r'high_liquidation_risk')
  static const PortfolioCrossLiquidationRiskStatusEnum highLiquidationRisk = _$portfolioCrossLiquidationRiskStatusEnum_highLiquidationRisk;

  static Serializer<PortfolioCrossLiquidationRiskStatusEnum> get serializer => _$portfolioCrossLiquidationRiskStatusEnumSerializer;

  const PortfolioCrossLiquidationRiskStatusEnum._(String name): super(name);

  static BuiltSet<PortfolioCrossLiquidationRiskStatusEnum> get values => _$portfolioCrossLiquidationRiskStatusEnumValues;
  static PortfolioCrossLiquidationRiskStatusEnum valueOf(String name) => _$portfolioCrossLiquidationRiskStatusEnumValueOf(name);
}

