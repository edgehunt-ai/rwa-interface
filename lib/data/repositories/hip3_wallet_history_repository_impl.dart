import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/hip3_wallet_history.dart';
import '../../domain/repositories/hip3_wallet_history_repository.dart';
import '../services/hip3_wallet_history_service.dart';

final class Hip3WalletHistoryRepositoryImpl
    implements Hip3WalletHistoryRepository {
  Hip3WalletHistoryRepositoryImpl(this._service);
  final Hip3WalletHistoryService _service;
  @override
  Future<Hip3HistoryPage<Hip3FundingPayment>> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async {
    final page = await _service.funding(query, cursor: cursor);
    try {
      _validatePage(
        query,
        page.querySource.name,
        page.environment.name,
        page.hasMore,
        page.nextCursor,
      );
      return Hip3HistoryPage(
        snapshotId: page.snapshotId,
        environment: page.environment.name,
        source: query.source,
        observedAt: page.observedAt.toUtc(),
        items: page.items.map((item) {
          if ((item.settlementAsset == null) !=
                  (item.collateralToken == null) ||
              (query.productId != null && item.productId != query.productId)) {
            throw const FormatException('Invalid funding scope');
          }
          return Hip3FundingPayment(
            id: item.id,
            productId: item.productId,
            amount: DecimalValue(item.amount, asset: item.settlementAsset),
            settlementAsset: item.settlementAsset,
            collateralToken: item.collateralToken,
            signedPositionSize: DecimalValue(item.signedPositionSize),
            fundingRate: DecimalValue(item.fundingRate),
            transactionHash: item.transactionHash,
            occurredAt: item.occurredAt.toUtc(),
          );
        }).toList(),
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
        coverage: _coverage(
          query,
          page.coverage.status.name,
          page.coverage.from,
          page.coverage.to,
          page.coverage.resumeFrom,
          page.coverage.retentionGuaranteed,
          page.archiveCoverage,
        ),
        warnings: page.warnings.map((w) => w.name).toList(),
      );
    } on FormatException {
      throw const DecodingFailure();
    } on ArgumentError {
      throw const DecodingFailure();
    }
  }

  @override
  Future<Hip3HistoryPage<Hip3LiquidationEvent>> liquidations(
    Hip3HistoryQuery query, {
    String? cursor,
  }) async {
    final page = await _service.liquidations(query, cursor: cursor);
    try {
      _validatePage(
        query,
        page.querySource.name,
        page.environment.name,
        page.hasMore,
        page.nextCursor,
      );
      return Hip3HistoryPage(
        snapshotId: page.snapshotId,
        environment: page.environment.name,
        source: query.source,
        observedAt: page.observedAt.toUtc(),
        items: page.items.map((item) {
          if (item.positions.isEmpty ||
              (query.productId != null &&
                  !item.positions.any((p) => p.productId == query.productId))) {
            throw const FormatException('Invalid liquidation scope');
          }
          return Hip3LiquidationEvent(
            id: item.id,
            providerAccountValue: DecimalValue(item.providerAccountValue),
            accountValueScope: item.accountValueScope.name,
            marginMode: item.marginMode.name,
            positions: item.positions
                .map(
                  (p) => Hip3LiquidationPosition(
                    productId: p.productId,
                    signedPositionSize: DecimalValue(p.signedPositionSize),
                  ),
                )
                .toList(),
            excludedNativePositionCount: item.excludedNativePositionCount,
            transactionHash: item.transactionHash,
            occurredAt: item.occurredAt.toUtc(),
          );
        }).toList(),
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
        coverage: _coverage(
          query,
          page.coverage.status.name,
          page.coverage.from,
          page.coverage.to,
          page.coverage.resumeFrom,
          page.coverage.retentionGuaranteed,
          page.archiveCoverage,
        ),
        warnings: page.warnings.map((w) => w.name).toList(),
      );
    } on FormatException {
      throw const DecodingFailure();
    } on ArgumentError {
      throw const DecodingFailure();
    }
  }

  void _validatePage(
    Hip3HistoryQuery query,
    String source,
    String environment,
    bool hasMore,
    String? cursor,
  ) {
    if (source != query.source.name ||
        !['mainnet', 'testnet'].contains(environment) ||
        hasMore != (cursor != null && cursor.isNotEmpty)) {
      throw const FormatException('Invalid history page');
    }
  }

  Hip3HistoryCoverage _coverage(
    Hip3HistoryQuery query,
    String name,
    DateTime from,
    DateTime to,
    DateTime? resume,
    bool retention,
    api.Hip3ArchiveCoverage? archive,
  ) {
    final status = Hip3HistoryCoverageStatus.values.byName(name);
    final complete =
        status == Hip3HistoryCoverageStatus.sourceExhausted ||
        status == Hip3HistoryCoverageStatus.archiveComplete;
    final archived = query.source == Hip3HistorySource.archive;
    if (from.toUtc() != query.from ||
        to.toUtc() != query.to ||
        retention ||
        complete != (resume == null) ||
        (resume != null && (resume.isBefore(from) || resume.isAfter(to))) ||
        archived != (archive != null) ||
        archived !=
            [
              Hip3HistoryCoverageStatus.archiveComplete,
              Hip3HistoryCoverageStatus.archivePartial,
            ].contains(status)) {
      throw const FormatException('Invalid history coverage');
    }
    if (archive != null && complete != archive.missingRanges.isEmpty) {
      throw const FormatException('Invalid archive gaps');
    }
    List<Hip3HistoryRange> ranges(Iterable<api.Hip3HistoryRange> values) =>
        values.map((r) {
          if (r.from.isAfter(r.to) ||
              r.from.isBefore(from) ||
              r.to.isAfter(to)) {
            throw const FormatException('Invalid archive range');
          }
          return Hip3HistoryRange(from: r.from.toUtc(), to: r.to.toUtc());
        }).toList();
    return Hip3HistoryCoverage(
      status: status,
      from: from.toUtc(),
      to: to.toUtc(),
      resumeFrom: resume?.toUtc(),
      retentionGuaranteed: retention,
      coveredRanges: ranges(archive?.coveredRanges ?? []),
      missingRanges: ranges(archive?.missingRanges ?? []),
    );
  }
}
