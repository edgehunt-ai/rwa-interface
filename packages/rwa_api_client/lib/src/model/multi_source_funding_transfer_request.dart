//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_funding_transfer_request.g.dart';

/// MultiSourceFundingTransferRequest
///
/// Properties:
/// * [planId] 
/// * [legId] - The next server-eligible leg in ordinal order for this frozen plan.
/// * [authorizationId] - One unconsumed authorization bound to this exact plan and leg.
@BuiltValue()
abstract class MultiSourceFundingTransferRequest implements Built<MultiSourceFundingTransferRequest, MultiSourceFundingTransferRequestBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  /// The next server-eligible leg in ordinal order for this frozen plan.
  @BuiltValueField(wireName: r'leg_id')
  String get legId;

  /// One unconsumed authorization bound to this exact plan and leg.
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  MultiSourceFundingTransferRequest._();

  factory MultiSourceFundingTransferRequest([void updates(MultiSourceFundingTransferRequestBuilder b)]) = _$MultiSourceFundingTransferRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MultiSourceFundingTransferRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MultiSourceFundingTransferRequest> get serializer => _$MultiSourceFundingTransferRequestSerializer();
}

class _$MultiSourceFundingTransferRequestSerializer implements PrimitiveSerializer<MultiSourceFundingTransferRequest> {
  @override
  final Iterable<Type> types = const [MultiSourceFundingTransferRequest, _$MultiSourceFundingTransferRequest];

  @override
  final String wireName = r'MultiSourceFundingTransferRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MultiSourceFundingTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
      specifiedType: const FullType(String),
    );
    yield r'leg_id';
    yield serializers.serialize(
      object.legId,
      specifiedType: const FullType(String),
    );
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MultiSourceFundingTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MultiSourceFundingTransferRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'plan_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.planId = valueDes;
          break;
        case r'leg_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.legId = valueDes;
          break;
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MultiSourceFundingTransferRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MultiSourceFundingTransferRequestBuilder();
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

