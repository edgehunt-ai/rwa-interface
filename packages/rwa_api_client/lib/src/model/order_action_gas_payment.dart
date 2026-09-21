//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_sponsorship_decision.dart';
import 'package:rwa_api_client/src/model/gas_payment_mode.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_action_gas_payment.g.dart';

/// 冻结动作目前仅返回 mode=user_paid_native，不能当作完整估费或代付资格判断。 创建 execution 后以 WalletActionExecution.gas_payment 为权威值；旧版完整字段兼容保留。 
///
/// Properties:
/// * [mode] 
/// * [decision] 
/// * [platformPays] 
/// * [nativeAsset] 
/// * [estimatedNativeFee] - 十进制字符串，避免浮点误差
/// * [estimatedFeeUsd] - 十进制字符串，避免浮点误差
/// * [walletNativeBalance] - 十进制字符串，避免浮点误差
/// * [fallbackAllowed] 
/// * [eip7702Required] 
/// * [eip7702Notice] 
@BuiltValue()
abstract class OrderActionGasPayment implements Built<OrderActionGasPayment, OrderActionGasPaymentBuilder> {
  @BuiltValueField(wireName: r'mode')
  GasPaymentMode get mode;
  // enum modeEnum {  app_sponsored,  user_paid_native,  };

  @BuiltValueField(wireName: r'decision')
  GasSponsorshipDecision? get decision;
  // enum decisionEnum {  eligible,  user_gas_confirmation_required,  unavailable,  limit_exceeded,  circuit_open,  provider_rejected,  provider_ambiguous,  };

  @BuiltValueField(wireName: r'platform_pays')
  bool? get platformPays;

  @BuiltValueField(wireName: r'native_asset')
  String? get nativeAsset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_native_fee')
  String? get estimatedNativeFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_fee_usd')
  String? get estimatedFeeUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'wallet_native_balance')
  String? get walletNativeBalance;

  @BuiltValueField(wireName: r'fallback_allowed')
  bool? get fallbackAllowed;

  @BuiltValueField(wireName: r'eip_7702_required')
  bool? get eip7702Required;

  @BuiltValueField(wireName: r'eip_7702_notice')
  String? get eip7702Notice;

  OrderActionGasPayment._();

  factory OrderActionGasPayment([void updates(OrderActionGasPaymentBuilder b)]) = _$OrderActionGasPayment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderActionGasPaymentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderActionGasPayment> get serializer => _$OrderActionGasPaymentSerializer();
}

class _$OrderActionGasPaymentSerializer implements PrimitiveSerializer<OrderActionGasPayment> {
  @override
  final Iterable<Type> types = const [OrderActionGasPayment, _$OrderActionGasPayment];

  @override
  final String wireName = r'OrderActionGasPayment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderActionGasPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(GasPaymentMode),
    );
    if (object.decision != null) {
      yield r'decision';
      yield serializers.serialize(
        object.decision,
        specifiedType: const FullType(GasSponsorshipDecision),
      );
    }
    if (object.platformPays != null) {
      yield r'platform_pays';
      yield serializers.serialize(
        object.platformPays,
        specifiedType: const FullType(bool),
      );
    }
    if (object.nativeAsset != null) {
      yield r'native_asset';
      yield serializers.serialize(
        object.nativeAsset,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedNativeFee != null) {
      yield r'estimated_native_fee';
      yield serializers.serialize(
        object.estimatedNativeFee,
        specifiedType: const FullType(String),
      );
    }
    if (object.estimatedFeeUsd != null) {
      yield r'estimated_fee_usd';
      yield serializers.serialize(
        object.estimatedFeeUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.walletNativeBalance != null) {
      yield r'wallet_native_balance';
      yield serializers.serialize(
        object.walletNativeBalance,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fallbackAllowed != null) {
      yield r'fallback_allowed';
      yield serializers.serialize(
        object.fallbackAllowed,
        specifiedType: const FullType(bool),
      );
    }
    if (object.eip7702Required != null) {
      yield r'eip_7702_required';
      yield serializers.serialize(
        object.eip7702Required,
        specifiedType: const FullType(bool),
      );
    }
    if (object.eip7702Notice != null) {
      yield r'eip_7702_notice';
      yield serializers.serialize(
        object.eip7702Notice,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderActionGasPayment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderActionGasPaymentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GasPaymentMode),
          ) as GasPaymentMode;
          result.mode = valueDes;
          break;
        case r'decision':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(GasSponsorshipDecision),
          ) as GasSponsorshipDecision?;
          if (valueDes == null) continue;
          result.decision = valueDes;
          break;
        case r'platform_pays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.platformPays = valueDes;
          break;
        case r'native_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nativeAsset = valueDes;
          break;
        case r'estimated_native_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedNativeFee = valueDes;
          break;
        case r'estimated_fee_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedFeeUsd = valueDes;
          break;
        case r'wallet_native_balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.walletNativeBalance = valueDes;
          break;
        case r'fallback_allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.fallbackAllowed = valueDes;
          break;
        case r'eip_7702_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.eip7702Required = valueDes;
          break;
        case r'eip_7702_notice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.eip7702Notice = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderActionGasPayment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderActionGasPaymentBuilder();
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

