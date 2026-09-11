//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_deletion_status.g.dart';

class AccountDeletionStatus extends EnumClass {

  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'requested')
  static const AccountDeletionStatus requested = _$requested;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'blocked')
  static const AccountDeletionStatus blocked = _$blocked;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'processing')
  static const AccountDeletionStatus processing = _$processing;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'anonymized')
  static const AccountDeletionStatus anonymized = _$anonymized;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const AccountDeletionStatus manualReview = _$manualReview;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'failed')
  static const AccountDeletionStatus failed = _$failed;
  /// `requested` 已接受；`blocked` 异步处理发现 blocker；`processing` 正在执行； `anonymized` 产品账户数据已完成删除或匿名化；`manual_review` 需要人工复核； `failed` 处理失败且没有被当作成功。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccountDeletionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<AccountDeletionStatus> get serializer => _$accountDeletionStatusSerializer;

  const AccountDeletionStatus._(String name): super(name);

  static BuiltSet<AccountDeletionStatus> get values => _$values;
  static AccountDeletionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AccountDeletionStatusMixin = Object with _$AccountDeletionStatusMixin;

