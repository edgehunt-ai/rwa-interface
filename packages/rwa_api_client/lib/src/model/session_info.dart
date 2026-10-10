//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_info.g.dart';

/// SessionInfo
///
/// Properties:
/// * [id] - 服务端会话记录 ID（非 Privy sid）
/// * [client] - 服务端解析 User-Agent 得到的 `浏览器 · 系统` 标签，回退 device.platform，无证据时为 `Unknown`
/// * [userAgent] - 登录时上报的原始 User-Agent；老会话可能为 null
/// * [ip] - 登录时经可信代理头采集的客户端 IP；老会话可能为 null
/// * [loginMethod] - 登录时客户端声明的展示元数据；未声明、null 或 `other` 时为 null，不是认证证据
/// * [createdAt] 
/// * [lastSeenAt] - 最近一次已认证请求时间；早于会话上下文采集功能上线前创建的会话可能为 null
/// * [expiresAt] 
/// * [current] - 是否为发起本次请求的会话
@BuiltValue()
abstract class SessionInfo implements Built<SessionInfo, SessionInfoBuilder> {
  /// 服务端会话记录 ID（非 Privy sid）
  @BuiltValueField(wireName: r'id')
  String get id;

  /// 服务端解析 User-Agent 得到的 `浏览器 · 系统` 标签，回退 device.platform，无证据时为 `Unknown`
  @BuiltValueField(wireName: r'client')
  String get client;

  /// 登录时上报的原始 User-Agent；老会话可能为 null
  @BuiltValueField(wireName: r'user_agent')
  String? get userAgent;

  /// 登录时经可信代理头采集的客户端 IP；老会话可能为 null
  @BuiltValueField(wireName: r'ip')
  String? get ip;

  /// 登录时客户端声明的展示元数据；未声明、null 或 `other` 时为 null，不是认证证据
  @BuiltValueField(wireName: r'login_method')
  String? get loginMethod;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  /// 最近一次已认证请求时间；早于会话上下文采集功能上线前创建的会话可能为 null
  @BuiltValueField(wireName: r'last_seen_at')
  DateTime? get lastSeenAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  /// 是否为发起本次请求的会话
  @BuiltValueField(wireName: r'current')
  bool get current;

  SessionInfo._();

  factory SessionInfo([void updates(SessionInfoBuilder b)]) = _$SessionInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionInfo> get serializer => _$SessionInfoSerializer();
}

class _$SessionInfoSerializer implements PrimitiveSerializer<SessionInfo> {
  @override
  final Iterable<Type> types = const [SessionInfo, _$SessionInfo];

  @override
  final String wireName = r'SessionInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'client';
    yield serializers.serialize(
      object.client,
      specifiedType: const FullType(String),
    );
    yield r'user_agent';
    yield object.userAgent == null ? null : serializers.serialize(
      object.userAgent,
      specifiedType: const FullType.nullable(String),
    );
    yield r'ip';
    yield object.ip == null ? null : serializers.serialize(
      object.ip,
      specifiedType: const FullType.nullable(String),
    );
    yield r'login_method';
    yield object.loginMethod == null ? null : serializers.serialize(
      object.loginMethod,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'last_seen_at';
    yield object.lastSeenAt == null ? null : serializers.serialize(
      object.lastSeenAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'current';
    yield serializers.serialize(
      object.current,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'client':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.client = valueDes;
          break;
        case r'user_agent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userAgent = valueDes;
          break;
        case r'ip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ip = valueDes;
          break;
        case r'login_method':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.loginMethod = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'last_seen_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSeenAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'current':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.current = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionInfoBuilder();
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

