import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/order.dart';

/// Saves only execution identity and a submission marker. Authorization
/// payloads and signatures are never stored. The marker prevents re-signing
/// after process loss or an uncertain submission response.
final class BstocksSponsoredExecutionJournal {
  BstocksSponsoredExecutionJournal() : _preferences = null;

  BstocksSponsoredExecutionJournal.persistent()
    : _preferences = SharedPreferences.getInstance;

  final Future<SharedPreferences> Function()? _preferences;
  final _executionIds = <String, String>{};
  final _submitted = <String>{};
  final _inFlight = <String, Future<void>>{};

  String _key(BstocksOrderAction action) =>
      'bstocks.execution.${action.chainId}.${action.from.toLowerCase()}.'
      '${action.orderId}.${action.actionId}';

  Future<String?> executionId(BstocksOrderAction action) async {
    final prefs = await _preferences?.call();
    return _executionIds[_key(action)] ?? prefs?.getString(_key(action));
  }

  Future<void> saveExecutionId(
    BstocksOrderAction action,
    String executionId,
  ) async {
    final prefs = await _preferences?.call();
    if (prefs != null && !await prefs.setString(_key(action), executionId)) {
      throw const UnknownFailure(
        userAction: 'Cannot save wallet execution identity',
      );
    }
    _executionIds[_key(action)] = executionId;
  }

  Future<bool> submissionStarted(String executionId) async {
    final prefs = await _preferences?.call();
    return _submitted.contains(executionId) ||
        (prefs?.getBool('bstocks.execution.submitted.$executionId') ?? false);
  }

  Future<void> markSubmissionStarted(String executionId) async {
    final prefs = await _preferences?.call();
    if (prefs != null &&
        !await prefs.setBool(
          'bstocks.execution.submitted.$executionId',
          true,
        )) {
      throw const UnknownFailure(
        userAction: 'Cannot save wallet execution submission evidence',
      );
    }
    _submitted.add(executionId);
  }

  /// Local cancellation before POST or a definitive API rejection before
  /// relay permits another submission.
  /// Unknown transport/provider results must retain their durable marker.
  Future<void> clearSubmissionStarted(String executionId) async {
    final prefs = await _preferences?.call();
    if (prefs != null &&
        !await prefs.remove('bstocks.execution.submitted.$executionId')) {
      throw const UnknownFailure(
        userAction: 'Cannot save wallet execution rejection evidence',
      );
    }
    _submitted.remove(executionId);
  }

  /// Coalesces authorization work for the same action within one provider.
  Future<void> run(BstocksOrderAction action, Future<void> Function() send) {
    final key = _key(action);
    if (_inFlight[key] case final active?) return active;
    final request = send();
    _inFlight[key] = request;
    return request.whenComplete(() => _inFlight.remove(key));
  }
}
