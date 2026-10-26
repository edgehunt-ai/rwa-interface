import 'package:flutter/material.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/rwa_tooltip.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

class MarketListDataSource extends StatelessWidget {
  const MarketListDataSource({
    super.key,
    required this.kind,
    required this.tab,
  });

  final MarketProductKind? kind;
  final String tab;

  @override
  Widget build(BuildContext context) {
    if (kind == MarketProductKind.perp ||
        !const {'Gainers', 'Losers', 'Volume'}.contains(tab)) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        AppLocalizations.of(context).spotMarketDataSource,
        style: TextStyle(
          fontSize: 11,
          height: 14 / 11,
          color: Theme.of(context).extension<AppRwaColors>()!.textTertiary,
        ),
      ),
    );
  }
}

class TradeMarketDataSource extends StatelessWidget {
  const TradeMarketDataSource({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Flexible(
          child: Text(
            l10n.marketDataSourceBinance,
            style: TextStyle(
              fontSize: 11,
              height: 14 / 11,
              color: colors.textTertiary,
            ),
          ),
        ),
        const SizedBox(width: 4),
        RwaRichTooltip(
          alignToCenter: true,
          autoFlipVertically: true,
          constrainToViewport: true,
          message: TextSpan(
            text: l10n.marketDataSourceDisclaimer,
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              color: colors.textSecondary,
            ),
          ),
          child: Semantics(
            button: true,
            label: l10n.marketDataSourceBinance,
            child: AppSvgIcon(
              'assets/figma/common/market_data_info.svg',
              key: const Key('market-data-source-info'),
              width: 14,
              height: 14,
              color: colors.textTertiary,
            ),
          ),
        ),
      ],
    );
  }
}
