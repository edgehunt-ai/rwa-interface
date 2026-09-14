//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_action_status.g.dart';

class BstocksActionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_signature')
  static const BstocksActionStatus awaitingSignature = _$awaitingSignature;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const BstocksActionStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'confirmed')
  static const BstocksActionStatus confirmed = _$confirmed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const BstocksActionStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const BstocksActionStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksActionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<BstocksActionStatus> get serializer => _$bstocksActionStatusSerializer;

  const BstocksActionStatus._(String name): super(name);

  static BuiltSet<BstocksActionStatus> get values => _$values;
  static BstocksActionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BstocksActionStatusMixin = Object with _$BstocksActionStatusMixin;

