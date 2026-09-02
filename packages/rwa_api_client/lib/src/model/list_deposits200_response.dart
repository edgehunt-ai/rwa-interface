//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_deposits200_response.g.dart';

/// ListDeposits200Response
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [items] 
@BuiltValue()
abstract class ListDeposits200Response implements Page, Built<ListDeposits200Response, ListDeposits200ResponseBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Deposit> get items;

  ListDeposits200Response._();

  factory ListDeposits200Response([void updates(ListDeposits200ResponseBuilder b)]) = _$ListDeposits200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ListDeposits200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ListDeposits200Response> get serializer => _$ListDeposits200ResponseSerializer();
}

class _$ListDeposits200ResponseSerializer implements PrimitiveSerializer<ListDeposits200Response> {
  @override
  final Iterable<Type> types = const [ListDeposits200Response, _$ListDeposits200Response];

  @override
  final String wireName = r'ListDeposits200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ListDeposits200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next_cursor';
    yield object.nextCursor == null ? null : serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType.nullable(String),
    );
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(Deposit)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ListDeposits200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ListDeposits200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Deposit)]),
          ) as BuiltList<Deposit>;
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
  ListDeposits200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListDeposits200ResponseBuilder();
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

