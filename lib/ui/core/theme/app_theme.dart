import 'package:flutter/material.dart';

const kShortTradeColor = Color(0xFFDE596E);

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.loss,
  });

  final Color success;
  final Color warning;
  final Color loss;

  @override
  AppSemanticColors copyWith({Color? success, Color? warning, Color? loss}) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      loss: loss ?? this.loss,
    );
  }

  @override
  AppSemanticColors lerp(AppSemanticColors? other, double t) {
    if (other == null) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
    );
  }
}

@immutable
class AppRwaColors extends ThemeExtension<AppRwaColors> {
  const AppRwaColors({
    required this.canvas,
    required this.surface,
    required this.subtleSurface,
    required this.border,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
    required this.primaryAction,
    required this.onPrimaryAction,
    required this.selected,
    required this.selectedSoft,
  });

  final Color canvas;
  final Color surface;
  final Color subtleSurface;
  final Color border;
  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;
  final Color primaryAction;
  final Color onPrimaryAction;
  final Color selected;
  final Color selectedSoft;

  @override
  AppRwaColors copyWith({
    Color? canvas,
    Color? surface,
    Color? subtleSurface,
    Color? border,
    Color? primaryText,
    Color? secondaryText,
    Color? tertiaryText,
    Color? primaryAction,
    Color? onPrimaryAction,
    Color? selected,
    Color? selectedSoft,
  }) => AppRwaColors(
    canvas: canvas ?? this.canvas,
    surface: surface ?? this.surface,
    subtleSurface: subtleSurface ?? this.subtleSurface,
    border: border ?? this.border,
    primaryText: primaryText ?? this.primaryText,
    secondaryText: secondaryText ?? this.secondaryText,
    tertiaryText: tertiaryText ?? this.tertiaryText,
    primaryAction: primaryAction ?? this.primaryAction,
    onPrimaryAction: onPrimaryAction ?? this.onPrimaryAction,
    selected: selected ?? this.selected,
    selectedSoft: selectedSoft ?? this.selectedSoft,
  );

  @override
  AppRwaColors lerp(AppRwaColors? other, double t) => other == null
      ? this
      : AppRwaColors(
          canvas: Color.lerp(canvas, other.canvas, t)!,
          surface: Color.lerp(surface, other.surface, t)!,
          subtleSurface: Color.lerp(subtleSurface, other.subtleSurface, t)!,
          border: Color.lerp(border, other.border, t)!,
          primaryText: Color.lerp(primaryText, other.primaryText, t)!,
          secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
          tertiaryText: Color.lerp(tertiaryText, other.tertiaryText, t)!,
          primaryAction: Color.lerp(primaryAction, other.primaryAction, t)!,
          onPrimaryAction: Color.lerp(
            onPrimaryAction,
            other.onPrimaryAction,
            t,
          )!,
          selected: Color.lerp(selected, other.selected, t)!,
          selectedSoft: Color.lerp(selectedSoft, other.selectedSoft, t)!,
        );
}

abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final seededColorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF315CFF),
      brightness: brightness,
    );

    final isDark = brightness == Brightness.dark;
    final rwa = AppRwaColors(
      canvas: isDark ? const Color(0xFF171719) : const Color(0xFFF7F7FA),
      surface: isDark ? const Color(0xFF24242B) : Colors.white,
      subtleSurface: isDark ? const Color(0xFF303038) : const Color(0xFFF1F1F5),
      border: isDark ? const Color(0xFF454550) : const Color(0xFFE4E4EA),
      primaryText: isDark ? Colors.white : const Color(0xFF1D1D24),
      secondaryText: isDark ? const Color(0xFFCACAD5) : const Color(0xFF676776),
      tertiaryText: isDark ? const Color(0xFF9292A0) : const Color(0xFF9292A0),
      primaryAction: isDark ? Colors.white : const Color(0xFF171719),
      onPrimaryAction: isDark ? const Color(0xFF171719) : Colors.white,
      selected: const Color(0xFFFF7BE5),
      selectedSoft: isDark ? const Color(0xFF59384F) : const Color(0xFFFFEAFB),
    );
    final colorScheme = seededColorScheme.copyWith(
      primary: rwa.primaryAction,
      onPrimary: rwa.onPrimaryAction,
      surface: rwa.surface,
      onSurface: rwa.primaryText,
      outline: rwa.border,
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
    ).apply(bodyColor: rwa.primaryText, displayColor: rwa.primaryText);
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: rwa.canvas,
      textTheme: textTheme,
      cardTheme: CardThemeData(
        color: rwa.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      chipTheme: ChipThemeData(
        // Segmented controls use their parent surface for unselected items.
        backgroundColor: Colors.transparent,
        selectedColor: rwa.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        pressElevation: 0,
        side: BorderSide.none,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(color: rwa.border, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: rwa.tertiaryText),
        filled: true,
        fillColor: rwa.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: rwa.primaryText, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: rwa.primaryAction,
          foregroundColor: rwa.onPrimaryAction,
          disabledBackgroundColor: rwa.subtleSurface,
          disabledForegroundColor: rwa.tertiaryText,
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
          foregroundColor: rwa.primaryText,
          disabledForegroundColor: rwa.tertiaryText,
          minimumSize: const Size(0, 48),
          side: BorderSide(color: rwa.border),
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
      appBarTheme: AppBarTheme(
        backgroundColor: rwa.canvas,
        foregroundColor: rwa.primaryText,
        elevation: 0,
      ),
      extensions: [
        AppSemanticColors(
          success: isDark ? const Color(0xFF6DDB8A) : const Color(0xFF04A08B),
          warning: isDark ? const Color(0xFFFFCB66) : const Color(0xFF8A5700),
          loss: isDark ? const Color(0xFFFF8A8A) : const Color(0xFFB3261E),
        ),
        rwa,
      ],
    );
  }
}
