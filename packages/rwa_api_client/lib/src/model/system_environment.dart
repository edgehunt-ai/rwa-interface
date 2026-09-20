//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/system_environment_execution.dart';
import 'package:rwa_api_client/src/model/system_environment_hip3.dart';
import 'package:rwa_api_client/src/model/service_environment.dart';
import 'package:rwa_api_client/src/model/system_environment_bstocks.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_environment.g.dart';

/// SystemEnvironment
///
/// Properties:
/// * [environment] 
/// * [execution] 
/// * [hip3] 
/// * [bstocks] 
@BuiltValue()
abstract class SystemEnvironment implements Built<SystemEnvironment, SystemEnvironmentBuilder> {
  @BuiltValueField(wireName: r'environment')
  ServiceEnvironment get environment;
  // enum environmentEnum {  development,  testnet,  mainnet,  };

  @BuiltValueField(wireName: r'execution')
  SystemEnvironmentExecution get execution;

  @BuiltValueField(wireName: r'hip3')
  SystemEnvironmentHip3 get hip3;

  @BuiltValueField(wireName: r'bstocks')
  SystemEnvironmentBstocks get bstocks;

  SystemEnvironment._();

  factory SystemEnvironment([void updates(SystemEnvironmentBuilder b)]) = _$SystemEnvironment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemEnvironmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemEnvironment> get serializer => _$SystemEnvironmentSerializer();
}

class _$SystemEnvironmentSerializer implements PrimitiveSerializer<SystemEnvironment> {
  @override
  final Iterable<Type> types = const [SystemEnvironment, _$SystemEnvironment];

  @override
  final String wireName = r'SystemEnvironment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemEnvironment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(ServiceEnvironment),
    );
    yield r'execution';
    yield serializers.serialize(
      object.execution,
      specifiedType: const FullType(SystemEnvironmentExecution),
    );
    yield r'hip3';
    yield serializers.serialize(
      object.hip3,
      specifiedType: const FullType(SystemEnvironmentHip3),
    );
    yield r'bstocks';
    yield serializers.serialize(
      object.bstocks,
      specifiedType: const FullType(SystemEnvironmentBstocks),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemEnvironment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SystemEnvironmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ServiceEnvironment),
          ) as ServiceEnvironment;
          result.environment = valueDes;
          break;
        case r'execution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SystemEnvironmentExecution),
          ) as SystemEnvironmentExecution;
          result.execution.replace(valueDes);
          break;
        case r'hip3':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SystemEnvironmentHip3),
          ) as SystemEnvironmentHip3;
          result.hip3.replace(valueDes);
          break;
        case r'bstocks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SystemEnvironmentBstocks),
          ) as SystemEnvironmentBstocks;
          result.bstocks.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemEnvironment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemEnvironmentBuilder();
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

