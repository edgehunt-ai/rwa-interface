//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/gas_sponsorship_decision.dart';
import 'package:rwa_api_client/src/model/gas_payment_mode.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gas_payment_quote.g.dart';

/// Server-authoritative gas estimate and sponsorship/fallback decision.
///
/// Properties:
/// * [mode] 
/// * [decision] 
/// * [platformPays] 
/// * [nativeAsset] - Native gas asset symbol for the frozen action chain, for example BNB or ETH.
/// * [estimatedNativeFee] - 十进制字符串，避免浮点误差
/// * [estimatedFeeUsd] - 十进制字符串，避免浮点误差
/// * [walletNativeBalance] - 十进制字符串，避免浮点误差
/// * [fallbackAllowed] - True only when policy permits user-paid fallback. Fallback may be entered only after a deterministic rejection proven to have occurred before any broadcast attempt. 
/// * [eip7702Required] 
/// * [eip7702Notice] - Required user-facing disclosure when EIP-7702 authorization is needed.
@BuiltValue()
abstract class GasPaymentQuote implements Built<GasPaymentQuote, GasPaymentQuoteBuilder> {
  @BuiltValueField(wireName: r'mode')
  GasPaymentMode get mode;
  // enum modeEnum {  app_sponsored,  user_paid_native,  };

  @BuiltValueField(wireName: r'decision')
  GasSponsorshipDecision get decision;
  // enum decisionEnum {  eligible,  user_gas_confirmation_required,  unavailable,  limit_exceeded,  circuit_open,  provider_rejected,  provider_ambiguous,  };

  @BuiltValueField(wireName: r'platform_pays')
  bool get platformPays;

  /// Native gas asset symbol for the frozen action chain, for example BNB or ETH.
  @BuiltValueField(wireName: r'native_asset')
  String get nativeAsset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_native_fee')
  String get estimatedNativeFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_fee_usd')
  String get estimatedFeeUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'wallet_native_balance')
  String? get walletNativeBalance;

  /// True only when policy permits user-paid fallback. Fallback may be entered only after a deterministic rejection proven to have occurred before any broadcast attempt. 
  @BuiltValueField(wireName: r'fallback_allowed')
  bool get fallbackAllowed;

  @BuiltValueField(wireName: r'eip_7702_required')
  bool get eip7702Required;

  /// Required user-facing disclosure when EIP-7702 authorization is needed.
  @BuiltValueField(wireName: r'eip_7702_notice')
  String? get eip7702Notice;

  GasPaymentQuote._();

  factory GasPaymentQuote([void updates(GasPaymentQuoteBuilder b)]) = _$GasPaymentQuote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GasPaymentQuoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GasPaymentQuote> get serializer => _$GasPaymentQuoteSerializer();
}

class _$GasPaymentQuoteSerializer implements PrimitiveSerializer<GasPaymentQuote> {
  @override
  final Iterable<Type> types = const [GasPaymentQuote, _$GasPaymentQuote];

  @override
  final String wireName = r'GasPaymentQuote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GasPaymentQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(GasPaymentMode),
    );
    yield r'decision';
    yield serializers.serialize(
      object.decision,
      specifiedType: const FullType(GasSponsorshipDecision),
    );
    yield r'platform_pays';
    yield serializers.serialize(
      object.platformPays,
      specifiedType: const FullType(bool),
    );
    yield r'native_asset';
    yield serializers.serialize(
      object.nativeAsset,
      specifiedType: const FullType(String),
    );
    yield r'estimated_native_fee';
    yield serializers.serialize(
      object.estimatedNativeFee,
      specifiedType: const FullType(String),
    );
    yield r'estimated_fee_usd';
    yield serializers.serialize(
      object.estimatedFeeUsd,
      specifiedType: const FullType(String),
    );
    yield r'wallet_native_balance';
    yield object.walletNativeBalance == null ? null : serializers.serialize(
      object.walletNativeBalance,
      specifiedType: const FullType.nullable(String),
    );
    yield r'fallback_allowed';
    yield serializers.serialize(
      object.fallbackAllowed,
      specifiedType: const FullType(bool),
    );
    yield r'eip_7702_required';
    yield serializers.serialize(
      object.eip7702Required,
      specifiedType: const FullType(bool),
    );
    yield r'eip_7702_notice';
    yield object.eip7702Notice == null ? null : serializers.serialize(
      object.eip7702Notice,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GasPaymentQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GasPaymentQuoteBuilder result,
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
            specifiedType: const FullType(GasSponsorshipDecision),
          ) as GasSponsorshipDecision;
          result.decision = valueDes;
          break;
        case r'platform_pays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.platformPays = valueDes;
          break;
        case r'native_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nativeAsset = valueDes;
          break;
        case r'estimated_native_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedNativeFee = valueDes;
          break;
        case r'estimated_fee_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(bool),
          ) as bool;
          result.fallbackAllowed = valueDes;
          break;
        case r'eip_7702_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
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
  GasPaymentQuote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GasPaymentQuoteBuilder();
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

