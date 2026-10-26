import 'package:flutter/material.dart';

/// Design tokens for the RWA colour system.
///
/// The values mirror `Light.tokens.json` and `Dark.tokens.json` one-to-one so
/// the Flutter theme and the Figma variables cannot drift apart. Every colour
/// rendered by the app must come from [AppRwaColors], [AppSemanticColors] or
/// [AppBrandColors]; screens must never hard-code a colour of their own.
@immutable
class AppColorTokens {
  const AppColorTokens({
    required this.surfaceCanvas,
    required this.surfaceBase,
    required this.surfaceSubtle,
    required this.surfaceWarm,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textInverse,
    required this.borderSubtle,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconBrand,
    required this.iconInverse,
    required this.actionPrimary,
    required this.actionPrimaryPressed,
    required this.actionSecondary,
    required this.brandDefault,
    required this.brandSoft,
    required this.illustrationLime,
    required this.illustrationSky,
    required this.illustrationOrange,
    required this.illustrationMint,
    required this.semanticSuccess,
    required this.semanticSuccessSoft,
    required this.semanticWarning,
    required this.semanticWarningSoft,
    required this.semanticDanger,
    required this.semanticDangerSoft,
    required this.dividerSoft,
    required this.overlayScrim,
  });

  final Color surfaceCanvas;
  final Color surfaceBase;
  final Color surfaceSubtle;
  final Color surfaceWarm;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textInverse;
  final Color borderSubtle;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconBrand;
  final Color iconInverse;
  final Color actionPrimary;
  final Color actionPrimaryPressed;
  final Color actionSecondary;
  final Color brandDefault;
  final Color brandSoft;
  final Color illustrationLime;
  final Color illustrationSky;
  final Color illustrationOrange;
  final Color illustrationMint;
  final Color semanticSuccess;
  final Color semanticSuccessSoft;
  final Color semanticWarning;
  final Color semanticWarningSoft;
  final Color semanticDanger;
  final Color semanticDangerSoft;
  final Color dividerSoft;
  final Color overlayScrim;

  /// `Light.tokens.json`.
  static const light = AppColorTokens(
    surfaceCanvas: Color(0xFFF7F7FA),
    surfaceBase: Color(0xFFFFFFFF),
    surfaceSubtle: Color(0xFFF1F1F5),
    surfaceWarm: Color(0xFFF4F3F0),
    textPrimary: Color(0xFF1D1D24),
    textSecondary: Color(0xFF676776),
    textTertiary: Color(0xFF9292A0),
    textInverse: Color(0xFFFFFFFF),
    borderSubtle: Color(0xFFE4E4EA),
    iconPrimary: Color(0xFF1D1D24),
    iconSecondary: Color(0xFF676776),
    iconBrand: Color(0xFFFF7BE5),
    iconInverse: Color(0xFFFFFFFF),
    actionPrimary: Color(0xFF171719),
    actionPrimaryPressed: Color(0xFF000000),
    actionSecondary: Color(0xFFF1F1F5),
    brandDefault: Color(0xFFFF7BE5),
    brandSoft: Color(0xFFFFEAFB),
    illustrationLime: Color(0xFFB9F34A),
    illustrationSky: Color(0xFF49BFF5),
    illustrationOrange: Color(0xFFFF9654),
    illustrationMint: Color(0xFF34CFA2),
    semanticSuccess: Color(0xFF04A08B),
    semanticSuccessSoft: Color(0xFFE9F8F4),
    semanticWarning: Color(0xFFB45309),
    semanticWarningSoft: Color(0xFFFFF7ED),
    semanticDanger: Color(0xFFDE596E),
    semanticDangerSoft: Color(0xFFFFF0F2),
    dividerSoft: Color(0xFFF1F1F5),
    overlayScrim: Color(0xFF000000),
  );

  /// `Dark.tokens.json`.
  static const dark = AppColorTokens(
    surfaceCanvas: Color(0xFF161B21),
    surfaceBase: Color(0xFF1D252E),
    surfaceSubtle: Color(0xFF2C3641),
    surfaceWarm: Color(0xFF222B35),
    textPrimary: Color(0xFFF3F6F8),
    textSecondary: Color(0xFFB1BBC7),
    textTertiary: Color(0xFF8E9AA8),
    textInverse: Color(0xFF161B21),
    borderSubtle: Color(0xFF3A4653),
    iconPrimary: Color(0xFFF3F6F8),
    iconSecondary: Color(0xFFB1BBC7),
    iconBrand: Color(0xFFFF7BE5),
    iconInverse: Color(0xFF161B21),
    actionPrimary: Color(0xFFEEF2F5),
    actionPrimaryPressed: Color(0xFFB1BBC7),
    actionSecondary: Color(0xFF2C3641),
    brandDefault: Color(0xFFFF7BE5),
    brandSoft: Color(0xFFFFEAFB),
    illustrationLime: Color(0xFFB9F34A),
    illustrationSky: Color(0xFF49BFF5),
    illustrationOrange: Color(0xFFFF9654),
    illustrationMint: Color(0xFF34CFA2),
    semanticSuccess: Color(0xFF3CC9B1),
    semanticSuccessSoft: Color(0xFF183830),
    semanticWarning: Color(0xFFB45309),
    semanticWarningSoft: Color(0xFF2C3641),
    semanticDanger: Color(0xFFFF7589),
    semanticDangerSoft: Color(0xFF2C3641),
    dividerSoft: Color(0xFF2C3641),
    overlayScrim: Color(0xFF000000),
  );
}

/// Colours used by the surfaces, text, icons, borders, actions and brand
/// accents of the product. Values come from [AppColorTokens].
@immutable
class AppRwaColors extends ThemeExtension<AppRwaColors> {
  const AppRwaColors({
    required this.surfaceCanvas,
    required this.surfaceBase,
    required this.surfaceSubtle,
    required this.surfaceWarm,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textInverse,
    required this.borderSubtle,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconBrand,
    required this.iconInverse,
    required this.actionPrimary,
    required this.actionPrimaryPressed,
    required this.actionSecondary,
    required this.brandDefault,
    required this.brandSoft,
    required this.illustrationLime,
    required this.illustrationSky,
    required this.illustrationOrange,
    required this.illustrationMint,
    required this.dividerSoft,
    required this.overlayScrim,
  });

  factory AppRwaColors.fromTokens(AppColorTokens tokens) => AppRwaColors(
    surfaceCanvas: tokens.surfaceCanvas,
    surfaceBase: tokens.surfaceBase,
    surfaceSubtle: tokens.surfaceSubtle,
    surfaceWarm: tokens.surfaceWarm,
    textPrimary: tokens.textPrimary,
    textSecondary: tokens.textSecondary,
    textTertiary: tokens.textTertiary,
    textInverse: tokens.textInverse,
    borderSubtle: tokens.borderSubtle,
    iconPrimary: tokens.iconPrimary,
    iconSecondary: tokens.iconSecondary,
    iconBrand: tokens.iconBrand,
    iconInverse: tokens.iconInverse,
    actionPrimary: tokens.actionPrimary,
    actionPrimaryPressed: tokens.actionPrimaryPressed,
    actionSecondary: tokens.actionSecondary,
    brandDefault: tokens.brandDefault,
    brandSoft: tokens.brandSoft,
    illustrationLime: tokens.illustrationLime,
    illustrationSky: tokens.illustrationSky,
    illustrationOrange: tokens.illustrationOrange,
    illustrationMint: tokens.illustrationMint,
    dividerSoft: tokens.dividerSoft,
    overlayScrim: tokens.overlayScrim,
  );

  final Color surfaceCanvas;
  final Color surfaceBase;
  final Color surfaceSubtle;
  final Color surfaceWarm;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textInverse;
  final Color borderSubtle;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconBrand;
  final Color iconInverse;
  final Color actionPrimary;
  final Color actionPrimaryPressed;
  final Color actionSecondary;
  final Color brandDefault;
  final Color brandSoft;
  final Color illustrationLime;
  final Color illustrationSky;
  final Color illustrationOrange;
  final Color illustrationMint;
  final Color dividerSoft;
  final Color overlayScrim;

  @override
  AppRwaColors copyWith({
    Color? surfaceCanvas,
    Color? surfaceBase,
    Color? surfaceSubtle,
    Color? surfaceWarm,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textInverse,
    Color? borderSubtle,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? iconBrand,
    Color? iconInverse,
    Color? actionPrimary,
    Color? actionPrimaryPressed,
    Color? actionSecondary,
    Color? brandDefault,
    Color? brandSoft,
    Color? illustrationLime,
    Color? illustrationSky,
    Color? illustrationOrange,
    Color? illustrationMint,
    Color? dividerSoft,
    Color? overlayScrim,
  }) => AppRwaColors(
    surfaceCanvas: surfaceCanvas ?? this.surfaceCanvas,
    surfaceBase: surfaceBase ?? this.surfaceBase,
    surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
    surfaceWarm: surfaceWarm ?? this.surfaceWarm,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textTertiary: textTertiary ?? this.textTertiary,
    textInverse: textInverse ?? this.textInverse,
    borderSubtle: borderSubtle ?? this.borderSubtle,
    iconPrimary: iconPrimary ?? this.iconPrimary,
    iconSecondary: iconSecondary ?? this.iconSecondary,
    iconBrand: iconBrand ?? this.iconBrand,
    iconInverse: iconInverse ?? this.iconInverse,
    actionPrimary: actionPrimary ?? this.actionPrimary,
    actionPrimaryPressed: actionPrimaryPressed ?? this.actionPrimaryPressed,
    actionSecondary: actionSecondary ?? this.actionSecondary,
    brandDefault: brandDefault ?? this.brandDefault,
    brandSoft: brandSoft ?? this.brandSoft,
    illustrationLime: illustrationLime ?? this.illustrationLime,
    illustrationSky: illustrationSky ?? this.illustrationSky,
    illustrationOrange: illustrationOrange ?? this.illustrationOrange,
    illustrationMint: illustrationMint ?? this.illustrationMint,
    dividerSoft: dividerSoft ?? this.dividerSoft,
    overlayScrim: overlayScrim ?? this.overlayScrim,
  );

  @override
  AppRwaColors lerp(AppRwaColors? other, double t) => other == null
      ? this
      : AppRwaColors(
          surfaceCanvas: Color.lerp(surfaceCanvas, other.surfaceCanvas, t)!,
          surfaceBase: Color.lerp(surfaceBase, other.surfaceBase, t)!,
          surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
          surfaceWarm: Color.lerp(surfaceWarm, other.surfaceWarm, t)!,
          textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
          textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
          textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
          textInverse: Color.lerp(textInverse, other.textInverse, t)!,
          borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
          iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
          iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
          iconBrand: Color.lerp(iconBrand, other.iconBrand, t)!,
          iconInverse: Color.lerp(iconInverse, other.iconInverse, t)!,
          actionPrimary: Color.lerp(actionPrimary, other.actionPrimary, t)!,
          actionPrimaryPressed: Color.lerp(
            actionPrimaryPressed,
            other.actionPrimaryPressed,
            t,
          )!,
          actionSecondary: Color.lerp(
            actionSecondary,
            other.actionSecondary,
            t,
          )!,
          brandDefault: Color.lerp(brandDefault, other.brandDefault, t)!,
          brandSoft: Color.lerp(brandSoft, other.brandSoft, t)!,
          illustrationLime: Color.lerp(
            illustrationLime,
            other.illustrationLime,
            t,
          )!,
          illustrationSky: Color.lerp(
            illustrationSky,
            other.illustrationSky,
            t,
          )!,
          illustrationOrange: Color.lerp(
            illustrationOrange,
            other.illustrationOrange,
            t,
          )!,
          illustrationMint: Color.lerp(
            illustrationMint,
            other.illustrationMint,
            t,
          )!,
          dividerSoft: Color.lerp(dividerSoft, other.dividerSoft, t)!,
          overlayScrim: Color.lerp(overlayScrim, other.overlayScrim, t)!,
        );
}

/// Positive, cautionary and destructive colours. Values come from
/// [AppColorTokens] so both appearances stay in sync with the design tokens.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.successSoft,
    required this.warning,
    required this.warningSoft,
    required this.danger,
    required this.dangerSoft,
  });

  factory AppSemanticColors.fromTokens(AppColorTokens tokens) =>
      AppSemanticColors(
        success: tokens.semanticSuccess,
        successSoft: tokens.semanticSuccessSoft,
        warning: tokens.semanticWarning,
        warningSoft: tokens.semanticWarningSoft,
        danger: tokens.semanticDanger,
        dangerSoft: tokens.semanticDangerSoft,
      );

  final Color success;
  final Color successSoft;
  final Color warning;
  final Color warningSoft;
  final Color danger;
  final Color dangerSoft;

  /// Trade-direction colours: long positions reuse the positive colour while
  /// short positions reuse the destructive colour.
  Color get long => success;
  Color get short => danger;

  @override
  AppSemanticColors copyWith({
    Color? success,
    Color? successSoft,
    Color? warning,
    Color? warningSoft,
    Color? danger,
    Color? dangerSoft,
  }) => AppSemanticColors(
    success: success ?? this.success,
    successSoft: successSoft ?? this.successSoft,
    warning: warning ?? this.warning,
    warningSoft: warningSoft ?? this.warningSoft,
    danger: danger ?? this.danger,
    dangerSoft: dangerSoft ?? this.dangerSoft,
  );

  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      successSoft: Color.lerp(successSoft, other.successSoft, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningSoft: Color.lerp(warningSoft, other.warningSoft, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t)!,
    );
  }
}

/// Third-party brand marks (networks, venues) that are intentionally fixed
/// across appearances. They are part of the theme layer so screens never
/// define colours themselves.
abstract final class AppBrandColors {
  static const ethereum = Color(0xFF627EEA);
  static const arbitrum = Color(0xFF2F3749);
  static const polygon = Color(0xFF8247E5);
}

/// Ink colour of the single-colour cold-start mark (the Rive artboard and its
/// SVG stand-ins). It stays theme pink on the light canvas and inverts to white
/// on the dark canvas, so the launch animation never reads as a light-mode
/// brand mark, and it stays legible against [AppColorTokens.surfaceCanvas].
///
/// The artwork is authored in one flat colour, so consumers recolour it rather
/// than shipping a second asset per appearance.
abstract final class AppLaunchMark {
  static Color colorFor(Brightness brightness) => brightness == Brightness.dark
      ? const Color(0xFFFFFFFF)
      : AppColorTokens.light.brandDefault;
}

abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static AppColorTokens tokensFor(Brightness brightness) =>
      brightness == Brightness.dark
      ? AppColorTokens.dark
      : AppColorTokens.light;

  static ThemeData _build(Brightness brightness) {
    final tokens = tokensFor(brightness);
    final rwa = AppRwaColors.fromTokens(tokens);
    final semantic = AppSemanticColors.fromTokens(tokens);
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: tokens.brandDefault,
          brightness: brightness,
        ).copyWith(
          primary: rwa.actionPrimary,
          onPrimary: rwa.textInverse,
          primaryContainer: rwa.actionSecondary,
          onPrimaryContainer: rwa.textPrimary,
          secondary: rwa.brandDefault,
          onSecondary: rwa.textInverse,
          secondaryContainer: rwa.brandSoft,
          // brand.soft stays a light pink in both appearances, so its content
          // colour must stay dark even in the dark theme.
          onSecondaryContainer: AppColorTokens.light.textPrimary,
          surface: rwa.surfaceBase,
          onSurface: rwa.textPrimary,
          surfaceContainerLowest: rwa.surfaceCanvas,
          surfaceContainerLow: rwa.surfaceBase,
          surfaceContainer: rwa.surfaceBase,
          surfaceContainerHigh: rwa.surfaceSubtle,
          surfaceContainerHighest: rwa.surfaceSubtle,
          onSurfaceVariant: rwa.textSecondary,
          outline: rwa.borderSubtle,
          outlineVariant: rwa.borderSubtle,
          error: semantic.danger,
          onError: rwa.textInverse,
          errorContainer: semantic.dangerSoft,
          onErrorContainer: semantic.danger,
          inverseSurface: rwa.textPrimary,
          onInverseSurface: rwa.textInverse,
          scrim: rwa.overlayScrim,
        );
    // The design is built on a compact mobile type scale.  Defining it here
    // prevents screens that use Material's semantic text styles from drifting
    // back to the larger/default platform scale.
    final textTheme = const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        height: 36 / 28,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        height: 26 / 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        height: 22 / 17,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontSize: 15, height: 22 / 15),
      bodyMedium: TextStyle(fontSize: 13, height: 18 / 13),
      bodySmall: TextStyle(fontSize: 12, height: 16 / 12),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 18 / 14,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        height: 14 / 11,
        fontWeight: FontWeight.w500,
      ),
    ).apply(bodyColor: rwa.textPrimary, displayColor: rwa.textPrimary);
    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: rwa.surfaceCanvas,
      canvasColor: rwa.surfaceCanvas,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: rwa.iconPrimary),
      cardTheme: CardThemeData(
        color: rwa.surfaceBase,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: rwa.surfaceBase,
        surfaceTintColor: Colors.transparent,
        barrierColor: rwa.overlayScrim.withValues(alpha: 0.44),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: rwa.surfaceBase,
        modalBackgroundColor: rwa.surfaceBase,
        surfaceTintColor: Colors.transparent,
        modalBarrierColor: rwa.overlayScrim.withValues(alpha: 0.44),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: rwa.textPrimary,
        contentTextStyle: TextStyle(color: rwa.textInverse),
        behavior: SnackBarBehavior.floating,
      ),
      chipTheme: ChipThemeData(
        // Segmented controls use their parent surface for unselected items.
        backgroundColor: Colors.transparent,
        selectedColor: rwa.surfaceBase,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        pressElevation: 0,
        side: BorderSide.none,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(
        color: rwa.dividerSoft,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        // Leave typography unset so each hint inherits its TextField's style.
        hintStyle: TextStyle(color: rwa.textTertiary),
        filled: true,
        fillColor: rwa.surfaceBase,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.textPrimary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: rwa.actionPrimary,
          foregroundColor: rwa.textInverse,
          disabledBackgroundColor: rwa.actionSecondary,
          disabledForegroundColor: rwa.textTertiary,
          elevation: 0,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            height: 20 / 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: rwa.textPrimary,
          disabledForegroundColor: rwa.textTertiary,
          minimumSize: const Size(0, 48),
          side: BorderSide(color: rwa.borderSubtle),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            height: 20 / 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: rwa.textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: rwa.surfaceCanvas,
        foregroundColor: rwa.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: rwa.textSecondary,
      ),
      extensions: [semantic, rwa],
    );
  }
}

extension AppThemeContext on BuildContext {
  /// Token colours for the active appearance.
  ///
  /// Falls back to the brightness-matching token set when a widget renders
  /// outside the app theme (for example an overlay inserted by the test
  /// harness), so callers never have to null-check the extension.
  AppRwaColors get appColors =>
      Theme.of(this).extension<AppRwaColors>() ??
      AppRwaColors.fromTokens(AppTheme.tokensFor(Theme.of(this).brightness));

  /// Success / warning / danger colours for the active appearance.
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>() ??
      AppSemanticColors.fromTokens(
        AppTheme.tokensFor(Theme.of(this).brightness),
      );
}
