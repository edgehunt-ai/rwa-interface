//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_account_allocation_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_account_allocation.g.dart';

/// PortfolioAccountAllocation
///
/// Properties:
/// * [items] 
/// * [valuedTotalUsd] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class PortfolioAccountAllocation implements Built<PortfolioAccountAllocation, PortfolioAccountAllocationBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<PortfolioAccountAllocationItem> get items;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'valued_total_usd')
  String get valuedTotalUsd;

  PortfolioAccountAllocation._();

  factory PortfolioAccountAllocation([void updates(PortfolioAccountAllocationBuilder b)]) = _$PortfolioAccountAllocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAccountAllocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAccountAllocation> get serializer => _$PortfolioAccountAllocationSerializer();
}

class _$PortfolioAccountAllocationSerializer implements PrimitiveSerializer<PortfolioAccountAllocation> {
  @override
  final Iterable<Type> types = const [PortfolioAccountAllocation, _$PortfolioAccountAllocation];

  @override
  final String wireName = r'PortfolioAccountAllocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAccountAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioAccountAllocationItem)]),
    );
    yield r'valued_total_usd';
    yield serializers.serialize(
      object.valuedTotalUsd,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAccountAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAccountAllocationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioAccountAllocationItem)]),
          ) as BuiltList<PortfolioAccountAllocationItem>;
          result.items.replace(valueDes);
          break;
        case r'valued_total_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valuedTotalUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAccountAllocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAccountAllocationBuilder();
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

