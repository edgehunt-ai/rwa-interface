//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_create_request.g.dart';

/// Creates a non-executable funding preparation session from an order draft. The server derives the settlement rail, target identity and funding requirement without freezing a trade quote. 
///
/// Properties:
/// * [trade] 
@BuiltValue()
abstract class FundingSessionCreateRequest implements Built<FundingSessionCreateRequest, FundingSessionCreateRequestBuilder> {
  @BuiltValueField(wireName: r'trade')
  OrderPreviewRequest get trade;

  FundingSessionCreateRequest._();

  factory FundingSessionCreateRequest([void updates(FundingSessionCreateRequestBuilder b)]) = _$FundingSessionCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionCreateRequest> get serializer => _$FundingSessionCreateRequestSerializer();
}

class _$FundingSessionCreateRequestSerializer implements PrimitiveSerializer<FundingSessionCreateRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionCreateRequest, _$FundingSessionCreateRequest];

  @override
  final String wireName = r'FundingSessionCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'trade';
    yield serializers.serialize(
      object.trade,
      specifiedType: const FullType(OrderPreviewRequest),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'trade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderPreviewRequest),
          ) as OrderPreviewRequest;
          result.trade.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionCreateRequestBuilder();
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

