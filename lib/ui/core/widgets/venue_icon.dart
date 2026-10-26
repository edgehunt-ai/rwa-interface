import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';

/// A neutral bStocks/HIP-3 source badge with independently themed layers.
///
/// The SVG geometry is shared between appearances; a single colour filter
/// would flatten the circular background, border and venue mark together.
class VenueIcon extends StatelessWidget {
  const VenueIcon(
    this.assetName, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    assetName,
    width: width,
    height: height,
    fit: fit,
    colorMapper: _VenueColorMapper(context.appColors),
  );
}

class _VenueColorMapper extends ColorMapper {
  const _VenueColorMapper(this.colors);

  final AppRwaColors colors;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    if (color == AppColorTokens.light.surfaceSubtle) {
      return colors.surfaceSubtle;
    }
    if (color == AppColorTokens.light.borderSubtle) {
      return colors.borderSubtle;
    }
    if (color == AppColorTokens.light.iconSecondary) {
      return colors.iconSecondary;
    }
    return color;
  }

  @override
  bool operator ==(Object other) =>
      other is _VenueColorMapper && other.colors == colors;

  @override
  int get hashCode => colors.hashCode;
}
