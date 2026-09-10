enum PortfolioCompleteness { complete, partial, empty, unknown }

enum PortfolioFreshness { live, cached, stale, unknown }

final class PortfolioReadStatus {
  const PortfolioReadStatus({
    this.completeness = PortfolioCompleteness.unknown,
    this.freshness = PortfolioFreshness.unknown,
    this.warnings = const [],
    this.oldestObservationAt,
  });

  final PortfolioCompleteness completeness;
  final PortfolioFreshness freshness;
  final List<String> warnings;
  final DateTime? oldestObservationAt;

  bool get reliable =>
      (completeness == PortfolioCompleteness.complete ||
          completeness == PortfolioCompleteness.empty) &&
      (freshness == PortfolioFreshness.live ||
          freshness == PortfolioFreshness.cached) &&
      warnings.isEmpty;

  PortfolioReadStatus merge(PortfolioReadStatus other) => PortfolioReadStatus(
    completeness:
        completeness == PortfolioCompleteness.partial ||
            other.completeness == PortfolioCompleteness.partial
        ? PortfolioCompleteness.partial
        : completeness == PortfolioCompleteness.unknown ||
              other.completeness == PortfolioCompleteness.unknown
        ? PortfolioCompleteness.unknown
        : completeness == PortfolioCompleteness.complete ||
              other.completeness == PortfolioCompleteness.complete
        ? PortfolioCompleteness.complete
        : PortfolioCompleteness.empty,
    freshness:
        freshness == PortfolioFreshness.stale ||
            other.freshness == PortfolioFreshness.stale
        ? PortfolioFreshness.stale
        : freshness == PortfolioFreshness.unknown ||
              other.freshness == PortfolioFreshness.unknown
        ? PortfolioFreshness.unknown
        : freshness == PortfolioFreshness.cached ||
              other.freshness == PortfolioFreshness.cached
        ? PortfolioFreshness.cached
        : PortfolioFreshness.live,
    warnings: List.unmodifiable({...warnings, ...other.warnings}),
    oldestObservationAt: oldestObservationAt == null
        ? other.oldestObservationAt
        : other.oldestObservationAt == null ||
              oldestObservationAt!.isBefore(other.oldestObservationAt!)
        ? oldestObservationAt
        : other.oldestObservationAt,
  );
}
