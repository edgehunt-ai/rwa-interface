//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_rail.g.dart';

class Hip3WithdrawalRail extends EnumClass {

  /// 出金通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC，Bridge2 到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）。 
  @BuiltValueEnumConst(wireName: r'bridge2')
  static const Hip3WithdrawalRail bridge2 = _$bridge2;
  /// 出金通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC，Bridge2 到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）。 
  @BuiltValueEnumConst(wireName: r'float')
  static const Hip3WithdrawalRail float = _$float;
  /// 出金通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC，Bridge2 到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3WithdrawalRail unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3WithdrawalRail> get serializer => _$hip3WithdrawalRailSerializer;

  const Hip3WithdrawalRail._(String name): super(name);

  static BuiltSet<Hip3WithdrawalRail> get values => _$values;
  static Hip3WithdrawalRail valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3WithdrawalRailMixin = Object with _$Hip3WithdrawalRailMixin;

