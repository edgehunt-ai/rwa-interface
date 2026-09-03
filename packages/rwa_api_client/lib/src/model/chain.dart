//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chain.g.dart';

class Chain extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BSC')
  static const Chain BSC = _$BSC;
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const Chain arbitrum = _$arbitrum;
  @BuiltValueEnumConst(wireName: r'Base')
  static const Chain base_ = _$base_;
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const Chain ethereum = _$ethereum;
  @BuiltValueEnumConst(wireName: r'Hyperliquid')
  static const Chain hyperliquid = _$hyperliquid;
  @BuiltValueEnumConst(wireName: r'Polygon')
  static const Chain polygon = _$polygon;
  @BuiltValueEnumConst(wireName: r'Solana')
  static const Chain solana = _$solana;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Chain unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Chain> get serializer => _$chainSerializer;

  const Chain._(String name): super(name);

  static BuiltSet<Chain> get values => _$values;
  static Chain valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ChainMixin = Object with _$ChainMixin;

