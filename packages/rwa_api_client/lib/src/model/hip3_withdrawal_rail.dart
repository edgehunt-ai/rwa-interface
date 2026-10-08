//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_rail.g.dart';

class Hip3WithdrawalRail extends EnumClass {

  /// 出金/划转通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC；Arbitrum 主网到账 USDC，测试网到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）； `relay` 走跨链 solver —— 用户 `sendAsset` 到 Relay depository，solver 在 BSC（chain 56） 垫付 USDT，费用为报价输入输出差（非零）。`relay` 仅在 mainnet 可用，请求前必须先用 preview 拿到实价；预览与创建中的 `amount` 对 relay 语义是 BSC 到账金额（exact output）， 实际 venue 扣款见响应 `amount`（quote input）。 
  @BuiltValueEnumConst(wireName: r'bridge2')
  static const Hip3WithdrawalRail bridge2 = _$bridge2;
  /// 出金/划转通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC；Arbitrum 主网到账 USDC，测试网到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）； `relay` 走跨链 solver —— 用户 `sendAsset` 到 Relay depository，solver 在 BSC（chain 56） 垫付 USDT，费用为报价输入输出差（非零）。`relay` 仅在 mainnet 可用，请求前必须先用 preview 拿到实价；预览与创建中的 `amount` 对 relay 语义是 BSC 到账金额（exact output）， 实际 venue 扣款见响应 `amount`（quote input）。 
  @BuiltValueEnumConst(wireName: r'float')
  static const Hip3WithdrawalRail float = _$float;
  /// 出金/划转通道：`bridge2` 走官方 `withdraw3`（venue 收 1 USDC；Arbitrum 主网到账 USDC，测试网到账 USDC2）； `float` 由用户 `sendAsset` 到平台池、平台在 Arbitrum 垫付原生 USDC（0 venue 费）； `relay` 走跨链 solver —— 用户 `sendAsset` 到 Relay depository，solver 在 BSC（chain 56） 垫付 USDT，费用为报价输入输出差（非零）。`relay` 仅在 mainnet 可用，请求前必须先用 preview 拿到实价；预览与创建中的 `amount` 对 relay 语义是 BSC 到账金额（exact output）， 实际 venue 扣款见响应 `amount`（quote input）。 
  @BuiltValueEnumConst(wireName: r'relay')
  static const Hip3WithdrawalRail relay = _$relay;

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

