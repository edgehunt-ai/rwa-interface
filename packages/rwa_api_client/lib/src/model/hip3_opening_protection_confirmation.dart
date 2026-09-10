//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_opening_protection_confirmation_legs_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_opening_protection_confirmation.g.dart';

/// 本单止盈止损的冻结确认值，数量等于规范化父单数量，固定不自动调整。 只用于原生 normalTpsl，不能替代已有持仓的默认全仓保护。 父子单在下单时一起签名，未来触发不补签；后续修改/主动撤销需要签名。 父单未完全成交时子保护尚未生效。主动撤销部分成交父单会取消子保护， 需检查剩余持仓的保护状态，不自动补保护。 
///
/// Properties:
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [legs] - 每个 role 最多一条，固定顺序 take_profit 然后 stop_loss；只有一腿时仅返回该腿。
@BuiltValue()
abstract class Hip3OpeningProtectionConfirmation implements Built<Hip3OpeningProtectionConfirmation, Hip3OpeningProtectionConfirmationBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  /// 每个 role 最多一条，固定顺序 take_profit 然后 stop_loss；只有一腿时仅返回该腿。
  @BuiltValueField(wireName: r'legs')
  BuiltList<Hip3OpeningProtectionConfirmationLegsInner> get legs;

  Hip3OpeningProtectionConfirmation._();

  factory Hip3OpeningProtectionConfirmation([void updates(Hip3OpeningProtectionConfirmationBuilder b)]) = _$Hip3OpeningProtectionConfirmation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OpeningProtectionConfirmationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OpeningProtectionConfirmation> get serializer => _$Hip3OpeningProtectionConfirmationSerializer();
}

class _$Hip3OpeningProtectionConfirmationSerializer implements PrimitiveSerializer<Hip3OpeningProtectionConfirmation> {
  @override
  final Iterable<Type> types = const [Hip3OpeningProtectionConfirmation, _$Hip3OpeningProtectionConfirmation];

  @override
  final String wireName = r'Hip3OpeningProtectionConfirmation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OpeningProtectionConfirmation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'legs';
    yield serializers.serialize(
      object.legs,
      specifiedType: const FullType(BuiltList, [FullType(Hip3OpeningProtectionConfirmationLegsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OpeningProtectionConfirmation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OpeningProtectionConfirmationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'legs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3OpeningProtectionConfirmationLegsInner)]),
          ) as BuiltList<Hip3OpeningProtectionConfirmationLegsInner>;
          result.legs.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OpeningProtectionConfirmation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OpeningProtectionConfirmationBuilder();
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

