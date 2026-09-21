//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_requote_validity.g.dart';

/// BstocksRequoteValidity
///
/// Properties:
/// * [kind] 
@BuiltValue()
abstract class BstocksRequoteValidity implements Built<BstocksRequoteValidity, BstocksRequoteValidityBuilder> {
  @BuiltValueField(wireName: r'kind')
  BstocksRequoteValidityKindEnum get kind;
  // enum kindEnum {  requote_on_confirmation,  };

  BstocksRequoteValidity._();

  factory BstocksRequoteValidity([void updates(BstocksRequoteValidityBuilder b)]) = _$BstocksRequoteValidity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksRequoteValidityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksRequoteValidity> get serializer => _$BstocksRequoteValiditySerializer();
}

class _$BstocksRequoteValiditySerializer implements PrimitiveSerializer<BstocksRequoteValidity> {
  @override
  final Iterable<Type> types = const [BstocksRequoteValidity, _$BstocksRequoteValidity];

  @override
  final String wireName = r'BstocksRequoteValidity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksRequoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstocksRequoteValidityKindEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksRequoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksRequoteValidityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksRequoteValidityKindEnum),
          ) as BstocksRequoteValidityKindEnum;
          result.kind = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksRequoteValidity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksRequoteValidityBuilder();
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

class BstocksRequoteValidityKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requote_on_confirmation')
  static const BstocksRequoteValidityKindEnum requoteOnConfirmation = _$bstocksRequoteValidityKindEnum_requoteOnConfirmation;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksRequoteValidityKindEnum unknownDefaultOpenApi = _$bstocksRequoteValidityKindEnum_unknownDefaultOpenApi;

  static Serializer<BstocksRequoteValidityKindEnum> get serializer => _$bstocksRequoteValidityKindEnumSerializer;

  const BstocksRequoteValidityKindEnum._(String name): super(name);

  static BuiltSet<BstocksRequoteValidityKindEnum> get values => _$bstocksRequoteValidityKindEnumValues;
  static BstocksRequoteValidityKindEnum valueOf(String name) => _$bstocksRequoteValidityKindEnumValueOf(name);
}

