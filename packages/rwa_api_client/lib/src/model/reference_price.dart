//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reference_price.g.dart';

/// ReferencePrice
///
/// Properties:
/// * [symbol]
/// * [price] - 十进制字符串，避免浮点误差
/// * [session]
/// * [asOf]
/// * [isStale] - 休市 / 隔夜时段为 `true`，前端应提示参考价停留在最近收盘水平
@BuiltValue()
abstract class ReferencePrice
    implements Built<ReferencePrice, ReferencePriceBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'price')
  String get price;

  @BuiltValueField(wireName: r'session')
  SessionKind get session;
  // enum sessionEnum {  premarket,  regular,  after,  overnight,  weekend,  holiday,  };

  @BuiltValueField(wireName: r'as_of')
  DateTime get asOf;

  /// 休市 / 隔夜时段为 `true`，前端应提示参考价停留在最近收盘水平
  @BuiltValueField(wireName: r'is_stale')
  bool? get isStale;

  ReferencePrice._();

  factory ReferencePrice([void updates(ReferencePriceBuilder b)]) =
      _$ReferencePrice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReferencePriceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReferencePrice> get serializer =>
      _$ReferencePriceSerializer();
}

class _$ReferencePriceSerializer
    implements PrimitiveSerializer<ReferencePrice> {
  @override
  final Iterable<Type> types = const [ReferencePrice, _$ReferencePrice];

  @override
  final String wireName = r'ReferencePrice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReferencePrice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'session';
    yield serializers.serialize(
      object.session,
      specifiedType: const FullType(SessionKind),
    );
    yield r'as_of';
    yield serializers.serialize(
      object.asOf,
      specifiedType: const FullType(DateTime),
    );
    if (object.isStale != null) {
      yield r'is_stale';
      yield serializers.serialize(
        object.isStale,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReferencePrice object, {
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
    required ReferencePriceBuilder result,
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
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'session':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SessionKind),
          ) as SessionKind;
          result.session = valueDes;
          break;
        case r'as_of':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.asOf = valueDes;
          break;
        case r'is_stale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isStale = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReferencePrice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReferencePriceBuilder();
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
