import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/hip3_withdrawal.dart';
import 'package:rwa_interface/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/hip3_withdrawal_providers.dart';

void main() {
  test('preparation reuses the frozen intent and submits it once', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [hip3WithdrawalRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);

    final first = await commands.prepare('51.4');
    final repeated = await commands.prepare('51.4');
    expect(identical(first, repeated), isTrue);
    expect(repo.creationKeys, hasLength(1));
    await commands.submit(first);
    expect(repo.submitted, 1);
    expect(repo.submittedIntent, same(first));
    expect(repo.submissionKeys, hasLength(1));
    final afterSubmission = await commands.submit(first);
    expect(afterSubmission.status, 'submitted');
    expect(repo.submitted, 1);
  });

  test(
    'lost submit response uses the same intent and idempotency key',
    () async {
      final repo = _Repository()..failSubmissionOnce = true;
      final container = ProviderContainer(
        overrides: [hip3WithdrawalRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      final commands = container.read(hip3WithdrawalCommandsProvider);
      final intent = await commands.prepare('51.4');
      await expectLater(commands.submit(intent), throwsStateError);
      expect(await commands.prepare('51.4'), same(intent));
      await commands.submit(intent);
      expect(repo.creationKeys, hasLength(1));
      expect(repo.submissionKeys.toSet(), hasLength(1));
    },
  );

  test('a terminal intent gets a new creation key', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [hip3WithdrawalRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    await commands.prepare('51.4');
    repo.status = 'failed';
    await commands.prepare('51.4');
    expect(repo.creationKeys, hasLength(2));
    expect(repo.creationKeys.toSet(), hasLength(2));
  });

  test('an old account session cannot submit its frozen intent', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [hip3WithdrawalRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    final commands = container.read(hip3WithdrawalCommandsProvider);
    final intent = await commands.prepare('51.4');
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await expectLater(commands.submit(intent), throwsStateError);
    expect(repo.submitted, 0);
  });
}

class _Repository implements Hip3WithdrawalRepository {
  final creationKeys = <String>[];
  final submissionKeys = <String>[];
  int submitted = 0;
  bool failSubmissionOnce = false;
  String status = 'awaiting_signature';
  Hip3Withdrawal? submittedIntent;

  Hip3Withdrawal _intent(String status) => Hip3Withdrawal(
    id: 'id',
    ownerAddress: '0x1111111111111111111111111111111111111111',
    destinationAddress: '0x1111111111111111111111111111111111111111',
    amount: '51.4',
    fee: '1.18',
    minimumReceived: '50.22',
    status: status,
    rail: 'float',
    expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    typedDataJson: '{}',
    payloadHash: 'hash',
  );

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String idempotencyKey,
  }) async {
    creationKeys.add(idempotencyKey);
    return _intent('awaiting_signature');
  }

  @override
  Future<Hip3Withdrawal> get(String id) async =>
      _intent(submitted > 0 ? 'submitted' : status);

  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    submissionKeys.add(idempotencyKey);
    submittedIntent = prepared;
    if (failSubmissionOnce) {
      failSubmissionOnce = false;
      throw StateError('response lost');
    }
    submitted++;
    return _intent('submitted');
  }
}
