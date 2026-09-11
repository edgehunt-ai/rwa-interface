//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_status.g.dart';

class SelfCustodialWithdrawalStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_submission')
  static const SelfCustodialWithdrawalStatus awaitingSubmission = _$awaitingSubmission;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const SelfCustodialWithdrawalStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'confirming')
  static const SelfCustodialWithdrawalStatus confirming = _$confirming;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const SelfCustodialWithdrawalStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const SelfCustodialWithdrawalStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'noncanonical')
  static const SelfCustodialWithdrawalStatus noncanonical = _$noncanonical;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const SelfCustodialWithdrawalStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SelfCustodialWithdrawalStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<SelfCustodialWithdrawalStatus> get serializer => _$selfCustodialWithdrawalStatusSerializer;

  const SelfCustodialWithdrawalStatus._(String name): super(name);

  static BuiltSet<SelfCustodialWithdrawalStatus> get values => _$values;
  static SelfCustodialWithdrawalStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SelfCustodialWithdrawalStatusMixin = Object with _$SelfCustodialWithdrawalStatusMixin;

