import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/hip3_step_confirmation.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import 'session_scope.dart';

final hip3ConfirmationProvider =
    NotifierProvider<Hip3ConfirmationController, Hip3StepConfirmation?>(
      Hip3ConfirmationController.new,
    );

/// Session-bound handoff between the action executor and a confirmation view.
/// No view response, expiration or logout is never treated as consent.
final class Hip3ConfirmationController extends Notifier<Hip3StepConfirmation?> {
  Completer<bool>? _pending;

  @override
  Hip3StepConfirmation? build() {
    ref.watch(sessionGenerationProvider);
    ref.onDispose(() {
      final pending = _pending;
      if (pending != null && !pending.isCompleted) pending.complete(false);
      _pending = null;
    });
    return null;
  }

  Future<bool> request(Hip3StepConfirmation confirmation) async {
    if (_pending != null) {
      throw const Hip3SigningFailure(
        Hip3SigningFailureCode.actionNotReady,
        retryable: true,
      );
    }
    final remaining = confirmation.validUntil.difference(
      DateTime.now().toUtc(),
    );
    if (remaining <= Duration.zero) return false;
    final pending = Completer<bool>();
    _pending = pending;
    state = confirmation;
    try {
      return await pending.future.timeout(remaining, onTimeout: () => false);
    } finally {
      if (identical(_pending, pending)) {
        _pending = null;
        state = null;
      }
    }
  }

  void respond({
    required String actionId,
    required String stepId,
    required bool accepted,
  }) {
    final current = state;
    final pending = _pending;
    if (current == null ||
        pending == null ||
        pending.isCompleted ||
        current.actionId != actionId ||
        current.stepId != stepId) {
      return;
    }
    pending.complete(
      accepted && current.validUntil.isAfter(DateTime.now().toUtc()),
    );
  }
}
