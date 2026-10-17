//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_withdrawal_create_request.g.dart';

/// 创建 HIP-3 提现只需金额；目标地址固定为账户自己的 unified EVM 地址，请求不接受 `destination`、`signature`、`nonce` 或任意 venue action 字段。 bridge2/float金额去除小数末尾零后最多6位小数；bridge2须大于1 USDC手续费，float须大于0。 例如5.5000000000可用，5.1234567在这两条通道返回422 invalid_request。 relay请求为正BSC USDT exact-output，可超过6位小数（仍受通用Decimal请求精度约束），实际HL扣款由quote确定。 
///
/// Properties:
/// * [amount] - bridge2/float为HL USDC总扣减额（bridge2含1 USDC手续费）；relay为BSC USDT期望到账额，实际HL扣款由quote决定。
/// * [rail] - 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
@BuiltValue()
abstract class Hip3WithdrawalCreateRequest implements Built<Hip3WithdrawalCreateRequest, Hip3WithdrawalCreateRequestBuilder> {
  /// bridge2/float为HL USDC总扣减额（bridge2含1 USDC手续费）；relay为BSC USDT期望到账额，实际HL扣款由quote决定。
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
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

class Hip3WithdrawalCreateRequestRailEnum extends EnumClass {

  /// 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
  @BuiltValueEnumConst(wireName: r'auto')
  static const Hip3WithdrawalCreateRequestRailEnum auto = _$hip3WithdrawalCreateRequestRailEnum_auto;
  /// 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
  @BuiltValueEnumConst(wireName: r'bridge2')
  static const Hip3WithdrawalCreateRequestRailEnum bridge2 = _$hip3WithdrawalCreateRequestRailEnum_bridge2;
  /// 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
  @BuiltValueEnumConst(wireName: r'float')
  static const Hip3WithdrawalCreateRequestRailEnum float = _$hip3WithdrawalCreateRequestRailEnum_float;
  /// 出金通道选择；缺省或 `auto` 时保持 Arbitrum USDC 到账：平台池已配置走 `float`， 否则走 `bridge2`。BSC USDT 到账必须显式请求 `relay`，不会因 Relay 已配置而自动改变到账资产或金额语义。 显式请求 `float`/`relay` 而对应能力未配置时返回错误，不会静默降级。 null与省略等价。 预览后创建提现应显式回传预览响应的 rail，不再传 auto；签名前核对创建响应的金额和费用。 relay 的 `amount` 语义是期望到账的 BSC USDT 金额（exact output），与 bridge2/float 的 venue 扣款语义不同——实际扣款金额由服务端 quote 决定并在响应 `amount` 中返回。
  @BuiltValueEnumConst(wireName: r'relay')
  static const Hip3WithdrawalCreateRequestRailEnum relay = _$hip3WithdrawalCreateRequestRailEnum_relay;

  static Serializer<Hip3WithdrawalCreateRequestRailEnum> get serializer => _$hip3WithdrawalCreateRequestRailEnumSerializer;

  const Hip3WithdrawalCreateRequestRailEnum._(String name): super(name);

  static BuiltSet<Hip3WithdrawalCreateRequestRailEnum> get values => _$hip3WithdrawalCreateRequestRailEnumValues;
  static Hip3WithdrawalCreateRequestRailEnum valueOf(String name) => _$hip3WithdrawalCreateRequestRailEnumValueOf(name);
}

