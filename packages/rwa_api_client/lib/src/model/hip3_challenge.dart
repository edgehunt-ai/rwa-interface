//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_challenge.g.dart';

/// Hip3Challenge
///
/// Properties:
/// * [challengeId] 
/// * [network] - Legacy master-wallet chain label retained for the v1 compatibility window.
/// * [environment] 
/// * [purpose] 
/// * [ownerAddress] 
/// * [agentAddress] 
/// * [typedDataJson] - Canonical JSON for the exact Hyperliquid approveAgent typed-data payload.
/// * [payloadHash] 
/// * [validUntil] - The registered Agent expires after at most 30 days and must then be rotated to a fresh address.
/// * [settlementAsset] 
/// * [status] - `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
/// * [message] 
/// * [createdAt] 
/// * [expiresAt] - Signature challenge expiry; always earlier than valid_until.
@BuiltValue()
abstract class Hip3Challenge implements Built<Hip3Challenge, Hip3ChallengeBuilder> {
  @BuiltValueField(wireName: r'challenge_id')
  String get challengeId;

  /// Legacy master-wallet chain label retained for the v1 compatibility window.
  @Deprecated('network has been deprecated')
  @BuiltValueField(wireName: r'network')
  Hip3ChallengeNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'environment')
  Hip3ChallengeEnvironmentEnum get environment;
  // enum environmentEnum {  mainnet,  };

  @BuiltValueField(wireName: r'purpose')
  Hip3ChallengePurposeEnum get purpose;
  // enum purposeEnum {  register,  rotate,  };

  @BuiltValueField(wireName: r'owner_address')
  String get ownerAddress;

  @BuiltValueField(wireName: r'agent_address')
  String get agentAddress;

  /// Canonical JSON for the exact Hyperliquid approveAgent typed-data payload.
  @BuiltValueField(wireName: r'typed_data_json')
  String get typedDataJson;

  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  /// The registered Agent expires after at most 30 days and must then be rotated to a fresh address.
  @BuiltValueField(wireName: r'valid_until')
  DateTime get validUntil;

  @BuiltValueField(wireName: r'settlement_asset')
  Hip3ChallengeSettlementAssetEnum? get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueField(wireName: r'status')
  Hip3ChallengeStatusEnum get status;
  // enum statusEnum {  issued,  pending_signature,  submitting,  completed,  expired,  failed,  manual_review,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  /// Signature challenge expiry; always earlier than valid_until.
  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  Hip3Challenge._();

  factory Hip3Challenge([void updates(Hip3ChallengeBuilder b)]) = _$Hip3Challenge;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ChallengeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Challenge> get serializer => _$Hip3ChallengeSerializer();
}

class _$Hip3ChallengeSerializer implements PrimitiveSerializer<Hip3Challenge> {
  @override
  final Iterable<Type> types = const [Hip3Challenge, _$Hip3Challenge];

  @override
  final String wireName = r'Hip3Challenge';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3Challenge object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'challenge_id';
    yield serializers.serialize(
      object.challengeId,
      specifiedType: const FullType(String),
    );
    yield r'network';
    yield serializers.serialize(
      object.network,
      specifiedType: const FullType(Hip3ChallengeNetworkEnum),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3ChallengeEnvironmentEnum),
    );
    yield r'purpose';
    yield serializers.serialize(
      object.purpose,
      specifiedType: const FullType(Hip3ChallengePurposeEnum),
    );
    yield r'owner_address';
    yield serializers.serialize(
      object.ownerAddress,
      specifiedType: const FullType(String),
    );
    yield r'agent_address';
    yield serializers.serialize(
      object.agentAddress,
      specifiedType: const FullType(String),
    );
    yield r'typed_data_json';
    yield serializers.serialize(
      object.typedDataJson,
      specifiedType: const FullType(String),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    yield r'valid_until';
    yield serializers.serialize(
      object.validUntil,
      specifiedType: const FullType(DateTime),
    );
    if (object.settlementAsset != null) {
      yield r'settlement_asset';
      yield serializers.serialize(
        object.settlementAsset,
        specifiedType: const FullType(Hip3ChallengeSettlementAssetEnum),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(Hip3ChallengeStatusEnum),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3Challenge object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ChallengeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'challenge_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challengeId = valueDes;
          break;
        case r'network':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ChallengeNetworkEnum),
          ) as Hip3ChallengeNetworkEnum;
          result.network = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ChallengeEnvironmentEnum),
          ) as Hip3ChallengeEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'purpose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ChallengePurposeEnum),
          ) as Hip3ChallengePurposeEnum;
          result.purpose = valueDes;
          break;
        case r'owner_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ownerAddress = valueDes;
          break;
        case r'agent_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentAddress = valueDes;
          break;
        case r'typed_data_json':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.typedDataJson = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'valid_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.validUntil = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ChallengeSettlementAssetEnum),
          ) as Hip3ChallengeSettlementAssetEnum?;
          if (valueDes == null) continue;
          result.settlementAsset = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ChallengeStatusEnum),
          ) as Hip3ChallengeStatusEnum;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3Challenge deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ChallengeBuilder();
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

class Hip3ChallengeNetworkEnum extends EnumClass {

  /// Legacy master-wallet chain label retained for the v1 compatibility window.
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const Hip3ChallengeNetworkEnum arbitrum = _$hip3ChallengeNetworkEnum_arbitrum;
  /// Legacy master-wallet chain label retained for the v1 compatibility window.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeNetworkEnum unknownDefaultOpenApi = _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeNetworkEnum> get serializer => _$hip3ChallengeNetworkEnumSerializer;

  const Hip3ChallengeNetworkEnum._(String name): super(name);

  static BuiltSet<Hip3ChallengeNetworkEnum> get values => _$hip3ChallengeNetworkEnumValues;
  static Hip3ChallengeNetworkEnum valueOf(String name) => _$hip3ChallengeNetworkEnumValueOf(name);
}

class Hip3ChallengeEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3ChallengeEnvironmentEnum mainnet = _$hip3ChallengeEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeEnvironmentEnum unknownDefaultOpenApi = _$hip3ChallengeEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeEnvironmentEnum> get serializer => _$hip3ChallengeEnvironmentEnumSerializer;

  const Hip3ChallengeEnvironmentEnum._(String name): super(name);

  static BuiltSet<Hip3ChallengeEnvironmentEnum> get values => _$hip3ChallengeEnvironmentEnumValues;
  static Hip3ChallengeEnvironmentEnum valueOf(String name) => _$hip3ChallengeEnvironmentEnumValueOf(name);
}

class Hip3ChallengePurposeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'register')
  static const Hip3ChallengePurposeEnum register = _$hip3ChallengePurposeEnum_register;
  @BuiltValueEnumConst(wireName: r'rotate')
  static const Hip3ChallengePurposeEnum rotate = _$hip3ChallengePurposeEnum_rotate;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengePurposeEnum unknownDefaultOpenApi = _$hip3ChallengePurposeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengePurposeEnum> get serializer => _$hip3ChallengePurposeEnumSerializer;

  const Hip3ChallengePurposeEnum._(String name): super(name);

  static BuiltSet<Hip3ChallengePurposeEnum> get values => _$hip3ChallengePurposeEnumValues;
  static Hip3ChallengePurposeEnum valueOf(String name) => _$hip3ChallengePurposeEnumValueOf(name);
}

class Hip3ChallengeSettlementAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3ChallengeSettlementAssetEnum USDC = _$hip3ChallengeSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeSettlementAssetEnum unknownDefaultOpenApi = _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeSettlementAssetEnum> get serializer => _$hip3ChallengeSettlementAssetEnumSerializer;

  const Hip3ChallengeSettlementAssetEnum._(String name): super(name);

  static BuiltSet<Hip3ChallengeSettlementAssetEnum> get values => _$hip3ChallengeSettlementAssetEnumValues;
  static Hip3ChallengeSettlementAssetEnum valueOf(String name) => _$hip3ChallengeSettlementAssetEnumValueOf(name);
}

class Hip3ChallengeStatusEnum extends EnumClass {

  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'issued')
  static const Hip3ChallengeStatusEnum issued = _$hip3ChallengeStatusEnum_issued;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'pending_signature')
  static const Hip3ChallengeStatusEnum pendingSignature = _$hip3ChallengeStatusEnum_pendingSignature;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'submitting')
  static const Hip3ChallengeStatusEnum submitting = _$hip3ChallengeStatusEnum_submitting;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'completed')
  static const Hip3ChallengeStatusEnum completed = _$hip3ChallengeStatusEnum_completed;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ChallengeStatusEnum expired = _$hip3ChallengeStatusEnum_expired;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3ChallengeStatusEnum failed = _$hip3ChallengeStatusEnum_failed;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const Hip3ChallengeStatusEnum manualReview = _$hip3ChallengeStatusEnum_manualReview;
  /// `pending_signature` is a deprecated v1 compatibility value. Newly issued Mainnet challenges use `issued` and never transition back to the legacy value.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeStatusEnum unknownDefaultOpenApi = _$hip3ChallengeStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeStatusEnum> get serializer => _$hip3ChallengeStatusEnumSerializer;

  const Hip3ChallengeStatusEnum._(String name): super(name);

  static BuiltSet<Hip3ChallengeStatusEnum> get values => _$hip3ChallengeStatusEnumValues;
  static Hip3ChallengeStatusEnum valueOf(String name) => _$hip3ChallengeStatusEnumValueOf(name);
}

