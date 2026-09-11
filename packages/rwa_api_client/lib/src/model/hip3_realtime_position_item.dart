//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/position.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_position_item.g.dart';

/// Hip3RealtimePositionItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimePositionItem implements Built<Hip3RealtimePositionItem, Hip3RealtimePositionItemBuilder> {
  @BuiltValueField(wireName: r'event')
  Hip3RealtimePositionItemEventEnum get event;
  // enum eventEnum {  hip3_position,  };

  @BuiltValueField(wireName: r'data')
  Position get data;

  Hip3RealtimePositionItem._();

  factory Hip3RealtimePositionItem([void updates(Hip3RealtimePositionItemBuilder b)]) = _$Hip3RealtimePositionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimePositionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimePositionItem> get serializer => _$Hip3RealtimePositionItemSerializer();
}

class _$Hip3RealtimePositionItemSerializer implements PrimitiveSerializer<Hip3RealtimePositionItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimePositionItem, _$Hip3RealtimePositionItem];

  @override
  final String wireName = r'Hip3RealtimePositionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimePositionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimePositionItemEventEnum),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Position),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimePositionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimePositionItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePositionItemEventEnum),
          ) as Hip3RealtimePositionItemEventEnum;
          result.event = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Position),
          ) as Position;
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
  Hip3RealtimePositionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimePositionItemBuilder();
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

class Hip3RealtimePositionItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_position')
  static const Hip3RealtimePositionItemEventEnum hip3Position = _$hip3RealtimePositionItemEventEnum_hip3Position;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePositionItemEventEnum unknownDefaultOpenApi = _$hip3RealtimePositionItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePositionItemEventEnum> get serializer => _$hip3RealtimePositionItemEventEnumSerializer;

  const Hip3RealtimePositionItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePositionItemEventEnum> get values => _$hip3RealtimePositionItemEventEnumValues;
  static Hip3RealtimePositionItemEventEnum valueOf(String name) => _$hip3RealtimePositionItemEventEnumValueOf(name);
}

