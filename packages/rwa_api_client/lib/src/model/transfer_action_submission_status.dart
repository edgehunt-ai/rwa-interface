//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_action_submission_status.g.dart';

class TransferActionSubmissionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'reported')
  static const TransferActionSubmissionStatus reported = _$reported;
  @BuiltValueEnumConst(wireName: r'verifying')
  static const TransferActionSubmissionStatus verifying = _$verifying;
  @BuiltValueEnumConst(wireName: r'verified')
  static const TransferActionSubmissionStatus verified = _$verified;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferActionSubmissionStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferActionSubmissionStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferActionSubmissionStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferActionSubmissionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferActionSubmissionStatus> get serializer => _$transferActionSubmissionStatusSerializer;

  const TransferActionSubmissionStatus._(String name): super(name);

  static BuiltSet<TransferActionSubmissionStatus> get values => _$values;
  static TransferActionSubmissionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferActionSubmissionStatusMixin = Object with _$TransferActionSubmissionStatusMixin;

