//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_history_range.g.dart';

/// Hip3HistoryRange
///
/// Properties:
/// * [from] 
/// * [to] 
@BuiltValue()
abstract class Hip3HistoryRange implements Built<Hip3HistoryRange, Hip3HistoryRangeBuilder> {
  @BuiltValueField(wireName: r'from')
  DateTime get from;

  @BuiltValueField(wireName: r'to')
  DateTime get to;

  Hip3HistoryRange._();

  factory Hip3HistoryRange([void updates(Hip3HistoryRangeBuilder b)]) = _$Hip3HistoryRange;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3HistoryRangeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3HistoryRange> get serializer => _$Hip3HistoryRangeSerializer();
}

class _$Hip3HistoryRangeSerializer implements PrimitiveSerializer<Hip3HistoryRange> {
  @override
  final Iterable<Type> types = const [Hip3HistoryRange, _$Hip3HistoryRange];

  @override
  final String wireName = r'Hip3HistoryRange';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3HistoryRange object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(DateTime),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3HistoryRange object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3HistoryRangeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.to = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3HistoryRange deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3HistoryRangeBuilder();
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

