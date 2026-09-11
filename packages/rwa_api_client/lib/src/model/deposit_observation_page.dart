//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_observation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_observation_page.g.dart';

/// 脱敏观察的封闭分页 envelope。顶层同样禁止 Provider 名称、Webhook/RPC payload、 raw evidence 与内部 evidence ID；未来新增公开字段必须通过显式 Contract 版本演进。 
///
/// Properties:
/// * [items] 
/// * [nextCursor] - 为 `null` 表示没有更多数据。
/// * [hasMore] 
@BuiltValue()
abstract class DepositObservationPage implements Built<DepositObservationPage, DepositObservationPageBuilder> {
  @BuiltValueField(wireName: r'items')
  BuiltList<DepositObservation> get items;

  /// 为 `null` 表示没有更多数据。
  @BuiltValueField(wireName: r'next_cursor')
  String? get nextCursor;

  @BuiltValueField(wireName: r'has_more')
  bool get hasMore;

  DepositObservationPage._();

  factory DepositObservationPage([void updates(DepositObservationPageBuilder b)]) = _$DepositObservationPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositObservationPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositObservationPage> get serializer => _$DepositObservationPageSerializer();
}

class _$DepositObservationPageSerializer implements PrimitiveSerializer<DepositObservationPage> {
  @override
  final Iterable<Type> types = const [DepositObservationPage, _$DepositObservationPage];

  @override
  final String wireName = r'DepositObservationPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositObservationPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(DepositObservation)]),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositObservationPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositObservationPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepositObservation)]),
          ) as BuiltList<DepositObservation>;
          result.items.replace(valueDes);
          break;
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
  DepositObservationPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositObservationPageBuilder();
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

