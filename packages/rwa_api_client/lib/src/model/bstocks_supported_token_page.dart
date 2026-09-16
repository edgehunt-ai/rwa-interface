//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_supported_token.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_supported_token_page.g.dart';

/// BstocksSupportedTokenPage
///
/// Properties:
/// * [items] 
@BuiltValue()
abstract class BstocksSupportedTokenPage implements Built<BstocksSupportedTokenPage, BstocksSupportedTokenPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<BstocksSupportedToken> get items;

  BstocksSupportedTokenPage._();

  factory BstocksSupportedTokenPage([void updates(BstocksSupportedTokenPageBuilder b)]) = _$BstocksSupportedTokenPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksSupportedTokenPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksSupportedTokenPage> get serializer => _$BstocksSupportedTokenPageSerializer();
}

class _$BstocksSupportedTokenPageSerializer implements PrimitiveSerializer<BstocksSupportedTokenPage> {
  @override
  final Iterable<Type> types = const [BstocksSupportedTokenPage, _$BstocksSupportedTokenPage];

  @override
  final String wireName = r'BstocksSupportedTokenPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksSupportedTokenPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(BstocksSupportedToken)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksSupportedTokenPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksSupportedTokenPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BstocksSupportedToken)]),
          ) as BuiltList<BstocksSupportedToken>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksSupportedTokenPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksSupportedTokenPageBuilder();
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

