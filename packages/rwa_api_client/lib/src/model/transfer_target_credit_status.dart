//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_target_credit_status.g.dart';

class TransferTargetCreditStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const TransferTargetCreditStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const TransferTargetCreditStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const TransferTargetCreditStatus unavailable = _$unavailable;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferTargetCreditStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferTargetCreditStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferTargetCreditStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferTargetCreditStatus> get serializer => _$transferTargetCreditStatusSerializer;

  const TransferTargetCreditStatus._(String name): super(name);

  static BuiltSet<TransferTargetCreditStatus> get values => _$values;
  static TransferTargetCreditStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferTargetCreditStatusMixin = Object with _$TransferTargetCreditStatusMixin;

