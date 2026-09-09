//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_eip712_message.dart';
import 'package:rwa_api_client/src/model/hip3_eip712_types.dart';
import 'package:rwa_api_client/src/model/hip3_eip712_domain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_eip712_typed_data.g.dart';

/// 可直接交给钱包 typed-data 签名方法的服务端冻结数据。
///
/// Properties:
/// * [domain] 
/// * [types] 
/// * [primaryType] 
/// * [message] 
@BuiltValue()
abstract class Hip3Eip712TypedData implements Built<Hip3Eip712TypedData, Hip3Eip712TypedDataBuilder> {
  @BuiltValueField(wireName: r'domain')
  Hip3Eip712Domain get domain;

  @BuiltValueField(wireName: r'types')
  Hip3Eip712Types get types;

  @BuiltValueField(wireName: r'primaryType')
  Hip3Eip712TypedDataPrimaryTypeEnum get primaryType;
  // enum primaryTypeEnum {  Agent,  };

  @BuiltValueField(wireName: r'message')
  Hip3Eip712Message get message;

  Hip3Eip712TypedData._();

  factory Hip3Eip712TypedData([void updates(Hip3Eip712TypedDataBuilder b)]) = _$Hip3Eip712TypedData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3Eip712TypedDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Eip712TypedData> get serializer => _$Hip3Eip712TypedDataSerializer();
}

class _$Hip3Eip712TypedDataSerializer implements PrimitiveSerializer<Hip3Eip712TypedData> {
  @override
  final Iterable<Type> types = const [Hip3Eip712TypedData, _$Hip3Eip712TypedData];

  @override
  final String wireName = r'Hip3Eip712TypedData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Eip712TypedData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'domain';
    yield serializers.serialize(
      object.domain,
      specifiedType: const FullType(Hip3Eip712Domain),
    );
    yield r'types';
    yield serializers.serialize(
      object.types,
      specifiedType: const FullType(Hip3Eip712Types),
    );
    yield r'primaryType';
    yield serializers.serialize(
      object.primaryType,
      specifiedType: const FullType(Hip3Eip712TypedDataPrimaryTypeEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(Hip3Eip712Message),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Eip712TypedData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3Eip712TypedDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'domain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712Domain),
          ) as Hip3Eip712Domain;
          result.domain.replace(valueDes);
          break;
        case r'types':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712Types),
          ) as Hip3Eip712Types;
          result.types.replace(valueDes);
          break;
        case r'primaryType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712TypedDataPrimaryTypeEnum),
          ) as Hip3Eip712TypedDataPrimaryTypeEnum;
          result.primaryType = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712Message),
          ) as Hip3Eip712Message;
          result.message.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Eip712TypedData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3Eip712TypedDataBuilder();
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

class Hip3Eip712TypedDataPrimaryTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Agent')
  static const Hip3Eip712TypedDataPrimaryTypeEnum agent = _$hip3Eip712TypedDataPrimaryTypeEnum_agent;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712TypedDataPrimaryTypeEnum unknownDefaultOpenApi = _$hip3Eip712TypedDataPrimaryTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712TypedDataPrimaryTypeEnum> get serializer => _$hip3Eip712TypedDataPrimaryTypeEnumSerializer;

  const Hip3Eip712TypedDataPrimaryTypeEnum._(String name): super(name);

  static BuiltSet<Hip3Eip712TypedDataPrimaryTypeEnum> get values => _$hip3Eip712TypedDataPrimaryTypeEnumValues;
  static Hip3Eip712TypedDataPrimaryTypeEnum valueOf(String name) => _$hip3Eip712TypedDataPrimaryTypeEnumValueOf(name);
}

