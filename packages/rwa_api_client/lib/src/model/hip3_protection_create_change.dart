//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_single_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_protection_create_change.g.dart';

/// Hip3ProtectionCreateChange
///
/// Properties:
/// * [operation] 
/// * [protection] 
@BuiltValue()
abstract class Hip3ProtectionCreateChange implements Built<Hip3ProtectionCreateChange, Hip3ProtectionCreateChangeBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3ProtectionCreateChangeOperationEnum get operation;
  // enum operationEnum {  create,  };

  @BuiltValueField(wireName: r'protection')
  Hip3SingleProtectionSpec? get protection;

  Hip3ProtectionCreateChange._();

  factory Hip3ProtectionCreateChange([void updates(Hip3ProtectionCreateChangeBuilder b)]) = _$Hip3ProtectionCreateChange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionCreateChangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionCreateChange> get serializer => _$Hip3ProtectionCreateChangeSerializer();
}

class _$Hip3ProtectionCreateChangeSerializer implements PrimitiveSerializer<Hip3ProtectionCreateChange> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionCreateChange, _$Hip3ProtectionCreateChange];

  @override
  final String wireName = r'Hip3ProtectionCreateChange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionCreateChange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3ProtectionCreateChangeOperationEnum),
    );
    yield r'protection';
    yield object.protection == null ? null : serializers.serialize(
      object.protection,
      specifiedType: const FullType.nullable(Hip3SingleProtectionSpec),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ProtectionCreateChange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ProtectionCreateChangeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionCreateChangeOperationEnum),
          ) as Hip3ProtectionCreateChangeOperationEnum;
          result.operation = valueDes;
          break;
        case r'protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3SingleProtectionSpec),
          ) as Hip3SingleProtectionSpec?;
          if (valueDes == null) continue;
          result.protection.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ProtectionCreateChange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionCreateChangeBuilder();
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

class Hip3ProtectionCreateChangeOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'create')
  static const Hip3ProtectionCreateChangeOperationEnum create = _$hip3ProtectionCreateChangeOperationEnum_create;

  static Serializer<Hip3ProtectionCreateChangeOperationEnum> get serializer => _$hip3ProtectionCreateChangeOperationEnumSerializer;

  const Hip3ProtectionCreateChangeOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionCreateChangeOperationEnum> get values => _$hip3ProtectionCreateChangeOperationEnumValues;
  static Hip3ProtectionCreateChangeOperationEnum valueOf(String name) => _$hip3ProtectionCreateChangeOperationEnumValueOf(name);
}

