//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'quote.g.dart';

/// Quote
///
/// Properties:
/// * [validUntil] - 行情源有效期；超过此时刻客户端应显示过期，不能沿用响应时的 fresh。
/// * [priceKind] - HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
/// * [dataStatus] - 服务端按行情源有效期判断；客户端按 updated_at 继续显示报价年龄。
/// * [label] - 报价说明，如 `Last traded · NVDAB/USDC` 或 `Mark price · NVDA-PERP`
/// * [price] - 十进制字符串，避免浮点误差
/// * [change24h] - 十进制字符串，避免浮点误差
/// * [change24hPercent] - 十进制字符串，避免浮点误差
/// * [updatedAt] 
@BuiltValue()
abstract class Quote implements Built<Quote, QuoteBuilder> {
  /// 行情源有效期；超过此时刻客户端应显示过期，不能沿用响应时的 fresh。
  @BuiltValueField(wireName: r'valid_until')
  DateTime? get validUntil;

  /// HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
  @BuiltValueField(wireName: r'price_kind')
  QuotePriceKindEnum? get priceKind;
  // enum priceKindEnum {  mark,  last_trade,  reference,  };

  /// 服务端按行情源有效期判断；客户端按 updated_at 继续显示报价年龄。
  @BuiltValueField(wireName: r'data_status')
  QuoteDataStatusEnum? get dataStatus;
  // enum dataStatusEnum {  fresh,  stale,  };

  /// 报价说明，如 `Last traded · NVDAB/USDC` 或 `Mark price · NVDA-PERP`
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'change_24h')
  String? get change24h;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'change_24h_percent')
  String? get change24hPercent;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  Quote._();

  factory Quote([void updates(QuoteBuilder b)]) = _$Quote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QuoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Quote> get serializer => _$QuoteSerializer();
}

class _$QuoteSerializer implements PrimitiveSerializer<Quote> {
  @override
  final Iterable<Type> types = const [Quote, _$Quote];

  @override
  final String wireName = r'Quote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Quote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.validUntil != null) {
      yield r'valid_until';
      yield serializers.serialize(
        object.validUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.priceKind != null) {
      yield r'price_kind';
      yield serializers.serialize(
        object.priceKind,
        specifiedType: const FullType(QuotePriceKindEnum),
      );
    }
    if (object.dataStatus != null) {
      yield r'data_status';
      yield serializers.serialize(
        object.dataStatus,
        specifiedType: const FullType(QuoteDataStatusEnum),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    if (object.change24h != null) {
      yield r'change_24h';
      yield serializers.serialize(
        object.change24h,
        specifiedType: const FullType(String),
      );
    }
    if (object.change24hPercent != null) {
      yield r'change_24h_percent';
      yield serializers.serialize(
        object.change24hPercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Quote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required QuoteBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.validUntil = valueDes;
          break;
        case r'price_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(QuotePriceKindEnum),
          ) as QuotePriceKindEnum?;
          if (valueDes == null) continue;
          result.priceKind = valueDes;
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(QuoteDataStatusEnum),
          ) as QuoteDataStatusEnum?;
          if (valueDes == null) continue;
          result.dataStatus = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'change_24h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.change24h = valueDes;
          break;
        case r'change_24h_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.change24hPercent = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Quote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QuoteBuilder();
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

class QuotePriceKindEnum extends EnumClass {

  /// HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
  @BuiltValueEnumConst(wireName: r'mark')
  static const QuotePriceKindEnum mark = _$quotePriceKindEnum_mark;
  /// HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
  @BuiltValueEnumConst(wireName: r'last_trade')
  static const QuotePriceKindEnum lastTrade = _$quotePriceKindEnum_lastTrade;
  /// HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
  @BuiltValueEnumConst(wireName: r'reference')
  static const QuotePriceKindEnum reference = _$quotePriceKindEnum_reference;
  /// HIP3 报价为 mark；oracle 在 stats 中独立标识，不冒充美股参考价。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const QuotePriceKindEnum unknownDefaultOpenApi = _$quotePriceKindEnum_unknownDefaultOpenApi;

  static Serializer<QuotePriceKindEnum> get serializer => _$quotePriceKindEnumSerializer;

  const QuotePriceKindEnum._(String name): super(name);

  static BuiltSet<QuotePriceKindEnum> get values => _$quotePriceKindEnumValues;
  static QuotePriceKindEnum valueOf(String name) => _$quotePriceKindEnumValueOf(name);
}

class QuoteDataStatusEnum extends EnumClass {

  /// 服务端按行情源有效期判断；客户端按 updated_at 继续显示报价年龄。
  @BuiltValueEnumConst(wireName: r'fresh')
  static const QuoteDataStatusEnum fresh = _$quoteDataStatusEnum_fresh;
  /// 服务端按行情源有效期判断；客户端按 updated_at 继续显示报价年龄。
  @BuiltValueEnumConst(wireName: r'stale')
  static const QuoteDataStatusEnum stale = _$quoteDataStatusEnum_stale;
  /// 服务端按行情源有效期判断；客户端按 updated_at 继续显示报价年龄。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const QuoteDataStatusEnum unknownDefaultOpenApi = _$quoteDataStatusEnum_unknownDefaultOpenApi;

  static Serializer<QuoteDataStatusEnum> get serializer => _$quoteDataStatusEnumSerializer;

  const QuoteDataStatusEnum._(String name): super(name);

  static BuiltSet<QuoteDataStatusEnum> get values => _$quoteDataStatusEnumValues;
  static QuoteDataStatusEnum valueOf(String name) => _$quoteDataStatusEnumValueOf(name);
}

