//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stock.g.dart';

/// Stock
///
/// Properties:
/// * [symbol]
/// * [name]
/// * [logoUrl]
/// * [logoText] - 无图时的占位字母
/// * [referencePrice] - 美股最近参考价
/// * [referenceSession]
/// * [referenceAt]
@BuiltValue()
abstract class Stock implements Built<Stock, StockBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'logo_url')
  String? get logoUrl;

  /// 无图时的占位字母
  @BuiltValueField(wireName: r'logo_text')
  String? get logoText;

  /// 美股最近参考价
  @BuiltValueField(wireName: r'reference_price')
  String get referencePrice;

  @BuiltValueField(wireName: r'reference_session')
  SessionKind? get referenceSession;
  // enum referenceSessionEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'reference_at')
  DateTime? get referenceAt;

  Stock._();

  factory Stock([void updates(StockBuilder b)]) = _$Stock;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StockBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Stock> get serializer => _$StockSerializer();
}

class _$StockSerializer implements PrimitiveSerializer<Stock> {
  @override
  final Iterable<Type> types = const [Stock, _$Stock];

  @override
  final String wireName = r'Stock';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Stock object, {
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
    yield r'reference_price';
    yield serializers.serialize(
      object.referencePrice,
      specifiedType: const FullType(String),
    );
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
    Stock object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StockBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
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
  Stock deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StockBuilder();
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
