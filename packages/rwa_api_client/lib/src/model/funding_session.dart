//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_session_source_allocation.dart';
import 'package:rwa_api_client/src/model/funding_session_continuation.dart';
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_fee_breakdown.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/funding_target_balance_snapshot.dart';
import 'package:rwa_api_client/src/model/funding_session_status.dart';
import 'package:rwa_api_client/src/model/unified_funding_position.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session.g.dart';

/// A 24-hour recoverable, non-executable funding draft. `recommended_top_up` is advisory only: it may initialize a client form but must never be used as a minimum, maximum or rejection rule. Balances and route estimates are refreshed independently and never inherit the session lifetime. 
///
/// Properties:
/// * [fundingSessionId] 
/// * [status] 
/// * [version] 
/// * [trade] 
/// * [continuation] 
/// * [rail] 
/// * [targetSnapshot] 
/// * [requiredTargetBalance] - 十进制字符串，避免浮点误差
/// * [minimumTopUp] - 十进制字符串，避免浮点误差
/// * [recommendedTopUp] - Advisory amount derived from the current requirement and safety buffer, rounded half-up to at most one decimal place; if that would fall below minimum_top_up it is raised to the next tenth. Users may choose any otherwise valid amount.
/// * [safetyBufferBps] - Advisory recommendation input only; the server must not reject a selection merely because it differs from this buffer.
/// * [selectedTargetAmount] - 十进制字符串，避免浮点误差
/// * [minimumReceived] - 十进制字符串，避免浮点误差
/// * [maximumSelectableTargetAmount] - Current server-valued upper bound across eligible selected sources and Provider limits.
/// * [totalSourceValueUsd] - 十进制字符串，避免浮点误差
/// * [estimatedFees] 
/// * [etaSeconds] 
/// * [positions] 
/// * [allocations] 
/// * [canConfirmTransfer] 
/// * [remainingMinimumTopUp] - 十进制字符串，避免浮点误差
/// * [estimateObservedAt] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [expiresAt] - Exactly 24 hours after session creation; it does not extend balance or Provider quote validity.
@BuiltValue()
abstract class FundingSession implements Built<FundingSession, FundingSessionBuilder> {
  @BuiltValueField(wireName: r'funding_session_id')
  String get fundingSessionId;

  @BuiltValueField(wireName: r'status')
  FundingSessionStatus get status;
  // enum statusEnum {  editing,  ready_to_confirm,  transferring,  funded,  expired,  cancelled,  manual_review,  };

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'trade')
  OrderPreviewRequest get trade;

  @BuiltValueField(wireName: r'continuation')
  FundingSessionContinuation get continuation;

  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'target_snapshot')
  FundingTargetBalanceSnapshot get targetSnapshot;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'required_target_balance')
  String get requiredTargetBalance;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_top_up')
  String get minimumTopUp;

  /// Advisory amount derived from the current requirement and safety buffer, rounded half-up to at most one decimal place; if that would fall below minimum_top_up it is raised to the next tenth. Users may choose any otherwise valid amount.
  @BuiltValueField(wireName: r'recommended_top_up')
  String get recommendedTopUp;

  /// Advisory recommendation input only; the server must not reject a selection merely because it differs from this buffer.
  @BuiltValueField(wireName: r'safety_buffer_bps')
  int get safetyBufferBps;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'selected_target_amount')
  String get selectedTargetAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  /// Current server-valued upper bound across eligible selected sources and Provider limits.
  @BuiltValueField(wireName: r'maximum_selectable_target_amount')
  String get maximumSelectableTargetAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_source_value_usd')
  String get totalSourceValueUsd;

  @BuiltValueField(wireName: r'estimated_fees')
  FundingFeeBreakdown get estimatedFees;

  @BuiltValueField(wireName: r'eta_seconds')
  int get etaSeconds;

  @BuiltValueField(wireName: r'positions')
  BuiltList<UnifiedFundingPosition> get positions;

  @BuiltValueField(wireName: r'allocations')
  BuiltList<FundingSessionSourceAllocation> get allocations;

  @BuiltValueField(wireName: r'can_confirm_transfer')
  bool get canConfirmTransfer;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'remaining_minimum_top_up')
  String get remainingMinimumTopUp;

  @BuiltValueField(wireName: r'estimate_observed_at')
  DateTime get estimateObservedAt;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  /// Exactly 24 hours after session creation; it does not extend balance or Provider quote validity.
  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  FundingSession._();

  factory FundingSession([void updates(FundingSessionBuilder b)]) = _$FundingSession;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSessionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSession> get serializer => _$FundingSessionSerializer();
}

class _$FundingSessionSerializer implements PrimitiveSerializer<FundingSession> {
  @override
  final Iterable<Type> types = const [FundingSession, _$FundingSession];

  @override
  final String wireName = r'FundingSession';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSession object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'funding_session_id';
    yield serializers.serialize(
      object.fundingSessionId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FundingSessionStatus),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'trade';
    yield serializers.serialize(
      object.trade,
      specifiedType: const FullType(OrderPreviewRequest),
    );
    yield r'continuation';
    yield serializers.serialize(
      object.continuation,
      specifiedType: const FullType(FundingSessionContinuation),
    );
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(ProductKind),
    );
    yield r'target_snapshot';
    yield serializers.serialize(
      object.targetSnapshot,
      specifiedType: const FullType(FundingTargetBalanceSnapshot),
    );
    yield r'required_target_balance';
    yield serializers.serialize(
      object.requiredTargetBalance,
      specifiedType: const FullType(String),
    );
    yield r'minimum_top_up';
    yield serializers.serialize(
      object.minimumTopUp,
      specifiedType: const FullType(String),
    );
    yield r'recommended_top_up';
    yield serializers.serialize(
      object.recommendedTopUp,
      specifiedType: const FullType(String),
    );
    yield r'safety_buffer_bps';
    yield serializers.serialize(
      object.safetyBufferBps,
      specifiedType: const FullType(int),
    );
    yield r'selected_target_amount';
    yield serializers.serialize(
      object.selectedTargetAmount,
      specifiedType: const FullType(String),
    );
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    yield r'maximum_selectable_target_amount';
    yield serializers.serialize(
      object.maximumSelectableTargetAmount,
      specifiedType: const FullType(String),
    );
    yield r'total_source_value_usd';
    yield serializers.serialize(
      object.totalSourceValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'estimated_fees';
    yield serializers.serialize(
      object.estimatedFees,
      specifiedType: const FullType(FundingFeeBreakdown),
    );
    yield r'eta_seconds';
    yield serializers.serialize(
      object.etaSeconds,
      specifiedType: const FullType(int),
    );
    yield r'positions';
    yield serializers.serialize(
      object.positions,
      specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingPosition)]),
    );
    yield r'allocations';
    yield serializers.serialize(
      object.allocations,
      specifiedType: const FullType(BuiltList, [FullType(FundingSessionSourceAllocation)]),
    );
    yield r'can_confirm_transfer';
    yield serializers.serialize(
      object.canConfirmTransfer,
      specifiedType: const FullType(bool),
    );
    yield r'remaining_minimum_top_up';
    yield serializers.serialize(
      object.remainingMinimumTopUp,
      specifiedType: const FullType(String),
    );
    yield r'estimate_observed_at';
    yield serializers.serialize(
      object.estimateObservedAt,
      specifiedType: const FullType(DateTime),
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
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingSession object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingSessionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'funding_session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fundingSessionId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionStatus),
          ) as FundingSessionStatus;
          result.status = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'trade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderPreviewRequest),
          ) as OrderPreviewRequest;
          result.trade.replace(valueDes);
          break;
        case r'continuation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingSessionContinuation),
          ) as FundingSessionContinuation;
          result.continuation.replace(valueDes);
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.rail = valueDes;
          break;
        case r'target_snapshot':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingTargetBalanceSnapshot),
          ) as FundingTargetBalanceSnapshot;
          result.targetSnapshot.replace(valueDes);
          break;
        case r'required_target_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requiredTargetBalance = valueDes;
          break;
        case r'minimum_top_up':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumTopUp = valueDes;
          break;
        case r'recommended_top_up':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recommendedTopUp = valueDes;
          break;
        case r'safety_buffer_bps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.safetyBufferBps = valueDes;
          break;
        case r'selected_target_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.selectedTargetAmount = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'maximum_selectable_target_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maximumSelectableTargetAmount = valueDes;
          break;
        case r'total_source_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalSourceValueUsd = valueDes;
          break;
        case r'estimated_fees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingFeeBreakdown),
          ) as FundingFeeBreakdown;
          result.estimatedFees.replace(valueDes);
          break;
        case r'eta_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.etaSeconds = valueDes;
          break;
        case r'positions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(UnifiedFundingPosition)]),
          ) as BuiltList<UnifiedFundingPosition>;
          result.positions.replace(valueDes);
          break;
        case r'allocations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingSessionSourceAllocation)]),
          ) as BuiltList<FundingSessionSourceAllocation>;
          result.allocations.replace(valueDes);
          break;
        case r'can_confirm_transfer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canConfirmTransfer = valueDes;
          break;
        case r'remaining_minimum_top_up':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.remainingMinimumTopUp = valueDes;
          break;
        case r'estimate_observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.estimateObservedAt = valueDes;
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
  FundingSession deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSessionBuilder();
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

