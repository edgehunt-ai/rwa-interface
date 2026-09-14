//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_account_abstraction_execution_method.g.dart';

class Hip3AccountAbstractionExecutionMethod extends EnumClass {

  @BuiltValueEnumConst(wireName: r'agent')
  static const Hip3AccountAbstractionExecutionMethod agent = _$agent;
  @BuiltValueEnumConst(wireName: r'user')
  static const Hip3AccountAbstractionExecutionMethod user = _$user;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3AccountAbstractionExecutionMethod unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3AccountAbstractionExecutionMethod> get serializer => _$hip3AccountAbstractionExecutionMethodSerializer;

  const Hip3AccountAbstractionExecutionMethod._(String name): super(name);

  static BuiltSet<Hip3AccountAbstractionExecutionMethod> get values => _$values;
  static Hip3AccountAbstractionExecutionMethod valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3AccountAbstractionExecutionMethodMixin = Object with _$Hip3AccountAbstractionExecutionMethodMixin;

