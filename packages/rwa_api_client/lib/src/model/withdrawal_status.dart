//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_status.g.dart';

class WithdrawalStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending_signature')
  static const WithdrawalStatus pendingSignature = _$pendingSignature;
  @BuiltValueEnumConst(wireName: r'processing')
  static const WithdrawalStatus processing = _$processing;
  @BuiltValueEnumConst(wireName: r'sent')
  static const WithdrawalStatus sent = _$sent;
  @BuiltValueEnumConst(wireName: r'completed')
  static const WithdrawalStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const WithdrawalStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const WithdrawalStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const WithdrawalStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WithdrawalStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<WithdrawalStatus> get serializer =>
      _$withdrawalStatusSerializer;

  const WithdrawalStatus._(String name) : super(name);

  static BuiltSet<WithdrawalStatus> get values => _$values;
  static WithdrawalStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class WithdrawalStatusMixin = Object with _$WithdrawalStatusMixin;
