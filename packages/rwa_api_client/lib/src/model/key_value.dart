//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'key_value.g.dart';

/// KeyValue
///
/// Properties:
/// * [label]
/// * [value]
/// * [tone]
@BuiltValue()
abstract class KeyValue implements Built<KeyValue, KeyValueBuilder> {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'value')
  String get value;

  @BuiltValueField(wireName: r'tone')
  KeyValueToneEnum? get tone;
  // enum toneEnum {  default,  positive,  negative,  muted,  };

  KeyValue._();

  factory KeyValue([void updates(KeyValueBuilder b)]) = _$KeyValue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KeyValueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KeyValue> get serializer => _$KeyValueSerializer();
}

class _$KeyValueSerializer implements PrimitiveSerializer<KeyValue> {
  @override
  final Iterable<Type> types = const [KeyValue, _$KeyValue];

  @override
  final String wireName = r'KeyValue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KeyValue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    if (object.tone != null) {
      yield r'tone';
      yield serializers.serialize(
        object.tone,
        specifiedType: const FullType.nullable(KeyValueToneEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KeyValue object, {
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
    required KeyValueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        case r'tone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KeyValueToneEnum),
          ) as KeyValueToneEnum?;
          if (valueDes == null) continue;
          result.tone = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KeyValue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KeyValueBuilder();
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

class KeyValueToneEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'default')
  static const KeyValueToneEnum default_ = _$keyValueToneEnum_default_;
  @BuiltValueEnumConst(wireName: r'positive')
  static const KeyValueToneEnum positive = _$keyValueToneEnum_positive;
  @BuiltValueEnumConst(wireName: r'negative')
  static const KeyValueToneEnum negative = _$keyValueToneEnum_negative;
  @BuiltValueEnumConst(wireName: r'muted')
  static const KeyValueToneEnum muted = _$keyValueToneEnum_muted;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const KeyValueToneEnum unknownDefaultOpenApi =
      _$keyValueToneEnum_unknownDefaultOpenApi;

  static Serializer<KeyValueToneEnum> get serializer =>
      _$keyValueToneEnumSerializer;

  const KeyValueToneEnum._(String name) : super(name);

  static BuiltSet<KeyValueToneEnum> get values => _$keyValueToneEnumValues;
  static KeyValueToneEnum valueOf(String name) =>
      _$keyValueToneEnumValueOf(name);
}
