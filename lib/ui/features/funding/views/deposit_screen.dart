import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/ui/core/feedback/copyable_text.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
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
                        'Deposit',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/figma/funding/activity.svg',
                        width: 20,
                        height: 20,
                      ),
                      label: const Text('History'),
                    ),
                    IconButton(
                      tooltip: 'Close deposit routes',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a recommended route, or browse all supported assets.',
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
                      title: 'Deposit routes unavailable',
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
    final recommendedRoutes = routes
        .where((route) => route.isRecommended)
        .toList();
    final additionalRoutes = routes
        .where((route) => !route.isRecommended)
        .toList();
    return Column(
      children: [
        if (recommendedRoutes.isEmpty && additionalRoutes.isEmpty)
          const SizedBox(
            height: 120,
            child: EmptyState(
              illustration: false,
              title: 'No deposit routes available',
              description: 'Try again later.',
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
    return Semantics(
      button: true,
      label: 'Deposit ${route.token} on ${route.chain}',
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
              _AssetMark(asset: route.token, chain: route.chain),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${route.token} on ${route.chain}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Best for ${route.chain == 'BSC' ? 'bStocks' : 'HIP-3 Perps'}',
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
  const _AssetMark({required this.asset, required this.chain});
  final String asset;
  final String chain;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 40,
    height: 40,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        _tokenIcon(context),
        Positioned(
          right: -2,
          bottom: -2,
          child: SvgPicture.asset(_chainIcon(chain), width: 18, height: 18),
        ),
      ],
    ),
  );

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

  String _chainIcon(String value) => value == 'BSC'
      ? 'assets/figma/funding/bnb_chain.svg'
      : 'assets/figma/funding/arbitrum.svg';
}

class _AllAssetsTile extends StatelessWidget {
  const _AllAssetsTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
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
                  const Text(
                    'All supported assets',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Choose another available asset and network',
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
      return const Scaffold(
        body: SafeArea(
          child: DesignStateFeedback(
            state: DesignState.unavailable,
            title: 'Deposit route required',
            message: 'Choose a supported route to receive an address.',
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
          loading: () => const DesignStateFeedback(
            state: DesignState.loading,
            title: 'Loading deposit instructions',
          ),
          error: (_, _) => DesignStateFeedback(
            state: DesignState.failure,
            title: 'Deposit instructions unavailable',
            message: 'Return to deposit routes and try again.',
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
                'Deposit Assets',
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
                'Deposit received !',
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
                child: const Text('Got it'),
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
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Back to deposit routes',
              onPressed: () => context.pop(),
              icon: Transform.rotate(
                angle: 3.141592653589793,
                child: SvgPicture.asset(
                  'assets/figma/funding/back.svg',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            Text(
              'Deposit ${instruction.token}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
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
              semanticsLabel: 'Deposit QR code',
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text('Deposit Address'),
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
              semanticLabel: 'Deposit address',
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
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _RouteValue(
            label: 'Network',
            value: instruction.chain,
            asset: instruction.chain == 'BSC'
                ? 'assets/figma/funding/bnb_chain.svg'
                : 'assets/figma/funding/arbitrum.svg',
          ),
          Divider(height: 1, color: colors.border),
          _RouteValue(
            label: 'Token',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Route details', style: TextStyle(color: colors.secondaryText)),
        const SizedBox(height: 4),
        Text(
          'Send ${instruction.token} on ${instruction.chain} only.',
          style: TextStyle(color: colors.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _DetailRow(
          label: 'Minimum deposit',
          value: '${instruction.minimumAmount.value} ${instruction.token}',
        ),
        const SizedBox(height: 8),
        _DetailRow(
          label: 'Estimated arrival',
          value: '${instruction.estimatedArrivalSeconds}s',
        ),
        const SizedBox(height: 8),
        _DetailRow(
          label: 'Confirmations required',
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

class _DepositSelector extends ConsumerWidget {
  const _DepositSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(depositRoutesProvider);
    return Scaffold(
      body: SafeArea(
        child: routes.when(
          loading: () => const DesignStateFeedback(
            state: DesignState.loading,
            title: 'Loading supported assets',
          ),
          error: (_, _) => DesignStateFeedback(
            state: DesignState.failure,
            title: 'Supported assets unavailable',
            onRetry: () => ref.refresh(depositDirectoryProvider.future),
          ),
          data: (value) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Back to deposit routes',
                      onPressed: () => context.pop(),
                      icon: Transform.rotate(
                        angle: 3.141592653589793,
                        child: SvgPicture.asset(
                          'assets/figma/funding/back.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    Text(
                      'Deposit crypto',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                for (final route in value) ...[
                  _DepositRouteTile(route: route),
                  const SizedBox(height: 12),
                ],
                if (value.isEmpty) ...[
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/figma/funding/deposit_empty.png',
                    width: 160,
                    height: 160,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No additional deposit routes available',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
