//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_realtime_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_balance_item.g.dart';

/// Hip3RealtimeBalanceItem
///
/// Properties:
/// * [event] 
/// * [data] 
@BuiltValue()
abstract class Hip3RealtimeBalanceItem implements Built<Hip3RealtimeBalanceItem, Hip3RealtimeBalanceItemBuilder> {
  @BuiltValueField(wireName: r'event')
  Hip3RealtimeBalanceItemEventEnum get event;
  // enum eventEnum {  hip3_balance,  };

  @BuiltValueField(wireName: r'data')
  Hip3RealtimeBalance get data;

  Hip3RealtimeBalanceItem._();

  factory Hip3RealtimeBalanceItem([void updates(Hip3RealtimeBalanceItemBuilder b)]) = _$Hip3RealtimeBalanceItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeBalanceItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeBalanceItem> get serializer => _$Hip3RealtimeBalanceItemSerializer();
}

class _$Hip3RealtimeBalanceItemSerializer implements PrimitiveSerializer<Hip3RealtimeBalanceItem> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeBalanceItem, _$Hip3RealtimeBalanceItem];

  @override
  final String wireName = r'Hip3RealtimeBalanceItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeBalanceItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'event';
    yield serializers.serialize(
      object.event,
      specifiedType: const FullType(Hip3RealtimeBalanceItemEventEnum),
    );
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(Hip3RealtimeBalance),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimeBalanceItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeBalanceItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'event':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeBalanceItemEventEnum),
          ) as Hip3RealtimeBalanceItemEventEnum;
          result.event = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimeBalance),
          ) as Hip3RealtimeBalance;
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
  Hip3RealtimeBalanceItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeBalanceItemBuilder();
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

class Hip3RealtimeBalanceItemEventEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3_balance')
  static const Hip3RealtimeBalanceItemEventEnum hip3Balance = _$hip3RealtimeBalanceItemEventEnum_hip3Balance;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeBalanceItemEventEnum unknownDefaultOpenApi = _$hip3RealtimeBalanceItemEventEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeBalanceItemEventEnum> get serializer => _$hip3RealtimeBalanceItemEventEnumSerializer;

  const Hip3RealtimeBalanceItemEventEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeBalanceItemEventEnum> get values => _$hip3RealtimeBalanceItemEventEnumValues;
  static Hip3RealtimeBalanceItemEventEnum valueOf(String name) => _$hip3RealtimeBalanceItemEventEnumValueOf(name);
}

