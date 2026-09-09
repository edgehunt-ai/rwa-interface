//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_notice_severity.g.dart';

class PortfolioNoticeSeverity extends EnumClass {
  @BuiltValueEnumConst(wireName: r'info')
  static const PortfolioNoticeSeverity info = _$info;
  @BuiltValueEnumConst(wireName: r'warning')
  static const PortfolioNoticeSeverity warning = _$warning;
  @BuiltValueEnumConst(wireName: r'error')
  static const PortfolioNoticeSeverity error = _$error;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioNoticeSeverity unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<PortfolioNoticeSeverity> get serializer =>
      _$portfolioNoticeSeveritySerializer;

  const PortfolioNoticeSeverity._(String name) : super(name);

  static BuiltSet<PortfolioNoticeSeverity> get values => _$values;
  static PortfolioNoticeSeverity valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioNoticeSeverityMixin = Object
    with _$PortfolioNoticeSeverityMixin;
