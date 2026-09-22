//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_approval_mode.dart';
import 'package:rwa_api_client/src/model/bstocks_action_status.dart';
import 'package:rwa_api_client/src/model/order_evm_action.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_cancellation_policy.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_wallet_action_state.g.dart';

/// action_status 是钱包动作状态，不等于最终订单成交。审批确认仍是 status=open、 action_status=confirmed、next_action=null；必须新建预览和交易动作，不能当作已买入。 
///
/// Properties:
/// * [approvalRequired] - 创建该动作时的快照，approve确认后可仍为true，不代表当前链上allowance不足。
/// * [approvalMode] 
/// * [approvalAmountRaw] - approve动作冻结的授权额度，原始单位字符串；与required_funding_raw交易输入预算区分。
/// * [fundingMode] 
/// * [fundsReserved] 
/// * [cancellationPolicy] 
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] - Must be null when `next_action` is present; enforced by server validation.
/// * [actionStatus] 
/// * [submittedTransactionHash] 
/// * [confirmedTransactionHash] 
/// * [requiredFundingRaw] - Server-derived trade funding bound in input-token raw units; an approval may authorize a larger approval_amount_raw without increasing this trade budget.
@BuiltValue()
abstract class BstockOrderWalletActionState implements Built<BstockOrderWalletActionState, BstockOrderWalletActionStateBuilder> {
  /// 创建该动作时的快照，approve确认后可仍为true，不代表当前链上allowance不足。
  @BuiltValueField(wireName: r'approval_required')
  bool? get approvalRequired;

  @BuiltValueField(wireName: r'approval_mode')
  BstocksApprovalMode? get approvalMode;
  // enum approvalModeEnum {  unlimited,  slippage,  };

  /// approve动作冻结的授权额度，原始单位字符串；与required_funding_raw交易输入预算区分。
  @BuiltValueField(wireName: r'approval_amount_raw')
  String? get approvalAmountRaw;

  @BuiltValueField(wireName: r'funding_mode')
  BstockOrderWalletActionStateFundingModeEnum? get fundingMode;
  // enum fundingModeEnum {  unreserved_transfer_from,  };

  @BuiltValueField(wireName: r'funds_reserved')
  bool? get fundsReserved;

  @BuiltValueField(wireName: r'cancellation_policy')
  BstocksCancellationPolicy? get cancellationPolicy;

  @BuiltValueField(wireName: r'kind')
  BstockOrderWalletActionStateKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'next_action')
  OrderEvmAction? get nextAction;

  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueField(wireName: r'wallet_action_blocker')
  BstockOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker;
  // enum walletActionBlockerEnum {  provider_unavailable,  action_not_ready,  capability_disabled,  };

  @BuiltValueField(wireName: r'action_status')
  BstocksActionStatus? get actionStatus;
  // enum actionStatusEnum {  awaiting_signature,  submitted,  confirmed,  failed,  manual_review,  };

  @BuiltValueField(wireName: r'submitted_transaction_hash')
  String? get submittedTransactionHash;

  @BuiltValueField(wireName: r'confirmed_transaction_hash')
  String? get confirmedTransactionHash;

  /// Server-derived trade funding bound in input-token raw units; an approval may authorize a larger approval_amount_raw without increasing this trade budget.
  @BuiltValueField(wireName: r'required_funding_raw')
  String? get requiredFundingRaw;

  BstockOrderWalletActionState._();

  factory BstockOrderWalletActionState([void updates(BstockOrderWalletActionStateBuilder b)]) = _$BstockOrderWalletActionState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderWalletActionStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderWalletActionState> get serializer => _$BstockOrderWalletActionStateSerializer();
}

class _$BstockOrderWalletActionStateSerializer implements PrimitiveSerializer<BstockOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [BstockOrderWalletActionState, _$BstockOrderWalletActionState];

  @override
  final String wireName = r'BstockOrderWalletActionState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.approvalRequired != null) {
      yield r'approval_required';
      yield serializers.serialize(
        object.approvalRequired,
        specifiedType: const FullType(bool),
      );
    }
    if (object.approvalMode != null) {
      yield r'approval_mode';
      yield serializers.serialize(
        object.approvalMode,
        specifiedType: const FullType(BstocksApprovalMode),
      );
    }
    if (object.approvalAmountRaw != null) {
      yield r'approval_amount_raw';
      yield serializers.serialize(
        object.approvalAmountRaw,
        specifiedType: const FullType(String),
      );
    }
    if (object.fundingMode != null) {
      yield r'funding_mode';
      yield serializers.serialize(
        object.fundingMode,
        specifiedType: const FullType(BstockOrderWalletActionStateFundingModeEnum),
      );
    }
    if (object.fundsReserved != null) {
      yield r'funds_reserved';
      yield serializers.serialize(
        object.fundsReserved,
        specifiedType: const FullType(bool),
      );
    }
    if (object.cancellationPolicy != null) {
      yield r'cancellation_policy';
      yield serializers.serialize(
        object.cancellationPolicy,
        specifiedType: const FullType(BstocksCancellationPolicy),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(OrderEvmAction),
    );
    yield r'wallet_action_blocker';
    yield object.walletActionBlocker == null ? null : serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
    );
    if (object.actionStatus != null) {
      yield r'action_status';
      yield serializers.serialize(
        object.actionStatus,
        specifiedType: const FullType(BstocksActionStatus),
      );
    }
    if (object.submittedTransactionHash != null) {
      yield r'submitted_transaction_hash';
      yield serializers.serialize(
        object.submittedTransactionHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.confirmedTransactionHash != null) {
      yield r'confirmed_transaction_hash';
      yield serializers.serialize(
        object.confirmedTransactionHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.requiredFundingRaw != null) {
      yield r'required_funding_raw';
      yield serializers.serialize(
        object.requiredFundingRaw,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderWalletActionStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'approval_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.approvalRequired = valueDes;
          break;
        case r'approval_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksApprovalMode),
          ) as BstocksApprovalMode?;
          if (valueDes == null) continue;
          result.approvalMode = valueDes;
          break;
        case r'approval_amount_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.approvalAmountRaw = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateFundingModeEnum),
          ) as BstockOrderWalletActionStateFundingModeEnum?;
          if (valueDes == null) continue;
          result.fundingMode = valueDes;
          break;
        case r'funds_reserved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.fundsReserved = valueDes;
          break;
        case r'cancellation_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksCancellationPolicy),
          ) as BstocksCancellationPolicy?;
          if (valueDes == null) continue;
          result.cancellationPolicy.replace(valueDes);
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
          ) as BstockOrderWalletActionStateKindEnum;
          result.kind = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderEvmAction),
          ) as OrderEvmAction?;
          if (valueDes == null) continue;
          result.nextAction.replace(valueDes);
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
          ) as BstockOrderWalletActionStateWalletActionBlockerEnum?;
          if (valueDes == null) continue;
          result.walletActionBlocker = valueDes;
          break;
        case r'action_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstocksActionStatus),
          ) as BstocksActionStatus?;
          if (valueDes == null) continue;
          result.actionStatus = valueDes;
          break;
        case r'submitted_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.submittedTransactionHash = valueDes;
          break;
        case r'confirmed_transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.confirmedTransactionHash = valueDes;
          break;
        case r'required_funding_raw':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requiredFundingRaw = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstockOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderWalletActionStateBuilder();
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

class BstockOrderWalletActionStateFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unreserved_transfer_from')
  static const BstockOrderWalletActionStateFundingModeEnum unreservedTransferFrom = _$bstockOrderWalletActionStateFundingModeEnum_unreservedTransferFrom;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderWalletActionStateFundingModeEnum unknownDefaultOpenApi = _$bstockOrderWalletActionStateFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderWalletActionStateFundingModeEnum> get serializer => _$bstockOrderWalletActionStateFundingModeEnumSerializer;

  const BstockOrderWalletActionStateFundingModeEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateFundingModeEnum> get values => _$bstockOrderWalletActionStateFundingModeEnumValues;
  static BstockOrderWalletActionStateFundingModeEnum valueOf(String name) => _$bstockOrderWalletActionStateFundingModeEnumValueOf(name);
}

class BstockOrderWalletActionStateKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderWalletActionStateKindEnum bstock = _$bstockOrderWalletActionStateKindEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderWalletActionStateKindEnum unknownDefaultOpenApi = _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderWalletActionStateKindEnum> get serializer => _$bstockOrderWalletActionStateKindEnumSerializer;

  const BstockOrderWalletActionStateKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateKindEnum> get values => _$bstockOrderWalletActionStateKindEnumValues;
  static BstockOrderWalletActionStateKindEnum valueOf(String name) => _$bstockOrderWalletActionStateKindEnumValueOf(name);
}

class BstockOrderWalletActionStateWalletActionBlockerEnum extends EnumClass {

  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum providerUnavailable = _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'action_not_ready')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum actionNotReady = _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum capabilityDisabled = _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderWalletActionStateWalletActionBlockerEnum unknownDefaultOpenApi = _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderWalletActionStateWalletActionBlockerEnum> get serializer => _$bstockOrderWalletActionStateWalletActionBlockerEnumSerializer;

  const BstockOrderWalletActionStateWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateWalletActionBlockerEnum> get values => _$bstockOrderWalletActionStateWalletActionBlockerEnumValues;
  static BstockOrderWalletActionStateWalletActionBlockerEnum valueOf(String name) => _$bstockOrderWalletActionStateWalletActionBlockerEnumValueOf(name);
}

