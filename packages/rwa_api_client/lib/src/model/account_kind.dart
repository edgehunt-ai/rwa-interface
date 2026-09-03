//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_kind.g.dart';

class AccountKind extends EnumClass {

  /// * `app` —— App 可用余额（聚合账户） * `bstocks` —— BSC Wallet，bStocks 交易账户 * `hip3` —— HIP-3 交易账户 
  @BuiltValueEnumConst(wireName: r'app')
  static const AccountKind app = _$app;
  /// * `app` —— App 可用余额（聚合账户） * `bstocks` —— BSC Wallet，bStocks 交易账户 * `hip3` —— HIP-3 交易账户 
  @BuiltValueEnumConst(wireName: r'bstocks')
  static const AccountKind bstocks = _$bstocks;
  /// * `app` —— App 可用余额（聚合账户） * `bstocks` —— BSC Wallet，bStocks 交易账户 * `hip3` —— HIP-3 交易账户 
  @BuiltValueEnumConst(wireName: r'hip3')
  static const AccountKind hip3 = _$hip3;
  /// * `app` —— App 可用余额（聚合账户） * `bstocks` —— BSC Wallet，bStocks 交易账户 * `hip3` —— HIP-3 交易账户 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AccountKind unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<AccountKind> get serializer => _$accountKindSerializer;

  const AccountKind._(String name): super(name);

  static BuiltSet<AccountKind> get values => _$values;
  static AccountKind valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AccountKindMixin = Object with _$AccountKindMixin;

