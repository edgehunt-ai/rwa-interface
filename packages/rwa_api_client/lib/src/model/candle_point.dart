//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'candle_point.g.dart';

/// CandlePoint
///
/// Properties:
/// * [t] - 该点时间
/// * [o] - 十进制字符串，避免浮点误差
/// * [h] - 十进制字符串，避免浮点误差
/// * [l] - 十进制字符串，避免浮点误差
/// * [c] - 收盘 / 该点价格
/// * [v] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class CandlePoint implements Built<CandlePoint, CandlePointBuilder> {
  /// 该点时间
  @BuiltValueField(wireName: r't')
  DateTime get t;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'o')
  String? get o;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'h')
  String? get h;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'l')
  String? get l;

  /// 收盘 / 该点价格
  @BuiltValueField(wireName: r'c')
  String get c;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'v')
  String? get v;

  CandlePoint._();

  factory CandlePoint([void updates(CandlePointBuilder b)]) = _$CandlePoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CandlePointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CandlePoint> get serializer => _$CandlePointSerializer();
}

class _$CandlePointSerializer implements PrimitiveSerializer<CandlePoint> {
  @override
  final Iterable<Type> types = const [CandlePoint, _$CandlePoint];

  @override
  final String wireName = r'CandlePoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CandlePoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r't';
    yield serializers.serialize(
      object.t,
      specifiedType: const FullType(DateTime),
    );
    if (object.o != null) {
      yield r'o';
      yield serializers.serialize(
        object.o,
        specifiedType: const FullType(String),
      );
    }
    if (object.h != null) {
      yield r'h';
      yield serializers.serialize(
        object.h,
        specifiedType: const FullType(String),
      );
    }
    if (object.l != null) {
      yield r'l';
      yield serializers.serialize(
        object.l,
        specifiedType: const FullType(String),
      );
    }
    yield r'c';
    yield serializers.serialize(
      object.c,
      specifiedType: const FullType(String),
    );
    if (object.v != null) {
      yield r'v';
      yield serializers.serialize(
        object.v,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CandlePoint object, {
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
    required CandlePointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r't':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.t = valueDes;
          break;
        case r'o':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.o = valueDes;
          break;
        case r'h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.h = valueDes;
          break;
        case r'l':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.l = valueDes;
          break;
        case r'c':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.c = valueDes;
          break;
        case r'v':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.v = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CandlePoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CandlePointBuilder();
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
