//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_liquidation_position.g.dart';

/// Hip3LiquidationPosition
///
/// Properties:
/// * [productId] - 原始完整HIP3产品标识。
/// * [signedPositionSize] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class Hip3LiquidationPosition implements Built<Hip3LiquidationPosition, Hip3LiquidationPositionBuilder> {
  /// 原始完整HIP3产品标识。
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'signed_position_size')
  String get signedPositionSize;

  Hip3LiquidationPosition._();

  factory Hip3LiquidationPosition([void updates(Hip3LiquidationPositionBuilder b)]) = _$Hip3LiquidationPosition;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3LiquidationPositionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3LiquidationPosition> get serializer => _$Hip3LiquidationPositionSerializer();
}

class _$Hip3LiquidationPositionSerializer implements PrimitiveSerializer<Hip3LiquidationPosition> {
  @override
  final Iterable<Type> types = const [Hip3LiquidationPosition, _$Hip3LiquidationPosition];

  @override
  final String wireName = r'Hip3LiquidationPosition';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3LiquidationPosition object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'signed_position_size';
    yield serializers.serialize(
      object.signedPositionSize,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3LiquidationPosition object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3LiquidationPositionBuilder result,
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
        case r'signed_position_size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signedPositionSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3LiquidationPosition deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3LiquidationPositionBuilder();
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

