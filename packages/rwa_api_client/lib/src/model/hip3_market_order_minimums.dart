//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_market_order_minimum.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_market_order_minimums.g.dart';

/// 市价单在当前盘口下的方向性最低输入金额，已经考虑默认滑点保护和数量精度；杠杆不改变 最小交易名义金额，只影响 minimum_margin_required_usdc。盘口变化或用户调整杠杆后应重新获取 trading-context。 
///
/// Properties:
/// * [amountAsset] 
/// * [slippagePercent] - 十进制字符串，避免浮点误差
/// * [leverage] - 十进制字符串，避免浮点误差
/// * [long] 
/// * [short] 
/// * [observedAt] 
@BuiltValue()
abstract class Hip3MarketOrderMinimums implements Built<Hip3MarketOrderMinimums, Hip3MarketOrderMinimumsBuilder> {
  @BuiltValueField(wireName: r'amount_asset')
  Hip3MarketOrderMinimumsAmountAssetEnum get amountAsset;
  // enum amountAssetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'slippage_percent')
  String get slippagePercent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'leverage')
  String get leverage;

  @BuiltValueField(wireName: r'long')
  Hip3MarketOrderMinimum? get long;

  @BuiltValueField(wireName: r'short')
  Hip3MarketOrderMinimum? get short;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  Hip3MarketOrderMinimums._();

  factory Hip3MarketOrderMinimums([void updates(Hip3MarketOrderMinimumsBuilder b)]) = _$Hip3MarketOrderMinimums;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3MarketOrderMinimumsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3MarketOrderMinimums> get serializer => _$Hip3MarketOrderMinimumsSerializer();
}

class _$Hip3MarketOrderMinimumsSerializer implements PrimitiveSerializer<Hip3MarketOrderMinimums> {
  @override
  final Iterable<Type> types = const [Hip3MarketOrderMinimums, _$Hip3MarketOrderMinimums];

  @override
  final String wireName = r'Hip3MarketOrderMinimums';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3MarketOrderMinimums object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount_asset';
    yield serializers.serialize(
      object.amountAsset,
      specifiedType: const FullType(Hip3MarketOrderMinimumsAmountAssetEnum),
    );
    yield r'slippage_percent';
    yield serializers.serialize(
      object.slippagePercent,
      specifiedType: const FullType(String),
    );
    yield r'leverage';
    yield serializers.serialize(
      object.leverage,
      specifiedType: const FullType(String),
    );
    yield r'long';
    yield object.long == null ? null : serializers.serialize(
      object.long,
      specifiedType: const FullType.nullable(Hip3MarketOrderMinimum),
    );
    yield r'short';
    yield object.short == null ? null : serializers.serialize(
      object.short,
      specifiedType: const FullType.nullable(Hip3MarketOrderMinimum),
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
    Hip3MarketOrderMinimums object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3MarketOrderMinimumsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3MarketOrderMinimumsAmountAssetEnum),
          ) as Hip3MarketOrderMinimumsAmountAssetEnum;
          result.amountAsset = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.slippagePercent = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.leverage = valueDes;
          break;
        case r'long':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3MarketOrderMinimum),
          ) as Hip3MarketOrderMinimum?;
          if (valueDes == null) continue;
          result.long.replace(valueDes);
          break;
        case r'short':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3MarketOrderMinimum),
          ) as Hip3MarketOrderMinimum?;
          if (valueDes == null) continue;
          result.short.replace(valueDes);
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
  Hip3MarketOrderMinimums deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3MarketOrderMinimumsBuilder();
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

class Hip3MarketOrderMinimumsAmountAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3MarketOrderMinimumsAmountAssetEnum USDC = _$hip3MarketOrderMinimumsAmountAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3MarketOrderMinimumsAmountAssetEnum unknownDefaultOpenApi = _$hip3MarketOrderMinimumsAmountAssetEnum_unknownDefaultOpenApi;

  static Serializer<Hip3MarketOrderMinimumsAmountAssetEnum> get serializer => _$hip3MarketOrderMinimumsAmountAssetEnumSerializer;

  const Hip3MarketOrderMinimumsAmountAssetEnum._(String name): super(name);

  static BuiltSet<Hip3MarketOrderMinimumsAmountAssetEnum> get values => _$hip3MarketOrderMinimumsAmountAssetEnumValues;
  static Hip3MarketOrderMinimumsAmountAssetEnum valueOf(String name) => _$hip3MarketOrderMinimumsAmountAssetEnumValueOf(name);
}

