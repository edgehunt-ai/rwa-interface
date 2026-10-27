import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/observability_reporter.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/repositories/hip3_order_execution_repository.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
// The SDK exposes OnErrorIntegration publicly but keeps its dispatcher adapter internal.
// ignore: implementation_imports
import 'package:sentry_flutter/src/utils/platform_dispatcher_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('captures a framework error exactly once', () async {
    final fixture = await _initializeSentry();

    FlutterError.reportError(
      FlutterErrorDetails(
        exception: StateError('framework failure'),
        stack: StackTrace.current,
      ),
    );
    await fixture.transport.waitForEventCount(1);

    _expectSingleEvent(fixture.transport, mechanism: 'FlutterError');
  });

  test('captures a platform asynchronous error exactly once', () async {
    final dispatcher = _TestPlatformDispatcher();
    final fixture = await _initializeSentry(testDispatcher: dispatcher);

    dispatcher.onError!(StateError('async failure'), StackTrace.current);
    await fixture.transport.waitForEventCount(1);

    _expectSingleEvent(
      fixture.transport,
      mechanism: 'PlatformDispatcher.onError',
    );
  });

  test('captures an uncaught zone error exactly once', () async {
    final fixture = await _initializeSentry();

    Sentry.runZonedGuarded<void>(
      () => throw StateError('zone failure'),
      (_, _) {},
    );
    await fixture.transport.waitForEventCount(1);

    _expectSingleEvent(fixture.transport, mechanism: 'runZonedGuarded');
  });

  test('groups a business failure without using resource IDs', () async {
    final fixture = await _initializeSentry();
    final reporter = SentryObservabilityReporter();

    reporter.recordApiFailure(
      operation: 'create_order',
      failure: const CompatibilityFailure(requestId: 'request-1'),
      context: const {'order_id': 'order-1', 'stage': 'submit'},
      duration: const Duration(milliseconds: 125),
    );
    await fixture.transport.waitForEventCount(1);

    final event = fixture.transport.events.single;
    expect(event.fingerprint, [
      'business-operation',
      'create_order',
      'compatibility',
      'compatibility',
    ]);
    expect(event.contexts['business_operation'], {
      'operation': 'create_order',
      'order_id': 'order-1',
      'stage': 'submit',
      'failure_kind': 'compatibility',
      'request_id': 'request-1',
      'duration_ms': 125,
    });
  });

  test(
    'pending cancellation retains its cause with a stable release identity',
    () async {
      final fixture = await _initializeSentry();
      SentryObservabilityReporter().recordError(
        operation: 'cancel_order',
        error: const Hip3ExecutionPending(
          'order-1',
          'action-1',
          requiresReview: true,
          reason: 'Venue confirmation delayed token=secret-token',
          failure: ServerFailure(
            statusCode: 503,
            code: 'venue_unavailable',
            requestId: 'request-1',
          ),
        ),
      );
      await fixture.transport.waitForEventCount(1);
      final event = fixture.transport.events.single;
      expect(event.exceptions!.single.type, 'Hip3ExecutionPending');
      expect(
        event.exceptions!.single.value,
        'Venue confirmation delayed token=<redacted>',
      );
      expect(event.fingerprint!.last, 'Hip3ExecutionPending:manual_review');
      expect(
        event.contexts['business_operation'],
        containsPair('action_id', 'action-1'),
      );
      expect(
        event.contexts['business_operation'],
        containsPair('request_id', 'request-1'),
      );
      expect(
        event.contexts['business_operation'],
        containsPair('http_status', '503'),
      );
      expect(
        event.contexts['business_operation'],
        containsPair('requires_review', 'true'),
      );
    },
  );

  test(
    'quote changes and signing failures have readable release diagnostics',
    () async {
      final fixture = await _initializeSentry();
      final reporter = SentryObservabilityReporter();
      reporter.recordError(
        operation: 'hip3_withdrawal_prepare',
        error: const Hip3WithdrawalQuoteChanged(),
      );
      await fixture.transport.waitForEventCount(1);
      final quote = fixture.transport.events.single;
      expect(quote.exceptions!.single.type, 'Hip3WithdrawalQuoteChanged');
      expect(
        quote.exceptions!.single.value,
        contains('Refresh and review before signing'),
      );
      expect(
        quote.fingerprint!.last,
        'Hip3WithdrawalQuoteChanged:quote_changed',
      );

      reporter.recordError(
        operation: 'hip3_withdrawal_submit',
        error: const Hip3SigningFailure(
          Hip3SigningFailureCode.actionNotReady,
          reason: 'Action expired. Bearer signing-secret',
          failureCode: 'action_expired',
        ),
      );
      await fixture.transport.waitForEventCount(2);
      final signing = fixture.transport.events.last;
      expect(signing.exceptions!.single.type, 'Hip3SigningFailure');
      expect(
        signing.exceptions!.single.value,
        'Action expired. Bearer <redacted>',
      );
      expect(
        signing.contexts['business_operation'],
        containsPair('failure_code', 'action_expired'),
      );
    },
  );

  test('reports safe decoding diagnostics without response content', () async {
    final fixture = await _initializeSentry();

    SentryObservabilityReporter().recordApiFailure(
      operation: 'tp-sl',
      failure: const DecodingFailure(
        requestId: 'request-1',
        diagnostics: (
          apiOperation: 'orders.get_hip3_action',
          responseModel: 'Hip3Action',
          httpStatus: 200,
          contentType: 'application/json',
          responseBodySize: 321,
          decoderError: 'generated_client',
        ),
      ),
    );
    await fixture.transport.waitForEventCount(1);

    final event = fixture.transport.events.single;
    expect(event.tags, containsPair('api_operation', 'orders.get_hip3_action'));
    expect(event.tags, containsPair('response_model', 'Hip3Action'));
    expect(event.tags, containsPair('decoder_error', 'generated_client'));
    expect(event.contexts['business_operation'], {
      'operation': 'tp-sl',
      'failure_kind': 'decoding',
      'request_id': 'request-1',
      'api_operation': 'orders.get_hip3_action',
      'response_model': 'Hip3Action',
      'http_status': '200',
      'response_content_type': 'application/json',
      'response_size_bytes': '321',
      'decoder_error': 'generated_client',
    });
  });

  test('network failure emits no event or business breadcrumb', () async {
    final fixture = await _initializeSentry();
    final reporter = SentryObservabilityReporter();
    reporter.recordApiFailure(
      operation: 'create_order',
      failure: const NetworkFailure(),
    );

    await Future<void>.delayed(const Duration(milliseconds: 100));
    final control = StateError('control failure');
    reporter.recordError(operation: 'control_operation', error: control);
    await fixture.transport.waitForEventCount(1);

    expect(
      fixture.transport.events.single.breadcrumbs?.where(
        (breadcrumb) =>
            breadcrumb.category == 'business.operation' &&
            breadcrumb.message?.startsWith('create_order:') == true,
      ),
      isEmpty,
    );
    expect(fixture.captureFailedRequests, isFalse);
    expect(fixture.captureNativeFailedRequests, isFalse);
  });

  test('global capture drops network and timeout failures', () async {
    final fixture = await _initializeSentry();

    await Sentry.captureException(const NetworkFailure());
    await Sentry.captureException(const TimeoutFailure());
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(fixture.transport.events, isEmpty);
  });

  test('cancellation is counted separately from failures', () async {
    final fixture = await _initializeSentry();
    final reporter = SentryObservabilityReporter();

    reporter.recordApiFailure(
      operation: 'close_position',
      failure: const CancelledFailure(),
    );
    await Future<void>.delayed(const Duration(milliseconds: 100));
    reporter.recordError(
      operation: 'control_operation',
      error: StateError('control failure'),
    );
    await fixture.transport.waitForEventCount(1);

    final messages = fixture.transport.events.single.breadcrumbs
        ?.map((breadcrumb) => breadcrumb.message)
        .toList();
    expect(messages, contains('close_position:cancelled'));
    expect(messages, isNot(contains('close_position:failed')));
  });

  test('explicit and subsequent global capture send one event', () async {
    final fixture = await _initializeSentry();
    final error = StateError('reported then rethrown');

    SentryObservabilityReporter().recordError(
      operation: 'submit_order',
      error: error,
    );
    await fixture.transport.waitForEventCount(1);
    await Sentry.captureException(error);
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(fixture.transport.events, hasLength(1));
  });
}

Future<_SentryFixture> _initializeSentry({
  _TestPlatformDispatcher? testDispatcher,
}) async {
  await Sentry.close();
  final originalFlutterError = FlutterError.onError;
  final dispatcher = WidgetsBinding.instance.platformDispatcher;
  final originalPlatformError = dispatcher.onError;
  final transport = _RecordingTransport();
  var captureFailedRequests = true;
  bool? captureNativeFailedRequests;

  FlutterError.onError = (_) {};
  dispatcher.onError = (_, _) => true;
  addTearDown(() async {
    await Sentry.close();
    FlutterError.onError = originalFlutterError;
    dispatcher.onError = originalPlatformError;
  });

  await SentryBootstrap.initializeForTesting(
    const ObservabilityConfig(
      dsn: 'https://public@example.invalid/1',
      environment: 'integration-test',
      release: 'nobell@test',
      tracesSampleRate: 0,
      profilesSampleRate: 0,
    ),
    () {},
    optionsOverride: (options) {
      captureFailedRequests = options.captureFailedRequests;
      captureNativeFailedRequests = options.captureNativeFailedRequests;
      options
        ..transport = transport
        ..autoInitializeNativeSdk = false;
      for (final integration
          in options.integrations.whereType<LoadReleaseIntegration>()) {
        options.removeIntegration(integration);
      }
      if (testDispatcher != null) {
        for (final integration
            in options.integrations.whereType<OnErrorIntegration>()) {
          options.removeIntegration(integration);
        }
        options.addIntegration(
          OnErrorIntegration(
            dispatchWrapper: PlatformDispatcherWrapper(testDispatcher),
          ),
        );
      }
    },
  );
  return _SentryFixture(
    transport,
    captureFailedRequests: captureFailedRequests,
    captureNativeFailedRequests: captureNativeFailedRequests,
  );
}

void _expectSingleEvent(
  _RecordingTransport transport, {
  required String mechanism,
}) {
  expect(transport.events, hasLength(1));
  final event = transport.events.single;
  expect(event.environment, 'integration-test');
  expect(event.release, 'nobell@test');
  expect(
    event.exceptions?.any(
      (exception) => exception.mechanism?.type == mechanism,
    ),
    isTrue,
  );
}

final class _SentryFixture {
  const _SentryFixture(
    this.transport, {
    required this.captureFailedRequests,
    required this.captureNativeFailedRequests,
  });

  final _RecordingTransport transport;
  final bool captureFailedRequests;
  final bool? captureNativeFailedRequests;
}

final class _TestPlatformDispatcher implements PlatformDispatcher {
  ErrorCallback? _onError;

  @override
  ErrorCallback? get onError => _onError;

  @override
  set onError(ErrorCallback? value) => _onError = value;

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

final class _RecordingTransport implements Transport {
  final events = <SentryEvent>[];
  Completer<void>? _waiter;
  int _targetCount = 0;

  Future<void> waitForEventCount(int count) {
    if (events.length >= count) return Future.value();
    _targetCount = count;
    _waiter = Completer<void>();
    return _waiter!.future.timeout(const Duration(seconds: 2));
  }

  @override
  Future<SentryId> send(SentryEnvelope envelope) async {
    for (final item in envelope.items) {
      if (item.originalObject case final SentryEvent event) {
        events.add(event);
      }
    }
    if (events.length >= _targetCount) {
      _waiter?.complete();
      _waiter = null;
    }
    return envelope.header.eventId ?? SentryId.empty();
  }
}
