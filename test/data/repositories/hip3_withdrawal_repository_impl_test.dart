import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/hip3_withdrawal_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_withdrawal_service.dart';
import 'package:rwa_interface/domain/models/hip3_withdrawal.dart' as domain;
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test('creates only native Arbitrum USDC float withdrawals', () async {
    final service = _Service();
    final prepared = await Hip3WithdrawalRepositoryImpl(
      service,
      _Signer(),
    ).create(amount: '51.4', idempotencyKey: 'create-key');
    expect(service.request!.amount, '51.4');
    expect(
      service.request!.rail,
      api.Hip3WithdrawalCreateRequestRailEnum.float,
    );
    expect(service.createKey, 'create-key');
    expect(prepared.status, 'awaiting_signature');
  });

  test(
    'signs the frozen server payload and submits the matching hash',
    () async {
      final service = _Service();
      final signer = _Signer();
      final repo = Hip3WithdrawalRepositoryImpl(service, signer);
      final prepared = await repo.create(
        amount: '51.4',
        idempotencyKey: 'create-key',
      );
      final submitted = await repo.signAndSubmit(
        prepared,
        idempotencyKey: 'submit-key',
      );
      expect(signer.address, service.address);
      expect(signer.typedData, {
        'domain': {'name': 'Hyperliquid'},
        'message': {'amount': '51.4'},
      });
      expect(service.signature!.signature, '0xsigned');
      expect(service.signature!.payloadHash, '0xfrozen');
      expect(service.submissionKey, 'submit-key');
      expect(submitted.status, 'submitted');
    },
  );

  test(
    'rejects foreign destination and expired intent before signing',
    () async {
      final service = _Service();
      final signer = _Signer();
      final repo = Hip3WithdrawalRepositoryImpl(service, signer);
      final base = await repo.create(amount: '51.4', idempotencyKey: 'key');
      Future<void> rejects(domain.Hip3Withdrawal intent) async {
        await expectLater(
          repo.signAndSubmit(intent, idempotencyKey: 'key'),
          throwsA(isA<Hip3SigningFailure>()),
        );
        expect(signer.typedData, isNull);
        expect(service.signature, isNull);
      }

      await rejects(
        _copy(base, destination: '0x2222222222222222222222222222222222222222'),
      );
      await rejects(_copy(base, expiresAt: DateTime.utc(2020)));
      await rejects(_copy(base, typedData: 'not json'));
    },
  );

  test(
    'does not submit a signature after the account session changes',
    () async {
      final service = _Service();
      var active = true;
      final signer = _Signer()..onSigned = () => active = false;
      final repo = Hip3WithdrawalRepositoryImpl(
        service,
        signer,
        isActive: () => active,
      );
      final prepared = await repo.create(amount: '51.4', idempotencyKey: 'key');
      await expectLater(
        repo.signAndSubmit(prepared, idempotencyKey: 'key'),
        throwsA(isA<Hip3SigningFailure>()),
      );
      expect(service.signature, isNull);
    },
  );
}

domain.Hip3Withdrawal _copy(
  domain.Hip3Withdrawal value, {
  String? destination,
  DateTime? expiresAt,
  String? typedData,
}) => domain.Hip3Withdrawal(
  id: value.id,
  ownerAddress: value.ownerAddress,
  destinationAddress: destination ?? value.destinationAddress,
  amount: value.amount,
  fee: value.fee,
  minimumReceived: value.minimumReceived,
  status: value.status,
  rail: value.rail,
  expiresAt: expiresAt ?? value.expiresAt,
  typedDataJson: typedData ?? value.typedDataJson,
  payloadHash: value.payloadHash,
);

class _Signer implements Hip3TypedDataSigner {
  String? address;
  Map<String, Object?>? typedData;
  void Function()? onSigned;

  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    address = expectedSigner;
    this.typedData = typedData;
    onSigned?.call();
    return '0xsigned';
  }
}

class _Service implements Hip3WithdrawalService {
  final address = '0x1111111111111111111111111111111111111111';
  api.Hip3WithdrawalCreateRequest? request;
  api.Hip3WithdrawalSubmissionRequest? signature;
  String? createKey;
  String? submissionKey;

  api.Hip3Withdrawal _resource(api.Hip3WithdrawalStatus status) =>
      api.Hip3Withdrawal(
        (b) => b
          ..withdrawalId = 'id'
          ..ownerAddress = address
          ..destinationAddress = address
          ..amount = '51.4'
          ..fee = '1.18'
          ..minimumReceived = '50.22'
          ..status = status
          ..rail = api.Hip3WithdrawalRail.float
          ..nonce = 1
          ..typedDataJson =
              '{"domain":{"name":"Hyperliquid"},"message":{"amount":"51.4"}}'
          ..payloadHash = '0xfrozen'
          ..expiresAt = DateTime.now().add(const Duration(minutes: 5))
          ..createdAt = DateTime.now()
          ..updatedAt = DateTime.now(),
      );

  @override
  Future<api.Hip3Withdrawal> create(
    api.Hip3WithdrawalCreateRequest request, {
    required String idempotencyKey,
  }) async {
    this.request = request;
    createKey = idempotencyKey;
    return _resource(api.Hip3WithdrawalStatus.awaitingSignature);
  }

  @override
  Future<api.Hip3Withdrawal> get(String id) async =>
      _resource(api.Hip3WithdrawalStatus.awaitingSignature);

  @override
  Future<api.Hip3Withdrawal> submit(
    String id,
    api.Hip3WithdrawalSubmissionRequest request, {
    required String idempotencyKey,
  }) async {
    signature = request;
    submissionKey = idempotencyKey;
    return _resource(api.Hip3WithdrawalStatus.submitted);
  }
}
