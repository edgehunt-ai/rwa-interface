//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/wallet_action_kind.dart';
import 'package:rwa_api_client/src/model/native_delivery_state.dart';
import 'package:rwa_api_client/src/model/privy_authorization_payload.dart';
import 'package:rwa_api_client/src/model/wallet_action_chain_observation.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution_status.dart';
import 'package:rwa_api_client/src/model/frozen_evm_transaction.dart';
import 'package:rwa_api_client/src/model/wallet_action_provider_status.dart';
import 'package:rwa_api_client/src/model/gas_payment_quote.dart';
import 'package:rwa_api_client/src/model/native_cancellation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/wallet_action_execution_provider.dart';
import 'package:rwa_api_client/src/model/gas_payment_mode.dart';
import 'package:rwa_api_client/src/model/wallet_action_resource_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_execution.g.dart';

/// Server-authoritative execution of one exact frozen business action. Creation binds the resource, wallet, chain, payload hash and transaction permanently; clients supply only `mode`.  New bStocks approval, IOC market trade, GTC placement and cancellation executions choose `app_sponsored` / `privy` or `user_paid_native` / `privy_native` through the request `mode`. Sponsorship remains subject to existing eligibility, budget and circuit controls. Primary user-paid native BNB requires no prior sponsored execution or fallback gate. Creation retries may recover the same execution idempotently; pending or ambiguous existing executions fence a second delivery even if another payment mode is requested.  Both providers durably persist dispatch identity before synchronously relaying user authorization to Privy; signatures are never persisted. Native authorization uses sponsor=false with a frozen nonce; gas remains paid by the user and never consumes sponsorship quota. A timeout, 5xx or crash becomes ambiguous/manual_review, never permission for a direct or alternate publisher. Historical user_wallet executions accept tx_hash only as read-only evidence and never expose fresh authorization. Original transaction identity is preserved through cancellation and reorg.  After Privy acceptance or any ambiguous Provider result, mode switching, re-signing and automatic replay are forbidden. An existing sponsored execution must be proven rejected before broadcast before explicit native fallback. Admitted primary native executions do not require first attempting sponsorship. A definitely rejected sponsored execution may be linked by a user-paid execution. Activity may be created only after Privy or RPC observes an actual broadcast; authorization submission alone is not broadcast evidence. Mode- and status-specific cross-field invariants are enforced fail-closed by server/domain validation. 
///
/// Properties:
/// * [executionId] 
/// * [resourceType] 
/// * [resourceId] - Bound order_id, transfer_id or self-custodial withdrawal_id; it is never accepted from the client. 
/// * [actionId] - Bound independent transfer/order action_id, or the self-custodial withdrawal_id for `erc20_transfer` executions. For order executions this is distinct from the business resource_id and belongs to that order/account; never a duplicated order step identifier. 
/// * [actionKind] 
/// * [chainId] - 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
/// * [walletAddress] 
/// * [payloadHash] - Lowercase SHA-256 digest without `0x` over the versioned canonical chain/from/to/calldata/value tuple. It MUST equal the bound business action hash. 
/// * [businessExpiresAt] 
/// * [mode] 
/// * [executionProvider] 
/// * [nativeNonce] - Immutable decimal nonce for server-owned native delivery; unknown legacy nonce stays null.
/// * [nativeDeliveryState] 
/// * [nativeCancellation] 
/// * [status] 
/// * [providerStatus] 
/// * [gasPayment] 
/// * [frozenTransaction] 
/// * [fallbackFromExecutionId] - Null for app-sponsored and admitted primary user-paid native executions. When replacing an existing sponsored execution, contains the server-derived id of the matching execution that ended in user_gas_confirmation_required after definite pre-broadcast rejection. Unknown delivery never authorizes fallback. 
/// * [privyAuthorizationPayload] - Non-null only for a privy or privy_native execution awaiting_user_authorization and with current server delivery authority. Historical user_wallet never exposes authorization. Its expiry is at most 60 seconds and never exceeds the frozen business action expiry. 
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
abstract class WalletActionExecution implements Built<WalletActionExecution, WalletActionExecutionBuilder> {
  @BuiltValueField(wireName: r'execution_id')
  String get executionId;

  @BuiltValueField(wireName: r'resource_type')
  WalletActionResourceType get resourceType;
  // enum resourceTypeEnum {  transfer,  order,  self_custodial_withdrawal,  };

  /// Bound order_id, transfer_id or self-custodial withdrawal_id; it is never accepted from the client. 
  @BuiltValueField(wireName: r'resource_id')
  String get resourceId;

  /// Bound independent transfer/order action_id, or the self-custodial withdrawal_id for `erc20_transfer` executions. For order executions this is distinct from the business resource_id and belongs to that order/account; never a duplicated order step identifier. 
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'action_kind')
  WalletActionKind get actionKind;
  // enum actionKindEnum {  erc20_approval,  origin_transaction,  erc20_transfer,  spot_swap,  };

  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueField(wireName: r'chain_id')
  WalletActionExecutionChainIdEnum get chainId;
  // enum chainIdEnum {  1,  56,  97,  8453,  42161,  421614,  };

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
  // enum executionProviderEnum {  privy,  privy_native,  user_wallet,  };

  /// Immutable decimal nonce for server-owned native delivery; unknown legacy nonce stays null.
  @BuiltValueField(wireName: r'native_nonce')
  String? get nativeNonce;

  @BuiltValueField(wireName: r'native_delivery_state')
  NativeDeliveryState? get nativeDeliveryState;
  // enum nativeDeliveryStateEnum {  prepared,  dispatching,  rejected,  voided,  cancelled,  };

  @BuiltValueField(wireName: r'native_cancellation')
  NativeCancellation? get nativeCancellation;

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

  /// Null for app-sponsored and admitted primary user-paid native executions. When replacing an existing sponsored execution, contains the server-derived id of the matching execution that ended in user_gas_confirmation_required after definite pre-broadcast rejection. Unknown delivery never authorizes fallback. 
  @BuiltValueField(wireName: r'fallback_from_execution_id')
  String? get fallbackFromExecutionId;

  /// Non-null only for a privy or privy_native execution awaiting_user_authorization and with current server delivery authority. Historical user_wallet never exposes authorization. Its expiry is at most 60 seconds and never exceeds the frozen business action expiry. 
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

  factory WalletActionExecution([void updates(WalletActionExecutionBuilder b)]) = _$WalletActionExecution;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WalletActionExecutionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WalletActionExecution> get serializer => _$WalletActionExecutionSerializer();
}

class _$WalletActionExecutionSerializer implements PrimitiveSerializer<WalletActionExecution> {
  @override
  final Iterable<Type> types = const [WalletActionExecution, _$WalletActionExecution];

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
    if (object.nativeNonce != null) {
      yield r'native_nonce';
      yield serializers.serialize(
        object.nativeNonce,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nativeDeliveryState != null) {
      yield r'native_delivery_state';
      yield serializers.serialize(
        object.nativeDeliveryState,
        specifiedType: const FullType.nullable(NativeDeliveryState),
      );
    }
    if (object.nativeCancellation != null) {
      yield r'native_cancellation';
      yield serializers.serialize(
        object.nativeCancellation,
        specifiedType: const FullType.nullable(NativeCancellation),
      );
    }
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
    yield object.fallbackFromExecutionId == null ? null : serializers.serialize(
      object.fallbackFromExecutionId,
      specifiedType: const FullType.nullable(String),
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
    yield r'privy_transaction_id';
    yield object.privyTransactionId == null ? null : serializers.serialize(
      object.privyTransactionId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'user_operation_hash';
    yield object.userOperationHash == null ? null : serializers.serialize(
      object.userOperationHash,
      specifiedType: const FullType.nullable(String),
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
    yield r'activity_id';
    yield object.activityId == null ? null : serializers.serialize(
      object.activityId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'failure_reason';
    yield object.failureReason == null ? null : serializers.serialize(
      object.failureReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'manual_review_reason';
    yield object.manualReviewReason == null ? null : serializers.serialize(
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
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
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
        case r'native_nonce':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nativeNonce = valueDes;
          break;
        case r'native_delivery_state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(NativeDeliveryState),
          ) as NativeDeliveryState?;
          if (valueDes == null) continue;
          result.nativeDeliveryState = valueDes;
          break;
        case r'native_cancellation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(NativeCancellation),
          ) as NativeCancellation?;
          if (valueDes == null) continue;
          result.nativeCancellation.replace(valueDes);
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
            specifiedType: const FullType.nullable(WalletActionChainObservation),
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

  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 1)
  static const WalletActionExecutionChainIdEnum number1 = _$walletActionExecutionChainIdEnum_number1;
  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 56)
  static const WalletActionExecutionChainIdEnum number56 = _$walletActionExecutionChainIdEnum_number56;
  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 97)
  static const WalletActionExecutionChainIdEnum number97 = _$walletActionExecutionChainIdEnum_number97;
  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 8453)
  static const WalletActionExecutionChainIdEnum number8453 = _$walletActionExecutionChainIdEnum_number8453;
  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 42161)
  static const WalletActionExecutionChainIdEnum number42161 = _$walletActionExecutionChainIdEnum_number42161;
  /// 必须使用被冻结动作的精确环境；支持枚举不表示该环境已启用代付。
  @BuiltValueEnumConst(wireNumber: 421614)
  static const WalletActionExecutionChainIdEnum number421614 = _$walletActionExecutionChainIdEnum_number421614;

  static Serializer<WalletActionExecutionChainIdEnum> get serializer => _$walletActionExecutionChainIdEnumSerializer;

  const WalletActionExecutionChainIdEnum._(String name): super(name);

  static BuiltSet<WalletActionExecutionChainIdEnum> get values => _$walletActionExecutionChainIdEnumValues;
  static WalletActionExecutionChainIdEnum valueOf(String name) => _$walletActionExecutionChainIdEnumValueOf(name);
}

