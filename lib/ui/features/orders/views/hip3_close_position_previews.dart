import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_close_preview.dart';
import '../../../../app/providers/api_providers.dart';
import '../../../../app_review/repositories.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../positions/providers/position_providers.dart';
import 'hip3_close_position_sheet.dart';

@Preview(name: 'Close position inputs', group: 'HIP-3', size: Size(393, 700))
@Preview(
  name: 'Close position inputs narrow',
  group: 'HIP-3',
  size: Size(320, 700),
)
Widget hip3ClosePositionInputsPreview() => _preview(ThemeMode.light);

@Preview(
  name: 'Close position inputs dark',
  group: 'HIP-3',
  size: Size(393, 700),
)
Widget hip3ClosePositionInputsDarkPreview() => _preview(ThemeMode.dark);

@Preview(
  name: 'Close preview skeletons (enter quantity)',
  group: 'HIP-3',
  size: Size(393, 700),
)
Widget hip3ClosePositionLoadingPreview() =>
    _preview(ThemeMode.light, loading: true);

Widget _preview(ThemeMode mode, {bool loading = false}) => ProviderScope(
  overrides: [
    positionsRepositoryProvider.overrideWithValue(
      AppReviewPositionsRepository(),
    ),
    if (loading)
      positionClosePreviewProvider.overrideWith(
        (ref, request) => Completer<PositionClosePreview>().future,
      ),
  ],
  child: MaterialApp(
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: mode,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Hip3ClosePositionSheet(
        // All position requests use the local review simulation above.
        position: Position(
          positionId: 'preview-position',
          productId: 'xyz:NVDA',
          positionVersion: 'preview-v1',
          symbol: 'NVDA',
          kind: MarketProductKind.perp,
          side: PositionSide.long,
          quantity: DecimalValue('1000'),
          valueUsd: DecimalValue('100'),
          leverage: DecimalValue('10'),
          entryPrice: DecimalValue('180.11'),
          markPrice: DecimalValue('180.11'),
          liquidationPrice: DecimalValue('120.14'),
          unrealizedPnl: DecimalValue('20.44'),
        ),
      ),
    ),
  ),
);
