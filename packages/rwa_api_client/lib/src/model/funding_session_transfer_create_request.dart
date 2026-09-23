//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_session_transfer_intent.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_transfer_create_request.g.dart';

/// Standalone account transfer session creation. The session tops up the destination account by the requested amount; no order is created or implied. 
///
/// Properties:
/// * [transfer] 
@BuiltValue()
abstract class FundingSessionTransferCreateRequest implements Built<FundingSessionTransferCreateRequest, FundingSessionTransferCreateRequestBuilder> {
  @BuiltValueField(wireName: r'transfer')
  FundingSessionTransferIntent get transfer;

  FundingSessionTransferCreateRequest._();

  factory FundingSessionTransferCreateRequest([void updates(FundingSessionTransferCreateRequestBuilder b)]) = _$FundingSessionTransferCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionTransferCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSessionTransferCreateRequest> get serializer => _$FundingSessionTransferCreateRequestSerializer();
}

class _$FundingSessionTransferCreateRequestSerializer implements PrimitiveSerializer<FundingSessionTransferCreateRequest> {
  @override
  final Iterable<Type> types = const [FundingSessionTransferCreateRequest, _$FundingSessionTransferCreateRequest];

  @override
  final String wireName = r'FundingSessionTransferCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSessionTransferCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'transfer';
    yield serializers.serialize(
      object.transfer,
      specifiedType: const FullType(FundingSessionTransferIntent),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionTransferCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionTransferCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transfer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionTransferIntent),
          ) as FundingSessionTransferIntent;
          result.transfer.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingSessionTransferCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionTransferCreateRequestBuilder();
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

