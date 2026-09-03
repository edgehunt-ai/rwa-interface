//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/user_settings.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

/// 账户主体，只放 **Privy 给不了的** 信息。  邮箱、登录方式这些属于 Privy 的身份数据，客户端登录后已经拿在手里 （`privyUser.linkedAccounts`），本接口不再重复返回一份 —— 两份数据 同步不及时反而会不一致。设置页的「当前登录账户」直接读 SDK。  用户偏好收在 `settings` 子对象里，更新走 `PATCH /v1/me/settings`。 
///
/// Properties:
/// * [userId] 
/// * [privyDid] - Privy 用户 DID
/// * [displayName] 
/// * [avatarUrl] 
/// * [settings] 
/// * [createdAt] 
@BuiltValue()
abstract class User implements Built<User, UserBuilder> {
  @BuiltValueField(wireName: r'user_id')
  String get userId;

  /// Privy 用户 DID
  @BuiltValueField(wireName: r'privy_did')
  String? get privyDid;

  @BuiltValueField(wireName: r'display_name')
  String? get displayName;

  @BuiltValueField(wireName: r'avatar_url')
  String? get avatarUrl;

  @BuiltValueField(wireName: r'settings')
  UserSettings get settings;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  User._();

  factory User([void updates(UserBuilder b)]) = _$User;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<User> get serializer => _$UserSerializer();
}

class _$UserSerializer implements PrimitiveSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];

  @override
  final String wireName = r'User';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    if (object.privyDid != null) {
      yield r'privy_did';
      yield serializers.serialize(
        object.privyDid,
        specifiedType: const FullType(String),
      );
    }
    if (object.displayName != null) {
      yield r'display_name';
      yield serializers.serialize(
        object.displayName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.avatarUrl != null) {
      yield r'avatar_url';
      yield serializers.serialize(
        object.avatarUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'settings';
    yield serializers.serialize(
      object.settings,
      specifiedType: const FullType(UserSettings),
    );
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
    User object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'privy_did':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privyDid = valueDes;
          break;
        case r'display_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'avatar_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.avatarUrl = valueDes;
          break;
        case r'settings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserSettings),
          ) as UserSettings;
          result.settings.replace(valueDes);
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
  User deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserBuilder();
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

