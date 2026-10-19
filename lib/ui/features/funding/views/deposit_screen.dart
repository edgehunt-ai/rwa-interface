import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/deposit.dart';
import 'package:nobell/domain/models/funding_catalog.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/copyable_text.dart';
import 'package:nobell/ui/core/feedback/design_state_feedback.dart';
import 'package:nobell/ui/core/feedback/empty_state.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/navigation/app_page_header.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

Future<void> showDepositRoutesSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DepositRoutesSheet(),
    );

class DepositRoutesSheet extends ConsumerWidget {
  const DepositRoutesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(depositRoutesProvider);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      top: false,
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: colors.subtleSurface,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.deposit,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        final router = GoRouter.of(context);
                        Navigator.of(context).pop();
                        router.go('${AppRoutes.activityPath}?tab=cash');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: colors.secondaryText,
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: SvgPicture.asset(
                        'assets/figma/funding/activity.svg',
                        width: 20,
                        height: 20,
                      ),
                      label: Text(l10n.history),
                    ),
                    IconButton(
                      tooltip: l10n.closeDepositRoutes,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.depositChooseRoute,
                  style: TextStyle(color: colors.secondaryText),
                ),
                const SizedBox(height: 12),
                routes.when(
                  loading: () => const LoadingSkeleton(
                    rows: 2,
                    padding: EdgeInsets.only(top: 12),
                  ),
                  error: (error, _) => SizedBox(
                    height: 340,
                    child: DesignStateFeedback(
                      error: error,
                      state: DesignState.failure,
                      title: l10n.depositRoutesUnavailable,
                      message: error.toString(),
                      onRetry: () =>
                          ref.refresh(depositDirectoryProvider.future),
                    ),
                  ),
                  data: _DepositRouteList.new,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DepositRouteList extends StatelessWidget {
  const _DepositRouteList(this.routes);
  final List<DepositRoute> routes;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recommendedRoutes = routes
        .where((route) => route.isRecommended)
        .toList();
    final additionalRoutes = routes
        .where((route) => !route.isRecommended)
        .toList();
    return Column(
      children: [
        if (recommendedRoutes.isEmpty && additionalRoutes.isEmpty)
          SizedBox(
            height: 120,
            child: EmptyState(
              illustration: false,
              title: l10n.noDepositRoutes,
              description: l10n.tryAgainLater,
            ),
          )
        else
          for (final route in recommendedRoutes) ...[
            _DepositRouteTile(route: route),
            const SizedBox(height: 12),
          ],
        if (additionalRoutes.isNotEmpty)
          _AllAssetsTile(
            onTap: () {
              final router = GoRouter.of(context);
              Navigator.of(context).pop();
              router.pushNamed(AppRoutes.depositName);
            },
          ),
      ],
    );
  }
}

class _DepositRouteTile extends ConsumerWidget {
  const _DepositRouteTile({required this.route});
  final DepositRoute route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final tokenIcon = _depositTokenIcon(route.token, size: 40);
    return Semantics(
      button: true,
      label: l10n.depositOn(route.token, networkDisplayName(route.chain)),
      child: InkWell(
        onTap: () {
          final router = GoRouter.of(context);
          ref.read(
            depositInstructionProvider((
              chain: route.chain,
              token: route.token,
            )),
          );
          Navigator.of(context).pop();
          router.pushNamed(
            AppRoutes.depositName,
            queryParameters: {'chain': route.chain, 'token': route.token},
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 72,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              if (tokenIcon != null) ...[tokenIcon, const SizedBox(width: 12)],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.depositOn(
                        route.token,
                        networkDisplayName(route.chain),
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      l10n.bestFor(
                        route.chain == 'BSC' ? 'bStocks' : l10n.hip3Perps,
                      ),
                      style: TextStyle(
                        color: colors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/figma/funding/chevron_right.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllAssetsTile extends StatelessWidget {
  const _AllAssetsTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const _SupportedAssetMark(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.allSupportedAssets,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    l10n.allSupportedAssetsDescription,
                    style: TextStyle(color: colors.secondaryText, fontSize: 12),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/figma/funding/chevron_right.svg',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportedAssetMark extends StatelessWidget {
  const _SupportedAssetMark();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 40,
    height: 40,
    child: Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (var index = 1; index <= 4; index++)
          SvgPicture.asset(
            'assets/figma/funding/supported_asset_$index.svg',
            width: 18,
            height: 18,
          ),
      ],
    ),
  );
}

class DepositScreen extends ConsumerStatefulWidget {
  const DepositScreen({super.key, this.chain, this.token});
  final String? chain;
  final String? token;

  @override
  ConsumerState<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends ConsumerState<DepositScreen> {
  final Set<String> _handledBalanceEvents = {};
  bool _presentingReceipt = false;

  @override
  Widget build(BuildContext context) {
    final chain = widget.chain;
    final token = widget.token;
    if (chain == null || token == null) {
      return _DepositSelector(initialChain: chain);
    }
    final route = (chain: chain, token: token);
    final instruction = ref.watch(depositInstructionProvider(route));
    ref.listen<AsyncValue<DepositBalanceChange>>(
      depositBalanceChangesProvider(route),
      (_, next) => next.whenData(_handleBalanceChange),
    );
    return Scaffold(
      body: SafeArea(
        child: instruction.when(
          loading: () => DesignStateFeedback(
            state: DesignState.loading,
            title: AppLocalizations.of(context).loadingDepositInstructions,
          ),
          error: (error, _) => DesignStateFeedback(
            error: error,
            state: DesignState.failure,
            title: AppLocalizations.of(context).depositInstructionsUnavailable,
            message: AppLocalizations.of(context).returnToDepositRoutes,
            onRetry: () {
              ref.invalidate(depositDirectoryProvider);
              ref.invalidate(depositInstructionProvider(route));
            },
          ),
          data: (value) => _DepositInstructions(instruction: value),
        ),
      ),
    );
  }

  void _handleBalanceChange(DepositBalanceChange change) {
    if (_presentingReceipt || !_handledBalanceEvents.add(change.eventId)) {
      return;
    }
    _presentingReceipt = true;
    ref.invalidate(portfolioSummaryProvider);
    ref.invalidate(tradingAccountsProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final transferToPerps = await showDepositReceivedSheet(
        context,
        change: change,
      );
      if (!mounted) return;
      _presentingReceipt = false;
      if (transferToPerps) {
        context.goNamed(
          AppRoutes.transferName,
          queryParameters: {'token': change.token, 'network': change.chain},
        );
      }
    });
  }
}

Future<bool> showDepositReceivedSheet(
  BuildContext context, {
  required DepositBalanceChange change,
}) async {
  return await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => _DepositReceivedSheet(change: change),
      ) ??
      false;
}

class _DepositReceivedSheet extends StatelessWidget {
  const _DepositReceivedSheet({required this.change});
  final DepositBalanceChange change;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final canTransferToPerps =
        change.chain.trim().toLowerCase() == 'arbitrum' &&
        change.token.trim().toUpperCase() == 'USDC';
    return SafeArea(
      top: false,
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.secondaryText.withValues(alpha: .45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.depositAssets,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Image.asset(
                'assets/figma/funding/deposit_received.webp',
                width: 120,
                height: 120,
              ),
              if (canTransferToPerps) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.depositReceivedTitle(
                    '${change.amount.value} ${change.token}',
                    networkDisplayName(change.chain),
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    height: 26 / 20,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    l10n.depositReceivedDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.secondaryText,
                      fontSize: 15,
                      height: 22 / 15,
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 8),
                Text(
                  l10n.depositReceived,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 17,
                    height: 22 / 17,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '+ ${TokenAmountFormatter.format(change.amount, symbol: change.token)} (${networkDisplayName(change.chain)})',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.secondaryText,
                    fontSize: 13,
                    height: 18 / 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              if (canTransferToPerps) ...[
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    key: const ValueKey('deposit-received-transfer'),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(l10n.transferToPerpsAccount),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    key: const ValueKey('deposit-received-maybe-later'),
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colors.subtleSurface,
                      foregroundColor: colors.primaryText,
                      side: BorderSide(color: colors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(l10n.maybeLater),
                  ),
                ),
              ] else
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.gotIt),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DepositInstructions extends StatelessWidget {
  const _DepositInstructions({required this.instruction});
  final DepositInstruction instruction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        AppPageHeader(
          title: l10n.depositOn(
            instruction.token,
            networkDisplayName(instruction.chain),
          ),
          onBack: () => context.pop(),
        ),
        const SizedBox(height: 40),
        _EditableRoute(instruction: instruction),
        const SizedBox(height: 32),
        Center(
          child: Container(
            height: 176,
            width: 176,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: QrImageView(
              key: const ValueKey('deposit-qr'),
              data: instruction.address,
              size: 160,
              backgroundColor: colors.subtleSurface,
              semanticsLabel: l10n.depositQrCode,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(l10n.depositAddress),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
          decoration: BoxDecoration(
            color: colors.subtleSurface,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CopyableText(
              value: instruction.address,
              shorten: false,
              wrap: true,
              selectable: true,
              semanticLabel: l10n.depositAddress,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _RouteDetails(instruction: instruction),
      ],
    );
  }
}

class _EditableRoute extends ConsumerWidget {
  const _EditableRoute({required this.instruction});
  final DepositInstruction instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableRoutes = ref.watch(depositRoutesProvider).value ?? const [];
    final chains = availableRoutes
        .map((route) => route.chain)
        .followedBy([instruction.chain])
        .toSet()
        .toList();
    final tokens = availableRoutes
        .where((route) => route.chain == instruction.chain)
        .map((route) => route.token)
        .followedBy([instruction.token])
        .toSet()
        .toList();
    return _DepositSelectionCard(
      chain: instruction.chain,
      token: instruction.token,
      chains: chains,
      tokens: tokens,
      onChainSelected: (chain) {
        if (chain == instruction.chain) return;
        context.replaceNamed(
          AppRoutes.depositName,
          queryParameters: {'chain': chain},
        );
      },
      onTokenSelected: (token) {
        if (token == instruction.token) return;
        context.replaceNamed(
          AppRoutes.depositName,
          queryParameters: {'chain': instruction.chain, 'token': token},
        );
      },
    );
  }
}

Widget? _depositNetworkIcon(String network, {double size = 24}) {
  final asset = networkIconAssetPath(network);
  return asset == null
      ? null
      : SvgPicture.asset(
          asset,
          key: ValueKey('deposit-network-icon-${network.toLowerCase()}'),
          width: size,
          height: size,
        );
}

Widget? _depositTokenIcon(String token, {double size = 24}) =>
    switch (token.trim().toUpperCase()) {
      'USDC' => SvgPicture.asset(
        'assets/figma/funding/usdc.svg',
        key: const ValueKey('deposit-token-icon-usdc'),
        width: size,
        height: size,
      ),
      'USDT' => Image.asset(
        'assets/figma/funding/usdt.png',
        key: const ValueKey('deposit-token-icon-usdt'),
        width: size,
        height: size,
      ),
      'ETH' => SvgPicture.asset(
        'assets/figma/funding/eth.svg',
        key: const ValueKey('deposit-token-icon-eth'),
        width: size,
        height: size,
      ),
      'BNB' => SvgPicture.asset(
        NetworkIconAssets.bsc,
        key: const ValueKey('deposit-token-icon-bnb'),
        width: size,
        height: size,
      ),
      _ => null,
    };

Widget? _depositNetworkMenuIcon(String network) {
  final kind = networkKind(network);
  if (kind == NetworkKind.arbitrum || kind == NetworkKind.ethereum) {
    final isArbitrum = kind == NetworkKind.arbitrum;
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: isArbitrum ? const Color(0xFF2F3749) : const Color(0xFF627EEA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: SvgPicture.asset(
          networkIconAssetPath(network, variant: NetworkIconVariant.mark)!,
          width: isArbitrum ? 10.7122 : 7.49905,
          height: isArbitrum ? 12 : 11.9981,
        ),
      ),
    );
  }
  final asset = switch (kind) {
    NetworkKind.bsc => 'assets/figma/funding/deposit_network_bsc.svg',
    NetworkKind.polygon => 'assets/figma/funding/deposit_network_polygon.svg',
    _ => null,
  };
  return asset == null
      ? _depositNetworkIcon(network, size: 16)
      : SvgPicture.asset(asset, width: 16, height: 16);
}

class _RouteDetails extends ConsumerWidget {
  const _RouteDetails({required this.instruction});
  final DepositInstruction instruction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final balance = ref.watch(
      depositCurrentBalanceProvider((
        chain: instruction.chain,
        token: instruction.token,
      )),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.routeDetails, style: TextStyle(color: colors.secondaryText)),
        const SizedBox(height: 4),
        Text(
          l10n.sendTokenOnChainOnly(
            instruction.token,
            networkDisplayName(instruction.chain),
          ),
          style: TextStyle(color: colors.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _DetailRow(
          label: l10n.balance,
          value: balance == null
              ? null
              : '${TokenAmountFormatter.formatValue(balance)} ${instruction.token}',
          trailing: balance == null
              ? const SkeletonBlock(
                  key: ValueKey('deposit-balance-skeleton'),
                  width: 72,
                  height: 16,
                  radius: 4,
                )
              : null,
        ),
        const SizedBox(height: 8),
        _DetailRow(
          label: l10n.minimumDeposit,
          value:
              '${TokenAmountFormatter.formatValue(instruction.minimumAmount)} ${instruction.token}',
        ),
        const SizedBox(height: 8),
        _DetailRow(
          label: l10n.estimatedArrival,
          value: '${instruction.estimatedArrivalSeconds}s',
        ),
        const SizedBox(height: 8),
        _DetailRow(
          label: l10n.confirmationsRequired,
          value: '${instruction.confirmationsRequired}',
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, this.value, this.trailing})
    : assert(value != null || trailing != null);
  final String label;
  final String? value;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyle(color: colors.secondaryText)),
        ),
        trailing ??
            Text(value!, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _DepositSelector extends ConsumerStatefulWidget {
  const _DepositSelector({this.initialChain});

  final String? initialChain;

  @override
  ConsumerState<_DepositSelector> createState() => _DepositSelectorState();
}

class _DepositSelectorState extends ConsumerState<_DepositSelector> {
  String? _selectedChain;
  String? _selectedToken;

  @override
  void initState() {
    super.initState();
    _selectedChain = widget.initialChain;
  }

  @override
  Widget build(BuildContext context) {
    final routes = ref.watch(depositRoutesProvider);
    return Scaffold(
      body: SafeArea(
        child: routes.when(
          loading: () => DesignStateFeedback(
            state: DesignState.loading,
            title: AppLocalizations.of(context).loadingSupportedAssets,
          ),
          error: (error, _) => DesignStateFeedback(
            error: error,
            state: DesignState.failure,
            title: AppLocalizations.of(context).supportedAssetsUnavailable,
            onRetry: () => ref.refresh(depositDirectoryProvider.future),
          ),
          data: (value) {
            final chains = value.map((route) => route.chain).toSet().toList();
            final tokens = value
                .where((route) => route.chain == _selectedChain)
                .map((route) => route.token)
                .toSet()
                .toList();
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              children: [
                AppPageHeader(
                  title: AppLocalizations.of(context).depositCrypto,
                  onBack: () => context.pop(),
                ),
                const SizedBox(height: 40),
                _DepositSelectionCard(
                  chain: _selectedChain,
                  token: _selectedToken,
                  chains: chains,
                  tokens: tokens,
                  onChainSelected: (chain) => setState(() {
                    if (_selectedChain == chain) return;
                    _selectedChain = chain;
                    _selectedToken = null;
                  }),
                  onTokenSelected: (token) {
                    setState(() => _selectedToken = token);
                    context.replaceNamed(
                      AppRoutes.depositName,
                      queryParameters: {
                        'chain': _selectedChain!,
                        'token': token,
                      },
                    );
                  },
                ),
                const SizedBox(height: 60),
                Center(
                  child: Image.asset(
                    'assets/figma/funding/deposit_empty.webp',
                    width: 120,
                    height: 120,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Choose a token and network',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your deposit address will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context)
                        .extension<AppRwaColors>()!
                        .primaryText,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DepositSelectionCard extends StatelessWidget {
  const _DepositSelectionCard({
    required this.chain,
    required this.token,
    required this.chains,
    required this.tokens,
    required this.onChainSelected,
    required this.onTokenSelected,
  });

  final String? chain;
  final String? token;
  final List<String> chains;
  final List<String> tokens;
  final ValueChanged<String> onChainSelected;
  final ValueChanged<String> onTokenSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _SelectionRow(
            key: const ValueKey('deposit-network-selector'),
            label: AppLocalizations.of(context).network,
            value: chain == null
                ? 'Choose Network'
                : networkDisplayName(chain!),
            valueColor: colors.primaryText,
            icon: chain == null ? null : _depositNetworkIcon(chain!),
            showArrow: chain == null,
            arrowKey: const ValueKey('deposit-network-selector-arrow'),
            options: chains,
            selectedValue: chain,
            optionKeyPrefix: 'deposit-network-option',
            optionIconBuilder: _depositNetworkMenuIcon,
            optionLabelBuilder: networkDisplayName,
            onSelected: onChainSelected,
          ),
          Divider(height: 1, color: colors.subtleSurface),
          _SelectionRow(
            key: const ValueKey('deposit-token-selector'),
            label: AppLocalizations.of(context).token,
            value: token ?? 'Choose network first',
            valueColor: chain == null
                ? colors.secondaryText
                : colors.primaryText,
            icon: token == null ? null : _depositTokenIcon(token!),
            showArrow: token == null,
            arrowKey: const ValueKey('deposit-token-selector-arrow'),
            enabled: chain != null,
            options: tokens,
            selectedValue: token,
            optionKeyPrefix: 'deposit-token-option',
            optionIconBuilder: (value) => _depositTokenIcon(value, size: 16),
            onSelected: onTokenSelected,
          ),
        ],
      ),
    );
  }
}

class _SelectionRow extends StatelessWidget {
  const _SelectionRow({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.showArrow,
    required this.arrowKey,
    required this.options,
    required this.selectedValue,
    required this.optionKeyPrefix,
    required this.optionIconBuilder,
    required this.onSelected,
    this.icon,
    this.enabled = true,
    this.optionLabelBuilder,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool showArrow;
  final Key arrowKey;
  final List<String> options;
  final String? selectedValue;
  final String optionKeyPrefix;
  final Widget? Function(String) optionIconBuilder;
  final ValueChanged<String> onSelected;
  final Widget? icon;
  final bool enabled;
  final String Function(String)? optionLabelBuilder;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: enabled && options.isNotEmpty ? () => _showOptions(context) : null,
    child: SizedBox(
      height: 51,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text(label)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Flexible(
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: valueColor,
                        fontWeight: value.startsWith('Choose')
                            ? null
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow) ...[
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/figma/funding/chevron_right.svg',
                key: arrowKey,
                width: 20,
                height: 20,
              ),
            ],
          ],
        ),
      ),
    ),
  );

  Future<void> _showOptions(BuildContext context) async {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final row = context.findRenderObject()! as RenderBox;
    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    RelativeRect position() {
      final anchor = row.localToGlobal(
        Offset(row.size.width - 16, row.size.height - 4),
        ancestor: overlay,
      );
      return RelativeRect.fromRect(
        anchor & Size.zero,
        Offset.zero & overlay.size,
      );
    }

    var lastPosition = position();
    final selected = await showMenu<String>(
      context: context,
      semanticLabel: label,
      positionBuilder: (_, _) {
        // Route replacement can detach the row during the closing animation.
        if (row.attached && overlay.attached) lastPosition = position();
        return lastPosition;
      },
      color: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      constraints: const BoxConstraints.tightFor(width: 240),
      menuPadding: const EdgeInsets.all(4),
      items: [
        for (final option in options)
          PopupMenuItem<String>(
            key: ValueKey('$optionKeyPrefix-$option'),
            value: option,
            height: 44,
            padding: EdgeInsets.zero,
            child: Semantics(
              selected: option == selectedValue,
              child: Container(
                constraints: const BoxConstraints(minHeight: 44),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: option == selectedValue ? colors.selectedSoft : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (optionIconBuilder(option) case final icon?) ...[
                      icon,
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        optionLabelBuilder?.call(option) ?? option,
                        style: TextStyle(
                          color: option == selectedValue
                              ? colors.primaryText
                              : colors.secondaryText,
                          fontSize: 15,
                          height: 22 / 15,
                          fontWeight: option == selectedValue
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
    if (context.mounted && selected != null) onSelected(selected);
  }
}
