//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_eip712_message.g.dart';

/// Hip3Eip712Message
///
/// Properties:
/// * [source_] - Mainnet 为 a，Testnet 为 b。
/// * [connectionId] 
@BuiltValue()
abstract class Hip3Eip712Message implements Built<Hip3Eip712Message, Hip3Eip712MessageBuilder> {
  /// Mainnet 为 a，Testnet 为 b。
  @BuiltValueField(wireName: r'source')
  Hip3Eip712MessageSource_Enum get source_;
  // enum source_Enum {  a,  b,  };

  @BuiltValueField(wireName: r'connectionId')
  String get connectionId;

  Hip3Eip712Message._();

  factory Hip3Eip712Message([void updates(Hip3Eip712MessageBuilder b)]) = _$Hip3Eip712Message;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3Eip712MessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Eip712Message> get serializer => _$Hip3Eip712MessageSerializer();
}

class _$Hip3Eip712MessageSerializer implements PrimitiveSerializer<Hip3Eip712Message> {
  @override
  final Iterable<Type> types = const [Hip3Eip712Message, _$Hip3Eip712Message];

  @override
  final String wireName = r'Hip3Eip712Message';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Eip712Message object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(Hip3Eip712MessageSource_Enum),
    );
    yield r'connectionId';
    yield serializers.serialize(
      object.connectionId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Eip712Message object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3Eip712MessageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Eip712MessageSource_Enum),
          ) as Hip3Eip712MessageSource_Enum;
          result.source_ = valueDes;
          break;
        case r'connectionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.connectionId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Eip712Message deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3Eip712MessageBuilder();
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

class Hip3Eip712MessageSource_Enum extends EnumClass {

  /// Mainnet 为 a，Testnet 为 b。
  @BuiltValueEnumConst(wireName: r'a')
  static const Hip3Eip712MessageSource_Enum a = _$hip3Eip712MessageSourceEnum_a;
  /// Mainnet 为 a，Testnet 为 b。
  @BuiltValueEnumConst(wireName: r'b')
  static const Hip3Eip712MessageSource_Enum b = _$hip3Eip712MessageSourceEnum_b;
  /// Mainnet 为 a，Testnet 为 b。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Eip712MessageSource_Enum unknownDefaultOpenApi = _$hip3Eip712MessageSourceEnum_unknownDefaultOpenApi;

  static Serializer<Hip3Eip712MessageSource_Enum> get serializer => _$hip3Eip712MessageSourceEnumSerializer;

  const Hip3Eip712MessageSource_Enum._(String name): super(name);

  static BuiltSet<Hip3Eip712MessageSource_Enum> get values => _$hip3Eip712MessageSourceEnumValues;
  static Hip3Eip712MessageSource_Enum valueOf(String name) => _$hip3Eip712MessageSourceEnumValueOf(name);
}

