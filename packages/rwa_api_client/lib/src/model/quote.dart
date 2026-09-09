//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'quote.g.dart';

/// Quote
///
/// Properties:
/// * [label] - 报价说明，如 `Last traded · NVDAB/USDC` 或 `Mark price · NVDA-PERP`
/// * [price] - 十进制字符串，避免浮点误差
/// * [change24h] - 十进制字符串，避免浮点误差
/// * [change24hPercent] - 十进制字符串，避免浮点误差
/// * [updatedAt] 
@BuiltValue()
abstract class Quote implements Built<Quote, QuoteBuilder> {
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

