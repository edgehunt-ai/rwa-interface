import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the "every colour comes from the theme" rule: screens and widgets
/// must reach for [AppRwaColors] / [AppSemanticColors] / [AppBrandColors]
/// instead of declaring literal colours of their own.
void main() {
  final literalColor = RegExp(r'Color\(\s*0x|Color\.fromARGB|Color\.fromRGBO');
  final namedColor = RegExp(r'(?<![A-Za-z])Colors\.(?!transparent\b)[A-Za-z]+');

  test('production widgets do not declare literal colours', () {
    final root = Directory('lib');
    expect(root.existsSync(), isTrue, reason: 'run from the package root');

    final violations = <String>[];
    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      // The theme file is the single place where token literals live.
      if (entity.path.endsWith('ui/core/theme/app_theme.dart')) continue;

      final lines = entity.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index];
        if (literalColor.hasMatch(line) || namedColor.hasMatch(line)) {
          violations.add('${entity.path}:${index + 1}: ${line.trim()}');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Use the theme tokens instead of hard-coded colours:\n'
          '${violations.join('\n')}',
    );
  });
}
