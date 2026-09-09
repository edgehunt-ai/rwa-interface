import 'api_failure.dart';

sealed class QueryState<T> {
  const QueryState();
}

final class QueryLoading<T> extends QueryState<T> {
  const QueryLoading();
}

final class QueryEmpty<T> extends QueryState<T> {
  const QueryEmpty({this.asOf});
  final DateTime? asOf;
}

final class QueryData<T> extends QueryState<T> {
  const QueryData(
    this.value, {
    this.isRefreshing = false,
    this.asOf,
    this.refreshFailure,
  });

  final T value;
  final bool isRefreshing;
  final DateTime? asOf;
  final ApiFailure? refreshFailure;
}

final class QueryFailure<T> extends QueryState<T> {
  const QueryFailure(this.failure);
  final ApiFailure failure;
}

sealed class CommandState<I, R> {
  const CommandState();
}

final class CommandIdle<I, R> extends CommandState<I, R> {
  const CommandIdle();
}

final class CommandSubmitting<I, R> extends CommandState<I, R> {
  const CommandSubmitting(this.intent, this.idempotencyKey);
  final I intent;
  final String idempotencyKey;
}

final class CommandAccepted<I, R> extends CommandState<I, R> {
  const CommandAccepted({
    required this.intent,
    required this.idempotencyKey,
    required this.result,
  });
  final I intent;
  final String idempotencyKey;
  final R result;
}

final class CommandFailure<I, R> extends CommandState<I, R> {
  const CommandFailure({
    required this.intent,
    required this.idempotencyKey,
    required this.failure,
  });
  final I intent;
  final String idempotencyKey;
  final ApiFailure failure;
}
