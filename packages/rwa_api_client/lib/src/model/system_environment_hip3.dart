//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_environment_hip3.g.dart';

/// SystemEnvironmentHip3
///
/// Properties:
/// * [environment] - HIP-3 数据源实际接入的 Hyperliquid 网络
@BuiltValue()
abstract class SystemEnvironmentHip3 implements Built<SystemEnvironmentHip3, SystemEnvironmentHip3Builder> {
  /// HIP-3 数据源实际接入的 Hyperliquid 网络
  @BuiltValueField(wireName: r'environment')
  SystemEnvironmentHip3EnvironmentEnum get environment;
  // enum environmentEnum {  testnet,  mainnet,  };

  SystemEnvironmentHip3._();

  factory SystemEnvironmentHip3([void updates(SystemEnvironmentHip3Builder b)]) = _$SystemEnvironmentHip3;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemEnvironmentHip3Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemEnvironmentHip3> get serializer => _$SystemEnvironmentHip3Serializer();
}

class _$SystemEnvironmentHip3Serializer implements PrimitiveSerializer<SystemEnvironmentHip3> {
  @override
  final Iterable<Type> types = const [SystemEnvironmentHip3, _$SystemEnvironmentHip3];

  @override
  final String wireName = r'SystemEnvironmentHip3';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemEnvironmentHip3 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(SystemEnvironmentHip3EnvironmentEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemEnvironmentHip3 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SystemEnvironmentHip3Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SystemEnvironmentHip3EnvironmentEnum),
          ) as SystemEnvironmentHip3EnvironmentEnum;
          result.environment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemEnvironmentHip3 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemEnvironmentHip3Builder();
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

class SystemEnvironmentHip3EnvironmentEnum extends EnumClass {

  /// HIP-3 数据源实际接入的 Hyperliquid 网络
  @BuiltValueEnumConst(wireName: r'testnet')
  static const SystemEnvironmentHip3EnvironmentEnum testnet = _$systemEnvironmentHip3EnvironmentEnum_testnet;
  /// HIP-3 数据源实际接入的 Hyperliquid 网络
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const SystemEnvironmentHip3EnvironmentEnum mainnet = _$systemEnvironmentHip3EnvironmentEnum_mainnet;
  /// HIP-3 数据源实际接入的 Hyperliquid 网络
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SystemEnvironmentHip3EnvironmentEnum unknownDefaultOpenApi = _$systemEnvironmentHip3EnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<SystemEnvironmentHip3EnvironmentEnum> get serializer => _$systemEnvironmentHip3EnvironmentEnumSerializer;

  const SystemEnvironmentHip3EnvironmentEnum._(String name): super(name);

  static BuiltSet<SystemEnvironmentHip3EnvironmentEnum> get values => _$systemEnvironmentHip3EnvironmentEnumValues;
  static SystemEnvironmentHip3EnvironmentEnum valueOf(String name) => _$systemEnvironmentHip3EnvironmentEnumValueOf(name);
}

