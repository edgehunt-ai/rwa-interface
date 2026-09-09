//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_recovery_status.g.dart';

class TransferRecoveryStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'none')
  static const TransferRecoveryStatus none = _$none;
  @BuiltValueEnumConst(wireName: r'tracking')
  static const TransferRecoveryStatus tracking = _$tracking;
  @BuiltValueEnumConst(wireName: r'refund_tracking')
  static const TransferRecoveryStatus refundTracking = _$refundTracking;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferRecoveryStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferRecoveryStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferRecoveryStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<TransferRecoveryStatus> get serializer =>
      _$transferRecoveryStatusSerializer;

  const TransferRecoveryStatus._(String name) : super(name);

  static BuiltSet<TransferRecoveryStatus> get values => _$values;
  static TransferRecoveryStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferRecoveryStatusMixin = Object
    with _$TransferRecoveryStatusMixin;
