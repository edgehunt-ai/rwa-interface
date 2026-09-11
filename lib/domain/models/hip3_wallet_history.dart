import 'decimal_value.dart';

enum Hip3HistorySource { live, archive }

enum Hip3HistoryKind { funding, liquidations }

enum Hip3HistoryCoverageStatus {
  sourceExhausted,
  pageLimit,
  timestampSaturated,
  upstreamUnavailable,
  archiveComplete,
  archivePartial,
}

/// One immutable query window. Keep this exact query when following its cursor.
final class Hip3HistoryQuery {
  Hip3HistoryQuery({
    required DateTime from,
    required DateTime to,
    this.productId,
    this.source = Hip3HistorySource.live,
  }) : from = DateTime.fromMillisecondsSinceEpoch(
         from.millisecondsSinceEpoch,
         isUtc: true,
       ),
       to = DateTime.fromMillisecondsSinceEpoch(
         to.millisecondsSinceEpoch,
         isUtc: true,
       ) {
    if (this.to.isBefore(this.from) ||
        this.to.difference(this.from) > const Duration(days: 31) ||
        (productId != null &&
            (productId!.trim().isEmpty || productId!.length > 128))) {
      throw ArgumentError('Invalid HIP3 history query');
    }
  }
  final DateTime from, to;
  final String? productId;
  final Hip3HistorySource source;
  @override
  bool operator ==(Object other) =>
      other is Hip3HistoryQuery &&
      from == other.from &&
      to == other.to &&
      productId == other.productId &&
      source == other.source;
  @override
  int get hashCode => Object.hash(from, to, productId, source);
}

final class Hip3HistoryRange {
  const Hip3HistoryRange({required this.from, required this.to});
  final DateTime from, to;
}

final class Hip3HistoryCoverage {
  Hip3HistoryCoverage({
    required this.status,
    required this.from,
    required this.to,
    required this.resumeFrom,
    required this.retentionGuaranteed,
    required List<Hip3HistoryRange> coveredRanges,
    required List<Hip3HistoryRange> missingRanges,
  }) : coveredRanges = List.unmodifiable(coveredRanges),
       missingRanges = List.unmodifiable(missingRanges);
  final Hip3HistoryCoverageStatus status;
  final DateTime from, to;
  final DateTime? resumeFrom;
  final bool retentionGuaranteed;
  final List<Hip3HistoryRange> coveredRanges, missingRanges;
  bool get isPartial =>
      status != Hip3HistoryCoverageStatus.sourceExhausted &&
      status != Hip3HistoryCoverageStatus.archiveComplete;
}

final class Hip3HistoryPage<T> {
  Hip3HistoryPage({
    required this.snapshotId,
    required this.environment,
    required this.source,
    required this.observedAt,
    required List<T> items,
    required this.hasMore,
    required this.nextCursor,
    required this.coverage,
    required List<String> warnings,
  }) : items = List.unmodifiable(items),
       warnings = List.unmodifiable(warnings);
  final String snapshotId, environment;
  final Hip3HistorySource source;
  final DateTime observedAt;
  final List<T> items;
  final bool hasMore;
  final String? nextCursor;
  final Hip3HistoryCoverage coverage;
  final List<String> warnings;
}

final class Hip3FundingPayment {
  const Hip3FundingPayment({
    required this.id,
    required this.productId,
    required this.amount,
    required this.settlementAsset,
    required this.collateralToken,
    required this.signedPositionSize,
    required this.fundingRate,
    required this.transactionHash,
    required this.occurredAt,
  });
  final String id, productId, transactionHash;
  final DecimalValue amount, signedPositionSize, fundingRate;
  final String? settlementAsset;
  final int? collateralToken;
  final DateTime occurredAt;
}

final class Hip3LiquidationPosition {
  const Hip3LiquidationPosition({
    required this.productId,
    required this.signedPositionSize,
  });
  final String productId;
  final DecimalValue signedPositionSize;
}

/// Account value is an event-scoped provider fact, never the selected product's loss.
final class Hip3LiquidationEvent {
  Hip3LiquidationEvent({
    required this.id,
    required this.providerAccountValue,
    required this.accountValueScope,
    required this.marginMode,
    required List<Hip3LiquidationPosition> positions,
    required this.excludedNativePositionCount,
    required this.transactionHash,
    required this.occurredAt,
  }) : positions = List.unmodifiable(positions);
  final String id, accountValueScope, marginMode, transactionHash;
  final DecimalValue providerAccountValue;
  final List<Hip3LiquidationPosition> positions;
  final int excludedNativePositionCount;
  final DateTime occurredAt;
}
