//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_open_order_margin_estimate.g.dart';

/// PortfolioOpenOrderMarginEstimate
///
/// Properties:
/// * [status] 
/// * [amountUsd] - 所有未成交、非 reduceOnly Perps 开仓单的估算保证金合计：Σ(剩余数量 × 委托价 ÷ 当前杠杆)。 这是估算值，不是 Hyperliquid 返回的逐单占用保证金；任一必要来源不可用时返回 null。 
/// * [orderCount] 
@BuiltValue()
abstract class PortfolioOpenOrderMarginEstimate implements Built<PortfolioOpenOrderMarginEstimate, PortfolioOpenOrderMarginEstimateBuilder> {
  @BuiltValueField(wireName: r'status')
  PortfolioOpenOrderMarginEstimateStatusEnum get status;
  // enum statusEnum {  available,  unavailable,  };

  /// 所有未成交、非 reduceOnly Perps 开仓单的估算保证金合计：Σ(剩余数量 × 委托价 ÷ 当前杠杆)。 这是估算值，不是 Hyperliquid 返回的逐单占用保证金；任一必要来源不可用时返回 null。 
  @BuiltValueField(wireName: r'amount_usd')
  String? get amountUsd;

  @BuiltValueField(wireName: r'order_count')
  int? get orderCount;

  PortfolioOpenOrderMarginEstimate._();

  factory PortfolioOpenOrderMarginEstimate([void updates(PortfolioOpenOrderMarginEstimateBuilder b)]) = _$PortfolioOpenOrderMarginEstimate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioOpenOrderMarginEstimateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioOpenOrderMarginEstimate> get serializer => _$PortfolioOpenOrderMarginEstimateSerializer();
}

class _$PortfolioOpenOrderMarginEstimateSerializer implements PrimitiveSerializer<PortfolioOpenOrderMarginEstimate> {
  @override
  final Iterable<Type> types = const [PortfolioOpenOrderMarginEstimate, _$PortfolioOpenOrderMarginEstimate];

  @override
  final String wireName = r'PortfolioOpenOrderMarginEstimate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioOpenOrderMarginEstimate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioOpenOrderMarginEstimateStatusEnum),
    );
    yield r'amount_usd';
    yield object.amountUsd == null ? null : serializers.serialize(
      object.amountUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'order_count';
    yield object.orderCount == null ? null : serializers.serialize(
      object.orderCount,
      specifiedType: const FullType.nullable(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioOpenOrderMarginEstimate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioOpenOrderMarginEstimateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioOpenOrderMarginEstimateStatusEnum),
          ) as PortfolioOpenOrderMarginEstimateStatusEnum;
          result.status = valueDes;
          break;
        case r'amount_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amountUsd = valueDes;
          break;
        case r'order_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.orderCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioOpenOrderMarginEstimate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioOpenOrderMarginEstimateBuilder();
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

class PortfolioOpenOrderMarginEstimateStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const PortfolioOpenOrderMarginEstimateStatusEnum available = _$portfolioOpenOrderMarginEstimateStatusEnum_available;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioOpenOrderMarginEstimateStatusEnum unavailable = _$portfolioOpenOrderMarginEstimateStatusEnum_unavailable;

  static Serializer<PortfolioOpenOrderMarginEstimateStatusEnum> get serializer => _$portfolioOpenOrderMarginEstimateStatusEnumSerializer;

  const PortfolioOpenOrderMarginEstimateStatusEnum._(String name): super(name);

  static BuiltSet<PortfolioOpenOrderMarginEstimateStatusEnum> get values => _$portfolioOpenOrderMarginEstimateStatusEnumValues;
  static PortfolioOpenOrderMarginEstimateStatusEnum valueOf(String name) => _$portfolioOpenOrderMarginEstimateStatusEnumValueOf(name);
}

