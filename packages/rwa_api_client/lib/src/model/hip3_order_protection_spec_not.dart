//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_order_protection_spec_not.g.dart';

/// Hip3OrderProtectionSpecNot
///
/// Properties:
/// * [takeProfit] 
/// * [stopLoss] 
@BuiltValue()
abstract class Hip3OrderProtectionSpecNot implements Built<Hip3OrderProtectionSpecNot, Hip3OrderProtectionSpecNotBuilder> {
  @BuiltValueField(wireName: r'take_profit')
  JsonObject? get takeProfit;

  @BuiltValueField(wireName: r'stop_loss')
  JsonObject? get stopLoss;

  Hip3OrderProtectionSpecNot._();

  factory Hip3OrderProtectionSpecNot([void updates(Hip3OrderProtectionSpecNotBuilder b)]) = _$Hip3OrderProtectionSpecNot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OrderProtectionSpecNotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OrderProtectionSpecNot> get serializer => _$Hip3OrderProtectionSpecNotSerializer();
}

class _$Hip3OrderProtectionSpecNotSerializer implements PrimitiveSerializer<Hip3OrderProtectionSpecNot> {
  @override
  final Iterable<Type> types = const [Hip3OrderProtectionSpecNot, _$Hip3OrderProtectionSpecNot];

  @override
  final String wireName = r'Hip3OrderProtectionSpecNot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OrderProtectionSpecNot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.takeProfit != null) {
      yield r'take_profit';
      yield serializers.serialize(
        object.takeProfit,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.stopLoss != null) {
      yield r'stop_loss';
      yield serializers.serialize(
        object.stopLoss,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OrderProtectionSpecNot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OrderProtectionSpecNotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'take_profit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.takeProfit = valueDes;
          break;
        case r'stop_loss':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.stopLoss = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OrderProtectionSpecNot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OrderProtectionSpecNotBuilder();
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

