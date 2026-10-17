//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_cash_flow_endpoint.g.dart';

/// ActivityCashFlowEndpoint
///
/// Properties:
/// * [asset] - 用户可见币种，例如 USDT 或 USDC；Hyperliquid Perps 的 USDC-PERPS 账户单位显示为 USDC。
/// * [chain] - Canonical account network; use chain_id to distinguish EVM networks.
/// * [chainId] - EVM 链的精确 chain ID（区分主网与测试网）；Hyperliquid Perps 等非 EVM 账户为 null，不使用签名链或桥接中转链 ID 冒充。
@BuiltValue()
abstract class ActivityCashFlowEndpoint implements Built<ActivityCashFlowEndpoint, ActivityCashFlowEndpointBuilder> {
  /// 用户可见币种，例如 USDT 或 USDC；Hyperliquid Perps 的 USDC-PERPS 账户单位显示为 USDC。
  @BuiltValueField(wireName: r'asset')
  String get asset;

  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueField(wireName: r'chain')
  ActivityCashFlowEndpointChainEnum get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// EVM 链的精确 chain ID（区分主网与测试网）；Hyperliquid Perps 等非 EVM 账户为 null，不使用签名链或桥接中转链 ID 冒充。
  @BuiltValueField(wireName: r'chain_id')
  String? get chainId;

  ActivityCashFlowEndpoint._();

  factory ActivityCashFlowEndpoint([void updates(ActivityCashFlowEndpointBuilder b)]) = _$ActivityCashFlowEndpoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityCashFlowEndpointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityCashFlowEndpoint> get serializer => _$ActivityCashFlowEndpointSerializer();
}

class _$ActivityCashFlowEndpointSerializer implements PrimitiveSerializer<ActivityCashFlowEndpoint> {
  @override
  final Iterable<Type> types = const [ActivityCashFlowEndpoint, _$ActivityCashFlowEndpoint];

  @override
  final String wireName = r'ActivityCashFlowEndpoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityCashFlowEndpoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(ActivityCashFlowEndpointChainEnum),
    );
    yield r'chain_id';
    yield object.chainId == null ? null : serializers.serialize(
      object.chainId,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityCashFlowEndpoint object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityCashFlowEndpointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.asset = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityCashFlowEndpointChainEnum),
          ) as ActivityCashFlowEndpointChainEnum;
          result.chain = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityCashFlowEndpoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityCashFlowEndpointBuilder();
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

class ActivityCashFlowEndpointChainEnum extends EnumClass {

  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'BSC')
  static const ActivityCashFlowEndpointChainEnum BSC = _$activityCashFlowEndpointChainEnum_BSC;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const ActivityCashFlowEndpointChainEnum arbitrum = _$activityCashFlowEndpointChainEnum_arbitrum;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Base')
  static const ActivityCashFlowEndpointChainEnum base_ = _$activityCashFlowEndpointChainEnum_base_;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const ActivityCashFlowEndpointChainEnum ethereum = _$activityCashFlowEndpointChainEnum_ethereum;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const ActivityCashFlowEndpointChainEnum hyperliquid = _$activityCashFlowEndpointChainEnum_hyperliquid;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Polygon')
  static const ActivityCashFlowEndpointChainEnum polygon = _$activityCashFlowEndpointChainEnum_polygon;
  /// Canonical account network; use chain_id to distinguish EVM networks.
  @BuiltValueEnumConst(wireName: r'Solana')
  static const ActivityCashFlowEndpointChainEnum solana = _$activityCashFlowEndpointChainEnum_solana;

  static Serializer<ActivityCashFlowEndpointChainEnum> get serializer => _$activityCashFlowEndpointChainEnumSerializer;

  const ActivityCashFlowEndpointChainEnum._(String name): super(name);

  static BuiltSet<ActivityCashFlowEndpointChainEnum> get values => _$activityCashFlowEndpointChainEnumValues;
  static ActivityCashFlowEndpointChainEnum valueOf(String name) => _$activityCashFlowEndpointChainEnumValueOf(name);
}

