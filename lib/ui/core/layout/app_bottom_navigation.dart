import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

enum AppDestination { home, markets, assets, activity }

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key, required this.current});

  final AppDestination current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final showLabels = MediaQuery.textScalerOf(context).scale(11) <= 14;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DestinationButton(
                destination: AppDestination.home,
                current: current,
                label: 'Home',
                showLabel: showLabels,
                asset: 'assets/figma/home_markets/nav_home.svg',
                onTap: () => context.goNamed(AppRoutes.homeName),
              ),
              _DestinationButton(
                destination: AppDestination.markets,
                current: current,
                label: 'Market',
                showLabel: showLabels,
                asset: 'assets/figma/home_markets/nav_markets.svg',
                onTap: () => context.goNamed(AppRoutes.marketsName),
              ),
              _DestinationButton(
                destination: AppDestination.assets,
                current: current,
                label: 'Assets',
                showLabel: showLabels,
                asset: 'assets/figma/home_markets/nav_assets.svg',
                onTap: () => context.goNamed(AppRoutes.assetsName),
              ),
              _DestinationButton(
                destination: AppDestination.activity,
                current: current,
                label: 'Activity',
                showLabel: showLabels,
                asset: 'assets/figma/home_markets/nav_activity.svg',
                onTap: () => context.goNamed(AppRoutes.activityName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationButton extends StatelessWidget {
  const _DestinationButton({
    required this.destination,
    required this.current,
    required this.label,
    required this.asset,
    required this.showLabel,
    required this.onTap,
  });

  final AppDestination destination;
  final AppDestination current;
  final String label;
  final String asset;
  final bool showLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final selected = destination == current;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 72,
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                asset,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  selected ? colors.selected : colors.tertiaryText,
                  BlendMode.srcIn,
                ),
              ),
              if (showLabel) ...[
                const SizedBox(height: 4),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: selected ? colors.primaryText : colors.tertiaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    height: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
