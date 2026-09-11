//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_resource_type.dart';
import 'package:rwa_api_client/src/model/realtime_resource_change.dart';
import 'package:rwa_api_client/src/model/realtime_private_channel.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resource_changed.g.dart';

/// `channel` 与 `resource_type` 必须一一对应：`orders/order`、`positions/position`、 `transfers/transfer`、`claims/claim`、`deposits/deposit`、`withdrawals/withdrawal`、 `balances/balance`、`activity/activity`。任何不一致组合均为服务端 contract violation， 客户端不得据此刷新其他账户 slice 或执行写操作。 
///
/// Properties:
/// * [channel] 
/// * [resourceType] 
/// * [resourceId] - 对应公共 REST resource 的稳定 ID；不包含内部 provider 或 outbox identity。
/// * [change] 
/// * [resourceVersion] - API 从 realtime projection sequence 生成的 decimal string，只用于判断同一资源通知的 新旧；它不是 business entity version，客户端不得将其作为写命令的并发控制版本。 
@BuiltValue()
abstract class RealtimeResourceChanged implements Built<RealtimeResourceChanged, RealtimeResourceChangedBuilder> {
  @BuiltValueField(wireName: r'channel')
  RealtimePrivateChannel get channel;
  // enum channelEnum {  orders,  positions,  transfers,  claims,  deposits,  withdrawals,  balances,  activity,  };

  @BuiltValueField(wireName: r'resource_type')
  RealtimeResourceType get resourceType;
  // enum resourceTypeEnum {  order,  position,  transfer,  claim,  deposit,  withdrawal,  balance,  activity,  };

  /// 对应公共 REST resource 的稳定 ID；不包含内部 provider 或 outbox identity。
  @BuiltValueField(wireName: r'resource_id')
  String get resourceId;

  @BuiltValueField(wireName: r'change')
  RealtimeResourceChange get change;
  // enum changeEnum {  created,  updated,  removed,  };

  /// API 从 realtime projection sequence 生成的 decimal string，只用于判断同一资源通知的 新旧；它不是 business entity version，客户端不得将其作为写命令的并发控制版本。 
  @BuiltValueField(wireName: r'resource_version')
  String get resourceVersion;

  RealtimeResourceChanged._();

  factory RealtimeResourceChanged([void updates(RealtimeResourceChangedBuilder b)]) = _$RealtimeResourceChanged;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RealtimeResourceChangedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RealtimeResourceChanged> get serializer => _$RealtimeResourceChangedSerializer();
}

class _$RealtimeResourceChangedSerializer implements PrimitiveSerializer<RealtimeResourceChanged> {
  @override
  final Iterable<Type> types = const [RealtimeResourceChanged, _$RealtimeResourceChanged];

  @override
  final String wireName = r'RealtimeResourceChanged';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RealtimeResourceChanged object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'channel';
    yield serializers.serialize(
      object.channel,
      specifiedType: const FullType(RealtimePrivateChannel),
    );
    yield r'resource_type';
    yield serializers.serialize(
      object.resourceType,
      specifiedType: const FullType(RealtimeResourceType),
    );
    yield r'resource_id';
    yield serializers.serialize(
      object.resourceId,
      specifiedType: const FullType(String),
    );
    yield r'change';
    yield serializers.serialize(
      object.change,
      specifiedType: const FullType(RealtimeResourceChange),
    );
    yield r'resource_version';
    yield serializers.serialize(
      object.resourceVersion,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RealtimeResourceChanged object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RealtimeResourceChangedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'channel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimePrivateChannel),
          ) as RealtimePrivateChannel;
          result.channel = valueDes;
          break;
        case r'resource_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeResourceType),
          ) as RealtimeResourceType;
          result.resourceType = valueDes;
          break;
        case r'resource_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceId = valueDes;
          break;
        case r'change':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeResourceChange),
          ) as RealtimeResourceChange;
          result.change = valueDes;
          break;
        case r'resource_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceVersion = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RealtimeResourceChanged deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RealtimeResourceChangedBuilder();
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

