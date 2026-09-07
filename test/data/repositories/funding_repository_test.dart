import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/services/funding_service.dart';

void main() {
  test('requires transfer is represented as non-retryable capability', () async {
    final result = await FundingRepositoryImpl(_Funding()).getDeposit('deposit-1');
    expect(result.resource.amount?.value, '0.000000000000000001');
    expect(result.capability?.code, 'funding_transfer_not_supported');
    expect(result.capability?.userAction, 'wait_for_feature');
    expect(result.capability?.retryable, isFalse);
  });
}

final class _Funding implements FundingService {
  @override
  Future<api.Deposit> getDeposit(String id) async => api.Deposit(
    (deposit) => deposit
      ..depositId = id
      ..chain = api.Chain.BSC
      ..token = api.DepositTokenEnum.USDC
      ..amount = '0.000000000000000001'
      ..status = api.DepositStatus.credited
      ..requiresTransfer = true
      ..instructions.update((instructions) => instructions
        ..chain = api.Chain.BSC
        ..token = api.DepositAddressTokenEnum.USDC
        ..address = '0x123'),
  );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
