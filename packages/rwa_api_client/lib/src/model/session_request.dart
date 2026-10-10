//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/device_info.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_request.g.dart';

/// SessionRequest
///
/// Properties:
/// * [language] - Backward-compatible BCP 47 language negotiation hint for this session response. Persistent account settings support only `zh-CN`, `en`, `ja`, and `ko`; any other valid tag MUST NOT persist or overwrite `UserSettings.language`. Clients change the cross-device preference only through `PATCH /v1/me/settings` with `UserLanguage`. 
/// * [device] 
/// * [loginMethod] - 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
@BuiltValue()
abstract class SessionRequest implements Built<SessionRequest, SessionRequestBuilder> {
  /// Backward-compatible BCP 47 language negotiation hint for this session response. Persistent account settings support only `zh-CN`, `en`, `ja`, and `ko`; any other valid tag MUST NOT persist or overwrite `UserSettings.language`. Clients change the cross-device preference only through `PATCH /v1/me/settings` with `UserLanguage`. 
  @BuiltValueField(wireName: r'language')
  String? get language;

  @BuiltValueField(wireName: r'device')
  DeviceInfo? get device;

  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueField(wireName: r'login_method')
  SessionRequestLoginMethodEnum? get loginMethod;
  // enum loginMethodEnum {  email,  sms,  google,  apple,  twitter,  discord,  github,  wallet,  passkey,  other,  };

  SessionRequest._();

  factory SessionRequest([void updates(SessionRequestBuilder b)]) = _$SessionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionRequest> get serializer => _$SessionRequestSerializer();
}

class _$SessionRequestSerializer implements PrimitiveSerializer<SessionRequest> {
  @override
  final Iterable<Type> types = const [SessionRequest, _$SessionRequest];

  @override
  final String wireName = r'SessionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.device != null) {
      yield r'device';
      yield serializers.serialize(
        object.device,
        specifiedType: const FullType(DeviceInfo),
      );
    }
    if (object.loginMethod != null) {
      yield r'login_method';
      yield serializers.serialize(
        object.loginMethod,
        specifiedType: const FullType.nullable(SessionRequestLoginMethodEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.language = valueDes;
          break;
        case r'device':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DeviceInfo),
          ) as DeviceInfo?;
          if (valueDes == null) continue;
          result.device.replace(valueDes);
          break;
        case r'login_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SessionRequestLoginMethodEnum),
          ) as SessionRequestLoginMethodEnum?;
          if (valueDes == null) continue;
          result.loginMethod = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionRequestBuilder();
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

class SessionRequestLoginMethodEnum extends EnumClass {

  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'email')
  static const SessionRequestLoginMethodEnum email = _$sessionRequestLoginMethodEnum_email;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'sms')
  static const SessionRequestLoginMethodEnum sms = _$sessionRequestLoginMethodEnum_sms;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'google')
  static const SessionRequestLoginMethodEnum google = _$sessionRequestLoginMethodEnum_google;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'apple')
  static const SessionRequestLoginMethodEnum apple = _$sessionRequestLoginMethodEnum_apple;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'twitter')
  static const SessionRequestLoginMethodEnum twitter = _$sessionRequestLoginMethodEnum_twitter;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'discord')
  static const SessionRequestLoginMethodEnum discord = _$sessionRequestLoginMethodEnum_discord;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'github')
  static const SessionRequestLoginMethodEnum github = _$sessionRequestLoginMethodEnum_github;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'wallet')
  static const SessionRequestLoginMethodEnum wallet = _$sessionRequestLoginMethodEnum_wallet;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'passkey')
  static const SessionRequestLoginMethodEnum passkey = _$sessionRequestLoginMethodEnum_passkey;
  /// 客户端声明的本次登录方式（展示用途的会话元数据，不参与认证判定）。 未传或传 `other` 时该会话不展示登录方式；非法值返回 422 `login_method_invalid`。 
  @BuiltValueEnumConst(wireName: r'other')
  static const SessionRequestLoginMethodEnum other = _$sessionRequestLoginMethodEnum_other;

  static Serializer<SessionRequestLoginMethodEnum> get serializer => _$sessionRequestLoginMethodEnumSerializer;

  const SessionRequestLoginMethodEnum._(String name): super(name);

  static BuiltSet<SessionRequestLoginMethodEnum> get values => _$sessionRequestLoginMethodEnumValues;
  static SessionRequestLoginMethodEnum valueOf(String name) => _$sessionRequestLoginMethodEnumValueOf(name);
}

