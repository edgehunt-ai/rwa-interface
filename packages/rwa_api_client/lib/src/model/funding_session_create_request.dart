//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_session_transfer_create_request.dart';
import 'package:rwa_api_client/src/model/funding_session_trade_create_request.dart';
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:rwa_api_client/src/model/funding_session_transfer_intent.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_session_create_request.g.dart';

/// Creates a non-executable funding preparation session. `trade` derives the funding requirement from an order draft; `transfer` derives it from an account-scoped top-up intent that carries no order. The server derives the settlement rail, target identity and funding requirement without freezing a trade quote. 
///
/// Properties:
/// * [trade] 
/// * [transfer] 
@BuiltValue()
abstract class FundingSessionCreateRequest implements Built<FundingSessionCreateRequest, FundingSessionCreateRequestBuilder> {
  /// One Of [FundingSessionTradeCreateRequest], [FundingSessionTransferCreateRequest]
  OneOf get oneOf;

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
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSessionCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingSessionCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionCreateRequestBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(FundingSessionTradeCreateRequest), FullType(FundingSessionTransferCreateRequest), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

