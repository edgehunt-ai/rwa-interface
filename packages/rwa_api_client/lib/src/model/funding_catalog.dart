//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_rail.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_catalog.g.dart';

/// FundingCatalog
///
/// Properties:
/// * [rails] 
/// * [updatedAt] 
@BuiltValue()
abstract class FundingCatalog implements Built<FundingCatalog, FundingCatalogBuilder> {
  @BuiltValueField(wireName: r'rails')
  BuiltList<FundingRail> get rails;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  FundingCatalog._();

  factory FundingCatalog([void updates(FundingCatalogBuilder b)]) = _$FundingCatalog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingCatalogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingCatalog> get serializer => _$FundingCatalogSerializer();
}

class _$FundingCatalogSerializer implements PrimitiveSerializer<FundingCatalog> {
  @override
  final Iterable<Type> types = const [FundingCatalog, _$FundingCatalog];

  @override
  final String wireName = r'FundingCatalog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rails';
    yield serializers.serialize(
      object.rails,
      specifiedType: const FullType(BuiltList, [FullType(FundingRail)]),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingCatalog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingCatalogBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rails':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingRail)]),
          ) as BuiltList<FundingRail>;
          result.rails.replace(valueDes);
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingCatalog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingCatalogBuilder();
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

