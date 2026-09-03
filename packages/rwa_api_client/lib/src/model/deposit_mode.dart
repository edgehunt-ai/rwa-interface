//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_mode.g.dart';

class DepositMode extends EnumClass {

  /// * `wallet` —— 普通入金到 App 可用余额 * `trade` —— 交易上下文中的入金，到账后需划转 * `external_import` —— 直接导入对应交易账户，链 / Token 固定 
  @BuiltValueEnumConst(wireName: r'wallet')
  static const DepositMode wallet = _$wallet;
  /// * `wallet` —— 普通入金到 App 可用余额 * `trade` —— 交易上下文中的入金，到账后需划转 * `external_import` —— 直接导入对应交易账户，链 / Token 固定 
  @BuiltValueEnumConst(wireName: r'trade')
  static const DepositMode trade = _$trade;
  /// * `wallet` —— 普通入金到 App 可用余额 * `trade` —— 交易上下文中的入金，到账后需划转 * `external_import` —— 直接导入对应交易账户，链 / Token 固定 
  @BuiltValueEnumConst(wireName: r'external_import')
  static const DepositMode externalImport = _$externalImport;
  /// * `wallet` —— 普通入金到 App 可用余额 * `trade` —— 交易上下文中的入金，到账后需划转 * `external_import` —— 直接导入对应交易账户，链 / Token 固定 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositMode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<DepositMode> get serializer => _$depositModeSerializer;

  const DepositMode._(String name): super(name);

  static BuiltSet<DepositMode> get values => _$values;
  static DepositMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DepositModeMixin = Object with _$DepositModeMixin;

