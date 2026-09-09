//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_capability_status.g.dart';

class FundingRouteCapabilityStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const FundingRouteCapabilityStatus available = _$available;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const FundingRouteCapabilityStatus unavailable = _$unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRouteCapabilityStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<FundingRouteCapabilityStatus> get serializer => _$fundingRouteCapabilityStatusSerializer;

  const FundingRouteCapabilityStatus._(String name): super(name);

  static BuiltSet<FundingRouteCapabilityStatus> get values => _$values;
  static FundingRouteCapabilityStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingRouteCapabilityStatusMixin = Object with _$FundingRouteCapabilityStatusMixin;

