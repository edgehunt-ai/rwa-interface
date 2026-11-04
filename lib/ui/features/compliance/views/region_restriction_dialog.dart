import 'package:flutter/material.dart';
import 'package:nobell/domain/models/access_region.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

/// Present only after the region API confirms restricted access.
/// The caller owns detection; this component never infers location from locale.
Future<void> showRegionRestrictionDialog(
  BuildContext context, {
  List<RestrictedRegion> restrictedRegions = const [],
}) => showDialog<void>(
  context: context,
  useRootNavigator: true,
  barrierDismissible: false,
  barrierColor: context.appColors.overlayScrim.withValues(alpha: 0.7),
  builder: (_) => RegionRestrictionDialog(restrictedRegions: restrictedRegions),
);

/// Intentionally has no actions or close affordance.
class RegionRestrictionDialog extends StatelessWidget {
  const RegionRestrictionDialog({super.key, this.restrictedRegions = const []});

  final List<RestrictedRegion> restrictedRegions;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: colors.surfaceBase,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        constraints: const BoxConstraints(maxWidth: 350),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExcludeSemantics(
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? 'assets/figma/common/region_restriction_dark.png'
                        : 'assets/figma/common/region_restriction.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Semantics(
                  header: true,
                  namesRoute: true,
                  child: Text(
                    l10n.regionRestrictionTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(letterSpacing: -0.1),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  restrictedRegions.isEmpty
                      ? l10n.regionRestrictionMessage
                      : '${l10n.regionRestrictionMessage}\n${_regionList(l10n)}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _regionList(AppLocalizations l10n) {
    final names = restrictedRegions
        .map((region) => region.name)
        .toList(growable: false);
    if (l10n.localeName.startsWith('zh')) return '${names.join('、')}。';
    if (names.length == 1) return '${names.single}.';
    if (names.length == 2) return '${names.first} and ${names.last}.';
    return '${names.take(names.length - 1).join(', ')}, and ${names.last}.';
  }
}
