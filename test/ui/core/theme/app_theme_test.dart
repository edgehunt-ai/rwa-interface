import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

void main() {
  test('semantic colors exist in both appearances', () {
    final light = AppTheme.light.extension<AppSemanticColors>();
    final dark = AppTheme.dark.extension<AppSemanticColors>();

    expect(light, isNotNull);
    expect(dark, isNotNull);
    expect(light!.success, isNot(dark!.success));
  });
}
