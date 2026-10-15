import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/hip3_action_summary.dart';
import '../../domain/models/hip3_protection.dart';

String hip3OperationWire(api.Hip3Operation operation) =>
    api.standardSerializers.serializeWith(
      api.Hip3Operation.serializer,
      operation,
    ) as String;

String hip3OperationName(String operation) => switch (operation) {
  'manage_tpsl' => 'manageTpsl',
  'set_leverage' => 'setLeverage',
  'close_position' => 'closePosition',
  'place_order' => 'placeOrder',
  'cancel_order' => 'cancelOrder',
  _ => operation,
};

api.Hip3ActionCreateRequest hip3CurrentIntent(api.Hip3Action action) =>
    api.standardSerializers.deserializeWith(
      api.Hip3ActionCreateRequest.serializer,
      action.intent.map((key, value) => MapEntry(key, value?.value)).toMap(),
    )!;

Hip3ProtectionParameters mapHip3Protection(
  api.Hip3SingleProtectionSpec protection,
) {
  final take = protection.takeProfit;
  final stop = protection.stopLoss;
  if ((take == null) == (stop == null)) {
    throw const FormatException('Protection must have exactly one role');
  }
  final trigger = (take ?? stop)!;
  return Hip3ProtectionParameters(
    role: take != null ? 'takeProfit' : 'stopLoss',
    triggerPrice: DecimalValue(trigger.triggerPrice!),
    triggerReference: trigger.triggerReference.name,
    quantity: protection.sizeMode.name == 'quantity'
        ? DecimalValue(protection.quantity!)
        : null,
    percent: protection.sizeMode.name == 'percent'
        ? DecimalValue(protection.percent!)
        : null,
    limitPrice: trigger.limitPrice == null
        ? null
        : DecimalValue(trigger.limitPrice!),
  );
}

bool hip3ProtectionStepMatches(api.Hip3Action action, api.Hip3ActionStep step) {
  final request = hip3CurrentIntent(action).oneOf.value;
  if (request is! api.Hip3ManageTpSlActionRequest) return false;
  final orders = step.protectionOrders;
  if (orders == null || orders.isEmpty) return false;
  final indices = <int>{};
  for (final order in orders) {
    final index = order.changeIndex;
    final actual = order.protection;
    if (index < 0 ||
        index >= request.changes.length ||
        !indices.add(index) ||
        actual == null ||
        order.orderId.isEmpty ||
        (actual.takeProfit == null) == (actual.stopLoss == null) ||
        (actual.takeProfit != null ? 'takeProfit' : 'stopLoss') !=
            order.role.name) {
      return false;
    }
    final change = request.changes[index].oneOf.value;
    final (target, parameters) = switch (change) {
      api.Hip3ProtectionModifyChange value => (value.orderId, value.protection),
      api.Hip3ProtectionCancelChange value => (value.orderId, null),
      api.Hip3ProtectionCreateChange value => (null, value.protection),
      _ => (null, null),
    };
    if (step.kind == api.Hip3ActionStepKindEnum.cancelProtection) {
      if (target == null || order.orderId != target) return false;
    } else if (step.kind == api.Hip3ActionStepKindEnum.placeProtection) {
      if (parameters == null ||
          order.replacedOrderId != target ||
          (parameters.takeProfit != null) != (actual.takeProfit != null)) {
        return false;
      }
      if (parameters.sizeMode.name == 'entirePosition'
          ? actual.sizeMode.name != 'entirePosition'
          : actual.sizeMode.name != 'quantity') {
        return false;
      }
      if (parameters.quantity != null &&
          (actual.quantity == null ||
              DecimalValue(actual.quantity!)
                      .compareTo(DecimalValue(parameters.quantity!)) >
                  0)) {
        return false;
      }
      final trigger = (actual.takeProfit ?? actual.stopLoss)!;
      final requested = (parameters.takeProfit ?? parameters.stopLoss)!;
      if (trigger.executionType != requested.executionType ||
          trigger.triggerReference != requested.triggerReference) {
        return false;
      }
    } else {
      return false;
    }
  }
  return true;
}

bool hip3ProtectionResultsConfirmed(api.Hip3Action action) {
  if (action.operation != 'manage_tpsl') return true;
  final request = hip3CurrentIntent(action).oneOf.value;
  if (request is! api.Hip3ManageTpSlActionRequest) return false;
  final placed = <int>{};
  final cancelled = <int>{};
  for (final step in action.steps) {
    if (step.protectionOrders == null) continue;
    if (!hip3ProtectionStepMatches(action, step)) return false;
    for (final order in step.protectionOrders!) {
      if (order.status != api.Hip3ProtectionStepOrderStatusEnum.confirmed) {
        return false;
      }
      (step.kind == api.Hip3ActionStepKindEnum.cancelProtection
              ? cancelled
              : placed)
          .add(order.changeIndex);
    }
  }
  for (var i = 0; i < request.changes.length; i++) {
    final change = request.changes[i].oneOf.value;
    if (change is! api.Hip3ProtectionCancelChange && !placed.contains(i)) {
      return false;
    }
    if (change is! api.Hip3ProtectionCreateChange && !cancelled.contains(i)) {
      return false;
    }
  }
  return true;
}

List<Hip3ProtectionOrderResult> mapHip3ProtectionResults(
  api.Hip3Action action,
) => List.unmodifiable([
  for (final step in action.steps)
    for (final order
        in step.protectionOrders ?? <api.Hip3ProtectionStepOrder>[])
      Hip3ProtectionOrderResult(
        stepId: step.stepId,
        changeIndex: order.changeIndex,
        orderId: order.orderId,
        replacedOrderId: order.replacedOrderId,
        protection: mapHip3Protection(order.protection!),
        status: order.status.name,
        failureReason: order.failureReason,
        isCancellation: step.kind.name == 'cancelProtection',
      ),
]);

Hip3ActionSummary mapHip3ActionSummary(api.Hip3Action action) =>
    Hip3ActionSummary(
      actionId: action.actionId,
      productId: action.productId,
      operation: hip3OperationName(action.operation),
      status: action.status.name,
      positionId: action.positionId,
      orderId: action.orderId,
      failureCode: action.failureCode,
      failureReason: action.failureReason,
      userAction: action.userAction,
      effectsApplied: action.effectsApplied,
      protectionOrders: mapHip3ProtectionResults(action),
      protectionResultsComplete: hip3ProtectionResultsConfirmed(action),
      canResumePositionAction:
          const {
            'manage_tpsl',
            'set_leverage',
            'close_position',
          }.contains(action.operation) &&
          const {
            'awaitingSignature',
            'submitting',
            'reconciling',
            'ambiguous',
          }.contains(action.status.name),
    );
