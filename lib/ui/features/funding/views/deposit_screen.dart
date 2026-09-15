import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/copyable_text.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/navigation/app_page_header.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

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
              router.pushNamed(AppRoutes.depositSelectName);
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
    return Semantics(
      button: true,
      label: l10n.depositOn(route.token, route.chain),
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
              _AssetMark(asset: route.token),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.depositOn(route.token, route.chain),
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

class _AssetMark extends StatelessWidget {
  const _AssetMark({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: 40, height: 40, child: _tokenIcon(context));

  Widget _tokenIcon(BuildContext context) {
    if (asset == 'USDC') {
      return SvgPicture.asset(
        'assets/figma/funding/usdc.svg',
        width: 40,
        height: 40,
      );
    }
    if (asset == 'USDT') {
      return Image.asset(
        'assets/figma/funding/usdt.png',
        width: 40,
        height: 40,
      );
    }
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        shape: BoxShape.circle,
      ),
      child: Text(asset, style: const TextStyle(fontWeight: FontWeight.w600)),
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
  const DepositScreen({
    super.key,
    this.showSelector = false,
    this.chain,
    this.token,
  });
  final bool showSelector;
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
    final showSelector = widget.showSelector;
    final chain = widget.chain;
    final token = widget.token;
    if (showSelector) return const _DepositSelector();
    if (chain == null || token == null) {
      return Scaffold(
        body: SafeArea(
          child: DesignStateFeedback(
            state: DesignState.unavailable,
            title: AppLocalizations.of(context).depositRouteRequired,
            message: AppLocalizations.of(context)
                .depositRouteRequiredDescription,
          ),
        ),
      );
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
          error: (_, _) => DesignStateFeedback(
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
      await showDepositReceivedSheet(context, change: change);
      if (mounted) _presentingReceipt = false;
    });
  }
}

Future<void> showDepositReceivedSheet(
  BuildContext context, {
  required DepositBalanceChange change,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => _DepositReceivedSheet(change: change),
);

class _DepositReceivedSheet extends StatelessWidget {
  const _DepositReceivedSheet({required this.change});
  final DepositBalanceChange change;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
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
                'assets/figma/funding/deposit_received.png',
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.depositReceived,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '+ ${TokenAmountFormatter.format(change.amount, symbol: change.token)} (${change.chain})',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.secondaryText),
              ),
              const SizedBox(height: 16),
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
          title: l10n.depositOn(instruction.token, instruction.chain),
          onBack: () => context.pop(),
        ),
        const SizedBox(height: 40),
        _ReadonlyRoute(instruction: instruction),
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
              data: instruction.qrPayload,
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
          padding: const EdgeInsets.only(left: 16, right: 8),
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

class _ReadonlyRoute extends StatelessWidget {
  const _ReadonlyRoute({required this.instruction});
  final DepositInstruction instruction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _RouteValue(
            label: l10n.network,
            value: instruction.chain,
            asset: instruction.chain == 'BSC'
                ? 'assets/figma/funding/bnb_chain.svg'
                : 'assets/figma/funding/arbitrum.svg',
          ),
          Divider(height: 1, color: colors.border),
          _RouteValue(
            label: l10n.token,
            value: instruction.token,
            asset: 'assets/figma/funding/usdc.svg',
          ),
        ],
      ),
    );
  }
}

class _RouteValue extends StatelessWidget {
  const _RouteValue({
    required this.label,
    required this.value,
    required this.asset,
  });
  final String label;
  final String value;
  final String asset;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 51,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          SvgPicture.asset(asset, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

class _RouteDetails extends StatelessWidget {
  const _RouteDetails({required this.instruction});
  final DepositInstruction instruction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.routeDetails, style: TextStyle(color: colors.secondaryText)),
        const SizedBox(height: 4),
        Text(
          l10n.sendTokenOnChainOnly(instruction.token, instruction.chain),
          style: TextStyle(color: colors.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _DetailRow(
          label: l10n.minimumDeposit,
          value: '${instruction.minimumAmount.value} ${instruction.token}',
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
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyle(color: colors.secondaryText)),
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _DepositSelector extends ConsumerStatefulWidget {
  const _DepositSelector();

  @override
  ConsumerState<_DepositSelector> createState() => _DepositSelectorState();
}

class _DepositSelectorState extends ConsumerState<_DepositSelector> {
  String? _selectedChain;
  String? _selectedToken;

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
          error: (_, _) => DesignStateFeedback(
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
                    _selectedChain = chain;
                    _selectedToken = null;
                  }),
                  onTokenSelected: (token) {
                    setState(() => _selectedToken = token);
                    context.pushNamed(
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
                    'assets/figma/funding/deposit_empty.png',
                    width: 160,
                    height: 160,
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
            label: AppLocalizations.of(context).network,
            value: chain ?? 'Choose Network',
            valueColor: chain == null ? colors.primaryText : colors.primaryText,
            onTap: () => _showOptions(
              context,
              title: AppLocalizations.of(context).network,
              options: chains,
              onSelected: onChainSelected,
            ),
          ),
          Divider(height: 1, color: colors.subtleSurface),
          _SelectionRow(
            label: AppLocalizations.of(context).token,
            value: token ?? 'Choose network first',
            valueColor: chain == null
                ? colors.secondaryText
                : colors.primaryText,
            enabled: chain != null,
            onTap: chain == null
                ? null
                : () => _showOptions(
                    context,
                    title: AppLocalizations.of(context).token,
                    options: tokens,
                    onSelected: onTokenSelected,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _showOptions(
    BuildContext context, {
    required String title,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(title: Text(title)),
            for (final option in options)
              ListTile(
                title: Text(option),
                onTap: () => Navigator.of(context).pop(option),
              ),
          ],
        ),
      ),
    );
    if (selected != null) onSelected(selected);
  }
}

class _SelectionRow extends StatelessWidget {
  const _SelectionRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final String value;
  final Color valueColor;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: enabled ? onTap : null,
    child: SizedBox(
      height: 51,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text(label)),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: value.startsWith('Choose')
                      ? null
                      : FontWeight.w600,
                ),
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
