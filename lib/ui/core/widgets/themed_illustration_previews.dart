import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'themed_illustration.dart';

@Preview(name: 'Light artwork', group: 'Illustrations', size: Size(600, 260))
Widget lightIllustrationsPreview() => _preview(ThemeMode.light);

@Preview(name: 'Dark artwork', group: 'Illustrations', size: Size(600, 260))
Widget darkIllustrationsPreview() => _preview(ThemeMode.dark);

Widget _preview(ThemeMode mode) => MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
  themeMode: mode,
  home: Scaffold(
    body: Center(
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          for (final asset in IllustrationAsset.values)
            ThemedIllustration(
              asset,
              width: 96,
              height: 96,
              fit: BoxFit.contain,
            ),
        ],
      ),
    ),
  ),
);
