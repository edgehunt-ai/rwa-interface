//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_mainnet_product.g.dart';

class Hip3MainnetProduct extends EnumClass {

  @BuiltValueEnumConst(wireName: r'xyz:SP500')
  static const Hip3MainnetProduct xyzColonSP500 = _$xyzColonSP500;
  @BuiltValueEnumConst(wireName: r'xyz:XYZ100')
  static const Hip3MainnetProduct xyzColonXYZ100 = _$xyzColonXYZ100;
  @BuiltValueEnumConst(wireName: r'xyz:GOLD')
  static const Hip3MainnetProduct xyzColonGOLD = _$xyzColonGOLD;
  @BuiltValueEnumConst(wireName: r'xyz:NVDA')
  static const Hip3MainnetProduct xyzColonNVDA = _$xyzColonNVDA;
  @BuiltValueEnumConst(wireName: r'xyz:TSLA')
  static const Hip3MainnetProduct xyzColonTSLA = _$xyzColonTSLA;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3MainnetProduct unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3MainnetProduct> get serializer => _$hip3MainnetProductSerializer;

  const Hip3MainnetProduct._(String name): super(name);

  static BuiltSet<Hip3MainnetProduct> get values => _$values;
  static Hip3MainnetProduct valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3MainnetProductMixin = Object with _$Hip3MainnetProductMixin;

