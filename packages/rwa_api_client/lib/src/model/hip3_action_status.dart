//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_action_status.g.dart';

class Hip3ActionStatus extends EnumClass {

  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'awaiting_signature')
  static const Hip3ActionStatus awaitingSignature = _$awaitingSignature;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'submitting')
  static const Hip3ActionStatus submitting = _$submitting;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'reconciling')
  static const Hip3ActionStatus reconciling = _$reconciling;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'succeeded')
  static const Hip3ActionStatus succeeded = _$succeeded;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'failed')
  static const Hip3ActionStatus failed = _$failed;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const Hip3ActionStatus cancelled = _$cancelled;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'expired')
  static const Hip3ActionStatus expired = _$expired;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const Hip3ActionStatus ambiguous = _$ambiguous;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const Hip3ActionStatus manualReview = _$manualReview;
  /// 动作状态不替代订单或仓位状态。succeeded 表示所有动作步骤已被 Provider 确认成功， 不表示挂单已经成交。failed/expired 可能保留先前已成功步骤的副作用。 ambiguous/manual_review 不是可安全重试的终态；只能查询或人工处理。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ActionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<Hip3ActionStatus> get serializer => _$hip3ActionStatusSerializer;

  const Hip3ActionStatus._(String name): super(name);

  static BuiltSet<Hip3ActionStatus> get values => _$values;
  static Hip3ActionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class Hip3ActionStatusMixin = Object with _$Hip3ActionStatusMixin;

