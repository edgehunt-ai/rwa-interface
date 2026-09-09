//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_trading_rules.g.dart';

/// 有效精度、最小名义金额及整数价格例外来自该环境的产品规则，不跨产品硬编码。 size step=10^-size_decimals。数量截断不增大风险；价格需同时符合有效位数和小数位规则， 原始整数价格是否豁免有效位限制由 integer_prices_allowed 指明。 返回 Provider 规则与本服务支持能力的交集；不宣告尚未实现的 Market/Isolated/TP/SL。 
///
/// Properties:
/// * [rulesVersion] 
/// * [sizeDecimals] 
/// * [priceMaxSignificantDigits] 
/// * [priceMaxDecimals] 
/// * [integerPricesAllowed] 
/// * [minimumNotionalUsdc] - 十进制字符串，避免浮点误差
/// * [maximumNotionalUsdc] - 当前执行策略的单笔名义金额上限；null 表示无额外策略上限，仍受账户容量与交易所规则限制。
/// * [maxLeverage] - 十进制字符串，避免浮点误差
/// * [marginModes] 
/// * [orderTypes] 
/// * [timeInForce] 
/// * [triggerReferences] 
/// * [observedAt] 
@BuiltValue()
abstract class Hip3TradingRules implements Built<Hip3TradingRules, Hip3TradingRulesBuilder> {
  @BuiltValueField(wireName: r'rules_version')
  String get rulesVersion;

  @BuiltValueField(wireName: r'size_decimals')
  int get sizeDecimals;

  @BuiltValueField(wireName: r'price_max_significant_digits')
  int get priceMaxSignificantDigits;

  @BuiltValueField(wireName: r'price_max_decimals')
  int get priceMaxDecimals;

  @BuiltValueField(wireName: r'integer_prices_allowed')
  bool get integerPricesAllowed;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_notional_usdc')
  String get minimumNotionalUsdc;

  /// 当前执行策略的单笔名义金额上限；null 表示无额外策略上限，仍受账户容量与交易所规则限制。
  @BuiltValueField(wireName: r'maximum_notional_usdc')
  String? get maximumNotionalUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'max_leverage')
  String get maxLeverage;

  @BuiltValueField(wireName: r'margin_modes')
  BuiltList<MarginMode> get marginModes;

  @BuiltValueField(wireName: r'order_types')
  BuiltList<Hip3TradingRulesOrderTypesEnum> get orderTypes;
  // enum orderTypesEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'time_in_force')
  BuiltList<Hip3TimeInForce> get timeInForce;

  @BuiltValueField(wireName: r'trigger_references')
  BuiltList<Hip3TradingRulesTriggerReferencesEnum> get triggerReferences;
  // enum triggerReferencesEnum {  mark,  oracle,  last,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  Hip3TradingRules._();

  factory Hip3TradingRules([void updates(Hip3TradingRulesBuilder b)]) = _$Hip3TradingRules;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3TradingRulesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3TradingRules> get serializer => _$Hip3TradingRulesSerializer();
}

class _$Hip3TradingRulesSerializer implements PrimitiveSerializer<Hip3TradingRules> {
  @override
  final Iterable<Type> types = const [Hip3TradingRules, _$Hip3TradingRules];

  @override
  final String wireName = r'Hip3TradingRules';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3TradingRules object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rules_version';
    yield serializers.serialize(
      object.rulesVersion,
      specifiedType: const FullType(String),
    );
    yield r'size_decimals';
    yield serializers.serialize(
      object.sizeDecimals,
      specifiedType: const FullType(int),
    );
    yield r'price_max_significant_digits';
    yield serializers.serialize(
      object.priceMaxSignificantDigits,
      specifiedType: const FullType(int),
    );
    yield r'price_max_decimals';
    yield serializers.serialize(
      object.priceMaxDecimals,
      specifiedType: const FullType(int),
    );
    yield r'integer_prices_allowed';
    yield serializers.serialize(
      object.integerPricesAllowed,
      specifiedType: const FullType(bool),
    );
    yield r'minimum_notional_usdc';
    yield serializers.serialize(
      object.minimumNotionalUsdc,
      specifiedType: const FullType(String),
    );
    if (object.maximumNotionalUsdc != null) {
      yield r'maximum_notional_usdc';
      yield serializers.serialize(
        object.maximumNotionalUsdc,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'max_leverage';
    yield serializers.serialize(
      object.maxLeverage,
      specifiedType: const FullType(String),
    );
    yield r'margin_modes';
    yield serializers.serialize(
      object.marginModes,
      specifiedType: const FullType(BuiltList, [FullType(MarginMode)]),
    );
    yield r'order_types';
    yield serializers.serialize(
      object.orderTypes,
      specifiedType: const FullType(BuiltList, [FullType(Hip3TradingRulesOrderTypesEnum)]),
    );
    yield r'time_in_force';
    yield serializers.serialize(
      object.timeInForce,
      specifiedType: const FullType(BuiltList, [FullType(Hip3TimeInForce)]),
    );
    yield r'trigger_references';
    yield serializers.serialize(
      object.triggerReferences,
      specifiedType: const FullType(BuiltList, [FullType(Hip3TradingRulesTriggerReferencesEnum)]),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3TradingRules object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3TradingRulesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rules_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rulesVersion = valueDes;
          break;
        case r'size_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sizeDecimals = valueDes;
          break;
        case r'price_max_significant_digits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.priceMaxSignificantDigits = valueDes;
          break;
        case r'price_max_decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.priceMaxDecimals = valueDes;
          break;
        case r'integer_prices_allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.integerPricesAllowed = valueDes;
          break;
        case r'minimum_notional_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumNotionalUsdc = valueDes;
          break;
        case r'maximum_notional_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.maximumNotionalUsdc = valueDes;
          break;
        case r'max_leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maxLeverage = valueDes;
          break;
        case r'margin_modes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MarginMode)]),
          ) as BuiltList<MarginMode>;
          result.marginModes.replace(valueDes);
          break;
        case r'order_types':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3TradingRulesOrderTypesEnum)]),
          ) as BuiltList<Hip3TradingRulesOrderTypesEnum>;
          result.orderTypes.replace(valueDes);
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3TimeInForce)]),
          ) as BuiltList<Hip3TimeInForce>;
          result.timeInForce.replace(valueDes);
          break;
        case r'trigger_references':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Hip3TradingRulesTriggerReferencesEnum)]),
          ) as BuiltList<Hip3TradingRulesTriggerReferencesEnum>;
          result.triggerReferences.replace(valueDes);
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3TradingRules deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3TradingRulesBuilder();
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

class Hip3TradingRulesOrderTypesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3TradingRulesOrderTypesEnum market = _$hip3TradingRulesOrderTypesEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3TradingRulesOrderTypesEnum limit = _$hip3TradingRulesOrderTypesEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TradingRulesOrderTypesEnum unknownDefaultOpenApi = _$hip3TradingRulesOrderTypesEnum_unknownDefaultOpenApi;

  static Serializer<Hip3TradingRulesOrderTypesEnum> get serializer => _$hip3TradingRulesOrderTypesEnumSerializer;

  const Hip3TradingRulesOrderTypesEnum._(String name): super(name);

  static BuiltSet<Hip3TradingRulesOrderTypesEnum> get values => _$hip3TradingRulesOrderTypesEnumValues;
  static Hip3TradingRulesOrderTypesEnum valueOf(String name) => _$hip3TradingRulesOrderTypesEnumValueOf(name);
}

class Hip3TradingRulesTriggerReferencesEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mark')
  static const Hip3TradingRulesTriggerReferencesEnum mark = _$hip3TradingRulesTriggerReferencesEnum_mark;
  @BuiltValueEnumConst(wireName: r'oracle')
  static const Hip3TradingRulesTriggerReferencesEnum oracle = _$hip3TradingRulesTriggerReferencesEnum_oracle;
  @BuiltValueEnumConst(wireName: r'last')
  static const Hip3TradingRulesTriggerReferencesEnum last = _$hip3TradingRulesTriggerReferencesEnum_last;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3TradingRulesTriggerReferencesEnum unknownDefaultOpenApi = _$hip3TradingRulesTriggerReferencesEnum_unknownDefaultOpenApi;

  static Serializer<Hip3TradingRulesTriggerReferencesEnum> get serializer => _$hip3TradingRulesTriggerReferencesEnumSerializer;

  const Hip3TradingRulesTriggerReferencesEnum._(String name): super(name);

  static BuiltSet<Hip3TradingRulesTriggerReferencesEnum> get values => _$hip3TradingRulesTriggerReferencesEnumValues;
  static Hip3TradingRulesTriggerReferencesEnum valueOf(String name) => _$hip3TradingRulesTriggerReferencesEnumValueOf(name);
}

