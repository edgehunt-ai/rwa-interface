//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'device_register_request.g.dart';

/// DeviceRegisterRequest
///
/// Properties:
/// * [deviceId] 
/// * [platform] - 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
/// * [appVersion] - 当前安装的版本号，可选。**用途是推送内容分流，不是设备统计**—— 比如老版本不支持富通知（图片 / 按钮）或某种深链格式时， 后端据此回退成纯文本推送，避免老版本收到解析不了的 payload。  与令牌一样会过期：客户端每次上报令牌时应一并带上当前版本号， 不需要单独维护更新时机。 
/// * [pushToken] - APNs / FCM 推送令牌
/// * [pushProvider] - 不传则由后端按 `platform` 推断
@BuiltValue()
abstract class DeviceRegisterRequest implements Built<DeviceRegisterRequest, DeviceRegisterRequestBuilder> {
  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  /// 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
  @BuiltValueField(wireName: r'platform')
  String get platform;

  /// 当前安装的版本号，可选。**用途是推送内容分流，不是设备统计**—— 比如老版本不支持富通知（图片 / 按钮）或某种深链格式时， 后端据此回退成纯文本推送，避免老版本收到解析不了的 payload。  与令牌一样会过期：客户端每次上报令牌时应一并带上当前版本号， 不需要单独维护更新时机。 
  @BuiltValueField(wireName: r'app_version')
  String? get appVersion;

  /// APNs / FCM 推送令牌
  @BuiltValueField(wireName: r'push_token')
  String get pushToken;

  /// 不传则由后端按 `platform` 推断
  @BuiltValueField(wireName: r'push_provider')
  DeviceRegisterRequestPushProviderEnum? get pushProvider;
  // enum pushProviderEnum {  apns,  fcm,  };

  DeviceRegisterRequest._();

  factory DeviceRegisterRequest([void updates(DeviceRegisterRequestBuilder b)]) = _$DeviceRegisterRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeviceRegisterRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeviceRegisterRequest> get serializer => _$DeviceRegisterRequestSerializer();
}

class _$DeviceRegisterRequestSerializer implements PrimitiveSerializer<DeviceRegisterRequest> {
  @override
  final Iterable<Type> types = const [DeviceRegisterRequest, _$DeviceRegisterRequest];

  @override
  final String wireName = r'DeviceRegisterRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeviceRegisterRequest object, {
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
    yield r'push_token';
    yield serializers.serialize(
      object.pushToken,
      specifiedType: const FullType(String),
    );
    if (object.pushProvider != null) {
      yield r'push_provider';
      yield serializers.serialize(
        object.pushProvider,
        specifiedType: const FullType(DeviceRegisterRequestPushProviderEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeviceRegisterRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeviceRegisterRequestBuilder result,
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
        case r'push_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pushToken = valueDes;
          break;
        case r'push_provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeviceRegisterRequestPushProviderEnum),
          ) as DeviceRegisterRequestPushProviderEnum?;
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
  DeviceRegisterRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeviceRegisterRequestBuilder();
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

class DeviceRegisterRequestPushProviderEnum extends EnumClass {

  /// 不传则由后端按 `platform` 推断
  @BuiltValueEnumConst(wireName: r'apns')
  static const DeviceRegisterRequestPushProviderEnum apns = _$deviceRegisterRequestPushProviderEnum_apns;
  /// 不传则由后端按 `platform` 推断
  @BuiltValueEnumConst(wireName: r'fcm')
  static const DeviceRegisterRequestPushProviderEnum fcm = _$deviceRegisterRequestPushProviderEnum_fcm;
  /// 不传则由后端按 `platform` 推断
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DeviceRegisterRequestPushProviderEnum unknownDefaultOpenApi = _$deviceRegisterRequestPushProviderEnum_unknownDefaultOpenApi;

  static Serializer<DeviceRegisterRequestPushProviderEnum> get serializer => _$deviceRegisterRequestPushProviderEnumSerializer;

  const DeviceRegisterRequestPushProviderEnum._(String name): super(name);

  static BuiltSet<DeviceRegisterRequestPushProviderEnum> get values => _$deviceRegisterRequestPushProviderEnumValues;
  static DeviceRegisterRequestPushProviderEnum valueOf(String name) => _$deviceRegisterRequestPushProviderEnumValueOf(name);
}

