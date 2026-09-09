//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_asset_provenance.g.dart';

class FundingAssetProvenance extends EnumClass {

  @BuiltValueEnumConst(wireName: r'circle_native')
  static const FundingAssetProvenance circleNative = _$circleNative;
  @BuiltValueEnumConst(wireName: r'tether_native')
  static const FundingAssetProvenance tetherNative = _$tetherNative;
  @BuiltValueEnumConst(wireName: r'tether_usdt0')
  static const FundingAssetProvenance tetherUsdt0 = _$tetherUsdt0;
  @BuiltValueEnumConst(wireName: r'l2_standard_bridged')
  static const FundingAssetProvenance l2StandardBridged = _$l2StandardBridged;
  @BuiltValueEnumConst(wireName: r'binance_peg')
  static const FundingAssetProvenance binancePeg = _$binancePeg;
  @BuiltValueEnumConst(wireName: r'hyperliquid_perps')
  static const FundingAssetProvenance hyperliquidPerps = _$hyperliquidPerps;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingAssetProvenance unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<FundingAssetProvenance> get serializer => _$fundingAssetProvenanceSerializer;

  const FundingAssetProvenance._(String name): super(name);

  static BuiltSet<FundingAssetProvenance> get values => _$values;
  static FundingAssetProvenance valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingAssetProvenanceMixin = Object with _$FundingAssetProvenanceMixin;

