//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_depth_status.g.dart';

class BstocksDepthStatus extends EnumClass {

  /// complete 仅表示完成请求的采样数，不表示发现全部容量；partial 不证明最大可成交数量。
  @BuiltValueEnumConst(wireName: r'complete')
  static const BstocksDepthStatus complete = _$complete;
  /// complete 仅表示完成请求的采样数，不表示发现全部容量；partial 不证明最大可成交数量。
  @BuiltValueEnumConst(wireName: r'partial')
  static const BstocksDepthStatus partial = _$partial;
  /// complete 仅表示完成请求的采样数，不表示发现全部容量；partial 不证明最大可成交数量。
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const BstocksDepthStatus unavailable = _$unavailable;
  /// complete 仅表示完成请求的采样数，不表示发现全部容量；partial 不证明最大可成交数量。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksDepthStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<BstocksDepthStatus> get serializer => _$bstocksDepthStatusSerializer;

  const BstocksDepthStatus._(String name): super(name);

  static BuiltSet<BstocksDepthStatus> get values => _$values;
  static BstocksDepthStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BstocksDepthStatusMixin = Object with _$BstocksDepthStatusMixin;

