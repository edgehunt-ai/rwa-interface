import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';
import 'package:nobell/ui/core/widgets/venue_icon.dart';

Future<void> showWithdrawalSourceSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const WithdrawalSourceSheet(),
    );

class WithdrawalSourceSheet extends ConsumerWidget {
  const WithdrawalSourceSheet({super.key, this.modal = true});

  final bool modal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allocationState = ref.watch(portfolioRailAllocationProvider);
    final allocation = allocationState.value;
    final router = GoRouter.of(context);

    void navigate(VoidCallback action) {
      if (modal) Navigator.of(context).pop();
      action();
    }

    return WithdrawalSourceSheetView(
      spotAvailable: allocation?.spot?.valueUsd == null
          ? null
          : TokenAmountFormatter.formatUsd(allocation!.spot!.valueUsd),
      perpsAvailable: allocation?.perps?.valueUsd == null
          ? null
          : TokenAmountFormatter.formatUsd(allocation!.perps!.valueUsd),
      balancesLoading: allocationState.isLoading,
      onSpot: () =>
          navigate(() => router.pushNamed(AppRoutes.withdrawalAssetSelectName)),
      onPerps: () =>
          navigate(() => router.push(AppRoutes.perpsWithdrawalLocation)),
      onHistory: () =>
          navigate(() => router.go('${AppRoutes.activityPath}?tab=cash')),
      onClose: () {
        if (modal || context.canPop()) {
          Navigator.of(context).pop();
        } else {
          router.go(AppRoutes.homePath);
        }
      },
    );
  }
}

class WithdrawalSourcePage extends StatelessWidget {
  const WithdrawalSourcePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColorTokens.light.overlayScrim.withValues(alpha: 0.45),
    body: const SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: WithdrawalSourceSheet(modal: false),
      ),
    ),
  );
}

class WithdrawalSourceSheetView extends StatelessWidget {
  const WithdrawalSourceSheetView({
    super.key,
    required this.spotAvailable,
    required this.perpsAvailable,
    this.balancesLoading = false,
    required this.onSpot,
    required this.onPerps,
    required this.onHistory,
    required this.onClose,
  });

  final String? spotAvailable;
  final String? perpsAvailable;
  final bool balancesLoading;
  final VoidCallback onSpot;
  final VoidCallback onPerps;
  final VoidCallback onHistory;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: colors.surfaceBase,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.withdraw,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  TextButton.icon(
                    key: const Key('withdrawal-source-history'),
                    onPressed: onHistory,
                    style: TextButton.styleFrom(
                      foregroundColor: colors.textSecondary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: AppSvgIcon(
                      'assets/figma/funding/activity.svg',
                      width: 20,
                      height: 20,
                      color: colors.textSecondary,
                    ),
                    label: Text(l10n.history),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    key: const Key('withdrawal-source-close'),
                    onPressed: onClose,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 20,
                      height: 20,
                    ),
                    icon: const Icon(Icons.close, size: 20),
                    tooltip: MaterialLocalizations.of(context)
                        .closeButtonTooltip,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.withdrawFromQuestion,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _WithdrawalSourceOption(
                      key: const Key('withdrawal-source-spot'),
                      iconAsset:
                          'assets/figma/funding/withdrawal_source_spot.svg',
                      title: l10n.spotAccount,
                      description: l10n.spotAccountDescription,
                      available: spotAvailable,
                      availableLoading: balancesLoading,
                      availableSkeletonKey: const Key(
                        'withdrawal-source-spot-balance-skeleton',
                      ),
                      onTap: onSpot,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _WithdrawalSourceOption(
                      key: const Key('withdrawal-source-perps'),
                      iconAsset:
                          'assets/figma/funding/withdrawal_source_perps.svg',
                      title: l10n.perps,
                      description: l10n.availableBalance,
                      available: perpsAvailable,
                      availableLoading: balancesLoading,
                      availableSkeletonKey: const Key(
                        'withdrawal-source-perps-balance-skeleton',
                      ),
                      onTap: onPerps,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WithdrawalSourceOption extends StatelessWidget {
  const _WithdrawalSourceOption({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.available,
    required this.availableLoading,
    required this.availableSkeletonKey,
    required this.onTap,
  });

  final String iconAsset;
  final String title;
  final String description;
  final String? available;
  final bool availableLoading;
  final Key availableSkeletonKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(minHeight: 152),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: colors.borderSubtle),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 40, height: 40, child: VenueIcon(iconAsset)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: 8),
            Divider(color: colors.surfaceSubtle),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${l10n.available}:',
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(width: 4),
                if (availableLoading)
                  SkeletonBlock(
                    key: availableSkeletonKey,
                    width: 48,
                    height: 10,
                    radius: 4,
                  )
                else
                  Flexible(
                    child: Text(
                      available ?? '—',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: colors.textSecondary),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

@Preview(
  name: 'Withdrawal source sheet',
  group: 'Funding',
  size: Size(393, 310),
)
Widget withdrawalSourceSheetPreview() => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    backgroundColor: AppColorTokens.light.overlayScrim.withValues(alpha: 0.45),
    body: Align(
      alignment: Alignment.bottomCenter,
      child: WithdrawalSourceSheetView(
        spotAvailable: r'$1,500.88',
        perpsAvailable: r'$2,328.44',
        onSpot: _previewNoop,
        onPerps: _previewNoop,
        onHistory: _previewNoop,
        onClose: _previewNoop,
      ),
    ),
  ),
);

void _previewNoop() {}
