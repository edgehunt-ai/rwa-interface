//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:rwa_api_client/src/model/funding_refund_policy.dart';
import 'package:rwa_api_client/src/model/funding_fee_breakdown.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_quote.g.dart';

/// The only selected, normalized and immutable Provider route exposed to the client.
///
/// Properties:
/// * [quoteId] 
/// * [provider] 
/// * [inputAmount] - 十进制字符串，避免浮点误差
/// * [maximumInputAmount] - 十进制字符串，避免浮点误差
/// * [minimumReceived] - 十进制字符串，避免浮点误差
/// * [fees] 
/// * [etaSeconds] 
/// * [quotedAt] 
/// * [expiresAt] 
/// * [quoteHash] 
/// * [refund] 
@BuiltValue()
abstract class FundingRouteQuote implements Built<FundingRouteQuote, FundingRouteQuoteBuilder> {
  @BuiltValueField(wireName: r'quote_id')
  String get quoteId;

  @BuiltValueField(wireName: r'provider')
  FundingProvider get provider;
  // enum providerEnum {  across,  relay,  hyperliquid_bridge2,  platform_float,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'input_amount')
  String get inputAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'maximum_input_amount')
  String get maximumInputAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  @BuiltValueField(wireName: r'fees')
  FundingFeeBreakdown get fees;

  @BuiltValueField(wireName: r'eta_seconds')
  int get etaSeconds;

  @BuiltValueField(wireName: r'quoted_at')
  DateTime get quotedAt;

  @BuiltValueField(wireName: r'expires_at')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'quote_hash')
  String get quoteHash;

  @BuiltValueField(wireName: r'refund')
  FundingRefundPolicy get refund;

  FundingRouteQuote._();

  factory FundingRouteQuote([void updates(FundingRouteQuoteBuilder b)]) = _$FundingRouteQuote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRouteQuoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRouteQuote> get serializer => _$FundingRouteQuoteSerializer();
}

class _$FundingRouteQuoteSerializer implements PrimitiveSerializer<FundingRouteQuote> {
  @override
  final Iterable<Type> types = const [FundingRouteQuote, _$FundingRouteQuote];

  @override
  final String wireName = r'FundingRouteQuote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRouteQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'quote_id';
    yield serializers.serialize(
      object.quoteId,
      specifiedType: const FullType(String),
    );
    yield r'provider';
    yield serializers.serialize(
      object.provider,
      specifiedType: const FullType(FundingProvider),
    );
    yield r'input_amount';
    yield serializers.serialize(
      object.inputAmount,
      specifiedType: const FullType(String),
    );
    yield r'maximum_input_amount';
    yield serializers.serialize(
      object.maximumInputAmount,
      specifiedType: const FullType(String),
    );
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    yield r'fees';
    yield serializers.serialize(
      object.fees,
      specifiedType: const FullType(FundingFeeBreakdown),
    );
    yield r'eta_seconds';
    yield serializers.serialize(
      object.etaSeconds,
      specifiedType: const FullType(int),
    );
    yield r'quoted_at';
    yield serializers.serialize(
      object.quotedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expires_at';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'quote_hash';
    yield serializers.serialize(
      object.quoteHash,
      specifiedType: const FullType(String),
    );
    yield r'refund';
    yield serializers.serialize(
      object.refund,
      specifiedType: const FullType(FundingRefundPolicy),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRouteQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRouteQuoteBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'quote_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quoteId = valueDes;
          break;
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingProvider),
          ) as FundingProvider;
          result.provider = valueDes;
          break;
        case r'input_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.inputAmount = valueDes;
          break;
        case r'maximum_input_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maximumInputAmount = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'fees':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingFeeBreakdown),
          ) as FundingFeeBreakdown;
          result.fees.replace(valueDes);
          break;
        case r'eta_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.etaSeconds = valueDes;
          break;
        case r'quoted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.quotedAt = valueDes;
          break;
        case r'expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'quote_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quoteHash = valueDes;
          break;
        case r'refund':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRefundPolicy),
          ) as FundingRefundPolicy;
          result.refund.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRouteQuote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRouteQuoteBuilder();
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

