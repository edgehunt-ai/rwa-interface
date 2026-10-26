import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

/// Renders a monochrome SVG whose fills/strokes use `currentColor`.
///
/// Like [Icon], it inherits the enclosing button or [IconTheme] foreground.
/// Use [color] for a semantic colour or a secondary foreground.
class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon(
    this.assetName, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetName;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    var foreground = color ?? iconTheme.color ?? context.appColors.iconPrimary;
    final opacity = iconTheme.opacity ?? 1;
    if (opacity != 1) {
      foreground = foreground.withValues(alpha: foreground.a * opacity);
    }
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      theme: SvgTheme(currentColor: foreground),
    );
  }
}
