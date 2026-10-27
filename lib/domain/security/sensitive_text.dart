/// Removes credentials from readable failure reasons before display or logging.
/// Keep this policy shared by SDK adapters, presentation, and telemetry.
abstract final class SensitiveTextRedactor {
  static String redact(String value) => value
      .replaceAll(RegExp(r'\b[^\s@]+@[^\s@]+\b'), '<redacted-email>')
      .replaceAllMapped(
        RegExp(r'\b(Bearer|Basic)\s+\S+', caseSensitive: false),
        (match) => '${match.group(1)} <redacted>',
      )
      .replaceAllMapped(_credential, (match) {
        final quote = match.group(1)!;
        final key = match.group(2)!;
        final separator = match.group(3)!;
        return '$quote$key$quote$separator$quote<redacted>$quote';
      });

  // Optional separators also cover camelCase names such as refreshToken and
  // clientSecret. Boundaries prevent matching the tail of unrelated keys.
  static const _sensitiveKeyPattern =
      '(?:access|refresh|id|identity|session)[_-]?token|authorization|code|state|'
      'token|signature|address|private[_-]?key|mnemonic|seed(?:[_-]?phrase)?|'
      'password|passphrase|client[_-]?secret|api[_-]?key|secret';

  static final _credential = RegExp(
    '(["\']?)\\b($_sensitiveKeyPattern)\\b\\1\\s*([=:])\\s*'
    r'''(?:"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|[^\s,&#}\]]+)''',
    caseSensitive: false,
  );
}
