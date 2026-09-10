import '../domain/auth/authentication.dart';
import '../domain/models/product_session.dart';

/// Build-time configuration for the App Store review account.
///
/// Values are public application configuration, not secrets. Pass a
/// comma-separated list with `--dart-define=APP_REVIEW_USERS=...`.
final class AppReviewConfiguration {
  const AppReviewConfiguration({required this.users, this.enabled = true});

  factory AppReviewConfiguration.fromEnvironment() => AppReviewConfiguration(
    users: _parse(const String.fromEnvironment('APP_REVIEW_USERS')),
    enabled: buildEnabled,
  );

  final Set<String> users;
  final bool enabled;

  static const buildEnabled = bool.fromEnvironment('APP_REVIEW_ENABLED');

  bool matchesPrincipal(IdentityPrincipal principal) =>
      _matches([principal.id, principal.displayName]);

  bool matchesSession(ProductSession session) =>
      _matches([session.account.userId, session.account.privyDid]);

  bool _matches(Iterable<String?> candidates) {
    if (!enabled || users.isEmpty) return false;
    return candidates.whereType<String>().map(_normalize).any(users.contains);
  }

  static Set<String> _parse(String value) =>
      value.split(',').map(_normalize).where((item) => item.isNotEmpty).toSet();

  static String _normalize(String value) => value.trim().toLowerCase();
}
