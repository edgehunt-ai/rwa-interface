//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'device.g.dart';

/// Device
///
/// Properties:
/// * [deviceId] 
/// * [platform] - 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
/// * [appVersion] - 用于推送内容分流；客户端未上报过时为 null
/// * [pushProvider] 
/// * [pushTokenRegistered] - 出于安全考虑不回显令牌本身，只告知是否已登记
/// * [lastSeenAt] 
/// * [createdAt] 
@BuiltValue()
abstract class Device implements Built<Device, DeviceBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  /// 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
  @BuiltValueField(wireName: r'platform')
  String get platform;

  /// 用于推送内容分流；客户端未上报过时为 null
  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  @BuiltValueField(wireName: r'push_provider')
  DevicePushProviderEnum? get pushProvider;
  // enum pushProviderEnum {  apns,  fcm,  };

  /// 出于安全考虑不回显令牌本身，只告知是否已登记
  @BuiltValueField(wireName: r'push_token_registered')
  bool? get pushTokenRegistered;

  @BuiltValueField(wireName: r'last_seen_at')
  DateTime? get lastSeenAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  Device._();

  factory Device([void updates(DeviceBuilder b)]) = _$Device;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeviceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Device> get serializer => _$DeviceSerializer();
}

class _$DeviceSerializer implements PrimitiveSerializer<Device> {
  @override
  final Iterable<Type> types = const [Device, _$Device];

  @override
  final String wireName = r'Device';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Device object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    if (object.appVersion != null) {
      yield r'app_version';
      yield serializers.serialize(
        object.appVersion,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.pushProvider != null) {
      yield r'push_provider';
      yield serializers.serialize(
        object.pushProvider,
        specifiedType: const FullType.nullable(DevicePushProviderEnum),
      );
    }
    if (object.pushTokenRegistered != null) {
      yield r'push_token_registered';
      yield serializers.serialize(
        object.pushTokenRegistered,
        specifiedType: const FullType(bool),
      );
    }
    if (object.lastSeenAt != null) {
      yield r'last_seen_at';
      yield serializers.serialize(
        object.lastSeenAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Device object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeviceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'app_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.appVersion = valueDes;
          break;
        case r'push_provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DevicePushProviderEnum),
          ) as DevicePushProviderEnum?;
          if (valueDes == null) continue;
          result.pushProvider = valueDes;
          break;
        case r'push_token_registered':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.pushTokenRegistered = valueDes;
          break;
        case r'last_seen_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSeenAt = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Device deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeviceBuilder();
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

class DevicePushProviderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'apns')
  static const DevicePushProviderEnum apns = _$devicePushProviderEnum_apns;
  @BuiltValueEnumConst(wireName: r'fcm')
  static const DevicePushProviderEnum fcm = _$devicePushProviderEnum_fcm;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DevicePushProviderEnum unknownDefaultOpenApi = _$devicePushProviderEnum_unknownDefaultOpenApi;

  static Serializer<DevicePushProviderEnum> get serializer => _$devicePushProviderEnumSerializer;

  const DevicePushProviderEnum._(String name): super(name);

  static BuiltSet<DevicePushProviderEnum> get values => _$devicePushProviderEnumValues;
  static DevicePushProviderEnum valueOf(String name) => _$devicePushProviderEnumValueOf(name);
}

