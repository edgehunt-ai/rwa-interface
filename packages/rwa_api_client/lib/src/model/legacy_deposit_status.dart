//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_deposit_status.g.dart';

@Deprecated('LegacyDepositStatus has been deprecated')
class LegacyDepositStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting')
  static const LegacyDepositStatus awaiting = _$awaiting;
  @BuiltValueEnumConst(wireName: r'confirming')
  static const LegacyDepositStatus confirming = _$confirming;
  @BuiltValueEnumConst(wireName: r'credited')
  static const LegacyDepositStatus credited = _$credited;
  @BuiltValueEnumConst(wireName: r'failed')
  static const LegacyDepositStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const LegacyDepositStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const LegacyDepositStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyDepositStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<LegacyDepositStatus> get serializer => _$legacyDepositStatusSerializer;

  const LegacyDepositStatus._(String name): super(name);

  static BuiltSet<LegacyDepositStatus> get values => _$values;
  static LegacyDepositStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LegacyDepositStatusMixin = Object with _$LegacyDepositStatusMixin;

