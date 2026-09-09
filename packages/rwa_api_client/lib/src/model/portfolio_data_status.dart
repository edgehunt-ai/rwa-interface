//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_data_status.g.dart';

class PortfolioDataStatus extends EnumClass {

  /// 聚合结果状态。`complete` 表示所有必要来源都有可用数据；`partial` 表示仍有真实 结果但部分来源或估值不可用；`empty` 表示用户没有已验证钱包或没有资产。 
  @BuiltValueEnumConst(wireName: r'complete')
  static const PortfolioDataStatus complete = _$complete;
  /// 聚合结果状态。`complete` 表示所有必要来源都有可用数据；`partial` 表示仍有真实 结果但部分来源或估值不可用；`empty` 表示用户没有已验证钱包或没有资产。 
  @BuiltValueEnumConst(wireName: r'partial')
  static const PortfolioDataStatus partial = _$partial;
  /// 聚合结果状态。`complete` 表示所有必要来源都有可用数据；`partial` 表示仍有真实 结果但部分来源或估值不可用；`empty` 表示用户没有已验证钱包或没有资产。 
  @BuiltValueEnumConst(wireName: r'empty')
  static const PortfolioDataStatus empty = _$empty;
  /// 聚合结果状态。`complete` 表示所有必要来源都有可用数据；`partial` 表示仍有真实 结果但部分来源或估值不可用；`empty` 表示用户没有已验证钱包或没有资产。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioDataStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<PortfolioDataStatus> get serializer => _$portfolioDataStatusSerializer;

  const PortfolioDataStatus._(String name): super(name);

  static BuiltSet<PortfolioDataStatus> get values => _$values;
  static PortfolioDataStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PortfolioDataStatusMixin = Object with _$PortfolioDataStatusMixin;

