//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_single_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_protection_modify_change.g.dart';

/// Hip3ProtectionModifyChange
///
/// Properties:
/// * [operation] 
/// * [orderId] 
/// * [protection] 
@BuiltValue()
abstract class Hip3ProtectionModifyChange implements Built<Hip3ProtectionModifyChange, Hip3ProtectionModifyChangeBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3ProtectionModifyChangeOperationEnum get operation;
  // enum operationEnum {  modify,  };

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'protection')
  Hip3SingleProtectionSpec? get protection;

  Hip3ProtectionModifyChange._();

  factory Hip3ProtectionModifyChange([void updates(Hip3ProtectionModifyChangeBuilder b)]) = _$Hip3ProtectionModifyChange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ProtectionModifyChangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ProtectionModifyChange> get serializer => _$Hip3ProtectionModifyChangeSerializer();
}

class _$Hip3ProtectionModifyChangeSerializer implements PrimitiveSerializer<Hip3ProtectionModifyChange> {
  @override
  final Iterable<Type> types = const [Hip3ProtectionModifyChange, _$Hip3ProtectionModifyChange];

  @override
  final String wireName = r'Hip3ProtectionModifyChange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ProtectionModifyChange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3ProtectionModifyChangeOperationEnum),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
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
    Hip3ProtectionModifyChange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ProtectionModifyChangeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionModifyChangeOperationEnum),
          ) as Hip3ProtectionModifyChangeOperationEnum;
          result.operation = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
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
  Hip3ProtectionModifyChange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ProtectionModifyChangeBuilder();
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

class Hip3ProtectionModifyChangeOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'modify')
  static const Hip3ProtectionModifyChangeOperationEnum modify = _$hip3ProtectionModifyChangeOperationEnum_modify;

  static Serializer<Hip3ProtectionModifyChangeOperationEnum> get serializer => _$hip3ProtectionModifyChangeOperationEnumSerializer;

  const Hip3ProtectionModifyChangeOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ProtectionModifyChangeOperationEnum> get values => _$hip3ProtectionModifyChangeOperationEnumValues;
  static Hip3ProtectionModifyChangeOperationEnum valueOf(String name) => _$hip3ProtectionModifyChangeOperationEnumValueOf(name);
}

