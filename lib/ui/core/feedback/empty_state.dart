import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    this.title,
    this.description,
    this.buttonLabel,
    this.onPressed,
    this.button,
    this.illustration = true,
  }) : assert(
         button == null || (buttonLabel == null && onPressed == null),
         'Use button or buttonLabel/onPressed, not both.',
       ),
       assert(
         buttonLabel == null || onPressed != null,
         'buttonLabel requires onPressed.',
       );

  final String? title;
  final String? description;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final Widget? button;
  final bool illustration;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (illustration) ...[
              Image.asset(
                'assets/figma/common/empty_state_illustration.png',
                width: 160,
                height: 160,
                fit: BoxFit.contain,
              ),
              if (title != null ||
                  description != null ||
                  button != null ||
                  buttonLabel != null)
                const SizedBox(height: 10),
            ],
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (description != null) ...[
              const SizedBox(height: 10),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.secondaryText,
                  fontSize: 15,
                  height: 22 / 15,
                ),
              ),
            ],
            if (button != null || buttonLabel != null) ...[
              const SizedBox(height: 10),
              button ??
                  OutlinedButton(
                    onPressed: onPressed,
                    child: Text(buttonLabel!),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
