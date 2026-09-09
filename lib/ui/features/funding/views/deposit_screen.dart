import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/ui/core/feedback/copyable_text.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/empty_state.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

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
    final catalog = ref.watch(fundingCatalogProvider);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SafeArea(
      top: false,
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
              catalog.when(
                loading: () => const SizedBox(
                  height: 160,
                  child: DesignStateFeedback(
                    state: DesignState.loading,
                    title: 'Loading deposit routes',
                  ),
                ),
                error: (_, _) => SizedBox(
                  height: 340,
                  child: DesignStateFeedback(
                    state: DesignState.failure,
                    title: 'Deposit routes unavailable',
                    message: 'Try again when your account connection recovers.',
                    onRetry: () => ref.refresh(fundingCatalogProvider),
                  ),
                ),
                data: (value) => _DepositRouteList(catalog: value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DepositRouteList extends StatelessWidget {
  const _DepositRouteList({required this.catalog});
  final FundingCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final routes = catalog.rails.take(2).toList(growable: false);
    return Column(
      children: [
        if (routes.isEmpty)
          const SizedBox(
            height: 120,
            child: EmptyState(
              illustration: false,
              title: 'No deposit routes available',
              description: 'Try again later.',
            ),
          )
        else
          for (final route in routes) ...[
            _DepositRouteTile(route: route),
            const SizedBox(height: 12),
          ],
        _AllAssetsTile(
          onTap: () {
            Navigator.of(context).pop();
            context.pushNamed(AppRoutes.depositSelectName);
          },
        ),
      ],
    );
  }
}

class _DepositRouteTile extends StatelessWidget {
  const _DepositRouteTile({required this.route});
  final FundingRail route;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: true,
      label: 'Deposit ${route.settlementAsset} on ${route.network}',
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          context.pushNamed(AppRoutes.depositName);
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
              _AssetMark(asset: route.settlementAsset),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${route.settlementAsset} on ${route.network}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Best for ${route.kind == FundingRailKind.bstock ? 'bStocks' : 'HIP-3 Perps'}',
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
  Widget build(BuildContext context) {
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
    return Semantics(
      button: true,
      label: 'All supported assets',
      child: InkWell(
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
                      'Choose any supported asset and network',
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

class DepositScreen extends ConsumerWidget {
  const DepositScreen({super.key, this.showSelector = false});
  final bool showSelector;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (showSelector) return const _DepositSelector();
    final deposits = ref.watch(depositsProvider(null));
    return Scaffold(
      body: SafeArea(
        child: deposits.when(
          loading: () => const DesignStateFeedback(
            state: DesignState.loading,
            title: 'Loading deposit instructions',
          ),
          error: (_, _) => DesignStateFeedback(
            state: DesignState.failure,
            title: 'Deposit instructions unavailable',
            message: 'Return to deposit routes and try again.',
            onRetry: () => ref.refresh(depositsProvider(null)),
          ),
          data: (page) {
            final deposit = _preferredDeposit(page.items);
            if (deposit == null) {
              return const DesignStateFeedback(
                state: DesignState.unavailable,
                title: 'Deposit instructions unavailable',
                message: 'Choose a supported route to receive an address.',
              );
            }
            return _DepositInstructions(deposit: deposit);
          },
        ),
      ),
    );
  }

  Deposit? _preferredDeposit(List<ResourceResult<Deposit>> items) {
    for (final item in items) {
      if (item.resource.token == 'USDC' && item.resource.chain == 'Arbitrum') {
        return item.resource;
      }
    }
    return items.isEmpty ? null : items.first.resource;
  }
}

class _DepositInstructions extends StatelessWidget {
  const _DepositInstructions({required this.deposit});
  final Deposit deposit;

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
              'Deposit ${deposit.token}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _ReadonlyRoute(deposit: deposit),
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
            child: SvgPicture.asset('assets/figma/funding/deposit_qr.svg'),
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
              value: deposit.instructions.address,
              shorten: false,
              semanticLabel: 'Deposit address',
            ),
          ),
        ),
        const SizedBox(height: 32),
        _RouteDetails(deposit: deposit),
      ],
    );
  }
}

class _ReadonlyRoute extends StatelessWidget {
  const _ReadonlyRoute({required this.deposit});
  final Deposit deposit;

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
            label: 'Token',
            value: deposit.token,
            asset: 'assets/figma/funding/usdc.svg',
          ),
          Divider(height: 1, color: colors.border),
          _RouteValue(
            label: 'Network',
            value: deposit.chain,
            asset: 'assets/figma/funding/arbitrum.svg',
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
  const _RouteDetails({required this.deposit});
  final Deposit deposit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Route details', style: TextStyle(color: colors.secondaryText)),
        const SizedBox(height: 4),
        Text(
          'Send ${deposit.token} on ${deposit.chain} only.',
          style: TextStyle(color: colors.secondaryText, fontSize: 12),
        ),
        const SizedBox(height: 12),
        _DetailRow(label: 'Credits as', value: deposit.token),
        const SizedBox(height: 8),
        const _DetailRow(label: 'Estimated arrival', value: '< 1 minute'),
        if (deposit.confirmationsRequired != null) ...[
          const SizedBox(height: 8),
          _DetailRow(
            label: 'Confirmations required',
            value: '${deposit.confirmationsRequired}',
          ),
        ],
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

class _DepositSelector extends StatelessWidget {
  const _DepositSelector();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  _SelectorRow(
                    label: 'Token',
                    value: 'Choose token',
                    enabled: true,
                  ),
                  Divider(height: 1),
                  _SelectorRow(
                    label: 'Network',
                    value: 'Choose token first',
                    enabled: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            Image.asset(
              'assets/figma/funding/deposit_empty.png',
              width: 160,
              height: 160,
            ),
            const SizedBox(height: 12),
            const Text(
              'Choose a token and network',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            const Text(
              'Your deposit address will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorRow extends StatelessWidget {
  const _SelectorRow({
    required this.label,
    required this.value,
    required this.enabled,
  });
  final String label;
  final String value;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
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
                  color: enabled ? colors.primaryText : colors.tertiaryText,
                  fontWeight: enabled ? FontWeight.w600 : null,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: enabled ? colors.primaryText : colors.tertiaryText,
            ),
          ],
        ),
      ),
    );
  }
}
