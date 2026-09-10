//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_funding_transfer_request.g.dart';

/// Deprecated single-source request retained during the v1 compatibility window.
///
/// Properties:
/// * [planId] 
/// * [authorizationId] - 已绑定同一 frozen single-source plan 且尚未消费的一次性钱包授权 ID。
@Deprecated('LegacyFundingTransferRequest has been deprecated')
@BuiltValue()
abstract class LegacyFundingTransferRequest implements Built<LegacyFundingTransferRequest, LegacyFundingTransferRequestBuilder> {
  @BuiltValueField(wireName: r'plan_id')
  String get planId;

  /// 已绑定同一 frozen single-source plan 且尚未消费的一次性钱包授权 ID。
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  LegacyFundingTransferRequest._();

  factory LegacyFundingTransferRequest([void updates(LegacyFundingTransferRequestBuilder b)]) = _$LegacyFundingTransferRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyFundingTransferRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyFundingTransferRequest> get serializer => _$LegacyFundingTransferRequestSerializer();
}

class _$LegacyFundingTransferRequestSerializer implements PrimitiveSerializer<LegacyFundingTransferRequest> {
  @override
  final Iterable<Type> types = const [LegacyFundingTransferRequest, _$LegacyFundingTransferRequest];

  @override
  final String wireName = r'LegacyFundingTransferRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyFundingTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'plan_id';
    yield serializers.serialize(
      object.planId,
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
    LegacyFundingTransferRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LegacyFundingTransferRequestBuilder result,
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
  LegacyFundingTransferRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyFundingTransferRequestBuilder();
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

