//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'self_custodial_withdrawal_gas_estimate.g.dart';

/// 服务端在创建 intent 时对冻结的精确 ERC-20 transfer 交易做的 EVM gas 观测。 该估算绑定响应中的 `transaction` 字段，仅供用户在签名前评估网络费用； 它不是服务端承诺的执行成本，链上实际 gas 以广播时的网络条件为准。 
///
/// Properties:
/// * [nativeAsset] - 冻结交易所在链的原生 gas 资产符号，例如 ETH 或 BNB。
/// * [gasUnits] - eth_estimateGas 对服务端冻结交易返回的 gas units 十进制字符串。
/// * [gasPriceWei] - 十进制字符串，避免浮点误差
/// * [estimatedNativeFee] - 十进制字符串，避免浮点误差
/// * [walletNativeBalance] - 十进制字符串，避免浮点误差
/// * [canPayGas] - 观测时点 source wallet 原生币余额是否足以支付估算 gas 费用。 为 false 时客户端必须提示用户先补充原生币，不得直接发起签名。 
/// * [observedAt] 
@BuiltValue()
abstract class SelfCustodialWithdrawalGasEstimate implements Built<SelfCustodialWithdrawalGasEstimate, SelfCustodialWithdrawalGasEstimateBuilder> {
  /// 冻结交易所在链的原生 gas 资产符号，例如 ETH 或 BNB。
  @BuiltValueField(wireName: r'native_asset')
  String get nativeAsset;

  /// eth_estimateGas 对服务端冻结交易返回的 gas units 十进制字符串。
  @BuiltValueField(wireName: r'gas_units')
  String get gasUnits;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'gas_price_wei')
  String get gasPriceWei;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_native_fee')
  String get estimatedNativeFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'wallet_native_balance')
  String get walletNativeBalance;

  /// 观测时点 source wallet 原生币余额是否足以支付估算 gas 费用。 为 false 时客户端必须提示用户先补充原生币，不得直接发起签名。 
  @BuiltValueField(wireName: r'can_pay_gas')
  bool get canPayGas;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  SelfCustodialWithdrawalGasEstimate._();

  factory SelfCustodialWithdrawalGasEstimate([void updates(SelfCustodialWithdrawalGasEstimateBuilder b)]) = _$SelfCustodialWithdrawalGasEstimate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SelfCustodialWithdrawalGasEstimateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SelfCustodialWithdrawalGasEstimate> get serializer => _$SelfCustodialWithdrawalGasEstimateSerializer();
}

class _$SelfCustodialWithdrawalGasEstimateSerializer implements PrimitiveSerializer<SelfCustodialWithdrawalGasEstimate> {
  @override
  final Iterable<Type> types = const [SelfCustodialWithdrawalGasEstimate, _$SelfCustodialWithdrawalGasEstimate];

  @override
  final String wireName = r'SelfCustodialWithdrawalGasEstimate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SelfCustodialWithdrawalGasEstimate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'native_asset';
    yield serializers.serialize(
      object.nativeAsset,
      specifiedType: const FullType(String),
    );
    yield r'gas_units';
    yield serializers.serialize(
      object.gasUnits,
      specifiedType: const FullType(String),
    );
    yield r'gas_price_wei';
    yield serializers.serialize(
      object.gasPriceWei,
      specifiedType: const FullType(String),
    );
    yield r'estimated_native_fee';
    yield serializers.serialize(
      object.estimatedNativeFee,
      specifiedType: const FullType(String),
    );
    yield r'wallet_native_balance';
    yield serializers.serialize(
      object.walletNativeBalance,
      specifiedType: const FullType(String),
    );
    yield r'can_pay_gas';
    yield serializers.serialize(
      object.canPayGas,
      specifiedType: const FullType(bool),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SelfCustodialWithdrawalGasEstimate object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SelfCustodialWithdrawalGasEstimateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'native_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nativeAsset = valueDes;
          break;
        case r'gas_units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gasUnits = valueDes;
          break;
        case r'gas_price_wei':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gasPriceWei = valueDes;
          break;
        case r'estimated_native_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedNativeFee = valueDes;
          break;
        case r'wallet_native_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletNativeBalance = valueDes;
          break;
        case r'can_pay_gas':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canPayGas = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SelfCustodialWithdrawalGasEstimate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SelfCustodialWithdrawalGasEstimateBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

