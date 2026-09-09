//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_preview_execution.g.dart';

/// HIP3 预览规范化后的执行条件。amount 是名义金额而非保证金；费用明确以 USDC 计价。 market 使用有滑点边界的 IOC；limit 按指定 TIF，不保证成交。 maximum_quantity 是该方向/价格/杠杆下允许的最大量（reduce-only 为可减仓量）。 preview 冻结条件而非保证市场成交价；create order 必须与预览一致，且再次校验过期、 仓位、可用余额与规则。强平价无法估算时为 null 并给出 reason，不展示为 0。 
///
/// Properties:
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
/// * [marginRequiredUsdc] - 十进制字符串，避免浮点误差
/// * [availableMarginUsdc] - 十进制字符串，避免浮点误差
/// * [maximumQuantity] - 十进制字符串，避免浮点误差
/// * [estimatedFeeUsdc] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 十进制字符串，避免浮点误差
/// * [liquidationPriceUnavailableReason] 
/// * [slippagePercent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class Hip3PreviewExecution implements Built<Hip3PreviewExecution, Hip3PreviewExecutionBuilder> {
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

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'margin_required_usdc')
  String get marginRequiredUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_margin_usdc')
  String get availableMarginUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'maximum_quantity')
  String get maximumQuantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_fee_usdc')
  String get estimatedFeeUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'liquidation_price')
  String? get liquidationPrice;

  @BuiltValueField(wireName: r'liquidation_price_unavailable_reason')
  String? get liquidationPriceUnavailableReason;

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
    yield serializers.serialize(
      object.maximumQuantity,
      specifiedType: const FullType(String),
    );
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
            specifiedType: const FullType(String),
          ) as String;
          result.maximumQuantity = valueDes;
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
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3PreviewExecutionTypeEnum unknownDefaultOpenApi = _$hip3PreviewExecutionTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3PreviewExecutionTypeEnum> get serializer => _$hip3PreviewExecutionTypeEnumSerializer;

  const Hip3PreviewExecutionTypeEnum._(String name): super(name);

  static BuiltSet<Hip3PreviewExecutionTypeEnum> get values => _$hip3PreviewExecutionTypeEnumValues;
  static Hip3PreviewExecutionTypeEnum valueOf(String name) => _$hip3PreviewExecutionTypeEnumValueOf(name);
}

