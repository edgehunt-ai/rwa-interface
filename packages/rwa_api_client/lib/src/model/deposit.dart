//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/deposit_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/deposit_address.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit.g.dart';

/// Deposit
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
/// * [requiresTransfer] - 为 `true` 表示资金进入 App 可用余额，交易前仍需划转至交易账户； 外部导入模式为 `false`。 
/// * [txHash] 
/// * [activityId] 
/// * [createdAt] 
/// * [creditedAt] 
/// * [instructions] 
@BuiltValue()
abstract class Deposit implements Built<Deposit, DepositBuilder> {
  @BuiltValueField(wireName: r'deposit_id')
  String get depositId;

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  @BuiltValueField(wireName: r'token')
  DepositTokenEnum get token;
  // enum tokenEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  @BuiltValueField(wireName: r'status')
  DepositStatus get status;
  // enum statusEnum {  awaiting,  confirming,  credited,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'confirmations')
  int? get confirmations;

  @BuiltValueField(wireName: r'confirmations_required')
  int? get confirmationsRequired;

  @BuiltValueField(wireName: r'credited_to')
  AccountKind? get creditedTo;
  // enum creditedToEnum {  app,  bstocks,  hip3,  };

  /// 为 `true` 表示资金进入 App 可用余额，交易前仍需划转至交易账户； 外部导入模式为 `false`。 
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

  @BuiltValueField(wireName: r'instructions')
  DepositAddress get instructions;

  Deposit._();

  factory Deposit([void updates(DepositBuilder b)]) = _$Deposit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Deposit> get serializer => _$DepositSerializer();
}

class _$DepositSerializer implements PrimitiveSerializer<Deposit> {
  @override
  final Iterable<Type> types = const [Deposit, _$Deposit];

  @override
  final String wireName = r'Deposit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Deposit object, {
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
      specifiedType: const FullType(DepositTokenEnum),
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
      specifiedType: const FullType(DepositStatus),
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
    Deposit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositBuilder result,
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
            specifiedType: const FullType(DepositTokenEnum),
          ) as DepositTokenEnum;
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
            specifiedType: const FullType(DepositStatus),
          ) as DepositStatus;
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
  Deposit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositBuilder();
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

class DepositTokenEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const DepositTokenEnum USDC = _$depositTokenEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositTokenEnum unknownDefaultOpenApi = _$depositTokenEnum_unknownDefaultOpenApi;

  static Serializer<DepositTokenEnum> get serializer => _$depositTokenEnumSerializer;

  const DepositTokenEnum._(String name): super(name);

  static BuiltSet<DepositTokenEnum> get values => _$depositTokenEnumValues;
  static DepositTokenEnum valueOf(String name) => _$depositTokenEnumValueOf(name);
}

