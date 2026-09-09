//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'wallet_action_execution_status.g.dart';

class WalletActionExecutionStatus extends EnumClass {
  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'awaiting_user_authorization')
  static const WalletActionExecutionStatus awaitingUserAuthorization =
      _$awaitingUserAuthorization;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'submitting')
  static const WalletActionExecutionStatus submitting = _$submitting;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'provider_submitted')
  static const WalletActionExecutionStatus providerSubmitted =
      _$providerSubmitted;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'chain_confirmed')
  static const WalletActionExecutionStatus chainConfirmed = _$chainConfirmed;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'completed')
  static const WalletActionExecutionStatus completed = _$completed;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'user_gas_confirmation_required')
  static const WalletActionExecutionStatus userGasConfirmationRequired =
      _$userGasConfirmationRequired;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'failed')
  static const WalletActionExecutionStatus failed = _$failed;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const WalletActionExecutionStatus ambiguous = _$ambiguous;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const WalletActionExecutionStatus manualReview = _$manualReview;

  /// `submitting` is durably entered with compare-and-set before the synchronous Privy relay. A Privy timeout, 5xx response or process crash after that point is not a deterministic rejection: it transitions to `ambiguous` or `manual_review` and must never be automatically replayed.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WalletActionExecutionStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<WalletActionExecutionStatus> get serializer =>
      _$walletActionExecutionStatusSerializer;

  const WalletActionExecutionStatus._(String name) : super(name);

  static BuiltSet<WalletActionExecutionStatus> get values => _$values;
  static WalletActionExecutionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WalletActionExecutionStatusMixin = Object
    with _$WalletActionExecutionStatusMixin;
