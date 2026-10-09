import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../../domain/models/order_intent.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import 'hip3_segmented_control.dart';

@Preview(name: 'Order type tabs', group: 'HIP-3', size: Size(191, 84))
Widget hip3OrderTypeTabsPreview() => _preview(ThemeMode.light);

@Preview(name: 'Order type tabs dark', group: 'HIP-3', size: Size(191, 84))
Widget hip3OrderTypeTabsDarkPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(body: Center(child: _OrderTypeTabsPreview())),
);

class _OrderTypeTabsPreview extends StatefulWidget {
  const _OrderTypeTabsPreview();

  @override
  State<_OrderTypeTabsPreview> createState() => _OrderTypeTabsPreviewState();
}

class _OrderTypeTabsPreviewState extends State<_OrderTypeTabsPreview> {
  TradingOrderType _type = TradingOrderType.market;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Hip3SegmentedControl<TradingOrderType>(
      width: 151,
      values: const [TradingOrderType.market, TradingOrderType.limit],
      selected: _type,
      selectedColor: colors.surface,
      selectedForeground: colors.primaryText,
      label: (value) =>
          value == TradingOrderType.market ? l10n.market : l10n.limit,
      onChanged: (value) => setState(() => _type = value),
    );
  }
}
