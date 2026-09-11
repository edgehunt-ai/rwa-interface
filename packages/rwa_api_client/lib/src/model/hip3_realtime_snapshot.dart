//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_snapshot_item.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_snapshot.g.dart';

/// 最近完整采集批次及其精确事件边界；事件外层event_id是整个快照的续传起点。 多个上游查询并非交易所全局原子快照，以各载荷来源时间和freshness为准。 客户端替换所订阅的状态，之后应用增量；缺项本身不是已平仓/撤单证据。 同一连接可收到带新游标的替换快照，用于完整更新所订阅的实时成员窗口，不需要重新订阅。 订单窗口包含该账户/钱包/环境下的全部活跃订单，以及按服务端updated_at降序（同时间按order_id降序） 选择的最近100条终态订单。filled/cancelled/rejected/failed为终态；reconciliation_status为 conflicting或manual_review的订单仍保留在活跃范围。完整订单历史使用订单列表分页查询。 历史订单退出窗口不是删除历史；不得截断活跃订单后声称完整。窗口超过整体安全容量时明确失败。 K线仅含近期窗口，不表示完整历史。超过服务端安全容量会失败，不能返回截断的完整快照。 
///
/// Properties:
/// * [channels] 
/// * [signer] 
/// * [environment] 
/// * [completedAt] 
/// * [items] 
@BuiltValue()
abstract class Hip3RealtimeSnapshot implements Built<Hip3RealtimeSnapshot, Hip3RealtimeSnapshotBuilder> {
  @BuiltValueField(wireName: r'channels')
  BuiltSet<String> get channels;

  @BuiltValueField(wireName: r'signer')
  String get signer;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'completed_at')
  DateTime get completedAt;

  @BuiltValueField(wireName: r'items')
  BuiltList<Hip3RealtimeSnapshotItem> get items;

  Hip3RealtimeSnapshot._();

  factory Hip3RealtimeSnapshot([void updates(Hip3RealtimeSnapshotBuilder b)]) = _$Hip3RealtimeSnapshot;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeSnapshotBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeSnapshot> get serializer => _$Hip3RealtimeSnapshotSerializer();
}

class _$Hip3RealtimeSnapshotSerializer implements PrimitiveSerializer<Hip3RealtimeSnapshot> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeSnapshot, _$Hip3RealtimeSnapshot];

  @override
  final String wireName = r'Hip3RealtimeSnapshot';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'channels';
    yield serializers.serialize(
      object.channels,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'signer';
    yield serializers.serialize(
      object.signer,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'completed_at';
    yield serializers.serialize(
      object.completedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(Hip3RealtimeSnapshotItem)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeSnapshot object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeSnapshotBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'channels':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.channels.replace(valueDes);
          break;
        case r'signer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signer = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'completed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.completedAt = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3RealtimeSnapshotItem)]),
          ) as BuiltList<Hip3RealtimeSnapshotItem>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimeSnapshot deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeSnapshotBuilder();
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

