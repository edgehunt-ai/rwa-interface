import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/deposit.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('network menu opens below the field with the design geometry', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await _pumpDeposit(tester);
    final selector = find.byKey(const ValueKey('deposit-network-selector'));
    final fieldRect = tester.getRect(selector);

    await tester.tap(selector);
    await tester.pumpAndSettle();

    expect(find.byType(BottomSheet), findsNothing);
    expect(find.byType(PopupMenuItem<String>), findsNWidgets(4));
    final firstRect = tester.getRect(_networkOption('Arbitrum'));
    expect(firstRect.width, 232);
    expect(firstRect.height, 44);
    expect(firstRect.top, fieldRect.bottom);
    expect(firstRect.right, fieldRect.right - 20);
    for (final chain in ['Arbitrum', 'BSC', 'Ethereum', 'Polygon']) {
      expect(
        find.descendant(
          of: _networkOption(chain),
          matching: find.byType(SvgPicture),
        ),
        findsOneWidget,
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('token selection waits for a network and filters its options', (
    tester,
  ) async {
    final router = await _pumpDeposit(tester);
    final tokenSelector = find.byKey(const ValueKey('deposit-token-selector'));
    await tester.tap(tokenSelector);
    await tester.pumpAndSettle();
    expect(find.byType(PopupMenuItem<String>), findsNothing);

    await tester.tap(find.byKey(const ValueKey('deposit-network-selector')));
    await tester.pumpAndSettle();
    await tester.tap(_networkOption('BSC'));
    await tester.pumpAndSettle();
    await tester.tap(tokenSelector);
    await tester.pumpAndSettle();
    expect(find.byType(PopupMenuItem<String>), findsOneWidget);
    expect(_tokenOption('USDC'), findsNothing);
    expect(_tokenOption('USDT'), findsOneWidget);

    await tester.tap(_tokenOption('USDT'));
    await tester.pumpAndSettle();
    expect(find.byType(PopupMenuItem<String>), findsNothing);
    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
    expect(router.routerDelegate.currentConfiguration.uri.queryParameters, {
      'chain': 'BSC',
      'token': 'USDT',
    });
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'token menu highlights the selection and dismisses without changes',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 852));
      final router = await _pumpDeposit(
        tester,
        location: '/funding/deposit?chain=Arbitrum&token=USDC',
      );
      final selector = find.byKey(const ValueKey('deposit-token-selector'));
      final fieldRect = tester.getRect(selector);
      await tester.tap(selector);
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
      expect(find.byType(PopupMenuItem<String>), findsNWidgets(4));
      final firstRect = tester.getRect(_tokenOption('USDC'));
      expect(firstRect.top, fieldRect.bottom);
      expect(firstRect.right, fieldRect.right - 20);
      final colors = Theme.of(tester.element(selector))
          .extension<AppRwaColors>()!;
      final highlight = tester.widget<Container>(
        find.descendant(
          of: _tokenOption('USDC'),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration! as BoxDecoration).color == colors.brandSoft,
          ),
        ),
      );
      expect((highlight.decoration! as BoxDecoration).color, colors.brandSoft);
      for (final token in ['USDC', 'USDT', 'ETH', 'BNB']) {
        final icon = find.descendant(
          of: _tokenOption(token),
          matching: find.byKey(
            ValueKey('deposit-token-icon-${token.toLowerCase()}'),
          ),
        );
        expect(icon, findsOneWidget);
        expect(tester.getSize(icon), const Size(16, 16));
      }

      await tester.tapAt(const Offset(10, 500));
      await tester.pumpAndSettle();
      expect(find.byType(PopupMenuItem<String>), findsNothing);
      expect(router.routerDelegate.currentConfiguration.uri.queryParameters, {
        'chain': 'Arbitrum',
        'token': 'USDC',
      });

      await tester.tap(selector);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byType(PopupMenuItem<String>), findsNothing);
      expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('selected network uses the same highlight in the dark theme', (
    tester,
  ) async {
    await _pumpDeposit(
      tester,
      location: '/funding/deposit?chain=Arbitrum&token=USDC',
      themeMode: ThemeMode.dark,
    );
    final selector = find.byKey(const ValueKey('deposit-network-selector'));
    final colors = Theme.of(tester.element(selector))
        .extension<AppRwaColors>()!;
    await tester.tap(selector);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: _networkOption('Arbitrum'),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration! as BoxDecoration).color == colors.brandSoft,
        ),
      ),
      findsOneWidget,
    );
    final text = tester.widget<RichText>(
      find.descendant(
        of: _networkOption('Arbitrum'),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is RichText && widget.text.toPlainText() == 'Arbitrum',
        ),
      ),
    );
    final foreground = text.text.style!.color!;
    final background = colors.brandSoft;
    final contrast =
        (background.computeLuminance() + 0.05) /
        (foreground.computeLuminance() + 0.05);
    expect(contrast, greaterThanOrEqualTo(4.5));
    await tester.tap(_networkOption('Arbitrum'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('menus fit a narrow short viewport with large text', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(280, 320), textScale: 2);
    await _pumpDeposit(tester, location: '/funding/deposit?chain=Arbitrum');
    await tester.tap(find.byKey(const ValueKey('deposit-network-selector')));
    await tester.pumpAndSettle();
    final firstRect = tester.getRect(_networkOption('Arbitrum'));
    expect(firstRect.left, greaterThanOrEqualTo(0));
    expect(firstRect.right, lessThanOrEqualTo(280));
    await tester.tapAt(const Offset(2, 300));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('deposit-token-selector')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(_tokenOption('BNB'));
    await tester.pumpAndSettle();
    expect(_tokenOption('BNB').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Finder _networkOption(String value) =>
    find.byKey(ValueKey('deposit-network-option-$value'));

Finder _tokenOption(String value) =>
    find.byKey(ValueKey('deposit-token-option-$value'));

Future<GoRouter> _pumpDeposit(
  WidgetTester tester, {
  String location = '/funding/deposit',
  ThemeMode themeMode = ThemeMode.light,
}) async {
  final router = GoRouter(
    initialLocation: location,
    routes: [
      GoRoute(
        path: AppRoutes.depositPath,
        name: AppRoutes.depositName,
        builder: (_, state) => DepositScreen(
          chain: state.uri.queryParameters['chain'],
          token: state.uri.queryParameters['token'],
        ),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        depositRoutesProvider.overrideWith((_) async => _routes),
        for (final route in _routes) ...[
          depositInstructionProvider((chain: route.chain, token: route.token))
              .overrideWith((_) async => _instruction(route)),
          depositBalanceChangesProvider((
            chain: route.chain,
            token: route.token,
          )).overrideWith((_) => const Stream.empty()),
          depositCurrentBalanceProvider((
            chain: route.chain,
            token: route.token,
          )).overrideWith(
            (_) => DecimalValue('0', asset: route.token, unit: 'token'),
          ),
        ],
      ],
      child: buildRouterTestApp(router, themeMode: themeMode),
    ),
  );
  await tester.pumpAndSettle();
  return router;
}

final _routes = [
  for (final token in ['USDC', 'USDT', 'ETH', 'BNB']) _route('Arbitrum', token),
  _route('BSC', 'USDT'),
  _route('Ethereum', 'USDC'),
  _route('Polygon', 'USDC'),
];

DepositRoute _route(String chain, String token) => DepositRoute(
  chain: chain,
  token: token,
  minimumAmount: DecimalValue('1', asset: token, unit: 'token'),
  confirmationsRequired: 20,
);

DepositInstruction _instruction(DepositRoute route) => DepositInstruction(
  chain: route.chain,
  token: route.token,
  tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  tokenDecimals: 6,
  address: '0x1111111111111111111111111111111111111111',
  qrPayload: '0x1111111111111111111111111111111111111111',
  minimumAmount: route.minimumAmount,
  confirmationsRequired: route.confirmationsRequired,
  estimatedArrivalSeconds: 60,
  warning: 'Send ${route.token} only.',
);
