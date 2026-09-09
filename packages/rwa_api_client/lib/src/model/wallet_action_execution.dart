//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/frozen_evm_transaction.dart';
import 'package:rwa_api_client/src/model/wallet_action_provider_status.dart';
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/wallet_action_kind.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution_provider.dart';
import 'package:rwa_api_client/src/model/gas_payment_mode.dart';
import 'package:rwa_api_client/src/model/privy_authorization_payload.dart';
import 'package:rwa_api_client/src/model/wallet_action_chain_observation.dart';
import 'package:rwa_api_client/src/model/wallet_action_resource_type.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_execution.g.dart';

/// Server-authoritative execution of one exact frozen business action. Creation binds the resource, wallet, chain, payload hash and transaction permanently; clients supply only `mode`.  Submission performs a compare-and-set to `submitting` before synchronously relaying an app-sponsored signature to Privy. The signature is never persisted. When Privy accepts the request, the server stores `privy_transaction_id` and/or `user_operation_hash`; only executions with such an identifier may be polled or reconciled by workers/Webhooks/RPC. A timeout, 5xx or crash with an unknown result becomes `ambiguous` or `manual_review`, never an automatic replay.  After Privy acceptance or any ambiguous Provider result, mode switching, re-signing and automatic replay are forbidden. User-paid fallback is allowed only after a deterministic pre-broadcast rejection. Activity may be created only after Privy or RPC observes an actual broadcast; authorization submission alone is not broadcast evidence. Mode- and status-specific cross-field invariants are enforced fail-closed by server/domain validation.
///
/// Properties:
/// * [executionId]
/// * [resourceType]
/// * [resourceId] - Bound order_id or transfer_id; it is never accepted from the client.
/// * [actionId] - Bound transfer action_id or order step_id; it is never accepted from the client.
/// * [actionKind]
/// * [chainId]
/// * [walletAddress]
/// * [payloadHash] - Lowercase SHA-256 digest without `0x` over the versioned canonical chain/from/to/calldata/value tuple. It MUST equal the bound business action hash.
/// * [businessExpiresAt]
/// * [mode]
/// * [executionProvider]
/// * [status]
/// * [providerStatus]
/// * [gasPayment]
/// * [frozenTransaction]
/// * [fallbackFromExecutionId] - Null for app-sponsored execution. A user-paid execution must contain the server-derived id of the matching sponsored execution that ended in `user_gas_confirmation_required`.
/// * [privyAuthorizationPayload] - Non-null only for an `app_sponsored` execution in `awaiting_user_authorization`; null in every other mode or status. Its expiry is at most 60 seconds and never exceeds the frozen business action expiry.
/// * [authorizationExpiresAt] - Mirrors the structured Privy request expiry; null when no authorization is exposed.
/// * [privyTransactionId]
/// * [userOperationHash]
/// * [txHash]
/// * [chainObservation]
/// * [activityId]
/// * [failureReason]
/// * [manualReviewReason]
/// * [createdAt]
/// * [updatedAt]
@BuiltValue()
abstract class WalletActionExecution
    implements Built<WalletActionExecution, WalletActionExecutionBuilder> {
  @BuiltValueField(wireName: r'execution_id')
  String get executionId;

  @BuiltValueField(wireName: r'resource_type')
  WalletActionResourceType get resourceType;
  // enum resourceTypeEnum {  transfer,  order,  };

  /// Bound order_id or transfer_id; it is never accepted from the client.
  @BuiltValueField(wireName: r'resource_id')
  String get resourceId;

  /// Bound transfer action_id or order step_id; it is never accepted from the client.
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'action_kind')
  WalletActionKind get actionKind;
  // enum actionKindEnum {  erc20_approval,  origin_transaction,  spot_swap,  };

  @BuiltValueField(wireName: r'chain_id')
  WalletActionExecutionChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  8453,  42161,  };

  @BuiltValueField(wireName: r'wallet_address')
  String get walletAddress;

  /// Lowercase SHA-256 digest without `0x` over the versioned canonical chain/from/to/calldata/value tuple. It MUST equal the bound business action hash.
  @BuiltValueField(wireName: r'payload_hash')
  String get payloadHash;

  @BuiltValueField(wireName: r'business_expires_at')
  DateTime get businessExpiresAt;

  @BuiltValueField(wireName: r'mode')
  GasPaymentMode get mode;
  // enum modeEnum {  app_sponsored,  user_paid_native,  };

  @BuiltValueField(wireName: r'execution_provider')
  WalletActionExecutionProvider get executionProvider;
  // enum executionProviderEnum {  privy,  user_wallet,  };

  @BuiltValueField(wireName: r'status')
  WalletActionExecutionStatus get status;
  // enum statusEnum {  awaiting_user_authorization,  submitting,  provider_submitted,  chain_confirmed,  completed,  user_gas_confirmation_required,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'provider_status')
  WalletActionProviderStatus get providerStatus;
  // enum providerStatusEnum {  not_submitted,  submitted,  pending,  confirmed,  reverted,  failed,  unknown,  };

  @BuiltValueField(wireName: r'gas_payment')
  GasPaymentQuote get gasPayment;

  @BuiltValueField(wireName: r'frozen_transaction')
  FrozenEvmTransaction get frozenTransaction;

  /// Null for app-sponsored execution. A user-paid execution must contain the server-derived id of the matching sponsored execution that ended in `user_gas_confirmation_required`.
  @BuiltValueField(wireName: r'fallback_from_execution_id')
  String? get fallbackFromExecutionId;

  /// Non-null only for an `app_sponsored` execution in `awaiting_user_authorization`; null in every other mode or status. Its expiry is at most 60 seconds and never exceeds the frozen business action expiry.
  @BuiltValueField(wireName: r'privy_authorization_payload')
  PrivyAuthorizationPayload? get privyAuthorizationPayload;

  /// Mirrors the structured Privy request expiry; null when no authorization is exposed.
  @BuiltValueField(wireName: r'authorization_expires_at')
  DateTime? get authorizationExpiresAt;

  @BuiltValueField(wireName: r'privy_transaction_id')
  String? get privyTransactionId;

  @BuiltValueField(wireName: r'user_operation_hash')
  String? get userOperationHash;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'chain_observation')
  WalletActionChainObservation? get chainObservation;

  @BuiltValueField(wireName: r'activity_id')
  String? get activityId;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  @BuiltValueField(wireName: r'manual_review_reason')
  String? get manualReviewReason;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  WalletActionExecution._();

  factory WalletActionExecution(
      [void updates(WalletActionExecutionBuilder b)]) = _$WalletActionExecution;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionExecutionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionExecution> get serializer =>
      _$WalletActionExecutionSerializer();
}

class _$WalletActionExecutionSerializer
    implements PrimitiveSerializer<WalletActionExecution> {
  @override
  final Iterable<Type> types = const [
    WalletActionExecution,
    _$WalletActionExecution
  ];

  @override
  final String wireName = r'WalletActionExecution';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WalletActionExecution object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'execution_id';
    yield serializers.serialize(
      object.executionId,
      specifiedType: const FullType(String),
    );
    yield r'resource_type';
    yield serializers.serialize(
      object.resourceType,
      specifiedType: const FullType(WalletActionResourceType),
    );
    yield r'resource_id';
    yield serializers.serialize(
      object.resourceId,
      specifiedType: const FullType(String),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'action_kind';
    yield serializers.serialize(
      object.actionKind,
      specifiedType: const FullType(WalletActionKind),
    );
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(WalletActionExecutionChainIdEnum),
    );
    yield r'wallet_address';
    yield serializers.serialize(
      object.walletAddress,
      specifiedType: const FullType(String),
    );
    yield r'payload_hash';
    yield serializers.serialize(
      object.payloadHash,
      specifiedType: const FullType(String),
    );
    yield r'business_expires_at';
    yield serializers.serialize(
      object.businessExpiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(GasPaymentMode),
    );
    yield r'execution_provider';
    yield serializers.serialize(
      object.executionProvider,
      specifiedType: const FullType(WalletActionExecutionProvider),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(WalletActionExecutionStatus),
    );
    yield r'provider_status';
    yield serializers.serialize(
      object.providerStatus,
      specifiedType: const FullType(WalletActionProviderStatus),
    );
    yield r'gas_payment';
    yield serializers.serialize(
      object.gasPayment,
      specifiedType: const FullType(GasPaymentQuote),
    );
    yield r'frozen_transaction';
    yield serializers.serialize(
      object.frozenTransaction,
      specifiedType: const FullType(FrozenEvmTransaction),
    );
    yield r'fallback_from_execution_id';
    yield object.fallbackFromExecutionId == null
        ? null
        : serializers.serialize(
            object.fallbackFromExecutionId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'privy_authorization_payload';
    yield object.privyAuthorizationPayload == null
        ? null
        : serializers.serialize(
            object.privyAuthorizationPayload,
            specifiedType: const FullType.nullable(PrivyAuthorizationPayload),
          );
    yield r'authorization_expires_at';
    yield object.authorizationExpiresAt == null
        ? null
        : serializers.serialize(
            object.authorizationExpiresAt,
            specifiedType: const FullType.nullable(DateTime),
          );
    yield r'privy_transaction_id';
    yield object.privyTransactionId == null
        ? null
        : serializers.serialize(
            object.privyTransactionId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'user_operation_hash';
    yield object.userOperationHash == null
        ? null
        : serializers.serialize(
            object.userOperationHash,
            specifiedType: const FullType.nullable(String),
          );
    yield r'tx_hash';
    yield object.txHash == null
        ? null
        : serializers.serialize(
            object.txHash,
            specifiedType: const FullType.nullable(String),
          );
    yield r'chain_observation';
    yield object.chainObservation == null
        ? null
        : serializers.serialize(
            object.chainObservation,
            specifiedType:
                const FullType.nullable(WalletActionChainObservation),
          );
    yield r'activity_id';
    yield object.activityId == null
        ? null
        : serializers.serialize(
            object.activityId,
            specifiedType: const FullType.nullable(String),
          );
    yield r'failure_reason';
    yield object.failureReason == null
        ? null
        : serializers.serialize(
            object.failureReason,
            specifiedType: const FullType.nullable(String),
          );
    yield r'manual_review_reason';
    yield object.manualReviewReason == null
        ? null
        : serializers.serialize(
            object.manualReviewReason,
            specifiedType: const FullType.nullable(String),
          );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WalletActionExecution object, {
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
    required WalletActionExecutionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'execution_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.executionId = valueDes;
          break;
        case r'resource_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionResourceType),
          ) as WalletActionResourceType;
          result.resourceType = valueDes;
          break;
        case r'resource_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceId = valueDes;
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'action_kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionKind),
          ) as WalletActionKind;
          result.actionKind = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionExecutionChainIdEnum),
          ) as WalletActionExecutionChainIdEnum;
          result.chainId = valueDes;
          break;
        case r'wallet_address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletAddress = valueDes;
          break;
        case r'payload_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.payloadHash = valueDes;
          break;
        case r'business_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.businessExpiresAt = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GasPaymentMode),
          ) as GasPaymentMode;
          result.mode = valueDes;
          break;
        case r'execution_provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionExecutionProvider),
          ) as WalletActionExecutionProvider;
          result.executionProvider = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionExecutionStatus),
          ) as WalletActionExecutionStatus;
          result.status = valueDes;
          break;
        case r'provider_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WalletActionProviderStatus),
          ) as WalletActionProviderStatus;
          result.providerStatus = valueDes;
          break;
        case r'gas_payment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GasPaymentQuote),
          ) as GasPaymentQuote;
          result.gasPayment.replace(valueDes);
          break;
        case r'frozen_transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FrozenEvmTransaction),
          ) as FrozenEvmTransaction;
          result.frozenTransaction.replace(valueDes);
          break;
        case r'fallback_from_execution_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fallbackFromExecutionId = valueDes;
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
        case r'privy_transaction_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privyTransactionId = valueDes;
          break;
        case r'user_operation_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userOperationHash = valueDes;
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
            specifiedType:
                const FullType.nullable(WalletActionChainObservation),
          ) as WalletActionChainObservation?;
          if (valueDes == null) continue;
          result.chainObservation.replace(valueDes);
          break;
        case r'activity_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.activityId = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        case r'manual_review_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.manualReviewReason = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WalletActionExecution deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WalletActionExecutionBuilder();
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

class WalletActionExecutionChainIdEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1)
  static const WalletActionExecutionChainIdEnum number1 =
      _$walletActionExecutionChainIdEnum_number1;
  @BuiltValueEnumConst(wireNumber: 56)
  static const WalletActionExecutionChainIdEnum number56 =
      _$walletActionExecutionChainIdEnum_number56;
  @BuiltValueEnumConst(wireNumber: 8453)
  static const WalletActionExecutionChainIdEnum number8453 =
      _$walletActionExecutionChainIdEnum_number8453;
  @BuiltValueEnumConst(wireNumber: 42161)
  static const WalletActionExecutionChainIdEnum number42161 =
      _$walletActionExecutionChainIdEnum_number42161;
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const WalletActionExecutionChainIdEnum unknownDefaultOpenApi =
      _$walletActionExecutionChainIdEnum_unknownDefaultOpenApi;

  static Serializer<WalletActionExecutionChainIdEnum> get serializer =>
      _$walletActionExecutionChainIdEnumSerializer;

  const WalletActionExecutionChainIdEnum._(String name) : super(name);

  static BuiltSet<WalletActionExecutionChainIdEnum> get values =>
      _$walletActionExecutionChainIdEnumValues;
  static WalletActionExecutionChainIdEnum valueOf(String name) =>
      _$walletActionExecutionChainIdEnumValueOf(name);
}
