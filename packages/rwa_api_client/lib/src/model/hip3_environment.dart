//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_environment.g.dart';

class Hip3Environment extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3Environment mainnet = _$mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const Hip3Environment testnet = _$testnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3Environment unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3Environment> get serializer => _$hip3EnvironmentSerializer;

  const Hip3Environment._(String name): super(name);

  static BuiltSet<Hip3Environment> get values => _$values;
  static Hip3Environment valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3EnvironmentMixin = Object with _$Hip3EnvironmentMixin;

