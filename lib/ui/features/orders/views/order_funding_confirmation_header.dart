import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class OrderFundingConfirmationHeader extends StatelessWidget {
  const OrderFundingConfirmationHeader({
    super.key,
    required this.title,
    required this.stepKey,
  });

  final String title;
  final Key stepKey;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      key: stepKey,
      children: [
        _StepCircle(
          backgroundColor: colors.subtleSurface,
          child: Icon(Icons.check, size: 18, color: colors.primaryText),
        ),
        const SizedBox(width: 8),
        _StepCircle(
          backgroundColor: colors.subtleSurface,
          child: Icon(Icons.check, size: 18, color: colors.primaryText),
        ),
        const SizedBox(width: 8),
        _StepCircle(
          backgroundColor: colors.primaryAction,
          child: Text(
            '3',
            style: TextStyle(
              fontSize: 13,
              height: 18 / 13,
              fontWeight: FontWeight.w600,
              color: colors.onPrimaryAction,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              height: 26 / 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              color: colors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.backgroundColor, required this.child});

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: 28,
    height: 28,
    alignment: Alignment.center,
    decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
    child: child,
  );
}
