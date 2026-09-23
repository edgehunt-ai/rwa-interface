//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_trade_create_request.g.dart';

/// Order-draft funding session creation. The draft is stored as the session snapshot.
///
/// Properties:
/// * [trade] 
@BuiltValue()
abstract class FundingSessionTradeCreateRequest implements Built<FundingSessionTradeCreateRequest, FundingSessionTradeCreateRequestBuilder> {
  @BuiltValueField(wireName: r'trade')
  OrderPreviewRequest get trade;

  FundingSessionTradeCreateRequest._();

  factory FundingSessionTradeCreateRequest([void updates(FundingSessionTradeCreateRequestBuilder b)]) = _$FundingSessionTradeCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTradeCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTradeCreateRequest> get serializer => _$FundingSessionTradeCreateRequestSerializer();
}

class _$FundingSessionTradeCreateRequestSerializer implements PrimitiveSerializer<FundingSessionTradeCreateRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionTradeCreateRequest, _$FundingSessionTradeCreateRequest];

  @override
  final String wireName = r'FundingSessionTradeCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTradeCreateRequest object, {
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
    FundingSessionTradeCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTradeCreateRequestBuilder result,
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
  FundingSessionTradeCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTradeCreateRequestBuilder();
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

