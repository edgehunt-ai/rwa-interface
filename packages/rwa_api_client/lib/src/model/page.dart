//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page.g.dart';

/// Page
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore]
@BuiltValue(instantiable: false)
abstract class Page {
  /// 为 `null` 表示没有更多数据
  @BuiltValueField(wireName: r'next_cursor')
  String? get nextCursor;

  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  @BuiltValueSerializer(custom: true)
  static Serializer<Page> get serializer => _$PageSerializer();
}

class _$PageSerializer implements PrimitiveSerializer<Page> {
  @override
  final Iterable<Type> types = const [Page];

  @override
  final String wireName = r'Page';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Page object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    Page object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  @override
  Page deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($Page))
        as $Page;
  }
}

/// a concrete implementation of [Page], since [Page] is not instantiable
@BuiltValue(instantiable: true)
abstract class $Page implements Page, Built<$Page, $PageBuilder> {
  $Page._();

  factory $Page([void Function($PageBuilder)? updates]) = _$$Page;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($PageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$Page> get serializer => _$$PageSerializer();
}

class _$$PageSerializer implements PrimitiveSerializer<$Page> {
  @override
  final Iterable<Type> types = const [$Page, _$$Page];

  @override
  final String wireName = r'$Page';

  @override
  Object serialize(
    Serializers serializers,
    $Page object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(Page))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PageBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $Page deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $PageBuilder();
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
