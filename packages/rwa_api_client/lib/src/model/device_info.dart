//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'device_info.g.dart';

/// 登录时一并提交的设备信息，等价于调用一次 `POST /v1/me/devices`。 令牌轮换必须走 `POST /v1/me/devices`。
///
/// Properties:
/// * [deviceId] - 客户端生成并持久化的设备标识，用于 upsert
/// * [platform] - 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。
/// * [appVersion]
/// * [pushToken]
/// * [pushProvider] - Flutter iOS / Android 客户端使用 Firebase 时显式传 `fcm`。
@BuiltValue()
abstract class DeviceInfo implements Built<DeviceInfo, DeviceInfoBuilder> {
  /// 客户端生成并持久化的设备标识，用于 upsert
  @BuiltValueField(wireName: r'device_id')
  String? get deviceId;

  /// 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。
  @BuiltValueField(wireName: r'platform')
  String? get platform;

  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  @BuiltValueField(wireName: r'push_token')
  String? get pushToken;

  /// Flutter iOS / Android 客户端使用 Firebase 时显式传 `fcm`。
  @BuiltValueField(wireName: r'push_provider')
  DeviceInfoPushProviderEnum? get pushProvider;
  // enum pushProviderEnum {  apns,  fcm,  };

  DeviceInfo._();

  factory DeviceInfo([void updates(DeviceInfoBuilder b)]) = _$DeviceInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeviceInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeviceInfo> get serializer => _$DeviceInfoSerializer();
}

class _$DeviceInfoSerializer implements PrimitiveSerializer<DeviceInfo> {
  @override
  final Iterable<Type> types = const [DeviceInfo, _$DeviceInfo];

  @override
  final String wireName = r'DeviceInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeviceInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.deviceId != null) {
      yield r'device_id';
      yield serializers.serialize(
        object.deviceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.platform != null) {
      yield r'platform';
      yield serializers.serialize(
        object.platform,
        specifiedType: const FullType(String),
      );
    }
    if (object.appVersion != null) {
      yield r'app_version';
      yield serializers.serialize(
        object.appVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.pushToken != null) {
      yield r'push_token';
      yield serializers.serialize(
        object.pushToken,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.pushProvider != null) {
      yield r'push_provider';
      yield serializers.serialize(
        object.pushProvider,
        specifiedType: const FullType.nullable(DeviceInfoPushProviderEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeviceInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeviceInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deviceId = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
        case r'push_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pushToken = valueDes;
          break;
        case r'push_provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeviceInfoPushProviderEnum),
          ) as DeviceInfoPushProviderEnum?;
          if (valueDes == null) continue;
          result.pushProvider = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeviceInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeviceInfoBuilder();
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

class DeviceInfoPushProviderEnum extends EnumClass {
  /// Flutter iOS / Android 客户端使用 Firebase 时显式传 `fcm`。
  @BuiltValueEnumConst(wireName: r'apns')
  static const DeviceInfoPushProviderEnum apns =
      _$deviceInfoPushProviderEnum_apns;

  /// Flutter iOS / Android 客户端使用 Firebase 时显式传 `fcm`。
  @BuiltValueEnumConst(wireName: r'fcm')
  static const DeviceInfoPushProviderEnum fcm =
      _$deviceInfoPushProviderEnum_fcm;

  /// Flutter iOS / Android 客户端使用 Firebase 时显式传 `fcm`。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeviceInfoPushProviderEnum unknownDefaultOpenApi =
      _$deviceInfoPushProviderEnum_unknownDefaultOpenApi;

  static Serializer<DeviceInfoPushProviderEnum> get serializer =>
      _$deviceInfoPushProviderEnumSerializer;

  const DeviceInfoPushProviderEnum._(String name) : super(name);

  static BuiltSet<DeviceInfoPushProviderEnum> get values =>
      _$deviceInfoPushProviderEnumValues;
  static DeviceInfoPushProviderEnum valueOf(String name) =>
      _$deviceInfoPushProviderEnumValueOf(name);
}
