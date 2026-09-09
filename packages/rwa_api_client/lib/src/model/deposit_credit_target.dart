//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_credit_target.g.dart';

class DepositCreditTarget extends EnumClass {

  /// `wallet` 表示资产位于用户自己的已验证链上钱包，不代表 App 内部账本已经记账。
  @BuiltValueEnumConst(wireName: r'wallet')
  static const DepositCreditTarget wallet = _$wallet;
  /// `wallet` 表示资产位于用户自己的已验证链上钱包，不代表 App 内部账本已经记账。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositCreditTarget unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositCreditTarget> get serializer => _$depositCreditTargetSerializer;

  const DepositCreditTarget._(String name): super(name);

  static BuiltSet<DepositCreditTarget> get values => _$values;
  static DepositCreditTarget valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositCreditTargetMixin = Object with _$DepositCreditTargetMixin;

