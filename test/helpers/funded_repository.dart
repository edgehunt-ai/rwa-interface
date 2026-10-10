import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/models/funding_session.dart';
import 'package:nobell/domain/models/order_intent.dart';

class FundedRepository implements FundingRepository {
  final previewIds = <String>[];

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async => FundingSessionSummary(
    sessionId: 'session-${intent.fingerprint}',
    status: 'funded',
    version: 1,
    canConfirmTransfer: true,
    expiresAt: DateTime.now().toUtc().add(const Duration(hours: 24)),
  );

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
    previewIds.add(fundingSessionId);
    return FundingPlan(
      planId: 'funded-$fundingSessionId',
      tradePreviewId: fundingSessionId,
      shortfall: DecimalValue('0'),
      status: FundingPlanState.alreadyFunded,
    );
  }

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    previewIds.add(tradePreviewId);
    return FundingPlan(
      planId: 'funded-$tradePreviewId',
      tradePreviewId: tradePreviewId,
      shortfall: DecimalValue('0'),
      status: FundingPlanState.alreadyFunded,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
