//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_cross_liquidation_impact.dart';
import 'package:rwa_api_client/src/model/hip3_opening_protection_confirmation.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_preview_execution.g.dart';

/// HIP3 预览规范化后的执行条件。amount 是名义金额而非保证金；费用明确以 USDC 计价。 market 使用有滑点边界的 IOC；limit 按指定 TIF，不保证成交。 maximum_quantity 是按 trading-context 所述原始数量预留算法计算的保守最大建议量（reduce-only 为可减仓量）。 手动输入略高于该建议量时，按本次订单实际保证金 + 手续费预留及 HL 原始数量上限校验；不据此要求无意义的补款。 estimated_fee_usdc 和顶层 fee 只表示预计实际 taker 费用；额外安全预留不计入强平价模拟中的实际支出。 preview 冻结条件而非保证市场成交价；create order 必须与预览一致，且再次校验过期、 仓位、可用余额与规则。强平价无法估算时为 null 并给出 reason，不展示为 0。 余额不足、账户未激活、杠杆/保证金模式待设置或当前方向容量不足不阻止预览返回 HTTP 200； 仍返回按请求计算的数量、名义金额、费用及所需保证金，并在 blockers 中说明下单阻塞。 杠杆及 margin_mode 返回用户请求的目标设置，金额、费用及所需保证金按目标设置计算。 账户有这些阻塞时不模拟未确认的充值或设置变更：强平价为 null，其他仓位影响的 after 值为 null。 设置不一致时 maximum_quantity 为 null：官方 maxTradeSzs 只适用于当前设置，不能当作目标设置的容量。 设置一致时 available_margin_usdc 使用 HL activeAssetData.availableToTrade 的当前下单方向额度， 再扣除本地尚未被 HL 观测包含的预留；该额度包含抵消反向仓位的能力， 因此可能高于 trading-context 的普通抵押资产余额，不能用作提现额度。 上游未提供方向额度或目标设置尚未生效时，按普通抵押资产余额保守估算。 真实余额及容量为零时返回 \"0\"；上游不可用不等同于零余额，仍返回错误。 
///
/// Properties:
/// * [blockers] - 当前账户执行此订单的阻塞原因，非预览计算错误。当前包括 account_not_activated、 insufficient_margin、insufficient_size_capacity、leverage_update_required、 margin_mode_update_required；无阻塞返回 []。设置不一致时应先完成设置，再刷新预览。 客户端应容忍未知原因；旧服务可能缺少此字段，缺省不代表已通过执行校验。 即使数组为空，下单及广播仍须重新验证账户状态、余额、容量和行情。 
/// * [openingProtection] - 开仓请求附带 protection 时必须返回，与同次父单签名中的子保护完全一致。无保护时省略；不得作为已激活证明。
/// * [contextId] 
/// * [productId] 
/// * [environment] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [type] 
/// * [timeInForce] 
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [leverage] - 十进制字符串，避免浮点误差
/// * [marginMode] 
/// * [reduceOnly] 
/// * [notionalUsdc] - 十进制字符串，避免浮点误差
/// * [marginRequiredUsdc] - 本次订单资金门槛，等于 ceil(notional_usdc / leverage + estimated_fee_usdc, 6)。开仓校验、资金预留和补款需求使用此口径，不包含 fee_reserve_usdc 中的额外缓冲。平仓预览沿用平仓语义。
/// * [availableMarginUsdc] - 十进制字符串，避免浮点误差
/// * [maximumQuantity] - 含 fee_reserve_multiplier 安全余量的保守滑杆最大数量，不是额外的硬性拒单上限。实际订单仍按保证金加预计手续费校验，并受 HL 数量上限、平台金额和精度等规则约束。
/// * [maximumQuantityUnavailableReason] - 最大数量不可用的原因；设置尚未生效时为 account_settings_update_required，可用时为 null。旧服务可能不返回此字段。
/// * [feeReserveUsdc] - 本次开仓建议预留的手续费预算，等于 ceil(estimated_fee_usdc × fee_reserve_multiplier, 6)，包含预计手续费及安全余量；用于展示，不是额外收费或实际冻结金额。margin_required_usdc 仅包括保证金与 estimated_fee_usdc，后端不会要求额外安全余量始终完整。平仓预览不返回该字段。
/// * [estimatedFeeUsdc] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 十进制字符串，避免浮点误差
/// * [liquidationPriceUnavailableReason] 
/// * [crossLiquidationImpacts] - 本次订单如果成交，对其他 USDC 全仓仓位强平价的账户级影响；不重复返回本单目标商品。 当前强平价不可用或无法可靠模拟时保留仓位身份和方向，并在 unavailable_reason 说明原因。 
/// * [slippagePercent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class Hip3PreviewExecution implements Built<Hip3PreviewExecution, Hip3PreviewExecutionBuilder> {
  /// 当前账户执行此订单的阻塞原因，非预览计算错误。当前包括 account_not_activated、 insufficient_margin、insufficient_size_capacity、leverage_update_required、 margin_mode_update_required；无阻塞返回 []。设置不一致时应先完成设置，再刷新预览。 客户端应容忍未知原因；旧服务可能缺少此字段，缺省不代表已通过执行校验。 即使数组为空，下单及广播仍须重新验证账户状态、余额、容量和行情。 
  @BuiltValueField(wireName: r'blockers')
  BuiltSet<String>? get blockers;

  /// 开仓请求附带 protection 时必须返回，与同次父单签名中的子保护完全一致。无保护时省略；不得作为已激活证明。
  @BuiltValueField(wireName: r'opening_protection')
  Hip3OpeningProtectionConfirmation? get openingProtection;

  @BuiltValueField(wireName: r'context_id')
  String get contextId;

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  @BuiltValueField(wireName: r'type')
  Hip3PreviewExecutionTypeEnum get type;
  // enum typeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String get limitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'leverage')
  String get leverage;

  @BuiltValueField(wireName: r'margin_mode')
  MarginMode get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  @BuiltValueField(wireName: r'reduce_only')
  bool get reduceOnly;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'notional_usdc')
  String get notionalUsdc;

  /// 本次订单资金门槛，等于 ceil(notional_usdc / leverage + estimated_fee_usdc, 6)。开仓校验、资金预留和补款需求使用此口径，不包含 fee_reserve_usdc 中的额外缓冲。平仓预览沿用平仓语义。
  @BuiltValueField(wireName: r'margin_required_usdc')
  String get marginRequiredUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_margin_usdc')
  String get availableMarginUsdc;

  /// 含 fee_reserve_multiplier 安全余量的保守滑杆最大数量，不是额外的硬性拒单上限。实际订单仍按保证金加预计手续费校验，并受 HL 数量上限、平台金额和精度等规则约束。
  @BuiltValueField(wireName: r'maximum_quantity')
  String? get maximumQuantity;

  /// 最大数量不可用的原因；设置尚未生效时为 account_settings_update_required，可用时为 null。旧服务可能不返回此字段。
  @BuiltValueField(wireName: r'maximum_quantity_unavailable_reason')
  String? get maximumQuantityUnavailableReason;

  /// 本次开仓建议预留的手续费预算，等于 ceil(estimated_fee_usdc × fee_reserve_multiplier, 6)，包含预计手续费及安全余量；用于展示，不是额外收费或实际冻结金额。margin_required_usdc 仅包括保证金与 estimated_fee_usdc，后端不会要求额外安全余量始终完整。平仓预览不返回该字段。
  @BuiltValueField(wireName: r'fee_reserve_usdc')
  String? get feeReserveUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_fee_usdc')
  String get estimatedFeeUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'liquidation_price')
  String? get liquidationPrice;

  @BuiltValueField(wireName: r'liquidation_price_unavailable_reason')
  String? get liquidationPriceUnavailableReason;

  /// 本次订单如果成交，对其他 USDC 全仓仓位强平价的账户级影响；不重复返回本单目标商品。 当前强平价不可用或无法可靠模拟时保留仓位身份和方向，并在 unavailable_reason 说明原因。 
  @BuiltValueField(wireName: r'cross_liquidation_impacts')
  BuiltList<Hip3CrossLiquidationImpact> get crossLiquidationImpacts;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'slippage_percent')
  String get slippagePercent;

  Hip3PreviewExecution._();

  factory Hip3PreviewExecution([void updates(Hip3PreviewExecutionBuilder b)]) = _$Hip3PreviewExecution;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3PreviewExecutionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3PreviewExecution> get serializer => _$Hip3PreviewExecutionSerializer();
}

class _$Hip3PreviewExecutionSerializer implements PrimitiveSerializer<Hip3PreviewExecution> {
  @override
  final Iterable<Type> types = const [Hip3PreviewExecution, _$Hip3PreviewExecution];

  @override
  final String wireName = r'Hip3PreviewExecution';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3PreviewExecution object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.blockers != null) {
      yield r'blockers';
      yield serializers.serialize(
        object.blockers,
        specifiedType: const FullType(BuiltSet, [FullType(String)]),
      );
    }
    if (object.openingProtection != null) {
      yield r'opening_protection';
      yield serializers.serialize(
        object.openingProtection,
        specifiedType: const FullType(Hip3OpeningProtectionConfirmation),
      );
    }
    yield r'context_id';
    yield serializers.serialize(
      object.contextId,
      specifiedType: const FullType(String),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(Hip3PreviewExecutionTypeEnum),
    );
    yield r'time_in_force';
    yield serializers.serialize(
      object.timeInForce,
      specifiedType: const FullType(Hip3TimeInForce),
    );
    yield r'limit_price';
    yield serializers.serialize(
      object.limitPrice,
      specifiedType: const FullType(String),
    );
    yield r'leverage';
    yield serializers.serialize(
      object.leverage,
      specifiedType: const FullType(String),
    );
    yield r'margin_mode';
    yield serializers.serialize(
      object.marginMode,
      specifiedType: const FullType(MarginMode),
    );
    yield r'reduce_only';
    yield serializers.serialize(
      object.reduceOnly,
      specifiedType: const FullType(bool),
    );
    yield r'notional_usdc';
    yield serializers.serialize(
      object.notionalUsdc,
      specifiedType: const FullType(String),
    );
    yield r'margin_required_usdc';
    yield serializers.serialize(
      object.marginRequiredUsdc,
      specifiedType: const FullType(String),
    );
    yield r'available_margin_usdc';
    yield serializers.serialize(
      object.availableMarginUsdc,
      specifiedType: const FullType(String),
    );
    yield r'maximum_quantity';
    yield object.maximumQuantity == null ? null : serializers.serialize(
      object.maximumQuantity,
      specifiedType: const FullType.nullable(String),
    );
    if (object.maximumQuantityUnavailableReason != null) {
      yield r'maximum_quantity_unavailable_reason';
      yield serializers.serialize(
        object.maximumQuantityUnavailableReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.feeReserveUsdc != null) {
      yield r'fee_reserve_usdc';
      yield serializers.serialize(
        object.feeReserveUsdc,
        specifiedType: const FullType(String),
      );
    }
    yield r'estimated_fee_usdc';
    yield serializers.serialize(
      object.estimatedFeeUsdc,
      specifiedType: const FullType(String),
    );
    yield r'liquidation_price';
    yield object.liquidationPrice == null ? null : serializers.serialize(
      object.liquidationPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'liquidation_price_unavailable_reason';
    yield object.liquidationPriceUnavailableReason == null ? null : serializers.serialize(
      object.liquidationPriceUnavailableReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'cross_liquidation_impacts';
    yield serializers.serialize(
      object.crossLiquidationImpacts,
      specifiedType: const FullType(BuiltList, [FullType(Hip3CrossLiquidationImpact)]),
    );
    yield r'slippage_percent';
    yield serializers.serialize(
      object.slippagePercent,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3PreviewExecution object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3PreviewExecutionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>?;
          if (valueDes == null) continue;
          result.blockers.replace(valueDes);
          break;
        case r'opening_protection':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3OpeningProtectionConfirmation),
          ) as Hip3OpeningProtectionConfirmation?;
          if (valueDes == null) continue;
          result.openingProtection.replace(valueDes);
          break;
        case r'context_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contextId = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PreviewExecutionTypeEnum),
          ) as Hip3PreviewExecutionTypeEnum;
          result.type = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TimeInForce),
          ) as Hip3TimeInForce;
          result.timeInForce = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.limitPrice = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MarginMode),
          ) as MarginMode;
          result.marginMode = valueDes;
          break;
        case r'reduce_only':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.reduceOnly = valueDes;
          break;
        case r'notional_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notionalUsdc = valueDes;
          break;
        case r'margin_required_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.marginRequiredUsdc = valueDes;
          break;
        case r'available_margin_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableMarginUsdc = valueDes;
          break;
        case r'maximum_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maximumQuantity = valueDes;
          break;
        case r'maximum_quantity_unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maximumQuantityUnavailableReason = valueDes;
          break;
        case r'fee_reserve_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.feeReserveUsdc = valueDes;
          break;
        case r'estimated_fee_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedFeeUsdc = valueDes;
          break;
        case r'liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPrice = valueDes;
          break;
        case r'liquidation_price_unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPriceUnavailableReason = valueDes;
          break;
        case r'cross_liquidation_impacts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3CrossLiquidationImpact)]),
          ) as BuiltList<Hip3CrossLiquidationImpact>;
          result.crossLiquidationImpacts.replace(valueDes);
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.slippagePercent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3PreviewExecution deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3PreviewExecutionBuilder();
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

class Hip3PreviewExecutionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3PreviewExecutionTypeEnum market = _$hip3PreviewExecutionTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3PreviewExecutionTypeEnum limit = _$hip3PreviewExecutionTypeEnum_limit;

  static Serializer<Hip3PreviewExecutionTypeEnum> get serializer => _$hip3PreviewExecutionTypeEnumSerializer;

  const Hip3PreviewExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3PreviewExecutionTypeEnum> get values => _$hip3PreviewExecutionTypeEnumValues;
  static Hip3PreviewExecutionTypeEnum valueOf(String name) => _$hip3PreviewExecutionTypeEnumValueOf(name);
}

