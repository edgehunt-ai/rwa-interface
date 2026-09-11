import 'package:sentry_flutter/sentry_flutter.dart';

/// Last-line defence for telemetry emitted by the SDK or future integrations.
abstract final class SentryEventSanitizer {
  static SentryEvent sanitize(SentryEvent event, Hint _) {
    event.request = null;
    // ignore: deprecated_member_use
    event.extra = null;
    event.user = switch (event.user?.id) {
      final id? when id.isNotEmpty => SentryUser(id: id),
      _ => null,
    };
    event.contexts.removeWhere(
      (key, _) => !const {
        SentryDevice.type,
        SentryOperatingSystem.type,
        SentryRuntime.listType,
        SentryApp.type,
      }.contains(key),
    );
    event.tags?.removeWhere((key, _) => !_safeKey(key));
    event.tags?.updateAll((_, value) => redact(value));
    event.breadcrumbs = event.breadcrumbs
        ?.map(
          (breadcrumb) => Breadcrumb(
            message: breadcrumb.message == null
                ? null
                : redact(breadcrumb.message!),
            category: breadcrumb.category,
            type: breadcrumb.type,
            level: breadcrumb.level,
            timestamp: breadcrumb.timestamp,
          ),
        )
        .toList(growable: false);
    event.message?.formatted = redact(event.message!.formatted);
    event.message?.template = event.message?.template == null
        ? null
        : redact(event.message!.template!);
    event.message?.params = null;
    for (final exception in event.exceptions ?? const <SentryException>[]) {
      if (exception.value != null) exception.value = redact(exception.value!);
    }
    return event;
  }

  static String redact(String value) => value
      .replaceAll(RegExp(r'\b[^\s@]+@[^\s@]+\b'), '<redacted-email>')
      .replaceAll(
        RegExp(r'Bearer\s+\S+', caseSensitive: false),
        'Bearer <redacted>',
      )
      .replaceAllMapped(
        RegExp(
          r'\b(access_token|authorization|code|id_token|state|token|signature|address)\s*=\s*[^\s,&]+',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}=<redacted>',
      )
      .replaceAllMapped(
        RegExp(
          r'([?&](?:access_token|authorization|code|id_token|state|token|signature|address)=)[^&#\s]+',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}<redacted>',
      )
      .replaceAllMapped(
        RegExp(
          r'("(?:access_token|authorization|code|id_token|state|token|signature|address)"\s*:\s*")[^"]+',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}<redacted>',
      );

  static bool _safeKey(String key) => !const {
    'token',
    'authorization',
    'cookie',
    'email',
    'address',
    'signature',
    'payload',
    'body',
    'amount',
    'price',
    'quantity',
  }.any((fragment) => key.toLowerCase().contains(fragment));
}
