import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/services/hip3_preparation_cache.dart';

void main() {
  test('concurrent retries retain the original prepared snapshot', () async {
    final cache = Hip3PreparationCache();
    final prepared = Completer<String>();
    var calls = 0;
    Future<String> prepare() {
      calls++;
      return prepared.future;
    }

    final first = cache.get('key', 'close:position:100%', prepare);
    final second = cache.get('key', 'close:position:100%', prepare);
    prepared.complete('preview-1');
    expect(await first, 'preview-1');
    expect(await second, 'preview-1');
    expect(
      await cache.get('key', 'close:position:100%', () async => 'preview-2'),
      'preview-1',
    );
    expect(calls, 1);
  });
  test('changed business parameters cannot reuse a preparation key', () async {
    final cache = Hip3PreparationCache();
    await cache.get('key', 'leverage:2', () async => 'context');
    await expectLater(
      cache.get('key', 'leverage:3', () async => 'new'),
      throwsArgumentError,
    );
  });
  test(
    'failed preparation can be retried without retaining failed futures',
    () async {
      final cache = Hip3PreparationCache();
      await expectLater(
        cache.get<String>(
          'key',
          'same',
          () async => throw StateError('offline'),
        ),
        throwsStateError,
      );
      expect(await cache.get('key', 'same', () async => 'ready'), 'ready');
    },
  );
}
