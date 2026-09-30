//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_availability_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_allocation_value.g.dart';

/// PortfolioAllocationValue
///
/// Properties:
/// * [status] 
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [unvaluedAssetCount] 
@BuiltValue()
abstract class PortfolioAllocationValue implements Built<PortfolioAllocationValue, PortfolioAllocationValueBuilder> {
  @BuiltValueField(wireName: r'status')
  PortfolioAvailabilityStatus get status;
  // enum statusEnum {  available,  partial,  unavailable,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  @BuiltValueField(wireName: r'unvalued_asset_count')
  int get unvaluedAssetCount;

  PortfolioAllocationValue._();

  factory PortfolioAllocationValue([void updates(PortfolioAllocationValueBuilder b)]) = _$PortfolioAllocationValue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAllocationValueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAllocationValue> get serializer => _$PortfolioAllocationValueSerializer();
}

class _$PortfolioAllocationValueSerializer implements PrimitiveSerializer<PortfolioAllocationValue> {
  @override
  final Iterable<Type> types = const [PortfolioAllocationValue, _$PortfolioAllocationValue];

  @override
  final String wireName = r'PortfolioAllocationValue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAllocationValue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioAvailabilityStatus),
    );
    yield r'value_usd';
    yield object.valueUsd == null ? null : serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'unvalued_asset_count';
    yield serializers.serialize(
      object.unvaluedAssetCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAllocationValue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAllocationValueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioAvailabilityStatus),
          ) as PortfolioAvailabilityStatus;
          result.status = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'unvalued_asset_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unvaluedAssetCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAllocationValue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAllocationValueBuilder();
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

