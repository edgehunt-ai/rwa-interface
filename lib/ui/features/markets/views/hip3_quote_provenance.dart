import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../domain/models/market_snapshot.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/formatters/token_amount_formatter.dart';

/// Presentation-only expiry. No repository, signing or network dependency.
class Hip3QuoteProvenance extends ConsumerStatefulWidget {
  const Hip3QuoteProvenance({
    super.key,
    required this.snapshot,
    this.now,
    this.compact = false,
  });
  factory Hip3QuoteProvenance.product(MarketProduct product) =>
      Hip3QuoteProvenance(
        compact: true,
        snapshot: MarketSnapshot(
          price: product.price,
          priceKind: product.priceKind,
          hip3Market: product.hip3Market,
          asOf: product.updatedAt,
          validUntil: product.validUntil,
          isStale: product.isStale,
        ),
      );
  final MarketSnapshot snapshot;
  final DateTime Function()? now;
  final bool compact;

  @override
  ConsumerState<Hip3QuoteProvenance> createState() =>
      _Hip3QuoteProvenanceState();
}

class _Hip3QuoteProvenanceState extends ConsumerState<Hip3QuoteProvenance> {
  Timer? _expiry;
  bool _expired = false;
  bool _visible = true;
  DateTime get _now => (widget.now ?? DateTime.now)().toUtc();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _visible = TickerMode.valuesOf(context).enabled;
    _schedule();
  }

  @override
  void didUpdateWidget(covariant Hip3QuoteProvenance oldWidget) {
    super.didUpdateWidget(oldWidget);
    _schedule();
  }

  void _schedule() {
    _expiry?.cancel();
    _expired = widget.snapshot.isStaleAt(_now);
    final until = widget.snapshot.validUntil;
    if (_expired ||
        until == null ||
        !_visible ||
        !ref.read(hip3ForegroundProvider)) {
      return;
    }
    _expiry = Timer(until.toUtc().difference(_now), () {
      if (mounted) setState(() => _expired = true);
    });
  }

  @override
  void dispose() {
    _expiry?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(hip3ForegroundProvider, (_, _) {
      setState(_schedule);
    });
    final quote = widget.snapshot;
    final market = quote.hip3Market;
    final reference = quote.referencePrice;
    final l10n = AppLocalizations.of(context);
    final label = switch (quote.priceKind) {
      'mark' => l10n.hip3QuoteMark,
      'oracle' => l10n.hip3QuoteOracle,
      _ => quote.quoteLabel ?? l10n.hip3QuoteUnknownSource,
    };
    final observed = quote.asOf?.toUtc().toIso8601String();
    if (widget.compact) {
      return Text(
        [
          label,
          if (market != null) '${market.venue}/${market.environment}',
          observed == null
              ? l10n.hip3QuoteTimeUnavailable
              : '${observed.substring(0, 19).replaceFirst('T', ' ')} UTC',
          if (_expired)
            l10n.hip3QuoteExpiredShort
          else if (quote.validUntil == null || observed == null)
            l10n.hip3QuoteFreshnessUnknown,
        ].join(' · '),
        style: Theme.of(context).textTheme.bodySmall,
        key: const Key('hip3-quote-freshness'),
      );
    }
    return Semantics(
      container: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          if (market != null)
            Text(
              '${market.venue} · ${market.environment} · ${market.settlementAsset}',
            ),
          if (reference != null && quote.referenceLabel != null)
            Text(
              '${quote.referenceLabel}: ${TokenAmountFormatter.formatUsd(reference)}',
            ),
          Text(l10n.hip3QuoteOracleDisclosure),
          Text(
            observed == null
                ? l10n.hip3QuoteTimeUnavailable
                : l10n.hip3QuoteObserved(observed),
          ),
          Text(
            _expired
                ? l10n.hip3QuoteExpired
                : quote.validUntil == null || observed == null
                ? l10n.hip3QuoteFreshnessUnknown
                : l10n.hip3QuoteCurrent,
            key: const Key('hip3-quote-freshness'),
          ),
        ],
      ),
    );
  }
}
