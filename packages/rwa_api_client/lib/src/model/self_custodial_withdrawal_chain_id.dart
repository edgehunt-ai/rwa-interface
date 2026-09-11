//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_chain_id.g.dart';

class SelfCustodialWithdrawalChainId extends EnumClass {

  /// 服务端冻结交易的十进制 EVM chain ID：`1`=Ethereum、`42161`=Arbitrum、 `8453`=Base、`56`=BSC。响应不再重复一个可能与此字段冲突的 chain label； 未知值必须在生成客户端反序列化阶段 fail-closed。 
  @BuiltValueEnumConst(wireName: r'1')
  static const SelfCustodialWithdrawalChainId n1 = _$n1;
  /// 服务端冻结交易的十进制 EVM chain ID：`1`=Ethereum、`42161`=Arbitrum、 `8453`=Base、`56`=BSC。响应不再重复一个可能与此字段冲突的 chain label； 未知值必须在生成客户端反序列化阶段 fail-closed。 
  @BuiltValueEnumConst(wireName: r'42161')
  static const SelfCustodialWithdrawalChainId n42161 = _$n42161;
  /// 服务端冻结交易的十进制 EVM chain ID：`1`=Ethereum、`42161`=Arbitrum、 `8453`=Base、`56`=BSC。响应不再重复一个可能与此字段冲突的 chain label； 未知值必须在生成客户端反序列化阶段 fail-closed。 
  @BuiltValueEnumConst(wireName: r'8453')
  static const SelfCustodialWithdrawalChainId n8453 = _$n8453;
  /// 服务端冻结交易的十进制 EVM chain ID：`1`=Ethereum、`42161`=Arbitrum、 `8453`=Base、`56`=BSC。响应不再重复一个可能与此字段冲突的 chain label； 未知值必须在生成客户端反序列化阶段 fail-closed。 
  @BuiltValueEnumConst(wireName: r'56')
  static const SelfCustodialWithdrawalChainId n56 = _$n56;
  /// 服务端冻结交易的十进制 EVM chain ID：`1`=Ethereum、`42161`=Arbitrum、 `8453`=Base、`56`=BSC。响应不再重复一个可能与此字段冲突的 chain label； 未知值必须在生成客户端反序列化阶段 fail-closed。 
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const SelfCustodialWithdrawalChainId unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<SelfCustodialWithdrawalChainId> get serializer => _$selfCustodialWithdrawalChainIdSerializer;

  const SelfCustodialWithdrawalChainId._(String name): super(name);

  static BuiltSet<SelfCustodialWithdrawalChainId> get values => _$values;
  static SelfCustodialWithdrawalChainId valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SelfCustodialWithdrawalChainIdMixin = Object with _$SelfCustodialWithdrawalChainIdMixin;

