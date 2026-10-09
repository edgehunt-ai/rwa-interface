//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_order_action_create_request.g.dart';

/// 显式接受原订单的新预览；服务端决定授权或执行动作，禁止客户端指定交易内容或动作类型。
///
/// Properties:
/// * [previewId] 
@BuiltValue()
abstract class BstocksOrderActionCreateRequest implements Built<BstocksOrderActionCreateRequest, BstocksOrderActionCreateRequestBuilder> {
  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  BstocksOrderActionCreateRequest._();

  factory BstocksOrderActionCreateRequest([void updates(BstocksOrderActionCreateRequestBuilder b)]) = _$BstocksOrderActionCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksOrderActionCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksOrderActionCreateRequest> get serializer => _$BstocksOrderActionCreateRequestSerializer();
}

class _$BstocksOrderActionCreateRequestSerializer implements PrimitiveSerializer<BstocksOrderActionCreateRequest> {
  @override
  final Iterable<Type> types = const [BstocksOrderActionCreateRequest, _$BstocksOrderActionCreateRequest];

  @override
  final String wireName = r'BstocksOrderActionCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksOrderActionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksOrderActionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksOrderActionCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksOrderActionCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksOrderActionCreateRequestBuilder();
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

