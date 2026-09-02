// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Orbit';

  @override
  String get homeTitle => 'Orbit foundation';

  @override
  String get openDetails => 'Open details';

  @override
  String get detailsTitle => 'Navigation details';

  @override
  String get pageNotFoundTitle => 'Page not found';

  @override
  String get pageNotFoundMessage =>
      'This address does not match an Orbit page.';

  @override
  String get returnHome => 'Return home';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get copyLabel => 'Copy';

  @override
  String get copySucceeded => 'Copied';

  @override
  String get copyFailed => 'Could not copy';

  @override
  String get cancel => 'Cancel';
}
