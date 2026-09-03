//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_status.g.dart';

class DepositStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting')
  static const DepositStatus awaiting = _$awaiting;
  @BuiltValueEnumConst(wireName: r'confirming')
  static const DepositStatus confirming = _$confirming;
  @BuiltValueEnumConst(wireName: r'credited')
  static const DepositStatus credited = _$credited;
  @BuiltValueEnumConst(wireName: r'failed')
  static const DepositStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const DepositStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const DepositStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositStatus> get serializer => _$depositStatusSerializer;

  const DepositStatus._(String name): super(name);

  static BuiltSet<DepositStatus> get values => _$values;
  static DepositStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositStatusMixin = Object with _$DepositStatusMixin;

