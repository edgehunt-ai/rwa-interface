//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_transfer_status.g.dart';

class LegacyTransferStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending')
  static const LegacyTransferStatus pending = _$pending;
  @BuiltValueEnumConst(wireName: r'processing')
  static const LegacyTransferStatus processing = _$processing;
  @BuiltValueEnumConst(wireName: r'claim_required')
  static const LegacyTransferStatus claimRequired = _$claimRequired;
  @BuiltValueEnumConst(wireName: r'completed')
  static const LegacyTransferStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const LegacyTransferStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const LegacyTransferStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const LegacyTransferStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyTransferStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<LegacyTransferStatus> get serializer =>
      _$legacyTransferStatusSerializer;

  const LegacyTransferStatus._(String name) : super(name);

  static BuiltSet<LegacyTransferStatus> get values => _$values;
  static LegacyTransferStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LegacyTransferStatusMixin = Object
    with _$LegacyTransferStatusMixin;
