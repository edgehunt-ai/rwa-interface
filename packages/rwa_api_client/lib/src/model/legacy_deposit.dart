//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/legacy_deposit_status.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/deposit_address.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_deposit.g.dart';

/// Legacy response shape used only by the side-effect-free deposit instruction adapter.
///
/// Properties:
/// * [depositId]
/// * [chain]
/// * [token]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [status]
/// * [confirmations]
/// * [confirmationsRequired]
/// * [creditedTo]
/// * [requiresTransfer]
/// * [txHash]
/// * [activityId]
/// * [createdAt]
/// * [creditedAt]
/// * [instructions]
@Deprecated('LegacyDeposit has been deprecated')
@BuiltValue()
abstract class LegacyDeposit
    implements Built<LegacyDeposit, LegacyDepositBuilder> {
  @BuiltValueField(wireName: r'deposit_id')
  String get depositId;

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'token')
  LegacyDepositTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @Deprecated('status has been deprecated')
  @BuiltValueField(wireName: r'status')
  LegacyDepositStatus get status;
  // enum statusEnum {  awaiting,  confirming,  credited,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'confirmations')
  int? get confirmations;

  @BuiltValueField(wireName: r'confirmations_required')
  int? get confirmationsRequired;

  @BuiltValueField(wireName: r'credited_to')
  AccountKind? get creditedTo;
  // enum creditedToEnum {  app,  bstocks,  hip3,  };

  @BuiltValueField(wireName: r'requires_transfer')
  bool? get requiresTransfer;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'activity_id')
  String? get activityId;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'credited_at')
  DateTime? get creditedAt;

  @Deprecated('instructions has been deprecated')
  @BuiltValueField(wireName: r'instructions')
  DepositAddress get instructions;

  LegacyDeposit._();

  factory LegacyDeposit([void updates(LegacyDepositBuilder b)]) =
      _$LegacyDeposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyDepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyDeposit> get serializer =>
      _$LegacyDepositSerializer();
}

class _$LegacyDepositSerializer implements PrimitiveSerializer<LegacyDeposit> {
  @override
  final Iterable<Type> types = const [LegacyDeposit, _$LegacyDeposit];

  @override
  final String wireName = r'LegacyDeposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyDeposit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'deposit_id';
    yield serializers.serialize(
      object.depositId,
      specifiedType: const FullType(String),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(LegacyDepositTokenEnum),
    );
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(LegacyDepositStatus),
    );
    if (object.confirmations != null) {
      yield r'confirmations';
      yield serializers.serialize(
        object.confirmations,
        specifiedType: const FullType(int),
      );
    }
    if (object.confirmationsRequired != null) {
      yield r'confirmations_required';
      yield serializers.serialize(
        object.confirmationsRequired,
        specifiedType: const FullType(int),
      );
    }
    if (object.creditedTo != null) {
      yield r'credited_to';
      yield serializers.serialize(
        object.creditedTo,
        specifiedType: const FullType(AccountKind),
      );
    }
    if (object.requiresTransfer != null) {
      yield r'requires_transfer';
      yield serializers.serialize(
        object.requiresTransfer,
        specifiedType: const FullType(bool),
      );
    }
    if (object.txHash != null) {
      yield r'tx_hash';
      yield serializers.serialize(
        object.txHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.activityId != null) {
      yield r'activity_id';
      yield serializers.serialize(
        object.activityId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.creditedAt != null) {
      yield r'credited_at';
      yield serializers.serialize(
        object.creditedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'instructions';
    yield serializers.serialize(
      object.instructions,
      specifiedType: const FullType(DepositAddress),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LegacyDeposit object, {
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
    required LegacyDepositBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'deposit_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.depositId = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyDepositTokenEnum),
          ) as LegacyDepositTokenEnum;
          result.token = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyDepositStatus),
          ) as LegacyDepositStatus;
          result.status = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmations = valueDes;
          break;
        case r'confirmations_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmationsRequired = valueDes;
          break;
        case r'credited_to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AccountKind),
          ) as AccountKind?;
          if (valueDes == null) continue;
          result.creditedTo = valueDes;
          break;
        case r'requires_transfer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.requiresTransfer = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'activity_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.activityId = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'credited_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.creditedAt = valueDes;
          break;
        case r'instructions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DepositAddress),
          ) as DepositAddress;
          result.instructions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LegacyDeposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyDepositBuilder();
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

@Deprecated('LegacyDepositTokenEnum has been deprecated')
class LegacyDepositTokenEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyDepositTokenEnum USDC = _$legacyDepositTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyDepositTokenEnum unknownDefaultOpenApi =
      _$legacyDepositTokenEnum_unknownDefaultOpenApi;

  static Serializer<LegacyDepositTokenEnum> get serializer =>
      _$legacyDepositTokenEnumSerializer;

  const LegacyDepositTokenEnum._(String name) : super(name);

  static BuiltSet<LegacyDepositTokenEnum> get values =>
      _$legacyDepositTokenEnumValues;
  static LegacyDepositTokenEnum valueOf(String name) =>
      _$legacyDepositTokenEnumValueOf(name);
}
