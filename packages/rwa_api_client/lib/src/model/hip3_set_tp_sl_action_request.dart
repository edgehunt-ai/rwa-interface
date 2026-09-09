//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_spec.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_set_tp_sl_action_request.g.dart';

/// 原子校验仓位版本后创建保护更新动作，不立即修改 Position 的已生效字段。 省略某 leg 保持该 leg 不变；至少指定一个 leg。清除使用 clear_tpsl。 若 Provider 不能原子替换，步骤须分别展示取消和创建，失败时保留已生效事实。 
///
/// Properties:
/// * [operation] 
/// * [positionId] 
/// * [positionVersion] 
/// * [protection] 
@BuiltValue()
abstract class Hip3SetTpSlActionRequest implements Built<Hip3SetTpSlActionRequest, Hip3SetTpSlActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3SetTpSlActionRequestOperationEnum get operation;
  // enum operationEnum {  set_tpsl,  };

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'position_version')
  String get positionVersion;

  @BuiltValueField(wireName: r'protection')
  Hip3ProtectionSpec get protection;

  Hip3SetTpSlActionRequest._();

  factory Hip3SetTpSlActionRequest([void updates(Hip3SetTpSlActionRequestBuilder b)]) = _$Hip3SetTpSlActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3SetTpSlActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3SetTpSlActionRequest> get serializer => _$Hip3SetTpSlActionRequestSerializer();
}

class _$Hip3SetTpSlActionRequestSerializer implements PrimitiveSerializer<Hip3SetTpSlActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3SetTpSlActionRequest, _$Hip3SetTpSlActionRequest];

  @override
  final String wireName = r'Hip3SetTpSlActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3SetTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3SetTpSlActionRequestOperationEnum),
    );
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'position_version';
    yield serializers.serialize(
      object.positionVersion,
      specifiedType: const FullType(String),
    );
    yield r'protection';
    yield serializers.serialize(
      object.protection,
      specifiedType: const FullType(Hip3ProtectionSpec),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3SetTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3SetTpSlActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3SetTpSlActionRequestOperationEnum),
          ) as Hip3SetTpSlActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'position_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionVersion = valueDes;
          break;
        case r'protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ProtectionSpec),
          ) as Hip3ProtectionSpec;
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
  Hip3SetTpSlActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3SetTpSlActionRequestBuilder();
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

class Hip3SetTpSlActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'set_tpsl')
  static const Hip3SetTpSlActionRequestOperationEnum setTpsl = _$hip3SetTpSlActionRequestOperationEnum_setTpsl;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3SetTpSlActionRequestOperationEnum unknownDefaultOpenApi = _$hip3SetTpSlActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3SetTpSlActionRequestOperationEnum> get serializer => _$hip3SetTpSlActionRequestOperationEnumSerializer;

  const Hip3SetTpSlActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3SetTpSlActionRequestOperationEnum> get values => _$hip3SetTpSlActionRequestOperationEnumValues;
  static Hip3SetTpSlActionRequestOperationEnum valueOf(String name) => _$hip3SetTpSlActionRequestOperationEnumValueOf(name);
}

