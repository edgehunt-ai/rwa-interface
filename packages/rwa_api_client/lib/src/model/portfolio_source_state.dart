//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_source_state.g.dart';

class PortfolioSourceState extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const PortfolioSourceState available = _$available;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioSourceState unavailable = _$unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioSourceState unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<PortfolioSourceState> get serializer => _$portfolioSourceStateSerializer;

  const PortfolioSourceState._(String name): super(name);

  static BuiltSet<PortfolioSourceState> get values => _$values;
  static PortfolioSourceState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioSourceStateMixin = Object with _$PortfolioSourceStateMixin;

