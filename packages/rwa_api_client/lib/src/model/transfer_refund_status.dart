//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_refund_status.g.dart';

class TransferRefundStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const TransferRefundStatus notApplicable = _$notApplicable;
  @BuiltValueEnumConst(wireName: r'eligible')
  static const TransferRefundStatus eligible = _$eligible;
  @BuiltValueEnumConst(wireName: r'pending')
  static const TransferRefundStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const TransferRefundStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferRefundStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferRefundStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferRefundStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferRefundStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferRefundStatus> get serializer => _$transferRefundStatusSerializer;

  const TransferRefundStatus._(String name): super(name);

  static BuiltSet<TransferRefundStatus> get values => _$values;
  static TransferRefundStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferRefundStatusMixin = Object with _$TransferRefundStatusMixin;

