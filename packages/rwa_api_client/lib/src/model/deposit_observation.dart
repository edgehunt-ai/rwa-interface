//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_observation_status.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_observation.g.dart';

/// 面向当前用户的脱敏链上观察摘要。`detected`、`confirming` 和 `manual_review` 不得计入 balance、Portfolio 或 History；`confirmed` 也必须等待正式 Deposit 入账 后才能进入这些读模型。该 shape 刻意不暴露 Provider 或 raw evidence。 
///
/// Properties:
/// * [observationId] - 服务端生成的不透明公开标识，不是内部证据或 Provider ID。
/// * [chain] 
/// * [asset] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [status] 
/// * [confirmations] 
/// * [confirmationsRequired] 
/// * [txHash] 
/// * [detectedAt] 
/// * [updatedAt] 
/// * [confirmedAt] 
/// * [depositId] - 形成正式已入账 Deposit 后才出现；仅 `confirmed` 并不保证该字段存在。
@BuiltValue()
abstract class DepositObservation implements Built<DepositObservation, DepositObservationBuilder> {
  /// 服务端生成的不透明公开标识，不是内部证据或 Provider ID。
  @BuiltValueField(wireName: r'observation_id')
  String get observationId;

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'asset')
  String get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'status')
  DepositObservationStatus get status;
  // enum statusEnum {  detected,  confirming,  confirmed,  manual_review,  };

  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  @BuiltValueField(wireName: r'confirmations_required')
  int get confirmationsRequired;

  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'detected_at')
  DateTime get detectedAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'confirmed_at')
  DateTime? get confirmedAt;

  /// 形成正式已入账 Deposit 后才出现；仅 `confirmed` 并不保证该字段存在。
  @BuiltValueField(wireName: r'deposit_id')
  String? get depositId;

  DepositObservation._();

  factory DepositObservation([void updates(DepositObservationBuilder b)]) = _$DepositObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositObservation> get serializer => _$DepositObservationSerializer();
}

class _$DepositObservationSerializer implements PrimitiveSerializer<DepositObservation> {
  @override
  final Iterable<Type> types = const [DepositObservation, _$DepositObservation];

  @override
  final String wireName = r'DepositObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'observation_id';
    yield serializers.serialize(
      object.observationId,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(DepositObservationStatus),
    );
    yield r'confirmations';
    yield serializers.serialize(
      object.confirmations,
      specifiedType: const FullType(int),
    );
    yield r'confirmations_required';
    yield serializers.serialize(
      object.confirmationsRequired,
      specifiedType: const FullType(int),
    );
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'detected_at';
    yield serializers.serialize(
      object.detectedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.confirmedAt != null) {
      yield r'confirmed_at';
      yield serializers.serialize(
        object.confirmedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.depositId != null) {
      yield r'deposit_id';
      yield serializers.serialize(
        object.depositId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositObservationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'observation_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.observationId = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.asset = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositObservationStatus),
          ) as DepositObservationStatus;
          result.status = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmations = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmationsRequired = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        case r'detected_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.detectedAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'confirmed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.confirmedAt = valueDes;
          break;
        case r'deposit_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.depositId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositObservationBuilder();
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

