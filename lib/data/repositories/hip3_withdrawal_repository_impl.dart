import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/hip3_withdrawal.dart' as domain;
import '../../domain/models/hip3_withdrawal_preview.dart' as domain_preview;
import '../../domain/models/order_intent.dart';
import '../../domain/models/order_preview.dart';
import '../../domain/repositories/hip3_withdrawal_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_withdrawal_service.dart';

final class Hip3WithdrawalRepositoryImpl implements Hip3WithdrawalRepository {
  Hip3WithdrawalRepositoryImpl(
    this._service,
    this._signer, {
    bool Function()? isActive,
  }) : _isActive = isActive ?? (() => true);

  final Hip3WithdrawalService _service;
  final Hip3TypedDataSigner _signer;
  final bool Function() _isActive;

  @override
  Future<domain_preview.Hip3WithdrawalPreview> preview({
    required String amount,
  }) async => _mapPreview(
    await _service.preview(
      api.Hip3WithdrawalCreateRequest(
        (b) => b
          ..amount = amount
          ..rail = api.Hip3WithdrawalCreateRequestRailEnum.auto,
      ),
    ),
  );

  @override
  Future<domain.Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required String idempotencyKey,
  }) async => _map(
    await _service.create(
      api.Hip3WithdrawalCreateRequest(
        (b) => b
          ..amount = amount
          ..rail = _rail(rail),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<domain.Hip3Withdrawal> signAndSubmit(
    domain.Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    if (prepared.status != 'awaiting_signature' ||
        !prepared.expiresAt.isAfter(DateTime.now())) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
    }
    if (prepared.ownerAddress.toLowerCase() !=
        prepared.destinationAddress.toLowerCase()) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final raw = prepared.typedDataJson;
    final hash = prepared.payloadHash;
    if (raw == null || hash == null || hash.isEmpty) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final signature = await _signer.signTypedDataV4(
      expectedSigner: prepared.ownerAddress,
      typedData: decoded.cast<String, Object?>(),
    );
    if (!_isActive()) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected);
    }
    return _map(
      await _service.submit(
        prepared.id,
        api.Hip3WithdrawalSubmissionRequest(
          (b) => b
            ..signature = signature
            ..payloadHash = hash,
        ),
        idempotencyKey: idempotencyKey,
      ),
    );
  }

  @override
  Future<domain.Hip3Withdrawal> get(String id) async =>
      _map(await _service.get(id));

  api.Hip3WithdrawalCreateRequestRailEnum _rail(String value) =>
      switch (value) {
        'auto' => api.Hip3WithdrawalCreateRequestRailEnum.auto,
        'bridge2' => api.Hip3WithdrawalCreateRequestRailEnum.bridge2,
        'float' => api.Hip3WithdrawalCreateRequestRailEnum.float,
        _ => throw FormatException('Unsupported HIP-3 withdrawal rail: $value'),
      };

  domain_preview.Hip3WithdrawalPreview _mapPreview(
    api.Hip3WithdrawalPreview value,
  ) {
    final risk = value.riskPreview;
    return domain_preview.Hip3WithdrawalPreview(
      amount: value.amount,
      fee: value.fee,
      minimumReceived: value.minimumReceived,
      rail: value.rail.name,
      destinationAddress: value.destinationAddress,
      chainId: value.chainId,
      maximumTransferable: value.maximumTransferable,
      blockers: List.unmodifiable(value.blockers.map((item) => item.name)),
      estimatedArrivalSeconds: value.estimatedArrivalSeconds,
      feeDetails: List.unmodifiable(
        value.feeDetails.map(
          (item) => domain_preview.Hip3WithdrawalFeeDetail(
            type: item.type.name,
            amount: item.amount,
            currency: item.currency.name,
            payer: item.payer.name,
          ),
        ),
      ),
      crossLiquidationImpacts: List.unmodifiable(
        risk.crossLiquidationImpacts.map(_mapImpact),
      ),
      riskStatus: risk.status.name,
      riskValidUntil: risk.validUntil?.toUtc(),
      riskUnavailableReason: risk.unavailableReason?.name,
    );
  }

  Hip3CrossLiquidationImpact _mapImpact(
    api.Hip3CrossLiquidationImpact impact,
  ) => Hip3CrossLiquidationImpact(
    productId: impact.productId,
    side: switch (impact.side) {
      api.Hip3CrossLiquidationImpactSideEnum.long => TradingSide.long,
      api.Hip3CrossLiquidationImpactSideEnum.short => TradingSide.short,
      _ => throw const FormatException(
        'Unsupported cross liquidation impact side',
      ),
    },
    markPrice: impact.markPrice == null
        ? null
        : DecimalValue(impact.markPrice!, asset: 'USDC', unit: 'price'),
    beforeLiquidationPrice: impact.beforeLiquidationPrice == null
        ? null
        : DecimalValue(
            impact.beforeLiquidationPrice!,
            asset: 'USDC',
            unit: 'price',
          ),
    afterLiquidationPrice: impact.afterLiquidationPrice == null
        ? null
        : DecimalValue(
            impact.afterLiquidationPrice!,
            asset: 'USDC',
            unit: 'price',
          ),
    unavailableReason: impact.unavailableReason?.name,
  );

  domain.Hip3Withdrawal _map(api.Hip3Withdrawal value) => domain.Hip3Withdrawal(
    id: value.withdrawalId,
    ownerAddress: value.ownerAddress,
    destinationAddress: value.destinationAddress,
    amount: value.amount,
    fee: value.fee,
    minimumReceived: value.minimumReceived,
    status: value.status == api.Hip3WithdrawalStatus.awaitingSignature
        ? 'awaiting_signature'
        : value.status.name,
    rail: value.rail.name,
    expiresAt: value.expiresAt.toUtc(),
    failureReason: value.failureReason,
    typedDataJson: value.typedDataJson,
    payloadHash: value.payloadHash,
  );
}
