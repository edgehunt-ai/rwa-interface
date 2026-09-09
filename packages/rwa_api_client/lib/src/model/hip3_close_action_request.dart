//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_close_action_request.g.dart';

/// 引用未过期且未被其他动作消费的 HIP3 close preview。账户、仓位、方向和 reduce-only 从预览推导。不得因为仓位反向而变为开仓；仓位版本或数量变化后需重新预览。 
///
/// Properties:
/// * [operation] 
/// * [previewId] 
@BuiltValue()
abstract class Hip3CloseActionRequest implements Built<Hip3CloseActionRequest, Hip3CloseActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3CloseActionRequestOperationEnum get operation;
  // enum operationEnum {  close_position,  };

  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  Hip3CloseActionRequest._();

  factory Hip3CloseActionRequest([void updates(Hip3CloseActionRequestBuilder b)]) = _$Hip3CloseActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3CloseActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3CloseActionRequest> get serializer => _$Hip3CloseActionRequestSerializer();
}

class _$Hip3CloseActionRequestSerializer implements PrimitiveSerializer<Hip3CloseActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3CloseActionRequest, _$Hip3CloseActionRequest];

  @override
  final String wireName = r'Hip3CloseActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3CloseActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3CloseActionRequestOperationEnum),
    );
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3CloseActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3CloseActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CloseActionRequestOperationEnum),
          ) as Hip3CloseActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3CloseActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3CloseActionRequestBuilder();
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

class Hip3CloseActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'close_position')
  static const Hip3CloseActionRequestOperationEnum closePosition = _$hip3CloseActionRequestOperationEnum_closePosition;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3CloseActionRequestOperationEnum unknownDefaultOpenApi = _$hip3CloseActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3CloseActionRequestOperationEnum> get serializer => _$hip3CloseActionRequestOperationEnumSerializer;

  const Hip3CloseActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3CloseActionRequestOperationEnum> get values => _$hip3CloseActionRequestOperationEnumValues;
  static Hip3CloseActionRequestOperationEnum valueOf(String name) => _$hip3CloseActionRequestOperationEnumValueOf(name);
}

