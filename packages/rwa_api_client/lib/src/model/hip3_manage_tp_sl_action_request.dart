//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_protection_change.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_manage_tp_sl_action_request.g.dart';

/// 显式管理已有仓位的独立保护订单。每项区分 create/modify/cancel，允许同仓位多笔同类型订单。 create 不取消已有订单；modify 仅替换指定 order_id 且必须保留原角色；cancel 仅取消指定 order_id。 数量按市场精度向下规范化；归零返回422 hip3_protection_quantity_below_step。 details.blockers[].details 提供size_decimals、quantity_step、requested_quantity和normalized_quantity（字符串），不自动向上放大数量。 quantity_step是最小正数量单位，不代表所有价格下都满足交易所最小名义金额。 order_id 为本系统订单ID，不接受客户端提供交易所oid、cloid、市场编号、签名账户或方向。 每项 protection 恰好一个 TP 或 SL；未出现在 changes 中的订单保持不变。同一原订单不能重复出现。 接受前完整验证所有目标与新参数；结果不明时读取同一 action，不得换幂等键重建。 批量取消所有选定旧订单并逐笔确认，全部取消确认后才释放新保护。 固定数量新订单批量提交；原生全仓订单另一个批次以保留 positionTpsl 语义。 每个批次一份签名。批量不保证全部成功，订单结果在 steps.protection_orders 逐笔返回。 原订单取消确认后新订单仍可能失败，此时真实保护缺口必须展示；不自动恢复旧订单或取消成功的新订单。 
///
/// Properties:
/// * [operation] 
/// * [positionId] 
/// * [positionVersion] 
/// * [changes] 
@BuiltValue()
abstract class Hip3ManageTpSlActionRequest implements Built<Hip3ManageTpSlActionRequest, Hip3ManageTpSlActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3ManageTpSlActionRequestOperationEnum get operation;
  // enum operationEnum {  manage_tpsl,  };

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'position_version')
  String get positionVersion;

  @BuiltValueField(wireName: r'changes')
  BuiltList<Hip3ProtectionChange> get changes;

  Hip3ManageTpSlActionRequest._();

  factory Hip3ManageTpSlActionRequest([void updates(Hip3ManageTpSlActionRequestBuilder b)]) = _$Hip3ManageTpSlActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ManageTpSlActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ManageTpSlActionRequest> get serializer => _$Hip3ManageTpSlActionRequestSerializer();
}

class _$Hip3ManageTpSlActionRequestSerializer implements PrimitiveSerializer<Hip3ManageTpSlActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3ManageTpSlActionRequest, _$Hip3ManageTpSlActionRequest];

  @override
  final String wireName = r'Hip3ManageTpSlActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ManageTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3ManageTpSlActionRequestOperationEnum),
    );
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'position_version';
    yield serializers.serialize(
      object.positionVersion,
      specifiedType: const FullType(String),
    );
    yield r'changes';
    yield serializers.serialize(
      object.changes,
      specifiedType: const FullType(BuiltList, [FullType(Hip3ProtectionChange)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ManageTpSlActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ManageTpSlActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ManageTpSlActionRequestOperationEnum),
          ) as Hip3ManageTpSlActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'position_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionVersion = valueDes;
          break;
        case r'changes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3ProtectionChange)]),
          ) as BuiltList<Hip3ProtectionChange>;
          result.changes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ManageTpSlActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ManageTpSlActionRequestBuilder();
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

class Hip3ManageTpSlActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'manage_tpsl')
  static const Hip3ManageTpSlActionRequestOperationEnum manageTpsl = _$hip3ManageTpSlActionRequestOperationEnum_manageTpsl;

  static Serializer<Hip3ManageTpSlActionRequestOperationEnum> get serializer => _$hip3ManageTpSlActionRequestOperationEnumSerializer;

  const Hip3ManageTpSlActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3ManageTpSlActionRequestOperationEnum> get values => _$hip3ManageTpSlActionRequestOperationEnumValues;
  static Hip3ManageTpSlActionRequestOperationEnum valueOf(String name) => _$hip3ManageTpSlActionRequestOperationEnumValueOf(name);
}

