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
/// * [network]
/// * [settlementAsset]
/// * [status]
/// * [message]
/// * [createdAt]
/// * [expiresAt]
@BuiltValue()
abstract class Hip3Challenge
    implements Built<Hip3Challenge, Hip3ChallengeBuilder> {
  @BuiltValueField(wireName: r'challenge_id')
  String get challengeId;

  @BuiltValueField(wireName: r'network')
  Hip3ChallengeNetworkEnum get network;
  // enum networkEnum {  Arbitrum,  };

  @BuiltValueField(wireName: r'settlement_asset')
  Hip3ChallengeSettlementAssetEnum? get settlementAsset;
  // enum settlementAssetEnum {  USDC,  };

  @BuiltValueField(wireName: r'status')
  Hip3ChallengeStatusEnum get status;
  // enum statusEnum {  pending_signature,  completed,  expired,  failed,  };

  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  Hip3Challenge._();

  factory Hip3Challenge([void updates(Hip3ChallengeBuilder b)]) =
      _$Hip3Challenge;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ChallengeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3Challenge> get serializer =>
      _$Hip3ChallengeSerializer();
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
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
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
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(Hip3ChallengeSettlementAssetEnum),
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
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const Hip3ChallengeNetworkEnum arbitrum =
      _$hip3ChallengeNetworkEnum_arbitrum;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeNetworkEnum unknownDefaultOpenApi =
      _$hip3ChallengeNetworkEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeNetworkEnum> get serializer =>
      _$hip3ChallengeNetworkEnumSerializer;

  const Hip3ChallengeNetworkEnum._(String name) : super(name);

  static BuiltSet<Hip3ChallengeNetworkEnum> get values =>
      _$hip3ChallengeNetworkEnumValues;
  static Hip3ChallengeNetworkEnum valueOf(String name) =>
      _$hip3ChallengeNetworkEnumValueOf(name);
}

class Hip3ChallengeSettlementAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const Hip3ChallengeSettlementAssetEnum USDC =
      _$hip3ChallengeSettlementAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeSettlementAssetEnum unknownDefaultOpenApi =
      _$hip3ChallengeSettlementAssetEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeSettlementAssetEnum> get serializer =>
      _$hip3ChallengeSettlementAssetEnumSerializer;

  const Hip3ChallengeSettlementAssetEnum._(String name) : super(name);

  static BuiltSet<Hip3ChallengeSettlementAssetEnum> get values =>
      _$hip3ChallengeSettlementAssetEnumValues;
  static Hip3ChallengeSettlementAssetEnum valueOf(String name) =>
      _$hip3ChallengeSettlementAssetEnumValueOf(name);
}

class Hip3ChallengeStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending_signature')
  static const Hip3ChallengeStatusEnum pendingSignature =
      _$hip3ChallengeStatusEnum_pendingSignature;
  @BuiltValueEnumConst(wireName: r'completed')
  static const Hip3ChallengeStatusEnum completed =
      _$hip3ChallengeStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ChallengeStatusEnum expired =
      _$hip3ChallengeStatusEnum_expired;
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3ChallengeStatusEnum failed =
      _$hip3ChallengeStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ChallengeStatusEnum unknownDefaultOpenApi =
      _$hip3ChallengeStatusEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ChallengeStatusEnum> get serializer =>
      _$hip3ChallengeStatusEnumSerializer;

  const Hip3ChallengeStatusEnum._(String name) : super(name);

  static BuiltSet<Hip3ChallengeStatusEnum> get values =>
      _$hip3ChallengeStatusEnumValues;
  static Hip3ChallengeStatusEnum valueOf(String name) =>
      _$hip3ChallengeStatusEnumValueOf(name);
}
