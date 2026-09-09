//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_operation.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:rwa_api_client/src/model/hip3_trading_rules.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_trading_context.g.dart';

/// 服务端从当前账户绑定及运行环境推导 context_id。无可靠账户余额返回 503。 supported_operations 只描述 client-signed 路径，不因 Agent 路径可用而开启。 available_margin_usdc 是扣除本地未结预留后的可交易保证金，与 withdrawable_usdc 分开； 均非账户总权益。最大可开量受方向、价格与杠杆影响，在订单 preview 中返回。 
///
/// Properties:
/// * [contextId] 
/// * [environment] 
/// * [productId] 
/// * [symbol] 
/// * [venue] 
/// * [settlementAsset] 
/// * [rules] 
/// * [currentLeverage] - 十进制字符串，避免浮点误差
/// * [currentMarginMode] 
/// * [availableMarginUsdc] - 十进制字符串，避免浮点误差
/// * [withdrawableUsdc] - 十进制字符串，避免浮点误差
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
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TradingContextSettlementAssetEnum unknownDefaultOpenApi = _$hip3TradingContextSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<Hip3TradingContextSettlementAssetEnum> get serializer => _$hip3TradingContextSettlementAssetEnumSerializer;

  const Hip3TradingContextSettlementAssetEnum._(String name): super(name);

  static BuiltSet<Hip3TradingContextSettlementAssetEnum> get values => _$hip3TradingContextSettlementAssetEnumValues;
  static Hip3TradingContextSettlementAssetEnum valueOf(String name) => _$hip3TradingContextSettlementAssetEnumValueOf(name);
}

