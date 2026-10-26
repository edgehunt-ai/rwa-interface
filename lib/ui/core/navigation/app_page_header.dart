import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

/// A compact back-navigation header whose icon, gap, and title share one tap
/// target.
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    required this.title,
    this.onBack,
    this.fallbackLocation = AppRoutes.homePath,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final String title;
  final VoidCallback? onBack;
  final String fallbackLocation;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final handleBack =
        onBack ??
        () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(fallbackLocation);
          }
        };

    return Padding(
      padding: padding,
      child: InkWell(
        onTap: handleBack,
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          height: 34,
          child: Row(
            children: [
              IconButton(
                onPressed: handleBack,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 20,
                  height: 34,
                ),
                style: IconButton.styleFrom(
                  fixedSize: const Size(20, 34),
                  minimumSize: const Size(20, 34),
                  maximumSize: const Size(20, 34),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                icon: Transform.translate(
                  offset: Offset.zero,
                  child: Transform.flip(
                    flipX: true,
                    child: AppSvgIcon(
                      'assets/figma/funding/back.svg',
                      color: context.appColors.iconPrimary,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
