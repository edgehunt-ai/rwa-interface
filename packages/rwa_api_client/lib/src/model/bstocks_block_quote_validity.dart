//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_block_quote_validity.g.dart';

/// BstocksBlockQuoteValidity
///
/// Properties:
/// * [kind] 
/// * [validAfterBlock] 
/// * [validUntilBlock] 
@BuiltValue()
abstract class BstocksBlockQuoteValidity implements Built<BstocksBlockQuoteValidity, BstocksBlockQuoteValidityBuilder> {
  @BuiltValueField(wireName: r'kind')
  BstocksBlockQuoteValidityKindEnum get kind;
  // enum kindEnum {  block_window,  };

  @BuiltValueField(wireName: r'valid_after_block')
  int get validAfterBlock;

  @BuiltValueField(wireName: r'valid_until_block')
  int get validUntilBlock;

  BstocksBlockQuoteValidity._();

  factory BstocksBlockQuoteValidity([void updates(BstocksBlockQuoteValidityBuilder b)]) = _$BstocksBlockQuoteValidity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksBlockQuoteValidityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksBlockQuoteValidity> get serializer => _$BstocksBlockQuoteValiditySerializer();
}

class _$BstocksBlockQuoteValiditySerializer implements PrimitiveSerializer<BstocksBlockQuoteValidity> {
  @override
  final Iterable<Type> types = const [BstocksBlockQuoteValidity, _$BstocksBlockQuoteValidity];

  @override
  final String wireName = r'BstocksBlockQuoteValidity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksBlockQuoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstocksBlockQuoteValidityKindEnum),
    );
    yield r'valid_after_block';
    yield serializers.serialize(
      object.validAfterBlock,
      specifiedType: const FullType(int),
    );
    yield r'valid_until_block';
    yield serializers.serialize(
      object.validUntilBlock,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksBlockQuoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksBlockQuoteValidityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksBlockQuoteValidityKindEnum),
          ) as BstocksBlockQuoteValidityKindEnum;
          result.kind = valueDes;
          break;
        case r'valid_after_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.validAfterBlock = valueDes;
          break;
        case r'valid_until_block':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.validUntilBlock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksBlockQuoteValidity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksBlockQuoteValidityBuilder();
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

class BstocksBlockQuoteValidityKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'block_window')
  static const BstocksBlockQuoteValidityKindEnum blockWindow = _$bstocksBlockQuoteValidityKindEnum_blockWindow;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksBlockQuoteValidityKindEnum unknownDefaultOpenApi = _$bstocksBlockQuoteValidityKindEnum_unknownDefaultOpenApi;

  static Serializer<BstocksBlockQuoteValidityKindEnum> get serializer => _$bstocksBlockQuoteValidityKindEnumSerializer;

  const BstocksBlockQuoteValidityKindEnum._(String name): super(name);

  static BuiltSet<BstocksBlockQuoteValidityKindEnum> get values => _$bstocksBlockQuoteValidityKindEnumValues;
  static BstocksBlockQuoteValidityKindEnum valueOf(String name) => _$bstocksBlockQuoteValidityKindEnumValueOf(name);
}

