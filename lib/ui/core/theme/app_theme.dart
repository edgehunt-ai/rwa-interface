import 'package:flutter/material.dart';

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

abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF315CFF),
      brightness: brightness,
    );

    final isDark = brightness == Brightness.dark;
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      extensions: [
        AppSemanticColors(
          success: isDark ? const Color(0xFF6DDB8A) : const Color(0xFF147A39),
          warning: isDark ? const Color(0xFFFFCB66) : const Color(0xFF8A5700),
          loss: isDark ? const Color(0xFFFF8A8A) : const Color(0xFFB3261E),
        ),
      ],
    );
  }
}
