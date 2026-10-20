/// Exact evidence-backed quantity. Unknown is not interchangeable with zero.
final class FinancialObligationAmount {
  FinancialObligationAmount.known(String raw)
    : raw = raw,
      unknownReason = null {
    if (!RegExp(r'^(0|[1-9][0-9]*)$').hasMatch(raw)) {
      throw const FormatException('Expected an unsigned raw integer amount');
    }
  }

  FinancialObligationAmount.unknown(String reason)
    : raw = null,
      unknownReason = reason {
    if (reason.trim().isEmpty) {
      throw const FormatException('Unknown amount requires a reason');
    }
  }

  final String? raw;
  final String? unknownReason;

  String? decimal(int decimals) {
    if (decimals < 0 || decimals > 255) {
      throw RangeError.range(decimals, 0, 255, 'decimals');
    }
    final value = raw;
    if (value == null || decimals == 0) return value;
    final digits = value.padLeft(decimals + 1, '0');
    final split = digits.length - decimals;
    return '${digits.substring(0, split)}.${digits.substring(split)}';
  }
}

final class FinancialBusinessReference {
  const FinancialBusinessReference({required this.type, required this.id});
  final String type;
  final String id;
  @override
  String toString() => '$type:$id';
}

final class FinancialObligationAsset {
  const FinancialObligationAsset({
    required this.status,
    this.assetId,
    this.namespace,
    this.environment,
    this.network,
    this.chainId,
    this.token,
    this.tokenContract,
    this.tokenDecimals,
    this.unknownReason,
    this.observedAssetRef,
    this.provenance,
  });
  final String status;
  final String? assetId;
  final String? namespace;
  final String? environment;
  final String? network;
  final int? chainId;
  final String? token;
  final String? tokenContract;
  final int? tokenDecimals;
  final String? unknownReason;
  final String? observedAssetRef;
  final String? provenance;
}

final class FinancialObligationAmounts {
  const FinancialObligationAmounts({
    required this.asset,
    required this.buckets,
  });
  final FinancialObligationAsset asset;
  // Buckets overlap: outstanding must not be added to in_transit or refund_due.
  final Map<String, FinancialObligationAmount> buckets;
}

final class FinancialSettlementEvidence {
  const FinancialSettlementEvidence({
    required this.id,
    required this.kind,
    required this.status,
    required this.reference,
    required this.observedAt,
    this.chainId,
    this.txHash,
    this.logIndex,
    this.venueReference,
    this.commandReference,
  });
  final String id;
  final String kind;
  final String status;
  final FinancialBusinessReference reference;
  final DateTime observedAt;
  final int? chainId;
  final String? txHash;
  final int? logIndex;
  final String? venueReference;
  final FinancialBusinessReference? commandReference;
}

final class FinancialResponsibility {
  const FinancialResponsibility({
    required this.queue,
    required this.escalationStatus,
    required this.allowedActions,
    this.caseId,
    this.owner,
  });
  final String queue;
  final String escalationStatus;
  final List<String> allowedActions;
  final String? caseId;
  final String? owner;
}

final class FinancialObligation {
  const FinancialObligation({
    required this.id,
    required this.businessReference,
    required this.relatedReferences,
    required this.economicStatus,
    required this.technicalStatus,
    required this.unresolved,
    required this.amounts,
    required this.evidence,
    required this.responsibility,
    required this.createdAt,
    required this.updatedAt,
    this.reason,
    this.lastObservedAt,
    this.nextObservationAt,
  });
  final String id;
  final FinancialBusinessReference businessReference;
  final List<FinancialBusinessReference> relatedReferences;
  final String economicStatus;
  final String technicalStatus;
  final bool unresolved;
  final List<FinancialObligationAmounts> amounts;
  final List<FinancialSettlementEvidence> evidence;
  final FinancialResponsibility responsibility;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? reason;
  final DateTime? lastObservedAt;
  final DateTime? nextObservationAt;

  String get supportReference => [
    id,
    businessReference.toString(),
    if (responsibility.caseId != null) responsibility.caseId!,
  ].join('\n');
}
