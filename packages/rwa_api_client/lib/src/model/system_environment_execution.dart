//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_environment_execution.g.dart';

/// SystemEnvironmentExecution
///
/// Properties:
/// * [enabled] - 平台级执行总开关（`RWA_EXECUTION_ENABLED`）
/// * [signing] - 服务端是否允许使用签名能力（`RWA_SIGNING_ENABLED`）
@BuiltValue()
abstract class SystemEnvironmentExecution implements Built<SystemEnvironmentExecution, SystemEnvironmentExecutionBuilder> {
  /// 平台级执行总开关（`RWA_EXECUTION_ENABLED`）
  @BuiltValueField(wireName: r'enabled')
  bool get enabled;

  /// 服务端是否允许使用签名能力（`RWA_SIGNING_ENABLED`）
  @BuiltValueField(wireName: r'signing')
  bool get signing;

  SystemEnvironmentExecution._();

  factory SystemEnvironmentExecution([void updates(SystemEnvironmentExecutionBuilder b)]) = _$SystemEnvironmentExecution;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemEnvironmentExecutionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemEnvironmentExecution> get serializer => _$SystemEnvironmentExecutionSerializer();
}

class _$SystemEnvironmentExecutionSerializer implements PrimitiveSerializer<SystemEnvironmentExecution> {
  @override
  final Iterable<Type> types = const [SystemEnvironmentExecution, _$SystemEnvironmentExecution];

  @override
  final String wireName = r'SystemEnvironmentExecution';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemEnvironmentExecution object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'enabled';
    yield serializers.serialize(
      object.enabled,
      specifiedType: const FullType(bool),
    );
    yield r'signing';
    yield serializers.serialize(
      object.signing,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemEnvironmentExecution object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SystemEnvironmentExecutionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'signing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.signing = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemEnvironmentExecution deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemEnvironmentExecutionBuilder();
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

