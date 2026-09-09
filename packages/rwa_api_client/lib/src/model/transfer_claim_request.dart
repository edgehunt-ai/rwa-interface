//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_claim_request.g.dart';

/// TransferClaimRequest
///
/// Properties:
/// * [authorizationId] - 已授权且尚未消费的 Claim 授权 ID
@BuiltValue()
abstract class TransferClaimRequest implements Built<TransferClaimRequest, TransferClaimRequestBuilder> {
  /// 已授权且尚未消费的 Claim 授权 ID
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  TransferClaimRequest._();

  factory TransferClaimRequest([void updates(TransferClaimRequestBuilder b)]) = _$TransferClaimRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransferClaimRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransferClaimRequest> get serializer => _$TransferClaimRequestSerializer();
}

class _$TransferClaimRequestSerializer implements PrimitiveSerializer<TransferClaimRequest> {
  @override
  final Iterable<Type> types = const [TransferClaimRequest, _$TransferClaimRequest];

  @override
  final String wireName = r'TransferClaimRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransferClaimRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransferClaimRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransferClaimRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  TransferClaimRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransferClaimRequestBuilder();
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

