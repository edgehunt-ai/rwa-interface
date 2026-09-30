//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_status.g.dart';

class Hip3WithdrawalStatus extends EnumClass {

  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'awaiting_signature')
  static const Hip3WithdrawalStatus awaitingSignature = _$awaitingSignature;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'submitting')
  static const Hip3WithdrawalStatus submitting = _$submitting;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'submitted')
  static const Hip3WithdrawalStatus submitted = _$submitted;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'payout')
  static const Hip3WithdrawalStatus payout = _$payout;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'completed')
  static const Hip3WithdrawalStatus completed = _$completed;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3WithdrawalStatus failed = _$failed;
  /// `submitting` 表示签名已通过校验且已经持久化提交声明，但外部 Hyperliquid `/exchange` 的响应尚未被可靠确认。客户端必须继续读取该提现， 不得重放签名或创建新的提现；服务端对账后会推进到 `submitted`、`completed` 或明确的失败状态。 
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3WithdrawalStatus expired = _$expired;

  static Serializer<Hip3WithdrawalStatus> get serializer => _$hip3WithdrawalStatusSerializer;

  const Hip3WithdrawalStatus._(String name): super(name);

  static BuiltSet<Hip3WithdrawalStatus> get values => _$values;
  static Hip3WithdrawalStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3WithdrawalStatusMixin = Object with _$Hip3WithdrawalStatusMixin;

