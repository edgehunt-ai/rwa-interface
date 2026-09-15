import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/failure_state.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/layout/app_bottom_navigation.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';
import 'package:rwa_interface/ui/features/session/views/privy_login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authentication = ref.watch(authenticationProvider);
    final authenticated = authentication is AuthenticationAuthenticated;
    final initializing = authentication is AuthenticationInitializing;
    final portfolio = authenticated
        ? ref.watch(portfolioSummaryProvider)
        : null;
    final portfolioValue = portfolio?.maybeWhen(
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
                  productType: null,
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
                onSettings: authenticated
                    ? () => context.pushNamed(AppRoutes.settingsName)
                    : null,
              ),
              const SizedBox(height: 12),
              if (authenticated)
                portfolio!.when(
                  loading: () => const _HomeStateCard(),
                  error: (_, _) => FailureState(
                    title: AppLocalizations.of(context).portfolioUnavailable,
                    description: AppLocalizations.of(context)
                        .checkConnectionRetry,
                    onRetry: () => ref.refresh(portfolioSummaryProvider.future),
                  ),
                  data: (value) => _PortfolioCard(portfolio: value),
                )
              else if (initializing)
                const _HomeStateCard()
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
                  : _LoginAction(onLogin: () => _openLogin(context)),
              const SizedBox(height: 12),
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
  const _UtilityBar({required this.onSearch, this.onSettings});
  final VoidCallback onSearch;
  final VoidCallback? onSettings;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onSettings != null)
            IconButton(
              tooltip: l10n.openSettings,
              onPressed: onSettings,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.border),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/figma/home_markets/account_avatar.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Container(
            width: 100,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              'Logo',
              style: TextStyle(
                color: colors.tertiaryText,
                fontSize: 13,
                height: 18 / 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onSettings == null) const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              tooltip: l10n.searchMarkets,
              onPressed: onSearch,
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/figma/home_markets/search.svg',
                width: 20,
                height: 20,
              ),
            ),
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
    final positive = !(pnl?.value.startsWith('-') ?? false);
    return Container(
      height: 142,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).homePortfolio,
            style: TextStyle(
              color: colors.secondaryText,
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TokenAmountFormatter.formatUsd(portfolio.totalValueUsd),
            style: TextStyle(
              color: colors.primaryText,
              fontSize: 32,
              height: 38 / 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            pnl == null ? 'No performance yet' : '${_formatPnl(pnl)} today',
            style: TextStyle(
              color: pnl == null
                  ? colors.secondaryText
                  : positive
                  ? semantic.success
                  : semantic.loss,
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
    final formatted = TokenAmountFormatter.formatUsd(value);
    return value.value.startsWith('-') || value.value == '0'
        ? formatted
        : '+$formatted';
  }
}

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
            icon: SvgPicture.asset(
              'assets/figma/home_markets/deposit.svg',
              width: 20,
              height: 20,
            ),
            label: Text(l10n.deposit),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.primaryAction),
              foregroundColor: WidgetStatePropertyAll(colors.onPrimaryAction),
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
              onPressed: () =>
                  context.pushNamed(AppRoutes.withdrawalSelectName),
              icon: SvgPicture.asset(
                'assets/figma/home_markets/withdraw.svg',
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
        child: InkWell(
          onTap: onLogin,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            padding: const EdgeInsets.fromLTRB(16, 11, 14, 11),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFFFD7F7)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            ?.copyWith(color: colors.secondaryText),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/figma/home_markets/login_prompt.png',
                  width: 112,
                  height: 112,
                  fit: BoxFit.cover,
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
  MarketProductKind? kind;
  bool _favoritesSelectedByUser = false;
  bool _popularFallbackScheduled = false;

  @override
  Widget build(BuildContext context) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.marketsTitle,
              style: TextStyle(
                color: colors.primaryText,
                fontSize: 20,
                height: 26 / 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            MarketProductFilter(
              value: kind,
              onChanged: (value) => setState(() => kind = value),
            ),
          ],
        ),
        const SizedBox(height: 8),
        MarketRankingTabs(
          active: selectedTab,
          showFavorites: authenticated,
          onSelected: (tab) => setState(() {
            ref.read(marketRankingTabProvider.notifier).select(tab);
            if (tab == 'Favorites') _favoritesSelectedByUser = true;
          }),
        ),
        const SizedBox(height: 8),
        products.when(
          loading: () => const _HomeStateCard(height: 240),
          error: (_, _) => FailureState(
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
                  onExplore: () => ref
                      .read(marketRankingTabProvider.notifier)
                      .select('Popular'),
                );
              }
              return Container(
                height: 240,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: DesignStateFeedback(
                  state: DesignState.empty,
                  title: l10n.noProductsYet,
                ),
              );
            }
            final visible = items.take(5).toList(growable: false);
            return Container(
              decoration: BoxDecoration(
                color: colors.surface,
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
                        onTap: () => context.push(
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
                        color: colors.border,
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
