//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'disclosures_always_on.g.dart';

/// 24×7 交易说明
///
/// Properties:
/// * [title] 
/// * [body] 
@BuiltValue()
abstract class DisclosuresAlwaysOn implements Built<DisclosuresAlwaysOn, DisclosuresAlwaysOnBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'body')
  String? get body;

  DisclosuresAlwaysOn._();

  factory DisclosuresAlwaysOn([void updates(DisclosuresAlwaysOnBuilder b)]) = _$DisclosuresAlwaysOn;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisclosuresAlwaysOnBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DisclosuresAlwaysOn> get serializer => _$DisclosuresAlwaysOnSerializer();
}

class _$DisclosuresAlwaysOnSerializer implements PrimitiveSerializer<DisclosuresAlwaysOn> {
  @override
  final Iterable<Type> types = const [DisclosuresAlwaysOn, _$DisclosuresAlwaysOn];

  @override
  final String wireName = r'DisclosuresAlwaysOn';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DisclosuresAlwaysOn object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.body != null) {
      yield r'body';
      yield serializers.serialize(
        object.body,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DisclosuresAlwaysOn object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisclosuresAlwaysOnBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DisclosuresAlwaysOn deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisclosuresAlwaysOnBuilder();
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

