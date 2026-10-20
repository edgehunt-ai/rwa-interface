import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/financial_obligation.dart';

FinancialObligation financialObligationFromApi(api.FinancialObligation value) =>
    FinancialObligation(
      id: value.obligationId,
      businessReference: _reference(value.businessReference),
      relatedReferences: value.relatedReferences.map(_reference).toList(growable: false),
      economicStatus: value.economicStatus.name,
      technicalStatus: value.technicalStatus,
      unresolved: value.unresolved,
      reason: value.reason,
      createdAt: value.createdAt.toUtc(),
      updatedAt: value.updatedAt.toUtc(),
      lastObservedAt: value.lastObservedAt?.toUtc(),
      nextObservationAt: value.nextObservationAt?.toUtc(),
      responsibility: FinancialResponsibility(
        queue: value.responsibility.queue,
        escalationStatus: value.responsibility.escalationStatus.name,
        allowedActions: value.responsibility.allowedActions
            .map((action) => action.name).toList(growable: false),
        caseId: value.responsibility.caseId,
        owner: value.responsibility.owner,
      ),
      amounts: value.amounts.map((row) => FinancialObligationAmounts(
        asset: _asset(row.asset),
        buckets: {
          'reserved': _amount(row.reserved),
          'source_debited': _amount(row.sourceDebited),
          'in_transit': _amount(row.inTransit),
          'credited': _amount(row.credited),
          'refund_due': _amount(row.refundDue),
          'refunded': _amount(row.refunded),
          'actual_fee': _amount(row.actualFee),
          'released': _amount(row.released),
          'compensated': _amount(row.compensated),
          'outstanding': _amount(row.outstanding),
        },
      )).toList(growable: false),
      evidence: value.evidence.map((item) => FinancialSettlementEvidence(
        id: item.evidenceId,
        kind: item.kind.name,
        status: item.status.name,
        reference: _reference(item.reference),
        observedAt: item.observedAt.toUtc(),
        chainId: item.chainId,
        txHash: item.txHash,
        logIndex: item.logIndex,
        venueReference: item.venueReference,
        commandReference: item.commandReference == null
            ? null : _reference(item.commandReference!),
      )).toList(growable: false),
    );

FinancialBusinessReference _reference(api.FinancialBusinessReference value) =>
    FinancialBusinessReference(type: value.type, id: value.id);

FinancialObligationAmount _amount(api.FinancialRawAmount value) {
  final amount = value.oneOf.value;
  if (amount is api.KnownFinancialRawAmount) {
    return FinancialObligationAmount.known(amount.amountRaw);
  }
  if (amount is api.UnknownFinancialRawAmount) {
    return FinancialObligationAmount.unknown(amount.reason);
  }
  throw const FormatException('Unsupported financial amount variant');
}

FinancialObligationAsset _asset(api.FinancialAssetIdentity value) {
  final asset = value.oneOf.value;
  if (asset is api.KnownFinancialAssetIdentity) {
    final environment = asset.environment?.name;
    if (asset.namespace.name == 'hyperliquid' &&
        (!const {'mainnet', 'testnet'}.contains(environment) ||
            asset.assetId != 'hyperliquid:$environment/perps:USDC-PERPS')) {
      throw const FormatException('Known Hyperliquid identity requires an exact environment-qualified asset');
    }
    return FinancialObligationAsset(
      status: 'known',
      assetId: asset.assetId,
      namespace: asset.namespace.name,
      environment: environment,
      network: asset.network.name,
      chainId: asset.chainId,
      token: asset.token,
      tokenContract: asset.tokenContract,
      tokenDecimals: asset.tokenDecimals,
      provenance: asset.provenance?.name,
    );
  }
  if (asset is api.UnknownFinancialAssetIdentity) {
    return FinancialObligationAsset(
      status: 'unknown',
      unknownReason: asset.reason,
      namespace: asset.namespace?.name,
      environment: asset.environment?.name,
      network: asset.network?.name,
      chainId: asset.chainId,
      tokenContract: asset.tokenContract,
      observedAssetRef: asset.observedAssetRef,
    );
  }
  throw const FormatException('Unsupported financial asset identity variant');
}
