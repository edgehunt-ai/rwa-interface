//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_availability_status.g.dart';

class PortfolioAvailabilityStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const PortfolioAvailabilityStatus available = _$available;
  @BuiltValueEnumConst(wireName: r'partial')
  static const PortfolioAvailabilityStatus partial = _$partial;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioAvailabilityStatus unavailable = _$unavailable;

  static Serializer<PortfolioAvailabilityStatus> get serializer => _$portfolioAvailabilityStatusSerializer;

  const PortfolioAvailabilityStatus._(String name): super(name);

  static BuiltSet<PortfolioAvailabilityStatus> get values => _$values;
  static PortfolioAvailabilityStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioAvailabilityStatusMixin = Object with _$PortfolioAvailabilityStatusMixin;

