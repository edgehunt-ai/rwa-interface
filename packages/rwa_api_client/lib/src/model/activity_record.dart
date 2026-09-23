//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/activity_record_reference.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/activity_record_explorer.dart';
import 'package:rwa_api_client/src/model/activity_status.dart';
import 'package:rwa_api_client/src/model/activity_type.dart';
import 'package:rwa_api_client/src/model/activity_category.dart';
import 'package:rwa_api_client/src/model/bstocks_activity_continuation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_record.g.dart';

/// ActivityRecord
///
/// Properties:
/// * [businessType] - HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
/// * [id] 
/// * [category] 
/// * [type] 
/// * [status] 
/// * [title] 
/// * [amount] - Decimal amount without a unit suffix.
/// * [context] - 副标题，说明市场与当前状态
/// * [failureReason] - 终态失败/人工复核时的可读原因（venue 拒因、reconciliation 说明等）， 来自资源 metadata 的 `last_error_message`/`failure_reason`；非终态或无失败时为 null。 
/// * [symbol] 
/// * [kind] 
/// * [fields] - 展开后的键值对明细
/// * [relatedId] - 关联记录 id（如划转失败 ↔ Claim 退款）
/// * [selfCustodialWithdrawalId] - bStock自托管提现活动的详情入口ID，等于reference.id；使用GET /v1/self-custodial-withdrawals/{id}查询，不路由到旧提现接口。
/// * [continuation] - 仅 `orderSign/pending` bStocks Activity 返回；其他记录省略。
/// * [reference] 
/// * [chain] 
/// * [txHash] 
/// * [explorer] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [asset] - Unit for amount, for example USDC or NVDAB.
@BuiltValue()
abstract class ActivityRecord implements Built<ActivityRecord, ActivityRecordBuilder> {
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueField(wireName: r'business_type')
  ActivityRecordBusinessTypeEnum? get businessType;
  // enum businessTypeEnum {  opening,  closing,  take_profit,  stop_loss,  unknown,  ,  };

  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'category')
  ActivityCategory get category;
  // enum categoryEnum {  orders,  cash,  funding,  };

  @BuiltValueField(wireName: r'type')
  ActivityType get type;
  // enum typeEnum {  market,  limit,  tpsl,  close,  liquidation,  deposit,  external,  bridge,  withdraw,  claim,  funding,  approval,  orderSign,  bridgeSign,  };

  @BuiltValueField(wireName: r'status')
  ActivityStatus get status;
  // enum statusEnum {  pending,  success,  failed,  cancelled,  manual_review,  };

  @BuiltValueField(wireName: r'title')
  String get title;

  /// Decimal amount without a unit suffix.
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// 副标题，说明市场与当前状态
  @BuiltValueField(wireName: r'context')
  String? get context;

  /// 终态失败/人工复核时的可读原因（venue 拒因、reconciliation 说明等）， 来自资源 metadata 的 `last_error_message`/`failure_reason`；非终态或无失败时为 null。 
  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'symbol')
  String? get symbol;

  @BuiltValueField(wireName: r'kind')
  ProductKind? get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 展开后的键值对明细
  @BuiltValueField(wireName: r'fields')
  BuiltList<KeyValue>? get fields;

  /// 关联记录 id（如划转失败 ↔ Claim 退款）
  @BuiltValueField(wireName: r'related_id')
  String? get relatedId;

  /// bStock自托管提现活动的详情入口ID，等于reference.id；使用GET /v1/self-custodial-withdrawals/{id}查询，不路由到旧提现接口。
  @BuiltValueField(wireName: r'self_custodial_withdrawal_id')
  String? get selfCustodialWithdrawalId;

  /// 仅 `orderSign/pending` bStocks Activity 返回；其他记录省略。
  @BuiltValueField(wireName: r'continuation')
  BstocksActivityContinuation? get continuation;

  @BuiltValueField(wireName: r'reference')
  ActivityRecordReference? get reference;

  @BuiltValueField(wireName: r'chain')
  ActivityRecordChainEnum? get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'explorer')
  ActivityRecordExplorer? get explorer;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  /// Unit for amount, for example USDC or NVDAB.
  @BuiltValueField(wireName: r'asset')
  String? get asset;

  ActivityRecord._();

  factory ActivityRecord([void updates(ActivityRecordBuilder b)]) = _$ActivityRecord;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityRecordBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityRecord> get serializer => _$ActivityRecordSerializer();
}

class _$ActivityRecordSerializer implements PrimitiveSerializer<ActivityRecord> {
  @override
  final Iterable<Type> types = const [ActivityRecord, _$ActivityRecord];

  @override
  final String wireName = r'ActivityRecord';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.businessType != null) {
      yield r'business_type';
      yield serializers.serialize(
        object.businessType,
        specifiedType: const FullType.nullable(ActivityRecordBusinessTypeEnum),
      );
    }
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(ActivityCategory),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(ActivityType),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(ActivityStatus),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    if (object.context != null) {
      yield r'context';
      yield serializers.serialize(
        object.context,
        specifiedType: const FullType(String),
      );
    }
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.symbol != null) {
      yield r'symbol';
      yield serializers.serialize(
        object.symbol,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(ProductKind),
      );
    }
    if (object.fields != null) {
      yield r'fields';
      yield serializers.serialize(
        object.fields,
        specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
      );
    }
    if (object.relatedId != null) {
      yield r'related_id';
      yield serializers.serialize(
        object.relatedId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.selfCustodialWithdrawalId != null) {
      yield r'self_custodial_withdrawal_id';
      yield serializers.serialize(
        object.selfCustodialWithdrawalId,
        specifiedType: const FullType(String),
      );
    }
    if (object.continuation != null) {
      yield r'continuation';
      yield serializers.serialize(
        object.continuation,
        specifiedType: const FullType(BstocksActivityContinuation),
      );
    }
    yield r'reference';
    yield object.reference == null ? null : serializers.serialize(
      object.reference,
      specifiedType: const FullType.nullable(ActivityRecordReference),
    );
    yield r'chain';
    yield object.chain == null ? null : serializers.serialize(
      object.chain,
      specifiedType: const FullType.nullable(ActivityRecordChainEnum),
    );
    yield r'tx_hash';
    yield object.txHash == null ? null : serializers.serialize(
      object.txHash,
      specifiedType: const FullType.nullable(String),
    );
    yield r'explorer';
    yield object.explorer == null ? null : serializers.serialize(
      object.explorer,
      specifiedType: const FullType.nullable(ActivityRecordExplorer),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'asset';
    yield object.asset == null ? null : serializers.serialize(
      object.asset,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityRecord object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityRecordBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'business_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ActivityRecordBusinessTypeEnum),
          ) as ActivityRecordBusinessTypeEnum?;
          if (valueDes == null) continue;
          result.businessType = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityCategory),
          ) as ActivityCategory;
          result.category = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityType),
          ) as ActivityType;
          result.type = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityStatus),
          ) as ActivityStatus;
          result.status = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'context':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.context = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.symbol = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ProductKind),
          ) as ProductKind?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'fields':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(KeyValue)]),
          ) as BuiltList<KeyValue>?;
          if (valueDes == null) continue;
          result.fields.replace(valueDes);
          break;
        case r'related_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.relatedId = valueDes;
          break;
        case r'self_custodial_withdrawal_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.selfCustodialWithdrawalId = valueDes;
          break;
        case r'continuation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksActivityContinuation),
          ) as BstocksActivityContinuation?;
          if (valueDes == null) continue;
          result.continuation.replace(valueDes);
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ActivityRecordReference),
          ) as ActivityRecordReference?;
          if (valueDes == null) continue;
          result.reference.replace(valueDes);
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ActivityRecordChainEnum),
          ) as ActivityRecordChainEnum?;
          if (valueDes == null) continue;
          result.chain = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'explorer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ActivityRecordExplorer),
          ) as ActivityRecordExplorer?;
          if (valueDes == null) continue;
          result.explorer.replace(valueDes);
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.asset = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityRecord deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityRecordBuilder();
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

class ActivityRecordBusinessTypeEnum extends EnumClass {

  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'opening')
  static const ActivityRecordBusinessTypeEnum opening = _$activityRecordBusinessTypeEnum_opening;
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'closing')
  static const ActivityRecordBusinessTypeEnum closing = _$activityRecordBusinessTypeEnum_closing;
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'take_profit')
  static const ActivityRecordBusinessTypeEnum takeProfit = _$activityRecordBusinessTypeEnum_takeProfit;
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'stop_loss')
  static const ActivityRecordBusinessTypeEnum stopLoss = _$activityRecordBusinessTypeEnum_stopLoss;
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'unknown')
  static const ActivityRecordBusinessTypeEnum unknown = _$activityRecordBusinessTypeEnum_unknown;
  /// HIP3 业务分类，与 market/limit 执行类型独立。仅依据持久化的开仓 preview 绑定、 reduce_only 或保护单角色判定，不从买卖方向推断开平仓。 无法证明的 HIP3 历史记录为 unknown；非 HIP3 记录为 null。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityRecordBusinessTypeEnum unknownDefaultOpenApi = _$activityRecordBusinessTypeEnum_unknownDefaultOpenApi;

  static Serializer<ActivityRecordBusinessTypeEnum> get serializer => _$activityRecordBusinessTypeEnumSerializer;

  const ActivityRecordBusinessTypeEnum._(String name): super(name);

  static BuiltSet<ActivityRecordBusinessTypeEnum> get values => _$activityRecordBusinessTypeEnumValues;
  static ActivityRecordBusinessTypeEnum valueOf(String name) => _$activityRecordBusinessTypeEnumValueOf(name);
}

class ActivityRecordChainEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const ActivityRecordChainEnum BSC = _$activityRecordChainEnum_BSC;
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ActivityRecordChainEnum arbitrum = _$activityRecordChainEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'Base')
  static const ActivityRecordChainEnum base_ = _$activityRecordChainEnum_base_;
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const ActivityRecordChainEnum ethereum = _$activityRecordChainEnum_ethereum;
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const ActivityRecordChainEnum hyperliquid = _$activityRecordChainEnum_hyperliquid;
  @BuiltValueEnumConst(wireName: r'Polygon')
  static const ActivityRecordChainEnum polygon = _$activityRecordChainEnum_polygon;
  @BuiltValueEnumConst(wireName: r'Solana')
  static const ActivityRecordChainEnum solana = _$activityRecordChainEnum_solana;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityRecordChainEnum unknownDefaultOpenApi = _$activityRecordChainEnum_unknownDefaultOpenApi;

  static Serializer<ActivityRecordChainEnum> get serializer => _$activityRecordChainEnumSerializer;

  const ActivityRecordChainEnum._(String name): super(name);

  static BuiltSet<ActivityRecordChainEnum> get values => _$activityRecordChainEnumValues;
  static ActivityRecordChainEnum valueOf(String name) => _$activityRecordChainEnumValueOf(name);
}

