import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/feedback/error_message.dart';
import '../../../core/theme/app_theme.dart';
import 'region_restriction_dialog.dart';

/// Lives above the router so navigation cannot cover the restriction notice.
class RegionRestrictionHost extends ConsumerStatefulWidget {
  const RegionRestrictionHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<RegionRestrictionHost> createState() =>
      _RegionRestrictionHostState();
}

class _RegionRestrictionHostState extends ConsumerState<RegionRestrictionHost>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(accessRegionProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(accessRegionProvider);
    // Riverpod retains the last result during refresh/error. A failed refresh
    // must not silently remove an already confirmed restriction.
    final region = status.value;
    final restricted = region?.restricted == true;
    final l10n = AppLocalizations.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        ExcludeFocus(
          excluding: restricted,
          child: ExcludeSemantics(
            excluding: restricted,
            child: IgnorePointer(ignoring: restricted, child: widget.child),
          ),
        ),
        if (restricted) ...[
          ModalBarrier(
            key: const ValueKey('region-restriction-barrier'),
            dismissible: false,
            color: context.appColors.overlayScrim.withValues(alpha: 0.7),
          ),
          FocusScope(
            autofocus: true,
            child: RegionRestrictionDialog(
              restrictedRegions: region!.restrictedRegions,
            ),
          ),
        ],
        if (status.hasError && !status.isLoading)
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Material(
                color: context.appColors.surfaceBase,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          errorMessage(
                            status.error!,
                            fallback: l10n.regionAccessCheckFailed,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => ref.invalidate(accessRegionProvider),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
