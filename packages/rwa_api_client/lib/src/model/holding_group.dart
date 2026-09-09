//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/position.dart';
import 'package:rwa_api_client/src/model/stock.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'holding_group.g.dart';

/// 资产页中一支股票下的所有产品持仓
///
/// Properties:
/// * [stock] 
/// * [totalValueUsd] - 十进制字符串，避免浮点误差
/// * [positions] 
@BuiltValue()
abstract class HoldingGroup implements Built<HoldingGroup, HoldingGroupBuilder> {
  @BuiltValueField(wireName: r'stock')
  Stock get stock;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_value_usd')
  String get totalValueUsd;

  @BuiltValueField(wireName: r'positions')
  BuiltList<Position> get positions;

  HoldingGroup._();

  factory HoldingGroup([void updates(HoldingGroupBuilder b)]) = _$HoldingGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HoldingGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HoldingGroup> get serializer => _$HoldingGroupSerializer();
}

class _$HoldingGroupSerializer implements PrimitiveSerializer<HoldingGroup> {
  @override
  final Iterable<Type> types = const [HoldingGroup, _$HoldingGroup];

  @override
  final String wireName = r'HoldingGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HoldingGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'stock';
    yield serializers.serialize(
      object.stock,
      specifiedType: const FullType(Stock),
    );
    yield r'total_value_usd';
    yield serializers.serialize(
      object.totalValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'positions';
    yield serializers.serialize(
      object.positions,
      specifiedType: const FullType(BuiltList, [FullType(Position)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HoldingGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HoldingGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'stock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Stock),
          ) as Stock;
          result.stock.replace(valueDes);
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalValueUsd = valueDes;
          break;
        case r'positions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Position)]),
          ) as BuiltList<Position>;
          result.positions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HoldingGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HoldingGroupBuilder();
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

