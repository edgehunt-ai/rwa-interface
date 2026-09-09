//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_type.g.dart';

class ActivityType extends EnumClass {
  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'market')
  static const ActivityType market = _$market;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'limit')
  static const ActivityType limit = _$limit;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'tpsl')
  static const ActivityType tpsl = _$tpsl;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'close')
  static const ActivityType close = _$close;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'liquidation')
  static const ActivityType liquidation = _$liquidation;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'deposit')
  static const ActivityType deposit = _$deposit;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'external')
  static const ActivityType external_ = _$external_;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'bridge')
  static const ActivityType bridge = _$bridge;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'withdraw')
  static const ActivityType withdraw = _$withdraw;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'claim')
  static const ActivityType claim = _$claim;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'funding')
  static const ActivityType funding = _$funding;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'approval')
  static const ActivityType approval = _$approval;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'orderSign')
  static const ActivityType orderSign = _$orderSign;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'bridgeSign')
  static const ActivityType bridgeSign = _$bridgeSign;

  /// 订单类：`market` 市价单 · `limit` 限价单 · `tpsl` 止盈止损 · `close` 平仓 · `liquidation` 强平  资金类：`deposit` 入金 · `external` 外部导入 · `bridge` 划转 · `withdraw` 提现 · `claim` Claim 退款 · `funding` 资金费。内部 Session、Intent、Preview、Authorization 和签名请求不属于新的用户活动记录。`approval`、`orderSign`、`bridgeSign` 仅为旧客户端 反序列化兼容值，服务端不得再为未实际广播或成交的意图创建此类 Activity。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityType unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ActivityType> get serializer => _$activityTypeSerializer;

  const ActivityType._(String name) : super(name);

  static BuiltSet<ActivityType> get values => _$values;
  static ActivityType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActivityTypeMixin = Object with _$ActivityTypeMixin;
