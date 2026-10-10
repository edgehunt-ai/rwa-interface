//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ended_session_info.g.dart';

/// 已结束会话（撤销或过期）。`id` 不会出现在 `items` 中；`current` 恒为 false 故省略
///
/// Properties:
/// * [id] - 服务端会话记录 ID（非 Privy sid）
/// * [client] - 服务端解析 User-Agent 得到的 `浏览器 · 系统` 标签，回退 device.platform，无证据时为 `Unknown`
/// * [userAgent] - 登录时上报的原始 User-Agent；老会话可能为 null
/// * [ip] - 登录时经可信代理头采集的客户端 IP；老会话可能为 null
/// * [loginMethod] - 登录时客户端声明的展示元数据；未声明、null 或 `other` 时为 null，不是认证证据
/// * [createdAt] 
/// * [lastSeenAt] - 最近一次已认证请求时间
/// * [expiresAt] 
/// * [endedAt] - 会话实际结束时间；撤销为 `revoked_at`，自然过期为 `expires_at`
/// * [endReason] - 结束原因；`revoked` 含单条撤销与被 `revoke-others` 批量撤销，不区分发起方
@BuiltValue()
abstract class EndedSessionInfo implements Built<EndedSessionInfo, EndedSessionInfoBuilder> {
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

  /// 最近一次已认证请求时间
  @BuiltValueField(wireName: r'last_seen_at')
  DateTime? get lastSeenAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  /// 会话实际结束时间；撤销为 `revoked_at`，自然过期为 `expires_at`
  @BuiltValueField(wireName: r'ended_at')
  DateTime get endedAt;

  /// 结束原因；`revoked` 含单条撤销与被 `revoke-others` 批量撤销，不区分发起方
  @BuiltValueField(wireName: r'end_reason')
  EndedSessionInfoEndReasonEnum get endReason;
  // enum endReasonEnum {  revoked,  expired,  };

  EndedSessionInfo._();

  factory EndedSessionInfo([void updates(EndedSessionInfoBuilder b)]) = _$EndedSessionInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EndedSessionInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EndedSessionInfo> get serializer => _$EndedSessionInfoSerializer();
}

class _$EndedSessionInfoSerializer implements PrimitiveSerializer<EndedSessionInfo> {
  @override
  final Iterable<Type> types = const [EndedSessionInfo, _$EndedSessionInfo];

  @override
  final String wireName = r'EndedSessionInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EndedSessionInfo object, {
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
    yield r'ended_at';
    yield serializers.serialize(
      object.endedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'end_reason';
    yield serializers.serialize(
      object.endReason,
      specifiedType: const FullType(EndedSessionInfoEndReasonEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EndedSessionInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EndedSessionInfoBuilder result,
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
        case r'ended_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endedAt = valueDes;
          break;
        case r'end_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EndedSessionInfoEndReasonEnum),
          ) as EndedSessionInfoEndReasonEnum;
          result.endReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EndedSessionInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EndedSessionInfoBuilder();
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

class EndedSessionInfoEndReasonEnum extends EnumClass {

  /// 结束原因；`revoked` 含单条撤销与被 `revoke-others` 批量撤销，不区分发起方
  @BuiltValueEnumConst(wireName: r'revoked')
  static const EndedSessionInfoEndReasonEnum revoked = _$endedSessionInfoEndReasonEnum_revoked;
  /// 结束原因；`revoked` 含单条撤销与被 `revoke-others` 批量撤销，不区分发起方
  @BuiltValueEnumConst(wireName: r'expired')
  static const EndedSessionInfoEndReasonEnum expired = _$endedSessionInfoEndReasonEnum_expired;

  static Serializer<EndedSessionInfoEndReasonEnum> get serializer => _$endedSessionInfoEndReasonEnumSerializer;

  const EndedSessionInfoEndReasonEnum._(String name): super(name);

  static BuiltSet<EndedSessionInfoEndReasonEnum> get values => _$endedSessionInfoEndReasonEnumValues;
  static EndedSessionInfoEndReasonEnum valueOf(String name) => _$endedSessionInfoEndReasonEnumValueOf(name);
}

