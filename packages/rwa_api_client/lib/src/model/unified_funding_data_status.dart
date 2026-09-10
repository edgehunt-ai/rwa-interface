//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_funding_data_status.g.dart';

class UnifiedFundingDataStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'complete')
  static const UnifiedFundingDataStatus complete = _$complete;
  @BuiltValueEnumConst(wireName: r'partial')
  static const UnifiedFundingDataStatus partial = _$partial;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const UnifiedFundingDataStatus unavailable = _$unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnifiedFundingDataStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<UnifiedFundingDataStatus> get serializer => _$unifiedFundingDataStatusSerializer;

  const UnifiedFundingDataStatus._(String name): super(name);

  static BuiltSet<UnifiedFundingDataStatus> get values => _$values;
  static UnifiedFundingDataStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class UnifiedFundingDataStatusMixin = Object with _$UnifiedFundingDataStatusMixin;

