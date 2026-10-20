//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_create_request.g.dart';

/// 创建 HIP-3 提现只需金额；目标地址固定为账户自己的 unified EVM 地址，请求不接受 `destination`、`signature`、`nonce` 或任意 venue action 字段。 bridge2/float金额去除小数末尾零后最多6位小数；bridge2须大于1 USDC手续费，float须大于0。 例如5.5000000000可用，5.1234567在这两条通道返回422 invalid_request。 payout_chain_id=42161 的 relay 请求同样为最多6位小数的 HL USDC 总扣减额（exact input）。 省略 payout_chain_id 的 relay 或显式56为正BSC USDT exact-output，可超过6位小数（仍受通用Decimal请求精度约束），实际HL扣款由quote确定。
///
/// Properties:
/// * [amount] - 显式 payout_chain_id=42161 或 bridge2/float 为HL USDC总扣减额（exact input；bridge2含1 USDC手续费）；旧版relay（目标链省略或56）为BSC USDT期望到账额（exact output），实际HL扣款由quote决定。
/// * [payoutChainId] - 目标资产链。42161 固定 Arbitrum 原生 USDC、请求 amount 为总扣减额；auto 按已配置能力选择 float、relay、bridge2。 421614 为 Testnet Arbitrum，不能搭配 relay；56 仅能显式搭配 relay，目标 BSC USDT、请求 amount 为期望到账额。 省略保持原有行为及金额语义，不因 Relay 配置而改变目标资产。预览后创建必须回传 preview.chain_id 对应的整数及 preview.rail。
/// * [rail] - 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
@BuiltValue()
abstract class Hip3WithdrawalCreateRequest implements Built<Hip3WithdrawalCreateRequest, Hip3WithdrawalCreateRequestBuilder> {
  /// 显式 payout_chain_id=42161 或 bridge2/float 为HL USDC总扣减额（exact input；bridge2含1 USDC手续费）；旧版relay（目标链省略或56）为BSC USDT期望到账额（exact output），实际HL扣款由quote决定。
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 目标资产链。42161 固定 Arbitrum 原生 USDC、请求 amount 为总扣减额；auto 按已配置能力选择 float、relay、bridge2。 421614 为 Testnet Arbitrum，不能搭配 relay；56 仅能显式搭配 relay，目标 BSC USDT、请求 amount 为期望到账额。 省略保持原有行为及金额语义，不因 Relay 配置而改变目标资产。预览后创建必须回传 preview.chain_id 对应的整数及 preview.rail。
  @BuiltValueField(wireName: r'payout_chain_id')
  Hip3WithdrawalCreateRequestPayoutChainIdEnum? get payoutChainId;
  // enum payoutChainIdEnum {  56,  42161,  421614,  };

  /// 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
  @BuiltValueField(wireName: r'rail')
  Hip3WithdrawalCreateRequestRailEnum? get rail;
  // enum railEnum {  auto,  bridge2,  float,  relay,  };

  Hip3WithdrawalCreateRequest._();

  factory Hip3WithdrawalCreateRequest([void updates(Hip3WithdrawalCreateRequestBuilder b)]) = _$Hip3WithdrawalCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3WithdrawalCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3WithdrawalCreateRequest> get serializer => _$Hip3WithdrawalCreateRequestSerializer();
}

class _$Hip3WithdrawalCreateRequestSerializer implements PrimitiveSerializer<Hip3WithdrawalCreateRequest> {
  @override
  final Iterable<Type> types = const [Hip3WithdrawalCreateRequest, _$Hip3WithdrawalCreateRequest];

  @override
  final String wireName = r'Hip3WithdrawalCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3WithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.payoutChainId != null) {
      yield r'payout_chain_id';
      yield serializers.serialize(
        object.payoutChainId,
        specifiedType: const FullType(Hip3WithdrawalCreateRequestPayoutChainIdEnum),
      );
    }
    if (object.rail != null) {
      yield r'rail';
      yield serializers.serialize(
        object.rail,
        specifiedType: const FullType.nullable(Hip3WithdrawalCreateRequestRailEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3WithdrawalCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3WithdrawalCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'payout_chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3WithdrawalCreateRequestPayoutChainIdEnum),
          ) as Hip3WithdrawalCreateRequestPayoutChainIdEnum?;
          if (valueDes == null) continue;
          result.payoutChainId = valueDes;
          break;
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3WithdrawalCreateRequestRailEnum),
          ) as Hip3WithdrawalCreateRequestRailEnum?;
          if (valueDes == null) continue;
          result.rail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3WithdrawalCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3WithdrawalCreateRequestBuilder();
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

class Hip3WithdrawalCreateRequestPayoutChainIdEnum extends EnumClass {

  /// 目标资产链。42161 固定 Arbitrum 原生 USDC、请求 amount 为总扣减额；auto 按已配置能力选择 float、relay、bridge2。 421614 为 Testnet Arbitrum，不能搭配 relay；56 仅能显式搭配 relay，目标 BSC USDT、请求 amount 为期望到账额。 省略保持原有行为及金额语义，不因 Relay 配置而改变目标资产。预览后创建必须回传 preview.chain_id 对应的整数及 preview.rail。
  @BuiltValueEnumConst(wireNumber: 56)
  static const Hip3WithdrawalCreateRequestPayoutChainIdEnum number56 = _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number56;
  /// 目标资产链。42161 固定 Arbitrum 原生 USDC、请求 amount 为总扣减额；auto 按已配置能力选择 float、relay、bridge2。 421614 为 Testnet Arbitrum，不能搭配 relay；56 仅能显式搭配 relay，目标 BSC USDT、请求 amount 为期望到账额。 省略保持原有行为及金额语义，不因 Relay 配置而改变目标资产。预览后创建必须回传 preview.chain_id 对应的整数及 preview.rail。
  @BuiltValueEnumConst(wireNumber: 42161)
  static const Hip3WithdrawalCreateRequestPayoutChainIdEnum number42161 = _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number42161;
  /// 目标资产链。42161 固定 Arbitrum 原生 USDC、请求 amount 为总扣减额；auto 按已配置能力选择 float、relay、bridge2。 421614 为 Testnet Arbitrum，不能搭配 relay；56 仅能显式搭配 relay，目标 BSC USDT、请求 amount 为期望到账额。 省略保持原有行为及金额语义，不因 Relay 配置而改变目标资产。预览后创建必须回传 preview.chain_id 对应的整数及 preview.rail。
  @BuiltValueEnumConst(wireNumber: 421614)
  static const Hip3WithdrawalCreateRequestPayoutChainIdEnum number421614 = _$hip3WithdrawalCreateRequestPayoutChainIdEnum_number421614;

  static Serializer<Hip3WithdrawalCreateRequestPayoutChainIdEnum> get serializer => _$hip3WithdrawalCreateRequestPayoutChainIdEnumSerializer;

  const Hip3WithdrawalCreateRequestPayoutChainIdEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalCreateRequestPayoutChainIdEnum> get values => _$hip3WithdrawalCreateRequestPayoutChainIdEnumValues;
  static Hip3WithdrawalCreateRequestPayoutChainIdEnum valueOf(String name) => _$hip3WithdrawalCreateRequestPayoutChainIdEnumValueOf(name);
}

class Hip3WithdrawalCreateRequestRailEnum extends EnumClass {

  /// 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
  @BuiltValueEnumConst(wireName: r'auto')
  static const Hip3WithdrawalCreateRequestRailEnum auto = _$hip3WithdrawalCreateRequestRailEnum_auto;
  /// 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
  @BuiltValueEnumConst(wireName: r'bridge2')
  static const Hip3WithdrawalCreateRequestRailEnum bridge2 = _$hip3WithdrawalCreateRequestRailEnum_bridge2;
  /// 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
  @BuiltValueEnumConst(wireName: r'float')
  static const Hip3WithdrawalCreateRequestRailEnum float = _$hip3WithdrawalCreateRequestRailEnum_float;
  /// 出金通道选择；显式 payout_chain_id=42161 时 auto 按已配置能力依次选择 float、relay、bridge2，保持同一总扣减额及 Arbitrum USDC 目标。 省略目标链时缺省或 auto 保持旧版 Arbitrum USDC 到账：平台池已配置走 float，否则走 bridge2。 BSC USDT 到账必须显式请求 relay，不会因 Relay 已配置而自动改变目标资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 amount 语义由目标链确定：42161 为 HL USDC 总扣减额；省略或56为 BSC USDT 期望到账额，实际扣款由报价决定。
  @BuiltValueEnumConst(wireName: r'relay')
  static const Hip3WithdrawalCreateRequestRailEnum relay = _$hip3WithdrawalCreateRequestRailEnum_relay;

  static Serializer<Hip3WithdrawalCreateRequestRailEnum> get serializer => _$hip3WithdrawalCreateRequestRailEnumSerializer;

  const Hip3WithdrawalCreateRequestRailEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalCreateRequestRailEnum> get values => _$hip3WithdrawalCreateRequestRailEnumValues;
  static Hip3WithdrawalCreateRequestRailEnum valueOf(String name) => _$hip3WithdrawalCreateRequestRailEnumValueOf(name);
}

