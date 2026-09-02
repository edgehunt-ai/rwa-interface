import 'package:flutter/material.dart';

class AppAdaptiveProgress extends StatelessWidget {
  const AppAdaptiveProgress({
    super.key,
    required this.semanticLabel,
    this.value,
  });

  final String semanticLabel;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: CircularProgressIndicator.adaptive(value: value),
    );
  }
}

class AppAdaptiveSwitch extends StatelessWidget {
  const AppAdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      toggled: value,
      child: Switch.adaptive(value: value, onChanged: onChanged),
    );
  }
}
