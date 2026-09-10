//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'holding_stock.g.dart';

/// 持仓分组的展示元数据，不授予该产品公开行情或下单能力。未知品牌使用已观测的完整产品身份展示。 仅有权威美股参考源时才返回 reference_price/session/at；不得用 mark/entry 冒充参考价或固定时段。 与市场 Stock 分离，避免为 HIP3 持仓伪造必填参考价格。 
///
/// Properties:
/// * [symbol] 
/// * [name] 
/// * [logoUrl] 
/// * [logoText] 
/// * [referencePrice] - 十进制字符串，避免浮点误差
/// * [referenceSession] 
/// * [referenceAt] 
@BuiltValue()
abstract class HoldingStock implements Built<HoldingStock, HoldingStockBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'logo_url')
  String? get logoUrl;

  @BuiltValueField(wireName: r'logo_text')
  String? get logoText;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'reference_price')
  String? get referencePrice;

  @BuiltValueField(wireName: r'reference_session')
  SessionKind? get referenceSession;
  // enum referenceSessionEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'reference_at')
  DateTime? get referenceAt;

  HoldingStock._();

  factory HoldingStock([void updates(HoldingStockBuilder b)]) = _$HoldingStock;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HoldingStockBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HoldingStock> get serializer => _$HoldingStockSerializer();
}

class _$HoldingStockSerializer implements PrimitiveSerializer<HoldingStock> {
  @override
  final Iterable<Type> types = const [HoldingStock, _$HoldingStock];

  @override
  final String wireName = r'HoldingStock';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HoldingStock object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.logoUrl != null) {
      yield r'logo_url';
      yield serializers.serialize(
        object.logoUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.logoText != null) {
      yield r'logo_text';
      yield serializers.serialize(
        object.logoText,
        specifiedType: const FullType(String),
      );
    }
    if (object.referencePrice != null) {
      yield r'reference_price';
      yield serializers.serialize(
        object.referencePrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.referenceSession != null) {
      yield r'reference_session';
      yield serializers.serialize(
        object.referenceSession,
        specifiedType: const FullType(SessionKind),
      );
    }
    if (object.referenceAt != null) {
      yield r'reference_at';
      yield serializers.serialize(
        object.referenceAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HoldingStock object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HoldingStockBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'logo_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoUrl = valueDes;
          break;
        case r'logo_text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoText = valueDes;
          break;
        case r'reference_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referencePrice = valueDes;
          break;
        case r'reference_session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SessionKind),
          ) as SessionKind?;
          if (valueDes == null) continue;
          result.referenceSession = valueDes;
          break;
        case r'reference_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.referenceAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HoldingStock deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HoldingStockBuilder();
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

