import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';

import 'position_protection_quantity_card.dart';
import 'tpsl_risk_agreement_sheet.dart';

@Preview(name: 'Position TP/SL error', group: 'TP/SL', size: Size(347, 100))
Widget positionTpSlErrorPreview() => MaterialApp(
  theme: AppTheme.light,
  home: const Scaffold(
    body: Padding(
      padding: EdgeInsets.all(12),
      child: TpSlInlineError(messages: ['止盈: 请输入有效的正数价格。']),
    ),
  ),
);

@Preview(name: 'Position quantity', group: 'TP/SL', size: Size(393, 110))
@Preview(name: 'Position quantity narrow', group: 'TP/SL', size: Size(320, 110))
Widget positionProtectionQuantityPreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: const Scaffold(body: _QuantityPreview()),
);

class _QuantityPreview extends StatefulWidget {
  const _QuantityPreview();

  @override
  State<_QuantityPreview> createState() => _QuantityPreviewState();
}

class _QuantityPreviewState extends State<_QuantityPreview> {
  final _controller = TextEditingController();
  double _percentage = 20;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: PositionProtectionQuantityCard(
      controller: _controller,
      symbol: 'NVDA',
      percentage: _percentage,
      onQuantityChanged: (value) => setState(() {
        _percentage = ((double.tryParse(value) ?? 0) * 100).clamp(0, 100);
      }),
      onPercentageChanged: (value) => setState(() {
        _percentage = value;
        _controller.text = (value / 100).toString();
      }),
    ),
  );
}
