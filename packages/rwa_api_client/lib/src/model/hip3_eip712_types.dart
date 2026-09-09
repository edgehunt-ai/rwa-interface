//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_eip712_field.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_eip712_types.g.dart';

/// Hip3Eip712Types
///
/// Properties:
/// * [agent] - 必须依次为 `source:string` 与 `connectionId:bytes32`。
@BuiltValue()
abstract class Hip3Eip712Types implements Built<Hip3Eip712Types, Hip3Eip712TypesBuilder> {
  /// 必须依次为 `source:string` 与 `connectionId:bytes32`。
  @BuiltValueField(wireName: r'Agent')
  BuiltList<Hip3Eip712Field> get agent;

  Hip3Eip712Types._();

  factory Hip3Eip712Types([void updates(Hip3Eip712TypesBuilder b)]) = _$Hip3Eip712Types;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3Eip712TypesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Eip712Types> get serializer => _$Hip3Eip712TypesSerializer();
}

class _$Hip3Eip712TypesSerializer implements PrimitiveSerializer<Hip3Eip712Types> {
  @override
  final Iterable<Type> types = const [Hip3Eip712Types, _$Hip3Eip712Types];

  @override
  final String wireName = r'Hip3Eip712Types';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Eip712Types object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'Agent';
    yield serializers.serialize(
      object.agent,
      specifiedType: const FullType(BuiltList, [FullType(Hip3Eip712Field)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Eip712Types object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3Eip712TypesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'Agent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3Eip712Field)]),
          ) as BuiltList<Hip3Eip712Field>;
          result.agent.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Eip712Types deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3Eip712TypesBuilder();
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

