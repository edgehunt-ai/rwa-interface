import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';

class FundedRepository implements FundingRepository {
  final previewIds = <String>[];

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
