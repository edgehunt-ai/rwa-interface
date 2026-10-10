import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
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
}

Future<_SentryFixture> _initializeSentry({
  _TestPlatformDispatcher? testDispatcher,
}) async {
  await Sentry.close();
  final originalFlutterError = FlutterError.onError;
  final dispatcher = WidgetsBinding.instance.platformDispatcher;
  final originalPlatformError = dispatcher.onError;
  final transport = _RecordingTransport();

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
  return _SentryFixture(transport);
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
  const _SentryFixture(this.transport);

  final _RecordingTransport transport;
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
