//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_observation_status.g.dart';

class DepositObservationStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'detected')
  static const DepositObservationStatus detected = _$detected;
  @BuiltValueEnumConst(wireName: r'confirming')
  static const DepositObservationStatus confirming = _$confirming;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const DepositObservationStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const DepositObservationStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositObservationStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositObservationStatus> get serializer => _$depositObservationStatusSerializer;

  const DepositObservationStatus._(String name): super(name);

  static BuiltSet<DepositObservationStatus> get values => _$values;
  static DepositObservationStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositObservationStatusMixin = Object with _$DepositObservationStatusMixin;

