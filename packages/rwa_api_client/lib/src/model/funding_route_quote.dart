//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_provider.dart';
import 'package:rwa_api_client/src/model/funding_refund_policy.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_fee_breakdown.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_route_quote.g.dart';

/// The only selected, normalized and immutable Provider route exposed to the client.
///
/// Properties:
/// * [quoteId] 
/// * [provider] 
/// * [targetEnvironment] - Frozen target environment of this selected route; historical null must not be inferred from chain or symbol.
/// * [inputAmount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [maximumInputAmount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [estimatedReceived] - Estimated target-asset amount before quote protection. This is denominated in the route target asset, never the source asset. For the current exact-output Relay route this equals `minimum_received`. 
/// * [minimumReceived] - Provider-guaranteed minimum target-asset amount after quote protection and the costs already represented by the route. Fee components are explanatory and must not be subtracted from this amount again. It must not be derived by subtracting unlike source and target asset amounts. 
/// * [slippageBps] - Provider-reported quote tolerance in basis points (`100` bps = `1%`), copied from the selected route without deriving it from source/output amounts. Null means the Provider did not report a tolerance; it does not mean zero slippage. 
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

  /// Frozen target environment of this selected route; historical null must not be inferred from chain or symbol.
  @BuiltValueField(wireName: r'target_environment')
  FundingRouteQuoteTargetEnvironmentEnum? get targetEnvironment;
  // enum targetEnvironmentEnum {  mainnet,  testnet,  };

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'input_amount')
  String get inputAmount;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'maximum_input_amount')
  String get maximumInputAmount;

  /// Estimated target-asset amount before quote protection. This is denominated in the route target asset, never the source asset. For the current exact-output Relay route this equals `minimum_received`. 
  @BuiltValueField(wireName: r'estimated_received')
  String? get estimatedReceived;

  /// Provider-guaranteed minimum target-asset amount after quote protection and the costs already represented by the route. Fee components are explanatory and must not be subtracted from this amount again. It must not be derived by subtracting unlike source and target asset amounts. 
  @BuiltValueField(wireName: r'minimum_received')
  String get minimumReceived;

  /// Provider-reported quote tolerance in basis points (`100` bps = `1%`), copied from the selected route without deriving it from source/output amounts. Null means the Provider did not report a tolerance; it does not mean zero slippage. 
  @BuiltValueField(wireName: r'slippage_bps')
  int? get slippageBps;

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
    if (object.targetEnvironment != null) {
      yield r'target_environment';
      yield serializers.serialize(
        object.targetEnvironment,
        specifiedType: const FullType.nullable(FundingRouteQuoteTargetEnvironmentEnum),
      );
    }
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
    if (object.estimatedReceived != null) {
      yield r'estimated_received';
      yield serializers.serialize(
        object.estimatedReceived,
        specifiedType: const FullType(String),
      );
    }
    yield r'minimum_received';
    yield serializers.serialize(
      object.minimumReceived,
      specifiedType: const FullType(String),
    );
    if (object.slippageBps != null) {
      yield r'slippage_bps';
      yield serializers.serialize(
        object.slippageBps,
        specifiedType: const FullType.nullable(int),
      );
    }
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
        case r'target_environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingRouteQuoteTargetEnvironmentEnum),
          ) as FundingRouteQuoteTargetEnvironmentEnum?;
          if (valueDes == null) continue;
          result.targetEnvironment = valueDes;
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
        case r'estimated_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedReceived = valueDes;
          break;
        case r'minimum_received':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minimumReceived = valueDes;
          break;
        case r'slippage_bps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.slippageBps = valueDes;
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

class FundingRouteQuoteTargetEnvironmentEnum extends EnumClass {

  /// Frozen target environment of this selected route; historical null must not be inferred from chain or symbol.
  @BuiltValueEnumConst(wireName: r'mainnet')
  static const FundingRouteQuoteTargetEnvironmentEnum mainnet = _$fundingRouteQuoteTargetEnvironmentEnum_mainnet;
  /// Frozen target environment of this selected route; historical null must not be inferred from chain or symbol.
  @BuiltValueEnumConst(wireName: r'testnet')
  static const FundingRouteQuoteTargetEnvironmentEnum testnet = _$fundingRouteQuoteTargetEnvironmentEnum_testnet;

  static Serializer<FundingRouteQuoteTargetEnvironmentEnum> get serializer => _$fundingRouteQuoteTargetEnvironmentEnumSerializer;

  const FundingRouteQuoteTargetEnvironmentEnum._(String name): super(name);

  static BuiltSet<FundingRouteQuoteTargetEnvironmentEnum> get values => _$fundingRouteQuoteTargetEnvironmentEnumValues;
  static FundingRouteQuoteTargetEnvironmentEnum valueOf(String name) => _$fundingRouteQuoteTargetEnvironmentEnumValueOf(name);
}

