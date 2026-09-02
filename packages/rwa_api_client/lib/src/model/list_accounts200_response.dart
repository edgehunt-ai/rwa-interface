//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_balance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_accounts200_response.g.dart';

/// ListAccounts200Response
///
/// Properties:
/// * [items] 
@BuiltValue()
abstract class ListAccounts200Response implements Built<ListAccounts200Response, ListAccounts200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<AccountBalance> get items;

  ListAccounts200Response._();

  factory ListAccounts200Response([void updates(ListAccounts200ResponseBuilder b)]) = _$ListAccounts200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListAccounts200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListAccounts200Response> get serializer => _$ListAccounts200ResponseSerializer();
}

class _$ListAccounts200ResponseSerializer implements PrimitiveSerializer<ListAccounts200Response> {
  @override
  final Iterable<Type> types = const [ListAccounts200Response, _$ListAccounts200Response];

  @override
  final String wireName = r'ListAccounts200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListAccounts200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(AccountBalance)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListAccounts200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListAccounts200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AccountBalance)]),
          ) as BuiltList<AccountBalance>;
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
  ListAccounts200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListAccounts200ResponseBuilder();
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

