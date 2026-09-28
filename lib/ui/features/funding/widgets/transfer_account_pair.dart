import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_theme.dart';

/// Shared account-direction card used by standalone and order funding flows.
class TransferAccountPair extends StatelessWidget {
  const TransferAccountPair({
    super.key,
    required this.send,
    required this.receive,
    this.onSwap,
  });

  final String send;
  final String receive;
  final VoidCallback? onSwap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;

    Widget account(
      String label,
      String value, {
      required bool receiveSide,
    }) => Expanded(
      child: Container(
        height: 78,
        padding: EdgeInsets.fromLTRB(receiveSide ? 28 : 12, 12, 12, 12),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.secondaryText),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: 24,
                    child: SvgPicture.asset(
                      value == 'Spot'
                          ? 'assets/figma/home_markets/venue_bnb.svg'
                          : 'assets/figma/home_markets/venue_hyperliquid.svg',
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            account(
              AppLocalizations.of(context).sendAccount,
              send,
              receiveSide: false,
            ),
            const SizedBox(width: 4),
            account(
              AppLocalizations.of(context).receiveAccount,
              receive,
              receiveSide: true,
            ),
          ],
        ),
        Material(
          color: colors.surface,
          shape: CircleBorder(side: BorderSide(color: colors.border)),
          child: SizedBox(
            width: 28,
            height: 28,
            child: onSwap == null
                ? const Icon(Icons.arrow_forward, size: 16)
                : InkWell(
                    onTap: onSwap,
                    customBorder: const CircleBorder(),
                    child: const Icon(Icons.arrow_forward, size: 16),
                  ),
          ),
        ),
      ],
    );
  }
}
