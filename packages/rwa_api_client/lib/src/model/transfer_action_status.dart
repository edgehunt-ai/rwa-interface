//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transfer_action_status.g.dart';

class TransferActionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'planned')
  static const TransferActionStatus planned = _$planned;
  @BuiltValueEnumConst(wireName: r'ready')
  static const TransferActionStatus ready = _$ready;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const TransferActionStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const TransferActionStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const TransferActionStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const TransferActionStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const TransferActionStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TransferActionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<TransferActionStatus> get serializer => _$transferActionStatusSerializer;

  const TransferActionStatus._(String name): super(name);

  static BuiltSet<TransferActionStatus> get values => _$values;
  static TransferActionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransferActionStatusMixin = Object with _$TransferActionStatusMixin;

