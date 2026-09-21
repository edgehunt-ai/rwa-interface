//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_route_leg.g.dart';

/// BstocksPreviewRouteLeg
///
/// Properties:
/// * [venue] 
/// * [amountInRaw] - 十进制字符串，避免浮点误差
/// * [amountOutRaw] - 十进制字符串，避免浮点误差
/// * [feeTier] 
/// * [quoteReference] 
@BuiltValue()
abstract class BstocksPreviewRouteLeg implements Built<BstocksPreviewRouteLeg, BstocksPreviewRouteLegBuilder> {
  @BuiltValueField(wireName: r'venue')
  BstocksPreviewRouteLegVenueEnum get venue;
  // enum venueEnum {  propamm,  pancake_v3,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount_in_raw')
  String get amountInRaw;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount_out_raw')
  String get amountOutRaw;

  @BuiltValueField(wireName: r'fee_tier')
  int? get feeTier;

  @BuiltValueField(wireName: r'quote_reference')
  String get quoteReference;

  BstocksPreviewRouteLeg._();

  factory BstocksPreviewRouteLeg([void updates(BstocksPreviewRouteLegBuilder b)]) = _$BstocksPreviewRouteLeg;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewRouteLegBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewRouteLeg> get serializer => _$BstocksPreviewRouteLegSerializer();
}

class _$BstocksPreviewRouteLegSerializer implements PrimitiveSerializer<BstocksPreviewRouteLeg> {
  @override
  final Iterable<Type> types = const [BstocksPreviewRouteLeg, _$BstocksPreviewRouteLeg];

  @override
  final String wireName = r'BstocksPreviewRouteLeg';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewRouteLeg object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'venue';
    yield serializers.serialize(
      object.venue,
      specifiedType: const FullType(BstocksPreviewRouteLegVenueEnum),
    );
    yield r'amount_in_raw';
    yield serializers.serialize(
      object.amountInRaw,
      specifiedType: const FullType(String),
    );
    yield r'amount_out_raw';
    yield serializers.serialize(
      object.amountOutRaw,
      specifiedType: const FullType(String),
    );
    yield r'fee_tier';
    yield object.feeTier == null ? null : serializers.serialize(
      object.feeTier,
      specifiedType: const FullType.nullable(int),
    );
    yield r'quote_reference';
    yield serializers.serialize(
      object.quoteReference,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewRouteLeg object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewRouteLegBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'venue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewRouteLegVenueEnum),
          ) as BstocksPreviewRouteLegVenueEnum;
          result.venue = valueDes;
          break;
        case r'amount_in_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountInRaw = valueDes;
          break;
        case r'amount_out_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amountOutRaw = valueDes;
          break;
        case r'fee_tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.feeTier = valueDes;
          break;
        case r'quote_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quoteReference = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPreviewRouteLeg deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewRouteLegBuilder();
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

class BstocksPreviewRouteLegVenueEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'propamm')
  static const BstocksPreviewRouteLegVenueEnum propamm = _$bstocksPreviewRouteLegVenueEnum_propamm;
  @BuiltValueEnumConst(wireName: r'pancake_v3')
  static const BstocksPreviewRouteLegVenueEnum pancakeV3 = _$bstocksPreviewRouteLegVenueEnum_pancakeV3;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksPreviewRouteLegVenueEnum unknownDefaultOpenApi = _$bstocksPreviewRouteLegVenueEnum_unknownDefaultOpenApi;

  static Serializer<BstocksPreviewRouteLegVenueEnum> get serializer => _$bstocksPreviewRouteLegVenueEnumSerializer;

  const BstocksPreviewRouteLegVenueEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewRouteLegVenueEnum> get values => _$bstocksPreviewRouteLegVenueEnumValues;
  static BstocksPreviewRouteLegVenueEnum valueOf(String name) => _$bstocksPreviewRouteLegVenueEnumValueOf(name);
}

