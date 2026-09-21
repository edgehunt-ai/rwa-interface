//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_block_quote_validity.dart';
import 'package:rwa_api_client/src/model/bstocks_requote_validity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'bstocks_preview_economics_quote_validity.g.dart';

/// BstocksPreviewEconomicsQuoteValidity
///
/// Properties:
/// * [kind] 
/// * [validAfterBlock] 
/// * [validUntilBlock] 
@BuiltValue()
abstract class BstocksPreviewEconomicsQuoteValidity implements Built<BstocksPreviewEconomicsQuoteValidity, BstocksPreviewEconomicsQuoteValidityBuilder> {
  /// One Of [BstocksBlockQuoteValidity], [BstocksRequoteValidity]
  OneOf get oneOf;

  BstocksPreviewEconomicsQuoteValidity._();

  factory BstocksPreviewEconomicsQuoteValidity([void updates(BstocksPreviewEconomicsQuoteValidityBuilder b)]) = _$BstocksPreviewEconomicsQuoteValidity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewEconomicsQuoteValidityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewEconomicsQuoteValidity> get serializer => _$BstocksPreviewEconomicsQuoteValiditySerializer();
}

class _$BstocksPreviewEconomicsQuoteValiditySerializer implements PrimitiveSerializer<BstocksPreviewEconomicsQuoteValidity> {
  @override
  final Iterable<Type> types = const [BstocksPreviewEconomicsQuoteValidity, _$BstocksPreviewEconomicsQuoteValidity];

  @override
  final String wireName = r'BstocksPreviewEconomicsQuoteValidity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewEconomicsQuoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewEconomicsQuoteValidity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  BstocksPreviewEconomicsQuoteValidity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewEconomicsQuoteValidityBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(BstocksBlockQuoteValidity), FullType(BstocksRequoteValidity), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class BstocksPreviewEconomicsQuoteValidityKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'requote_on_confirmation')
  static const BstocksPreviewEconomicsQuoteValidityKindEnum requoteOnConfirmation = _$bstocksPreviewEconomicsQuoteValidityKindEnum_requoteOnConfirmation;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksPreviewEconomicsQuoteValidityKindEnum unknownDefaultOpenApi = _$bstocksPreviewEconomicsQuoteValidityKindEnum_unknownDefaultOpenApi;

  static Serializer<BstocksPreviewEconomicsQuoteValidityKindEnum> get serializer => _$bstocksPreviewEconomicsQuoteValidityKindEnumSerializer;

  const BstocksPreviewEconomicsQuoteValidityKindEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewEconomicsQuoteValidityKindEnum> get values => _$bstocksPreviewEconomicsQuoteValidityKindEnumValues;
  static BstocksPreviewEconomicsQuoteValidityKindEnum valueOf(String name) => _$bstocksPreviewEconomicsQuoteValidityKindEnumValueOf(name);
}

