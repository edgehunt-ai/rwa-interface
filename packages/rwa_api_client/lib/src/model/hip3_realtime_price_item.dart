//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_price.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_price_item.g.dart';

/// Hip3RealtimePriceItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimePriceItem implements Built<Hip3RealtimePriceItem, Hip3RealtimePriceItemBuilder> {
  @BuiltValueField(wireName: r'event')
  Hip3RealtimePriceItemEventEnum get event;
  // enum eventEnum {  hip3_price,  };

  @BuiltValueField(wireName: r'data')
  Hip3RealtimePrice get data;

  Hip3RealtimePriceItem._();

  factory Hip3RealtimePriceItem([void updates(Hip3RealtimePriceItemBuilder b)]) = _$Hip3RealtimePriceItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimePriceItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimePriceItem> get serializer => _$Hip3RealtimePriceItemSerializer();
}

class _$Hip3RealtimePriceItemSerializer implements PrimitiveSerializer<Hip3RealtimePriceItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimePriceItem, _$Hip3RealtimePriceItem];

  @override
  final String wireName = r'Hip3RealtimePriceItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimePriceItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimePriceItemEventEnum),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Hip3RealtimePrice),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimePriceItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimePriceItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePriceItemEventEnum),
          ) as Hip3RealtimePriceItemEventEnum;
          result.event = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePrice),
          ) as Hip3RealtimePrice;
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
  Hip3RealtimePriceItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimePriceItemBuilder();
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

class Hip3RealtimePriceItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_price')
  static const Hip3RealtimePriceItemEventEnum hip3Price = _$hip3RealtimePriceItemEventEnum_hip3Price;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePriceItemEventEnum unknownDefaultOpenApi = _$hip3RealtimePriceItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePriceItemEventEnum> get serializer => _$hip3RealtimePriceItemEventEnumSerializer;

  const Hip3RealtimePriceItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePriceItemEventEnum> get values => _$hip3RealtimePriceItemEventEnumValues;
  static Hip3RealtimePriceItemEventEnum valueOf(String name) => _$hip3RealtimePriceItemEventEnumValueOf(name);
}

