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

class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              children: [
                Positioned(
                  left: 16.2,
                  top: 22.6,
                  width: 127.6,
                  height: 127.6,
                  child: Image.asset(
                    'assets/figma/home_markets/'
                    'favorites_empty_illustration.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'No favorites yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              height: 22 / 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap the star on any market to save it here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.secondaryText,
              fontSize: 15,
              height: 22 / 15,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            height: 44,
            child: OutlinedButton(
              onPressed: onExplore,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(200, 44),
                maximumSize: const Size(200, 44),
                backgroundColor: colors.subtleSurface,
              ),
              child: const Text('Explore markets'),
            ),
          ),
        ],
      ),
    );
  }
}
