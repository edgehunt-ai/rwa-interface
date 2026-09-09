//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hyperliquid_signature.g.dart';

/// HyperliquidSignature
///
/// Properties:
/// * [r] 
/// * [s] 
/// * [v] 
@BuiltValue()
abstract class HyperliquidSignature implements Built<HyperliquidSignature, HyperliquidSignatureBuilder> {
  @BuiltValueField(wireName: r'r')
  String get r;

  @BuiltValueField(wireName: r's')
  String get s;

  @BuiltValueField(wireName: r'v')
  HyperliquidSignatureVEnum get v;
  // enum vEnum {  27,  28,  };

  HyperliquidSignature._();

  factory HyperliquidSignature([void updates(HyperliquidSignatureBuilder b)]) = _$HyperliquidSignature;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HyperliquidSignatureBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HyperliquidSignature> get serializer => _$HyperliquidSignatureSerializer();
}

class _$HyperliquidSignatureSerializer implements PrimitiveSerializer<HyperliquidSignature> {
  @override
  final Iterable<Type> types = const [HyperliquidSignature, _$HyperliquidSignature];

  @override
  final String wireName = r'HyperliquidSignature';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HyperliquidSignature object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'r';
    yield serializers.serialize(
      object.r,
      specifiedType: const FullType(String),
    );
    yield r's';
    yield serializers.serialize(
      object.s,
      specifiedType: const FullType(String),
    );
    yield r'v';
    yield serializers.serialize(
      object.v,
      specifiedType: const FullType(HyperliquidSignatureVEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HyperliquidSignature object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HyperliquidSignatureBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'r':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.r = valueDes;
          break;
        case r's':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.s = valueDes;
          break;
        case r'v':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HyperliquidSignatureVEnum),
          ) as HyperliquidSignatureVEnum;
          result.v = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HyperliquidSignature deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HyperliquidSignatureBuilder();
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

class HyperliquidSignatureVEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 27)
  static const HyperliquidSignatureVEnum number27 = _$hyperliquidSignatureVEnum_number27;
  @BuiltValueEnumConst(wireNumber: 28)
  static const HyperliquidSignatureVEnum number28 = _$hyperliquidSignatureVEnum_number28;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const HyperliquidSignatureVEnum unknownDefaultOpenApi = _$hyperliquidSignatureVEnum_unknownDefaultOpenApi;

  static Serializer<HyperliquidSignatureVEnum> get serializer => _$hyperliquidSignatureVEnumSerializer;

  const HyperliquidSignatureVEnum._(String name): super(name);

  static BuiltSet<HyperliquidSignatureVEnum> get values => _$hyperliquidSignatureVEnumValues;
  static HyperliquidSignatureVEnum valueOf(String name) => _$hyperliquidSignatureVEnumValueOf(name);
}

