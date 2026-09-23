//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hyperliquid_usdc_collateral.g.dart';

/// HyperliquidUsdcCollateral
///
/// Properties:
/// * [accountRefHash] - 钱包地址的不可逆哈希，用于区分同一用户的多个 HL 账户。
/// * [asset] 
/// * [total] - spotClearinghouseState 中 USDC 的 total；这笔余额仅计入总资产一次。
/// * [isolatedMarginUsed] - 使用 USDC 抵押的所有 DEX 逐仓仓位 marginUsed 合计。
/// * [crossMaintenanceMarginRequired] - 使用 USDC 抵押的所有 DEX crossMaintenanceMarginUsed 合计；这是风险门槛，不是冻结资金。
/// * [hold] - spotClearinghouseState 中 USDC 的 hold 总额；不承诺只来自 HIP-3 委托。
/// * [availableCollateralLimit] - 当前 Portfolio 使用的 min(max(total - hold, 0), HL 提供的维持保证金后额度)；不是可提款额或下单承诺。
/// * [observedAt] 
/// * [freshness] 
/// * [warningCode] 
@BuiltValue()
abstract class HyperliquidUsdcCollateral implements Built<HyperliquidUsdcCollateral, HyperliquidUsdcCollateralBuilder> {
  /// 钱包地址的不可逆哈希，用于区分同一用户的多个 HL 账户。
  @BuiltValueField(wireName: r'account_ref_hash')
  String get accountRefHash;

  @BuiltValueField(wireName: r'asset')
  HyperliquidUsdcCollateralAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// spotClearinghouseState 中 USDC 的 total；这笔余额仅计入总资产一次。
  @BuiltValueField(wireName: r'total')
  String get total;

  /// 使用 USDC 抵押的所有 DEX 逐仓仓位 marginUsed 合计。
  @BuiltValueField(wireName: r'isolated_margin_used')
  String get isolatedMarginUsed;

  /// 使用 USDC 抵押的所有 DEX crossMaintenanceMarginUsed 合计；这是风险门槛，不是冻结资金。
  @BuiltValueField(wireName: r'cross_maintenance_margin_required')
  String get crossMaintenanceMarginRequired;

  /// spotClearinghouseState 中 USDC 的 hold 总额；不承诺只来自 HIP-3 委托。
  @BuiltValueField(wireName: r'hold')
  String get hold;

  /// 当前 Portfolio 使用的 min(max(total - hold, 0), HL 提供的维持保证金后额度)；不是可提款额或下单承诺。
  @BuiltValueField(wireName: r'available_collateral_limit')
  String get availableCollateralLimit;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'warning_code')
  String? get warningCode;

  HyperliquidUsdcCollateral._();

  factory HyperliquidUsdcCollateral([void updates(HyperliquidUsdcCollateralBuilder b)]) = _$HyperliquidUsdcCollateral;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HyperliquidUsdcCollateralBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HyperliquidUsdcCollateral> get serializer => _$HyperliquidUsdcCollateralSerializer();
}

class _$HyperliquidUsdcCollateralSerializer implements PrimitiveSerializer<HyperliquidUsdcCollateral> {
  @override
  final Iterable<Type> types = const [HyperliquidUsdcCollateral, _$HyperliquidUsdcCollateral];

  @override
  final String wireName = r'HyperliquidUsdcCollateral';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HyperliquidUsdcCollateral object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account_ref_hash';
    yield serializers.serialize(
      object.accountRefHash,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(HyperliquidUsdcCollateralAssetEnum),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(String),
    );
    yield r'isolated_margin_used';
    yield serializers.serialize(
      object.isolatedMarginUsed,
      specifiedType: const FullType(String),
    );
    yield r'cross_maintenance_margin_required';
    yield serializers.serialize(
      object.crossMaintenanceMarginRequired,
      specifiedType: const FullType(String),
    );
    yield r'hold';
    yield serializers.serialize(
      object.hold,
      specifiedType: const FullType(String),
    );
    yield r'available_collateral_limit';
    yield serializers.serialize(
      object.availableCollateralLimit,
      specifiedType: const FullType(String),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'warning_code';
    yield object.warningCode == null ? null : serializers.serialize(
      object.warningCode,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HyperliquidUsdcCollateral object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HyperliquidUsdcCollateralBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account_ref_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountRefHash = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HyperliquidUsdcCollateralAssetEnum),
          ) as HyperliquidUsdcCollateralAssetEnum;
          result.asset = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.total = valueDes;
          break;
        case r'isolated_margin_used':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.isolatedMarginUsed = valueDes;
          break;
        case r'cross_maintenance_margin_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.crossMaintenanceMarginRequired = valueDes;
          break;
        case r'hold':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hold = valueDes;
          break;
        case r'available_collateral_limit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableCollateralLimit = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'warning_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.warningCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HyperliquidUsdcCollateral deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HyperliquidUsdcCollateralBuilder();
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

class HyperliquidUsdcCollateralAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const HyperliquidUsdcCollateralAssetEnum USDC = _$hyperliquidUsdcCollateralAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const HyperliquidUsdcCollateralAssetEnum unknownDefaultOpenApi = _$hyperliquidUsdcCollateralAssetEnum_unknownDefaultOpenApi;

  static Serializer<HyperliquidUsdcCollateralAssetEnum> get serializer => _$hyperliquidUsdcCollateralAssetEnumSerializer;

  const HyperliquidUsdcCollateralAssetEnum._(String name): super(name);

  static BuiltSet<HyperliquidUsdcCollateralAssetEnum> get values => _$hyperliquidUsdcCollateralAssetEnumValues;
  static HyperliquidUsdcCollateralAssetEnum valueOf(String name) => _$hyperliquidUsdcCollateralAssetEnumValueOf(name);
}

