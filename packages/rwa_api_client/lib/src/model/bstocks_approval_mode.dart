//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_approval_mode.g.dart';

class BstocksApprovalMode extends EnumClass {

  /// bStocks 服务端授权策略，由 RWA_BSTOCKS_APPROVAL_MODE 配置（实现默认 unlimited），客户端不能请求或覆盖。 unlimited 授权 uint256.max；slippage 授权 ceil(required_funding_raw × (1 + slippage_percent/100))， 省略滑点视为0。两者均不扩大 frozen preview 的交易支出上限；旧响应缺失此字段时不能自行推断无限授权。 
  @BuiltValueEnumConst(wireName: r'unlimited')
  static const BstocksApprovalMode unlimited = _$unlimited;
  /// bStocks 服务端授权策略，由 RWA_BSTOCKS_APPROVAL_MODE 配置（实现默认 unlimited），客户端不能请求或覆盖。 unlimited 授权 uint256.max；slippage 授权 ceil(required_funding_raw × (1 + slippage_percent/100))， 省略滑点视为0。两者均不扩大 frozen preview 的交易支出上限；旧响应缺失此字段时不能自行推断无限授权。 
  @BuiltValueEnumConst(wireName: r'slippage')
  static const BstocksApprovalMode slippage = _$slippage;
  /// bStocks 服务端授权策略，由 RWA_BSTOCKS_APPROVAL_MODE 配置（实现默认 unlimited），客户端不能请求或覆盖。 unlimited 授权 uint256.max；slippage 授权 ceil(required_funding_raw × (1 + slippage_percent/100))， 省略滑点视为0。两者均不扩大 frozen preview 的交易支出上限；旧响应缺失此字段时不能自行推断无限授权。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksApprovalMode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

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

