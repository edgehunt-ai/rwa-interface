//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_eip712_field.g.dart';

/// Hip3Eip712Field
///
/// Properties:
/// * [name] 
/// * [type] 
@BuiltValue()
abstract class Hip3Eip712Field implements Built<Hip3Eip712Field, Hip3Eip712FieldBuilder> {
  @BuiltValueField(wireName: r'name')
  Hip3Eip712FieldNameEnum get name;
  // enum nameEnum {  source,  connectionId,  };

  @BuiltValueField(wireName: r'type')
  Hip3Eip712FieldTypeEnum get type;
  // enum typeEnum {  string,  bytes32,  };

  Hip3Eip712Field._();

  factory Hip3Eip712Field([void updates(Hip3Eip712FieldBuilder b)]) = _$Hip3Eip712Field;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3Eip712FieldBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Eip712Field> get serializer => _$Hip3Eip712FieldSerializer();
}

class _$Hip3Eip712FieldSerializer implements PrimitiveSerializer<Hip3Eip712Field> {
  @override
  final Iterable<Type> types = const [Hip3Eip712Field, _$Hip3Eip712Field];

  @override
  final String wireName = r'Hip3Eip712Field';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Eip712Field object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(Hip3Eip712FieldNameEnum),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(Hip3Eip712FieldTypeEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Eip712Field object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3Eip712FieldBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712FieldNameEnum),
          ) as Hip3Eip712FieldNameEnum;
          result.name = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712FieldTypeEnum),
          ) as Hip3Eip712FieldTypeEnum;
          result.type = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Eip712Field deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3Eip712FieldBuilder();
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

class Hip3Eip712FieldNameEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'source')
  static const Hip3Eip712FieldNameEnum source_ = _$hip3Eip712FieldNameEnum_source_;
  @BuiltValueEnumConst(wireName: r'connectionId')
  static const Hip3Eip712FieldNameEnum connectionId = _$hip3Eip712FieldNameEnum_connectionId;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712FieldNameEnum unknownDefaultOpenApi = _$hip3Eip712FieldNameEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712FieldNameEnum> get serializer => _$hip3Eip712FieldNameEnumSerializer;

  const Hip3Eip712FieldNameEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712FieldNameEnum> get values => _$hip3Eip712FieldNameEnumValues;
  static Hip3Eip712FieldNameEnum valueOf(String name) => _$hip3Eip712FieldNameEnumValueOf(name);
}

class Hip3Eip712FieldTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'string')
  static const Hip3Eip712FieldTypeEnum string = _$hip3Eip712FieldTypeEnum_string;
  @BuiltValueEnumConst(wireName: r'bytes32')
  static const Hip3Eip712FieldTypeEnum bytes32 = _$hip3Eip712FieldTypeEnum_bytes32;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712FieldTypeEnum unknownDefaultOpenApi = _$hip3Eip712FieldTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712FieldTypeEnum> get serializer => _$hip3Eip712FieldTypeEnumSerializer;

  const Hip3Eip712FieldTypeEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712FieldTypeEnum> get values => _$hip3Eip712FieldTypeEnumValues;
  static Hip3Eip712FieldTypeEnum valueOf(String name) => _$hip3Eip712FieldTypeEnumValueOf(name);
}

