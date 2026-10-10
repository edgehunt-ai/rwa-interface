import 'package:nobell/domain/models/api_failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Last-line defence for telemetry emitted by the SDK or future integrations.
abstract final class SentryEventSanitizer {
  /// Drops expected environmental failures even when they escape application
  /// code and reach a Flutter, platform, or zone-level Sentry integration.
  static SentryEvent? filterAndSanitize(SentryEvent event, Hint hint) {
    final error = event.throwable as Object?;
    if (error is NetworkFailure ||
        error is TimeoutFailure ||
        error is CancelledFailure) {
      return null;
    }
    return sanitize(event, hint);
  }

  static SentryEvent sanitize(SentryEvent event, Hint _) {
    final privyAuthMessage = _privyAuthMessage(event.contexts['privy_auth']);
    final businessOperation = _safeBusinessOperation(
      event.contexts['business_operation'],
    );
    final trace = event.contexts.trace;
    if (trace != null) {
      trace.data = null;
      if (trace.description case final description?) {
        trace.description = redact(description);
      }
    }
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
        SentryTraceContext.type,
        'privy_auth',
        'business_operation',
      }.contains(key),
    );
    if (privyAuthMessage == null) {
      event.contexts.remove('privy_auth');
    } else {
      event.contexts['privy_auth'] = {'safe_message': privyAuthMessage};
    }
    if (businessOperation == null) {
      event.contexts.remove('business_operation');
    } else {
      event.contexts['business_operation'] = businessOperation;
    }
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
            data: _safeBreadcrumbData(breadcrumb),
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
          '"($_sensitiveValueKeyPattern)"\\s*:\\s*"[^"]*"',
          caseSensitive: false,
        ),
        (match) => '"${match.group(1)}":"<redacted>"',
      )
      .replaceAllMapped(
        RegExp(
          '\\b($_sensitiveValueKeyPattern)\\b\\s*([=:])\\s*(["\'])[^"\']*\\3',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}${match.group(2)}<redacted>',
      )
      .replaceAllMapped(
        RegExp(
          '\\b($_sensitiveValueKeyPattern)\\b\\s*([=:])\\s*[^\\s,&]+',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}${match.group(2)}<redacted>',
      )
      .replaceAllMapped(
        RegExp(
          '([?&](?:$_sensitiveValueKeyPattern)=)[^&#\\s]+',
          caseSensitive: false,
        ),
        (match) => '${match.group(1)}<redacted>',
      );

  static const _sensitiveValueKeyPattern =
      'access_token|authorization|code|id_token|state|token|signature|address|'
      'private[_-]?key|mnemonic|seed(?:[_-]?phrase)?|password|passphrase|'
      'client[_-]?secret|api[_-]?key|secret';

  static String? _privyAuthMessage(Object? context) {
    if (context is! Map<Object?, Object?>) return null;
    final message = context['safe_message'];
    if (message is! String || message.trim().isEmpty) return null;
    return redact(message)
        .replaceAll(RegExp(r'\b\d{4,10}\b'), '<redacted-code>');
  }

  static Map<String, Object?>? _safeBusinessOperation(Object? context) =>
      _safeMap(context, _businessOperationKeys);

  static Map<String, dynamic>? _safeBreadcrumbData(Breadcrumb breadcrumb) {
    final keys = switch (breadcrumb.category) {
      'business.operation' => _businessOperationKeys,
      'http' => _httpBreadcrumbKeys,
      _ => const <String>{},
    };
    final result = _safeMap(breadcrumb.data, keys);
    return result?.cast<String, dynamic>();
  }

  static Map<String, Object?>? _safeMap(Object? value, Set<String> keys) {
    if (value is! Map<Object?, Object?>) return null;
    final result = <String, Object?>{};
    for (final entry in value.entries) {
      final key = entry.key;
      if (key is! String || !keys.contains(key) || !_safeKey(key)) continue;
      final item = entry.value;
      if (item is String) {
        result[key] = redact(item);
      } else if (item is num || item is bool) {
        result[key] = item;
      }
    }
    return result.isEmpty ? null : result;
  }

  static const _businessOperationKeys = <String>{
    'operation',
    'outcome',
    'duration_ms',
    'failure_kind',
    'error_type',
    'request_id',
    'http_status',
    'api_code',
    'order_id',
    'withdrawal_id',
    'action_id',
    'execution_id',
    'position_id',
    'trade_intent_id',
    'funding_session_id',
    'plan_id',
    'transfer_id',
    'product_kind',
    'rail',
    'mode',
    'stage',
    'status',
  };

  static const _httpBreadcrumbKeys = <String>{
    'method',
    'status_code',
    'duration',
    'request_body_size',
    'response_body_size',
    'start_timestamp',
    'end_timestamp',
  };

  static bool _safeKey(String key) => !const {
    'token',
    'authorization',
    'cookie',
    'email',
    'address',
    'signature',
    'private_key',
    'private-key',
    'privatekey',
    'mnemonic',
    'seed',
    'password',
    'passphrase',
    'secret',
    'api_key',
    'api-key',
    'apikey',
    'payload',
    'body',
    'amount',
    'price',
    'quantity',
  }.any((fragment) => key.toLowerCase().contains(fragment));
}
