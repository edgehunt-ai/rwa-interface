import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/markets/market_data_source.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/empty_state.dart';
import 'package:nobell/ui/core/feedback/failure_state.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/layout/app_bottom_navigation.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/features/funding/views/deposit_screen.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_source_sheet.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ModalRoute.of(context)?.isCurrent ?? true) {
      ref.watch(portfolioListRefreshProvider);
      ref.watch(marketListRefreshProvider);
    }
    final authentication = ref.watch(authenticationProvider);
    final authenticated = authentication is AuthenticationAuthenticated;
    final initializing = authentication is AuthenticationInitializing;
    final restoreFailure =
        authentication is AuthenticationFailed &&
            authentication.failure.retryable &&
            authentication.failure.code ==
                AuthenticationFailureCode.backendSession
        ? authentication.failure
        : null;
    final portfolio = authenticated
        ? ref.watch(portfolioSummaryProvider)
        : null;
    final portfolioValue = portfolio?.maybeWhen(
      skipLoadingOnReload: true,
      data: (value) => value,
      orElse: () => null,
    );
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(
        current: AppDestination.home,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            final refreshes = <Future<void>>[
              ref.refresh(
                marketProductsProvider((
                  query: null,
                  cursor: null,
                  group: marketProductGroupForTab(
                    effectiveMarketRankingTab(
                      authenticated: authenticated,
                      storedTab: ref.read(marketRankingTabProvider).value,
                    ),
                  ),
                  productType: ref.read(marketProductTypeProvider).value,
                )).future,
              ),
            ];
            if (authenticated) {
              refreshes.add(ref.refresh(portfolioSummaryProvider.future));
            }
            await Future.wait(refreshes);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            children: [
              _UtilityBar(
                onSearch: () => context.pushNamed(AppRoutes.marketSearchName),
                onSettings: () => context.pushNamed(AppRoutes.settingsName),
              ),
              const SizedBox(height: 12),
              if (authenticated)
                portfolio!.when(
                  skipLoadingOnReload: true,
                  loading: () => const _HomeStateCard(),
                  error: (error, _) => FailureState(
                    error: error,
                    title: AppLocalizations.of(context).portfolioUnavailable,
                    description: AppLocalizations.of(context)
                        .checkConnectionRetry,
                    onRetry: () => ref.refresh(portfolioSummaryProvider.future),
                  ),
                  data: (value) => _PortfolioCard(portfolio: value),
                )
              else if (initializing)
                const _HomeStateCard()
              else if (restoreFailure != null)
                FailureState(
                  error: restoreFailure,
                  description: AppLocalizations.of(context)
                      .backendSessionFailed,
                  supportingMessage: restoreFailure.requestId == null
                      ? null
                      : AppLocalizations.of(context)
                            .supportId(restoreFailure.requestId!),
                  onRetry: () =>
                      ref.read(authenticationProvider.notifier).retry(),
                )
              else
                _LoggedOutPrompt(onLogin: () => _openLogin(context)),
              const SizedBox(height: 12),
              authenticated
                  ? _QuickActions(
                      showWithdraw:
                          portfolioValue != null &&
                          portfolioValue.totalValueUsd.compareTo(
                                DecimalValue(
                                  '0',
                                  asset: portfolioValue.totalValueUsd.asset,
                                  unit: portfolioValue.totalValueUsd.unit,
                                ),
                              ) >
                              0,
                    )
                  : initializing
                  ? const SkeletonBlock(
                      width: double.infinity,
                      height: 48,
                      radius: 12,
                    )
                  : restoreFailure != null
                  ? const SizedBox.shrink()
                  : _LoginAction(onLogin: () => _openLogin(context)),
              const SizedBox(height: 28),
              const _MarketPreview(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openLogin(BuildContext context) => pushLoginScreen(context);
}

class _UtilityBar extends StatelessWidget {
  const _UtilityBar({required this.onSearch, required this.onSettings});

  final VoidCallback onSearch;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    Widget action(String tooltip, String asset, VoidCallback onPressed) =>
        SizedBox.square(
          dimension: 44,
          child: IconButton(
            tooltip: tooltip,
            onPressed: onPressed,
            padding: EdgeInsets.zero,
            style: IconButton.styleFrom(backgroundColor: colors.surfaceBase),
            icon: AppSvgIcon(
              asset,
              color: colors.iconPrimary,
              width: 20,
              height: 20,
            ),
          ),
        );
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          action(
            l10n.openSettings,
            'assets/figma/home_markets/settings.svg',
            onSettings,
          ),
          const AppSvgIcon(
            'assets/figma/home_markets/nobell-wordmark.svg',
            key: Key('home-wordmark'),
            width: 100,
            height: 26,
          ),
          action(
            l10n.searchMarkets,
            'assets/figma/home_markets/search.svg',
            onSearch,
          ),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({required this.portfolio});
  final Portfolio portfolio;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final pnl = portfolio.todayPnl;
    final pnlPercent = portfolio.todayPnlPercent;
    final isEmpty =
        portfolio.totalValueUsd.compareTo(
          DecimalValue('0', asset: 'USD', unit: 'fiat'),
        ) ==
        0;
    final positive =
        !((pnl?.value ?? pnlPercent?.value)?.startsWith('-') ?? false);
    return Container(
      height: 142,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      decoration: BoxDecoration(
        color: colors.surfaceBase,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).homePortfolio,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 38,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: AnimatedNumberText(
                TokenAmountFormatter.formatUsdFixed(portfolio.totalValueUsd),
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 32,
                  height: 38 / 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (isEmpty)
            Text('—', style: TextStyle(color: colors.textSecondary))
          else if (pnl != null || pnlPercent != null)
            Text(
              [
                if (pnl != null) _formatPnl(pnl),
                if (pnlPercent != null)
                  '(${TokenAmountFormatter.formatPercent(pnlPercent, maxFractionDigits: 2, trimInsignificantZeros: false)})',
                'Today',
              ].join(' '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: positive ? semantic.success : semantic.danger,
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w500,
              ),
            )
          else
            Text(
              'No performance yet',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 15,
                height: 22 / 15,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  String _formatPnl(DecimalValue value) {
    final formatted = TokenAmountFormatter.formatUsdFixed(value);
    return value.value.startsWith('-') || value.value == '0'
        ? formatted
        : '+$formatted';
  }
}

@Preview(name: 'Portfolio performance', group: 'Home', size: Size(393, 182))
@Preview(
  name: 'Portfolio performance narrow',
  group: 'Home',
  size: Size(320, 182),
)
Widget homePortfolioPerformancePreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: _PortfolioCard(
        portfolio: Portfolio(
          totalValueUsd: DecimalValue('12580.4', asset: 'USD', unit: 'fiat'),
          availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
          todayPnl: DecimalValue('248.3', asset: 'USD', unit: 'fiat'),
          todayPnlPercent: DecimalValue('2.01', unit: 'percent'),
        ),
      ),
    ),
  ),
);

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.showWithdraw});
  final bool showWithdraw;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => showDepositRoutesSheet(context),
            icon: AppSvgIcon(
              'assets/figma/home_markets/deposit.svg',
              width: 20,
              height: 20,
            ),
            label: Text(l10n.deposit),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.actionPrimary),
              foregroundColor: WidgetStatePropertyAll(colors.textInverse),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
        if (showWithdraw) ...[
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => showWithdrawalSourceSheet(context),
              icon: AppSvgIcon(
                'assets/figma/home_markets/withdraw.svg',
                color: context.appColors.iconPrimary,
                width: 20,
                height: 20,
              ),
              label: Text(l10n.withdraw),
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LoggedOutPrompt extends StatelessWidget {
  const _LoggedOutPrompt({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 142,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onLogin,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.surfaceBase,
                  Color.alphaBlend(
                    colors.brandDefault.withValues(alpha: 0.14),
                    colors.surfaceBase,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 16,
                  right: 142,
                  top: 11,
                  bottom: 11,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 190,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.readyWhenYouAre,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.loginToViewPortfolio,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -11,
                  top: 26,
                  width: 126,
                  height: 126,
                  child: Image.asset(
                    'assets/figma/home_markets/login_prompt.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginAction extends StatelessWidget {
  const _LoginAction({required this.onLogin});

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    width: double.infinity,
    child: FilledButton(
      onPressed: onLogin,
      child: Text(AppLocalizations.of(context).logIn),
    ),
  );
}

class _MarketPreview extends ConsumerStatefulWidget {
  const _MarketPreview();
  @override
  ConsumerState<_MarketPreview> createState() => _MarketPreviewState();
}

class _MarketPreviewState extends ConsumerState<_MarketPreview> {
  bool _favoritesSelectedByUser = false;
  bool _popularFallbackScheduled = false;

  @override
  Widget build(BuildContext context) {
    final kind = ref.watch(marketProductTypeProvider).value;
    final authenticated =
        ref.watch(authenticationProvider) is AuthenticationAuthenticated;
    final selectedTab = effectiveMarketRankingTab(
      authenticated: authenticated,
      storedTab: ref.watch(marketRankingTabProvider).value,
    );
    final products = ref.watch(
      marketProductsProvider((
        query: null,
        cursor: null,
        group: marketProductGroupForTab(selectedTab),
        productType: kind,
      )),
    );
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarketProductFilter(
          value: kind,
          onChanged: (value) async {
            await ref.read(marketProductTypeProvider.notifier).select(value);
          },
        ),
        const SizedBox(height: 12),
        MarketRankingTabs(
          active: selectedTab,
          showFavorites: authenticated,
          onSelected: (tab) => setState(() {
            ref.read(marketRankingTabProvider.notifier).select(tab);
            if (tab == 'Favorites') _favoritesSelectedByUser = true;
          }),
        ),
        MarketListDataSource(kind: kind, tab: selectedTab),
        const SizedBox(height: 8),
        products.when(
          loading: () => const _HomeStateCard(height: 240),
          error: (error, _) => FailureState(
            error: error,
            height: 340,
            title: l10n.marketsLoadFailed,
            description: l10n.checkConnectionRetry,
            onRetry: () => ref.refresh(
              marketProductsProvider((
                query: null,
                cursor: null,
                group: marketProductGroupForTab(selectedTab),
                productType: kind,
              )).future,
            ),
          ),
          data: (page) {
            final items = page.items.cast<MarketProduct>();
            if (items.isEmpty) {
              if (selectedTab == 'Favorites') {
                if (!_favoritesSelectedByUser) {
                  _schedulePopularFallback();
                }
                return FavoritesEmptyState(
                  onExplore: () => _openMarkets('Popular'),
                );
              }
              return Container(
                height: 240,
                decoration: BoxDecoration(
                  color: colors.surfaceBase,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: DesignStateFeedback(
                  state: DesignState.empty,
                  title: l10n.noProductsYet,
                ),
              );
            }
            final visible = items.take(5).toList(growable: false);
            final showViewMore = items.length > visible.length || page.hasMore;
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: colors.surfaceBase,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  for (final product in visible) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: MarketProductRow(
                        product: product,
                        dense: true,
                        showVolume: selectedTab == 'Volume',
                        onTap: () => context.go(
                          AppRoutes.tradeLocation(
                            symbol: product.symbol,
                            kind: product.kind.name,
                          ),
                        ),
                      ),
                    ),
                    if (product != visible.last)
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: colors.borderSubtle,
                      ),
                  ],
                  if (showViewMore) ...[
                    Divider(height: 1, color: colors.borderSubtle),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: TextButton(
                        key: const Key('home-markets-view-more'),
                        onPressed: () => _openMarkets(selectedTab),
                        style: TextButton.styleFrom(
                          foregroundColor: colors.textSecondary,
                          shape: const RoundedRectangleBorder(),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            height: 16 / 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text(l10n.viewMore),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          skipLoadingOnRefresh: true,
        ),
      ],
    );
  }

  void _schedulePopularFallback() {
    if (_popularFallbackScheduled) return;
    _popularFallbackScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _popularFallbackScheduled = false;
      final authenticated =
          ref.read(authenticationProvider) is AuthenticationAuthenticated;
      final selectedTab = effectiveMarketRankingTab(
        authenticated: authenticated,
        storedTab: ref.read(marketRankingTabProvider).value,
      );
      if (!mounted || _favoritesSelectedByUser || selectedTab != 'Favorites') {
        return;
      }
      ref.read(marketRankingTabProvider.notifier).select('Popular');
    });
  }

  void _openMarkets(String tab) {
    unawaited(ref.read(marketRankingTabProvider.notifier).select(tab));
    context.goNamed(AppRoutes.marketsName);
  }
}

/// Keeps asynchronous fallback states inside the same Figma card geometry as
/// the loaded content, instead of letting the generic feedback pattern take
/// over the complete section.
class _HomeStateCard extends StatelessWidget {
  const _HomeStateCard({this.height = 142});

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: LoadingSkeleton(
      rows: height > 180 ? 2 : 1,
      padding: const EdgeInsets.all(16),
    ),
  );
}
