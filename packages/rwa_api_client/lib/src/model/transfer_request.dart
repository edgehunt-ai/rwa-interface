//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/multi_source_funding_transfer_request.dart';
import 'package:rwa_api_client/src/model/legacy_funding_transfer_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'transfer_request.g.dart';

/// Creates exactly one Transfer. Multi-source plans require a leg-scoped request and one independent authorization per leg; clients cannot batch authorization IDs or create multiple legs at once. 
///
/// Properties:
/// * [planId] 
/// * [legId] - The next server-eligible leg in ordinal order for this frozen plan.
/// * [authorizationId] - 已绑定同一 frozen single-source plan 且尚未消费的一次性钱包授权 ID。
@BuiltValue()
abstract class TransferRequest implements Built<TransferRequest, TransferRequestBuilder> {
  /// One Of [LegacyFundingTransferRequest], [MultiSourceFundingTransferRequest]
  OneOf get oneOf;

  TransferRequest._();

  factory TransferRequest([void updates(TransferRequestBuilder b)]) = _$TransferRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferRequest> get serializer => _$TransferRequestSerializer();
}

class _$TransferRequestSerializer implements PrimitiveSerializer<TransferRequest> {
  @override
  final Iterable<Type> types = const [TransferRequest, _$TransferRequest];

  @override
  final String wireName = r'TransferRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  TransferRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferRequestBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(MultiSourceFundingTransferRequest), FullType(LegacyFundingTransferRequest), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

