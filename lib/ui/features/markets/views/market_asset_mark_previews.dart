import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

import 'market_product_widgets.dart';

@Preview(
  name: 'API text and symbol initial placeholders',
  group: 'Markets',
  size: Size(220, 80),
)
Widget marketAssetMarkPreview() => MaterialApp(
  theme: AppTheme.light,
  home: const Scaffold(
    body: Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MarketAssetMark(symbol: 'NVDAB', logoText: 'NV'),
          SizedBox(width: 16),
          MarketAssetMark(symbol: 'TOKEN-X', size: 32, borderRadius: 12),
          SizedBox(width: 16),
          MarketAssetMark(symbol: ''),
        ],
      ),
    ),
  ),
);
