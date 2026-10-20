//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/native_cancellation_status.dart';
import 'package:rwa_api_client/src/model/privy_authorization_payload.dart';
import 'package:rwa_api_client/src/model/wallet_action_chain_observation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'native_cancellation.g.dart';

/// Separate exact-original-nonce recovery attempt. Authorization is exposed only while awaiting the user; uncertain dispatch cannot be renewed. Expired never-dispatched or proven rejected attempts may be explicitly prepared again with a new cancellation_id/request identity and unchanged original nonce. confirmed means canonical nonce consumption, not original business success; receipt_success may be false. Reorg retracts current proof without replacing original facts. 
///
/// Properties:
/// * [cancellationId] 
/// * [nonce] 
/// * [to] 
/// * [status] 
/// * [privyAuthorizationPayload] 
/// * [authorizationExpiresAt] 
/// * [txHash] 
/// * [chainObservation] 
@BuiltValue()
abstract class NativeCancellation implements Built<NativeCancellation, NativeCancellationBuilder> {
  @BuiltValueField(wireName: r'cancellation_id')
  String get cancellationId;

  @BuiltValueField(wireName: r'nonce')
  String get nonce;

  @BuiltValueField(wireName: r'to')
  String get to;

  @BuiltValueField(wireName: r'status')
  NativeCancellationStatus get status;
  // enum statusEnum {  awaiting_user_authorization,  submitting,  provider_submitted,  confirmed,  ambiguous,  failed,  };

  @BuiltValueField(wireName: r'privy_authorization_payload')
  PrivyAuthorizationPayload? get privyAuthorizationPayload;

  @BuiltValueField(wireName: r'authorization_expires_at')
  DateTime? get authorizationExpiresAt;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'chain_observation')
  WalletActionChainObservation? get chainObservation;

  NativeCancellation._();

  factory NativeCancellation([void updates(NativeCancellationBuilder b)]) = _$NativeCancellation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NativeCancellationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NativeCancellation> get serializer => _$NativeCancellationSerializer();
}

class _$NativeCancellationSerializer implements PrimitiveSerializer<NativeCancellation> {
  @override
  final Iterable<Type> types = const [NativeCancellation, _$NativeCancellation];

  @override
  final String wireName = r'NativeCancellation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NativeCancellation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'cancellation_id';
    yield serializers.serialize(
      object.cancellationId,
      specifiedType: const FullType(String),
    );
    yield r'nonce';
    yield serializers.serialize(
      object.nonce,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(NativeCancellationStatus),
    );
    yield r'privy_authorization_payload';
    yield object.privyAuthorizationPayload == null ? null : serializers.serialize(
      object.privyAuthorizationPayload,
      specifiedType: const FullType.nullable(PrivyAuthorizationPayload),
    );
    yield r'authorization_expires_at';
    yield object.authorizationExpiresAt == null ? null : serializers.serialize(
      object.authorizationExpiresAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'tx_hash';
    yield object.txHash == null ? null : serializers.serialize(
      object.txHash,
      specifiedType: const FullType.nullable(String),
    );
    yield r'chain_observation';
    yield object.chainObservation == null ? null : serializers.serialize(
      object.chainObservation,
      specifiedType: const FullType.nullable(WalletActionChainObservation),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NativeCancellation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NativeCancellationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cancellation_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cancellationId = valueDes;
          break;
        case r'nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nonce = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NativeCancellationStatus),
          ) as NativeCancellationStatus;
          result.status = valueDes;
          break;
        case r'privy_authorization_payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PrivyAuthorizationPayload),
          ) as PrivyAuthorizationPayload?;
          if (valueDes == null) continue;
          result.privyAuthorizationPayload.replace(valueDes);
          break;
        case r'authorization_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.authorizationExpiresAt = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'chain_observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WalletActionChainObservation),
          ) as WalletActionChainObservation?;
          if (valueDes == null) continue;
          result.chainObservation.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NativeCancellation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NativeCancellationBuilder();
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

