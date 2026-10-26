import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'market_session_presentation.dart';

@Preview(
  name: 'Initial market session loading',
  group: 'Market hours',
  size: Size(140, 60),
)
Widget marketSessionLoadingPreview() => _preview(ThemeMode.light);

@Preview(
  name: 'Initial market session loading dark',
  group: 'Market hours',
  size: Size(140, 60),
)
Widget marketSessionLoadingDarkPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  home: const Scaffold(
    body: Center(
      child: MarketSessionBadge(hours: null, compact: true, loading: true),
    ),
  ),
);
