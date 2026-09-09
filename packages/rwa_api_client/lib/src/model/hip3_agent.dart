//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_agent_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_agent.g.dart';

/// Hip3Agent
///
/// Properties:
/// * [agentId] 
/// * [ownerAddress] 
/// * [agentAddress] 
/// * [environment] 
/// * [status] 
/// * [validUntil] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class Hip3Agent implements Built<Hip3Agent, Hip3AgentBuilder> {
  @BuiltValueField(wireName: r'agent_id')
  String get agentId;

  @BuiltValueField(wireName: r'owner_address')
  String get ownerAddress;

  @BuiltValueField(wireName: r'agent_address')
  String get agentAddress;

  @BuiltValueField(wireName: r'environment')
  Hip3AgentEnvironmentEnum get environment;
  // enum environmentEnum {  mainnet,  };

  @BuiltValueField(wireName: r'status')
  Hip3AgentStatus get status;
  // enum statusEnum {  awaiting_owner_approval,  registering,  active,  expiring,  expired,  rotating,  revoked,  failed,  manual_review,  };

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  Hip3Agent._();

  factory Hip3Agent([void updates(Hip3AgentBuilder b)]) = _$Hip3Agent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3AgentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Agent> get serializer => _$Hip3AgentSerializer();
}

class _$Hip3AgentSerializer implements PrimitiveSerializer<Hip3Agent> {
  @override
  final Iterable<Type> types = const [Hip3Agent, _$Hip3Agent];

  @override
  final String wireName = r'Hip3Agent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Agent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'agent_id';
    yield serializers.serialize(
      object.agentId,
      specifiedType: const FullType(String),
    );
    yield r'owner_address';
    yield serializers.serialize(
      object.ownerAddress,
      specifiedType: const FullType(String),
    );
    yield r'agent_address';
    yield serializers.serialize(
      object.agentAddress,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3AgentEnvironmentEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3AgentStatus),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Agent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3AgentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agent_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentId = valueDes;
          break;
        case r'owner_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerAddress = valueDes;
          break;
        case r'agent_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentAddress = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AgentEnvironmentEnum),
          ) as Hip3AgentEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3AgentStatus),
          ) as Hip3AgentStatus;
          result.status = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Agent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3AgentBuilder();
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

class Hip3AgentEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3AgentEnvironmentEnum mainnet = _$hip3AgentEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AgentEnvironmentEnum unknownDefaultOpenApi = _$hip3AgentEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3AgentEnvironmentEnum> get serializer => _$hip3AgentEnvironmentEnumSerializer;

  const Hip3AgentEnvironmentEnum._(String name): super(name);

  static BuiltSet<Hip3AgentEnvironmentEnum> get values => _$hip3AgentEnvironmentEnumValues;
  static Hip3AgentEnvironmentEnum valueOf(String name) => _$hip3AgentEnvironmentEnumValueOf(name);
}

