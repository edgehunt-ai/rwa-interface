//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction_mode.g.dart';

class Hip3AccountAbstractionMode extends EnumClass {

  @BuiltValueEnumConst(wireName: r'default')
  static const Hip3AccountAbstractionMode default_ = _$default_;
  @BuiltValueEnumConst(wireName: r'unifiedAccount')
  static const Hip3AccountAbstractionMode unifiedAccount = _$unifiedAccount;
  @BuiltValueEnumConst(wireName: r'portfolioMargin')
  static const Hip3AccountAbstractionMode portfolioMargin = _$portfolioMargin;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionMode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionMode> get serializer => _$hip3AccountAbstractionModeSerializer;

  const Hip3AccountAbstractionMode._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionMode> get values => _$values;
  static Hip3AccountAbstractionMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3AccountAbstractionModeMixin = Object with _$Hip3AccountAbstractionModeMixin;

