//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_candle.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_candle_item.g.dart';

/// Hip3RealtimeCandleItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeCandleItem implements Built<Hip3RealtimeCandleItem, Hip3RealtimeCandleItemBuilder> {
  @BuiltValueField(wireName: r'event')
  Hip3RealtimeCandleItemEventEnum get event;
  // enum eventEnum {  hip3_candle,  };

  @BuiltValueField(wireName: r'data')
  Hip3RealtimeCandle get data;

  Hip3RealtimeCandleItem._();

  factory Hip3RealtimeCandleItem([void updates(Hip3RealtimeCandleItemBuilder b)]) = _$Hip3RealtimeCandleItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeCandleItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeCandleItem> get serializer => _$Hip3RealtimeCandleItemSerializer();
}

class _$Hip3RealtimeCandleItemSerializer implements PrimitiveSerializer<Hip3RealtimeCandleItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeCandleItem, _$Hip3RealtimeCandleItem];

  @override
  final String wireName = r'Hip3RealtimeCandleItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeCandleItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeCandleItemEventEnum),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Hip3RealtimeCandle),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeCandleItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeCandleItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeCandleItemEventEnum),
          ) as Hip3RealtimeCandleItemEventEnum;
          result.event = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeCandle),
          ) as Hip3RealtimeCandle;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimeCandleItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeCandleItemBuilder();
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

class Hip3RealtimeCandleItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_candle')
  static const Hip3RealtimeCandleItemEventEnum hip3Candle = _$hip3RealtimeCandleItemEventEnum_hip3Candle;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeCandleItemEventEnum unknownDefaultOpenApi = _$hip3RealtimeCandleItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeCandleItemEventEnum> get serializer => _$hip3RealtimeCandleItemEventEnumSerializer;

  const Hip3RealtimeCandleItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeCandleItemEventEnum> get values => _$hip3RealtimeCandleItemEventEnumValues;
  static Hip3RealtimeCandleItemEventEnum valueOf(String name) => _$hip3RealtimeCandleItemEventEnumValueOf(name);
}

