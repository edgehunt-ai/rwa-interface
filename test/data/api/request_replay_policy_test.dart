import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/request_replay_policy.dart';

void main() {
  const policy = RequestReplayPolicy();
  test(
    'GET is replayable',
    () => expect(
      policy.canReplay(RequestOptions(path: '/', method: 'GET')),
      isTrue,
    ),
  );
  test(
    'mutation requires idempotency key',
    () => expect(
      policy.canReplay(
        RequestOptions(path: '/', method: 'POST', data: <String, Object?>{}),
      ),
      isFalse,
    ),
  );
  test(
    'idempotent mutation with buffered body is replayable',
    () => expect(
      policy.canReplay(
        RequestOptions(
          path: '/',
          method: 'POST',
          data: <String, Object?>{},
          headers: {'Idempotency-Key': 'same'},
        ),
      ),
      isTrue,
    ),
  );
  test(
    'stream body is never replayed',
    () => expect(
      policy.canReplay(
        RequestOptions(
          path: '/',
          method: 'POST',
          data: const Stream<List<int>>.empty(),
          headers: {'Idempotency-Key': 'same'},
        ),
      ),
      isFalse,
    ),
  );
}
