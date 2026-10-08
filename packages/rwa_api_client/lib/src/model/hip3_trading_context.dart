//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_market_order_minimums.dart';
import 'package:rwa_api_client/src/model/hip3_operation.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:rwa_api_client/src/model/hip3_order_capacity.dart';
import 'package:rwa_api_client/src/model/hip3_trading_rules.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_trading_context.g.dart';

/// 服务端从当前账户绑定及运行环境推导 context_id。无可靠账户余额返回 503。 supported_operations 只描述 client-signed 路径，不因 Agent 路径可用而开启。 available_margin_usdc 是普通抵押资产额度扣除本地尚未被 HL 确认的预留后的余额，与 withdrawable_usdc 分开； 已被 HL 确认、且已反映在当前 HL 观测中的订单不再重复扣除本地预留； 包括部分成交或已成交、但本地成交结算尚未完成的订单。 均非账户总权益。market_order_minimums 供下单前展示币种、方向对应的最小市价单金额及 当前杠杆下最低保证金；最大可开量仍受方向、价格与杠杆影响，在订单 preview 中返回。 百分比下单应使用 order_capacity 对应方向，而不是顶层 available_margin_usdc。 给定当前设置下的数量上限 Q、方向可用额度 A、下单价格 P、杠杆 L、taker 费率 r、预留系数 k： Q0 = min(Q, A × L / P, rules.maximum_notional_usdc / P)； F = ceil(Q0 × P × r, 6)，R = ceil(F × k, 6)，B = floor(max(A - R, 0), 6)； 最大数量 = floor(min(Q, B × L / P, rules.maximum_notional_usdc / P), rules.size_decimals)。 P 使用限价单价格或市价单按方向和精度生成的滑点保护限价；全程使用十进制定点计算。 Q 是 HL 原始数量上限，不是平台最终最大量，也不承诺某一明确的手续费扣减方式。 配置/行情变化会改变可执行容量，最终以最新 preview 为准。调整杠杆或保证金模式后先完成设置并重新获取 context； 不得将旧设置下的 Q/A 按杠杆比例换算。补款后保留原订单参数重新 preview，不自动重新拉满。 
///
/// Properties:
/// * [contextId] 
/// * [environment] 
/// * [productId] 
/// * [symbol] 
/// * [venue] 
/// * [settlementAsset] 
/// * [rules] 
/// * [marketOrderMinimums] - 当前盘口可用时返回；不支持市价单或无法取得新鲜盘口时为 null。
/// * [currentLeverage] - 十进制字符串，避免浮点误差
/// * [currentMarginMode] 
/// * [availableMarginUsdc] - 十进制字符串，避免浮点误差
/// * [withdrawableUsdc] - 十进制字符串，避免浮点误差
/// * [takerFeeRate] - 当前账户和 USDC 抵押 HIP-3 市场的预计 taker 费率（含账户费率、部署者倍率、growth mode 和有效推荐折扣），不含平台额外预留。只读场景无费率证据时为 null。
/// * [feeReserveMultiplier] - 后端配置的手续费预留系数（1–10，初始默认 1.2），不是实际收费倍率。只读场景为 null。
/// * [orderCapacity] - 当前账户设置下的双向交易额度。账户尚未就绪、只读场景或上游未提供方向额度时为 null；真实零额度返回字符串 0。
/// * [supportedOperations] 
/// * [blocker] 
/// * [observedAt] 
/// * [validUntil] 
@BuiltValue()
abstract class Hip3TradingContext implements Built<Hip3TradingContext, Hip3TradingContextBuilder> {
  @BuiltValueField(wireName: r'context_id')
  String get contextId;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'venue')
  String get venue;

  @BuiltValueField(wireName: r'settlement_asset')
  Hip3TradingContextSettlementAssetEnum get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  @BuiltValueField(wireName: r'rules')
  Hip3TradingRules get rules;

  /// 当前盘口可用时返回；不支持市价单或无法取得新鲜盘口时为 null。
  @BuiltValueField(wireName: r'market_order_minimums')
  Hip3MarketOrderMinimums? get marketOrderMinimums;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'current_leverage')
  String? get currentLeverage;

  @BuiltValueField(wireName: r'current_margin_mode')
  MarginMode? get currentMarginMode;
  // enum currentMarginModeEnum {  isolated,  cross,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_margin_usdc')
  String get availableMarginUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'withdrawable_usdc')
  String get withdrawableUsdc;

  /// 当前账户和 USDC 抵押 HIP-3 市场的预计 taker 费率（含账户费率、部署者倍率、growth mode 和有效推荐折扣），不含平台额外预留。只读场景无费率证据时为 null。
  @BuiltValueField(wireName: r'taker_fee_rate')
  String? get takerFeeRate;

  /// 后端配置的手续费预留系数（1–10，初始默认 1.2），不是实际收费倍率。只读场景为 null。
  @BuiltValueField(wireName: r'fee_reserve_multiplier')
  String? get feeReserveMultiplier;

  /// 当前账户设置下的双向交易额度。账户尚未就绪、只读场景或上游未提供方向额度时为 null；真实零额度返回字符串 0。
  @BuiltValueField(wireName: r'order_capacity')
  Hip3OrderCapacity? get orderCapacity;

  @BuiltValueField(wireName: r'supported_operations')
  BuiltList<Hip3Operation> get supportedOperations;

  @BuiltValueField(wireName: r'blocker')
  String? get blocker;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  Hip3TradingContext._();

  factory Hip3TradingContext([void updates(Hip3TradingContextBuilder b)]) = _$Hip3TradingContext;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3TradingContextBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3TradingContext> get serializer => _$Hip3TradingContextSerializer();
}

class _$Hip3TradingContextSerializer implements PrimitiveSerializer<Hip3TradingContext> {
  @override
  final Iterable<Type> types = const [Hip3TradingContext, _$Hip3TradingContext];

  @override
  final String wireName = r'Hip3TradingContext';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3TradingContext object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'context_id';
    yield serializers.serialize(
      object.contextId,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'venue';
    yield serializers.serialize(
      object.venue,
      specifiedType: const FullType(String),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(Hip3TradingContextSettlementAssetEnum),
    );
    yield r'rules';
    yield serializers.serialize(
      object.rules,
      specifiedType: const FullType(Hip3TradingRules),
    );
    yield r'market_order_minimums';
    yield object.marketOrderMinimums == null ? null : serializers.serialize(
      object.marketOrderMinimums,
      specifiedType: const FullType.nullable(Hip3MarketOrderMinimums),
    );
    yield r'current_leverage';
    yield object.currentLeverage == null ? null : serializers.serialize(
      object.currentLeverage,
      specifiedType: const FullType.nullable(String),
    );
    yield r'current_margin_mode';
    yield object.currentMarginMode == null ? null : serializers.serialize(
      object.currentMarginMode,
      specifiedType: const FullType.nullable(MarginMode),
    );
    yield r'available_margin_usdc';
    yield serializers.serialize(
      object.availableMarginUsdc,
      specifiedType: const FullType(String),
    );
    yield r'withdrawable_usdc';
    yield serializers.serialize(
      object.withdrawableUsdc,
      specifiedType: const FullType(String),
    );
    if (object.takerFeeRate != null) {
      yield r'taker_fee_rate';
      yield serializers.serialize(
        object.takerFeeRate,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.feeReserveMultiplier != null) {
      yield r'fee_reserve_multiplier';
      yield serializers.serialize(
        object.feeReserveMultiplier,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.orderCapacity != null) {
      yield r'order_capacity';
      yield serializers.serialize(
        object.orderCapacity,
        specifiedType: const FullType.nullable(Hip3OrderCapacity),
      );
    }
    yield r'supported_operations';
    yield serializers.serialize(
      object.supportedOperations,
      specifiedType: const FullType(BuiltList, [FullType(Hip3Operation)]),
    );
    yield r'blocker';
    yield object.blocker == null ? null : serializers.serialize(
      object.blocker,
      specifiedType: const FullType.nullable(String),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3TradingContext object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3TradingContextBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'context_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contextId = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'venue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.venue = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TradingContextSettlementAssetEnum),
          ) as Hip3TradingContextSettlementAssetEnum;
          result.settlementAsset = valueDes;
          break;
        case r'rules':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TradingRules),
          ) as Hip3TradingRules;
          result.rules.replace(valueDes);
          break;
        case r'market_order_minimums':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3MarketOrderMinimums),
          ) as Hip3MarketOrderMinimums?;
          if (valueDes == null) continue;
          result.marketOrderMinimums.replace(valueDes);
          break;
        case r'current_leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentLeverage = valueDes;
          break;
        case r'current_margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarginMode),
          ) as MarginMode?;
          if (valueDes == null) continue;
          result.currentMarginMode = valueDes;
          break;
        case r'available_margin_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableMarginUsdc = valueDes;
          break;
        case r'withdrawable_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.withdrawableUsdc = valueDes;
          break;
        case r'taker_fee_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.takerFeeRate = valueDes;
          break;
        case r'fee_reserve_multiplier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeReserveMultiplier = valueDes;
          break;
        case r'order_capacity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3OrderCapacity),
          ) as Hip3OrderCapacity?;
          if (valueDes == null) continue;
          result.orderCapacity.replace(valueDes);
          break;
        case r'supported_operations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3Operation)]),
          ) as BuiltList<Hip3Operation>;
          result.supportedOperations.replace(valueDes);
          break;
        case r'blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.blocker = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3TradingContext deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3TradingContextBuilder();
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

class Hip3TradingContextSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3TradingContextSettlementAssetEnum USDC = _$hip3TradingContextSettlementAssetEnum_USDC;

  static Serializer<Hip3TradingContextSettlementAssetEnum> get serializer => _$hip3TradingContextSettlementAssetEnumSerializer;

  const Hip3TradingContextSettlementAssetEnum._(String name): super(name);

  static BuiltSet<Hip3TradingContextSettlementAssetEnum> get values => _$hip3TradingContextSettlementAssetEnumValues;
  static Hip3TradingContextSettlementAssetEnum valueOf(String name) => _$hip3TradingContextSettlementAssetEnumValueOf(name);
}

