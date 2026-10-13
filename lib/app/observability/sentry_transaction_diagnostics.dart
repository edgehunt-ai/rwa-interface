import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class SentryTransactionDiagnostics {
  static SentryTransaction inspect(SentryTransaction transaction, Hint _) {
    try {
      debugPrint(
        'Sentry transaction diagnostic: ${summarize(transaction.toJson())}',
      );
    } on Object catch (error) {
      debugPrint('Sentry transaction diagnostic failed: ${error.runtimeType}');
    }
    return transaction;
  }

  @visibleForTesting
  static String summarize(Map<String, dynamic> event) {
    final start = _timestamp(event['start_timestamp']);
    final end = _timestamp(event['timestamp']);
    final contexts = event['contexts'];
    final trace = contexts is Map ? contexts['trace'] : null;
    final traceId = trace is Map ? trace['trace_id'] : null;
    final spanId = trace is Map ? trace['span_id'] : null;
    final spans = event['spans'];
    var missingStart = 0;
    var missingEnd = 0;
    var reversed = 0;
    var missingTraceId = 0;
    var missingSpanId = 0;

    if (spans is List) {
      for (final span in spans) {
        final fields = span is Map ? span : const <String, dynamic>{};
        final spanStart = _timestamp(fields['start_timestamp']);
        final spanEnd = _timestamp(fields['timestamp']);
        if (spanStart == null) missingStart++;
        if (spanEnd == null) missingEnd++;
        if (spanStart != null &&
            spanEnd != null &&
            spanEnd.isBefore(spanStart)) {
          reversed++;
        }
        if (!_hasId(fields['trace_id'])) missingTraceId++;
        if (!_hasId(fields['span_id'])) missingSpanId++;
      }
    }

    return 'root_start_valid=${start != null} '
        'root_end_valid=${end != null} '
        'root_order_valid=${start != null && end != null && !end.isBefore(start)} '
        'trace_id_present=${_hasId(traceId)} '
        'span_id_present=${_hasId(spanId)} '
        'span_count=${spans is List ? spans.length : 0} '
        'span_missing_start=$missingStart '
        'span_missing_end=$missingEnd '
        'span_reversed=$reversed '
        'span_missing_trace_id=$missingTraceId '
        'span_missing_span_id=$missingSpanId';
  }

  static DateTime? _timestamp(Object? value) =>
      value is String ? DateTime.tryParse(value) : null;

  static bool _hasId(Object? value) => value is String && value.isNotEmpty;
}
