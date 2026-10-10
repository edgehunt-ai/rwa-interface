import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'market_countdown_dot.dart';

@Preview(
  name: 'Countdown breathing dot',
  group: 'Market hours',
  size: Size(270, 76),
)
Widget marketCountdownDotPreview() => _preview(ThemeMode.light);

@Preview(
  name: 'Countdown breathing dot dark',
  group: 'Market hours',
  size: Size(270, 76),
)
Widget marketCountdownDotDarkPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  home: const Scaffold(
    body: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('美股市场将在 04:28:33 后开盘', style: TextStyle(fontSize: 12)),
          SizedBox(width: 8),
          MarketCountdownDot(),
        ],
      ),
    ),
  ),
);
