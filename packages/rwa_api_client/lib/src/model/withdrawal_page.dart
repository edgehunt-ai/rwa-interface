//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/withdrawal.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_page.g.dart';

/// WithdrawalPage
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore]
/// * [items]
@BuiltValue()
abstract class WithdrawalPage
    implements Page, Built<WithdrawalPage, WithdrawalPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<Withdrawal> get items;

  WithdrawalPage._();

  factory WithdrawalPage([void updates(WithdrawalPageBuilder b)]) =
      _$WithdrawalPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WithdrawalPage> get serializer =>
      _$WithdrawalPageSerializer();
}

class _$WithdrawalPageSerializer
    implements PrimitiveSerializer<WithdrawalPage> {
  @override
  final Iterable<Type> types = const [WithdrawalPage, _$WithdrawalPage];

  @override
  final String wireName = r'WithdrawalPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WithdrawalPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next_cursor';
    yield object.nextCursor == null
        ? null
        : serializers.serialize(
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
      specifiedType: const FullType(BuiltList, [FullType(Withdrawal)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WithdrawalPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalPageBuilder result,
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
            specifiedType: const FullType(BuiltList, [FullType(Withdrawal)]),
          ) as BuiltList<Withdrawal>;
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
  WithdrawalPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalPageBuilder();
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
