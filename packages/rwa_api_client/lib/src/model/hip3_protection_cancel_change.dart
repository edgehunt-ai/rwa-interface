//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_protection_cancel_change.g.dart';

/// Hip3ProtectionCancelChange
///
/// Properties:
/// * [operation] 
/// * [orderId] 
@BuiltValue()
abstract class Hip3ProtectionCancelChange implements Built<Hip3ProtectionCancelChange, Hip3ProtectionCancelChangeBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3ProtectionCancelChangeOperationEnum get operation;
  // enum operationEnum {  cancel,  };

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  Hip3ProtectionCancelChange._();

  factory Hip3ProtectionCancelChange([void updates(Hip3ProtectionCancelChangeBuilder b)]) = _$Hip3ProtectionCancelChange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionCancelChangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionCancelChange> get serializer => _$Hip3ProtectionCancelChangeSerializer();
}

class _$Hip3ProtectionCancelChangeSerializer implements PrimitiveSerializer<Hip3ProtectionCancelChange> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionCancelChange, _$Hip3ProtectionCancelChange];

  @override
  final String wireName = r'Hip3ProtectionCancelChange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionCancelChange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3ProtectionCancelChangeOperationEnum),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ProtectionCancelChange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ProtectionCancelChangeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionCancelChangeOperationEnum),
          ) as Hip3ProtectionCancelChangeOperationEnum;
          result.operation = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ProtectionCancelChange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionCancelChangeBuilder();
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

class Hip3ProtectionCancelChangeOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancel')
  static const Hip3ProtectionCancelChangeOperationEnum cancel = _$hip3ProtectionCancelChangeOperationEnum_cancel;

  static Serializer<Hip3ProtectionCancelChangeOperationEnum> get serializer => _$hip3ProtectionCancelChangeOperationEnumSerializer;

  const Hip3ProtectionCancelChangeOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionCancelChangeOperationEnum> get values => _$hip3ProtectionCancelChangeOperationEnumValues;
  static Hip3ProtectionCancelChangeOperationEnum valueOf(String name) => _$hip3ProtectionCancelChangeOperationEnumValueOf(name);
}

