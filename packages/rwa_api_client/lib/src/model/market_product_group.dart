//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'market_product_group.g.dart';

class MarketProductGroup extends EnumClass {

  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'hot')
  static const MarketProductGroup hot = _$hot;
  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'gainers')
  static const MarketProductGroup gainers = _$gainers;
  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'losers')
  static const MarketProductGroup losers = _$losers;
  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'volume')
  static const MarketProductGroup volume = _$volume;
  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'favorites')
  static const MarketProductGroup favorites = _$favorites;
  /// 市场产品列表分组。`favorites` 仅表示当前登录用户的自选产品，其他值为全市场排行。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MarketProductGroup unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<MarketProductGroup> get serializer => _$marketProductGroupSerializer;

  const MarketProductGroup._(String name): super(name);

  static BuiltSet<MarketProductGroup> get values => _$values;
  static MarketProductGroup valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MarketProductGroupMixin = Object with _$MarketProductGroupMixin;

