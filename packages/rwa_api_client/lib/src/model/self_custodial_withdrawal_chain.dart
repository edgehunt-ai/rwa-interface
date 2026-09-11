//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_chain.g.dart';

class SelfCustodialWithdrawalChain extends EnumClass {

  /// Privy embedded EVM wallet 当前允许自行签名和广播的网络。
  @BuiltValueEnumConst(wireName: r'Ethereum')
  static const SelfCustodialWithdrawalChain ethereum = _$ethereum;
  /// Privy embedded EVM wallet 当前允许自行签名和广播的网络。
  @BuiltValueEnumConst(wireName: r'Arbitrum')
  static const SelfCustodialWithdrawalChain arbitrum = _$arbitrum;
  /// Privy embedded EVM wallet 当前允许自行签名和广播的网络。
  @BuiltValueEnumConst(wireName: r'Base')
  static const SelfCustodialWithdrawalChain base_ = _$base_;
  /// Privy embedded EVM wallet 当前允许自行签名和广播的网络。
  @BuiltValueEnumConst(wireName: r'BSC')
  static const SelfCustodialWithdrawalChain BSC = _$BSC;
  /// Privy embedded EVM wallet 当前允许自行签名和广播的网络。
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SelfCustodialWithdrawalChain unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<SelfCustodialWithdrawalChain> get serializer => _$selfCustodialWithdrawalChainSerializer;

  const SelfCustodialWithdrawalChain._(String name): super(name);

  static BuiltSet<SelfCustodialWithdrawalChain> get values => _$values;
  static SelfCustodialWithdrawalChain valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SelfCustodialWithdrawalChainMixin = Object with _$SelfCustodialWithdrawalChainMixin;

