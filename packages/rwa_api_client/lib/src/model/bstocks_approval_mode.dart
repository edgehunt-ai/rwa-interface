//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_approval_mode.g.dart';

class BstocksApprovalMode extends EnumClass {

  /// bStocks 服务端授权策略，由 RWA_BSTOCKS_APPROVAL_MODE 配置（实现默认 unlimited），客户端不能请求或覆盖。 unlimited 授权 uint256.max，保持显式无限授权语义，不使用有限余量的余额 cap。 slippage 授权 min(ceil(required_funding_raw × (1 + slippage_percent/100)), balance_raw)，省略滑点视为0。 balance_raw 为认证用户输入 token 的链上余额：买入是 quote token，卖出是 bStock；不是原生 gas 余额。 按最小单位向上取整后先取余额 cap，再编码为 uint256，避免清仓时滑点余量超过可用余额。 创建 action 重新检查余额和冻结授权金额；余额不足拒绝，cap 变化导致授权目标不同则要求重新预览，不自动缩单。 两者均不扩大 frozen preview 的交易支出上限；旧响应缺失此字段时不能自行推断无限授权。 
  @BuiltValueEnumConst(wireName: r'unlimited')
  static const BstocksApprovalMode unlimited = _$unlimited;
  /// bStocks 服务端授权策略，由 RWA_BSTOCKS_APPROVAL_MODE 配置（实现默认 unlimited），客户端不能请求或覆盖。 unlimited 授权 uint256.max，保持显式无限授权语义，不使用有限余量的余额 cap。 slippage 授权 min(ceil(required_funding_raw × (1 + slippage_percent/100)), balance_raw)，省略滑点视为0。 balance_raw 为认证用户输入 token 的链上余额：买入是 quote token，卖出是 bStock；不是原生 gas 余额。 按最小单位向上取整后先取余额 cap，再编码为 uint256，避免清仓时滑点余量超过可用余额。 创建 action 重新检查余额和冻结授权金额；余额不足拒绝，cap 变化导致授权目标不同则要求重新预览，不自动缩单。 两者均不扩大 frozen preview 的交易支出上限；旧响应缺失此字段时不能自行推断无限授权。 
  @BuiltValueEnumConst(wireName: r'slippage')
  static const BstocksApprovalMode slippage = _$slippage;

  static Serializer<BstocksApprovalMode> get serializer => _$bstocksApprovalModeSerializer;

  const BstocksApprovalMode._(String name): super(name);

  static BuiltSet<BstocksApprovalMode> get values => _$values;
  static BstocksApprovalMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BstocksApprovalModeMixin = Object with _$BstocksApprovalModeMixin;

