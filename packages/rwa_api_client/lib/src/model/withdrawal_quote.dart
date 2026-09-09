//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_quote.g.dart';

/// WithdrawalQuote
///
/// Properties:
/// * [quoteId] - 本次报价的标识，回传到 `CreateWithdrawalRequest.quote_id` 可锁定费率
/// * [asset]
/// * [chain]
/// * [amount] - 十进制字符串，避免浮点误差
/// * [needsConvert] - 目标资产非 USDC 时需内部 Convert
/// * [convertRoute]
/// * [transferRoute]
/// * [needsBridge]
/// * [bridgeRoute]
/// * [convertTransferFee] - 十进制字符串，避免浮点误差
/// * [bridgeFee] - 十进制字符串，避免浮点误差
/// * [networkFee] - 十进制字符串，避免浮点误差
/// * [totalFee] - 十进制字符串，避免浮点误差
/// * [estimatedReceive] - 十进制字符串，避免浮点误差
/// * [estimatedTime]
/// * [sufficient] - 提现金额是否足以覆盖费用
/// * [details]
@BuiltValue()
abstract class WithdrawalQuote
    implements Built<WithdrawalQuote, WithdrawalQuoteBuilder> {
  /// 本次报价的标识，回传到 `CreateWithdrawalRequest.quote_id` 可锁定费率
  @BuiltValueField(wireName: r'quote_id')
  String get quoteId;

  @BuiltValueField(wireName: r'asset')
  WithdrawalQuoteAssetEnum? get asset;
  // enum assetEnum {  USDC,  };

  @BuiltValueField(wireName: r'chain')
  Chain? get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  /// 目标资产非 USDC 时需内部 Convert
  @BuiltValueField(wireName: r'needs_convert')
  bool? get needsConvert;

  @BuiltValueField(wireName: r'convert_route')
  String? get convertRoute;

  @BuiltValueField(wireName: r'transfer_route')
  String? get transferRoute;

  @BuiltValueField(wireName: r'needs_bridge')
  bool? get needsBridge;

  @BuiltValueField(wireName: r'bridge_route')
  String? get bridgeRoute;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'convert_transfer_fee')
  String? get convertTransferFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'bridge_fee')
  String? get bridgeFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'network_fee')
  String? get networkFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_fee')
  String get totalFee;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_receive')
  String get estimatedReceive;

  @BuiltValueField(wireName: r'estimated_time')
  String? get estimatedTime;

  /// 提现金额是否足以覆盖费用
  @BuiltValueField(wireName: r'sufficient')
  bool get sufficient;

  @BuiltValueField(wireName: r'details')
  BuiltList<KeyValue>? get details;

  WithdrawalQuote._();

  factory WithdrawalQuote([void updates(WithdrawalQuoteBuilder b)]) =
      _$WithdrawalQuote;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalQuoteBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WithdrawalQuote> get serializer =>
      _$WithdrawalQuoteSerializer();
}

class _$WithdrawalQuoteSerializer
    implements PrimitiveSerializer<WithdrawalQuote> {
  @override
  final Iterable<Type> types = const [WithdrawalQuote, _$WithdrawalQuote];

  @override
  final String wireName = r'WithdrawalQuote';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WithdrawalQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'quote_id';
    yield serializers.serialize(
      object.quoteId,
      specifiedType: const FullType(String),
    );
    if (object.asset != null) {
      yield r'asset';
      yield serializers.serialize(
        object.asset,
        specifiedType: const FullType(WithdrawalQuoteAssetEnum),
      );
    }
    if (object.chain != null) {
      yield r'chain';
      yield serializers.serialize(
        object.chain,
        specifiedType: const FullType(Chain),
      );
    }
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.needsConvert != null) {
      yield r'needs_convert';
      yield serializers.serialize(
        object.needsConvert,
        specifiedType: const FullType(bool),
      );
    }
    if (object.convertRoute != null) {
      yield r'convert_route';
      yield serializers.serialize(
        object.convertRoute,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.transferRoute != null) {
      yield r'transfer_route';
      yield serializers.serialize(
        object.transferRoute,
        specifiedType: const FullType(String),
      );
    }
    if (object.needsBridge != null) {
      yield r'needs_bridge';
      yield serializers.serialize(
        object.needsBridge,
        specifiedType: const FullType(bool),
      );
    }
    if (object.bridgeRoute != null) {
      yield r'bridge_route';
      yield serializers.serialize(
        object.bridgeRoute,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.convertTransferFee != null) {
      yield r'convert_transfer_fee';
      yield serializers.serialize(
        object.convertTransferFee,
        specifiedType: const FullType(String),
      );
    }
    if (object.bridgeFee != null) {
      yield r'bridge_fee';
      yield serializers.serialize(
        object.bridgeFee,
        specifiedType: const FullType(String),
      );
    }
    if (object.networkFee != null) {
      yield r'network_fee';
      yield serializers.serialize(
        object.networkFee,
        specifiedType: const FullType(String),
      );
    }
    yield r'total_fee';
    yield serializers.serialize(
      object.totalFee,
      specifiedType: const FullType(String),
    );
    yield r'estimated_receive';
    yield serializers.serialize(
      object.estimatedReceive,
      specifiedType: const FullType(String),
    );
    if (object.estimatedTime != null) {
      yield r'estimated_time';
      yield serializers.serialize(
        object.estimatedTime,
        specifiedType: const FullType(String),
      );
    }
    yield r'sufficient';
    yield serializers.serialize(
      object.sufficient,
      specifiedType: const FullType(bool),
    );
    if (object.details != null) {
      yield r'details';
      yield serializers.serialize(
        object.details,
        specifiedType: const FullType(BuiltList, [FullType(KeyValue)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WithdrawalQuote object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalQuoteBuilder result,
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
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(WithdrawalQuoteAssetEnum),
          ) as WithdrawalQuoteAssetEnum?;
          if (valueDes == null) continue;
          result.asset = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Chain),
          ) as Chain?;
          if (valueDes == null) continue;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'needs_convert':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.needsConvert = valueDes;
          break;
        case r'convert_route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.convertRoute = valueDes;
          break;
        case r'transfer_route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transferRoute = valueDes;
          break;
        case r'needs_bridge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.needsBridge = valueDes;
          break;
        case r'bridge_route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bridgeRoute = valueDes;
          break;
        case r'convert_transfer_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.convertTransferFee = valueDes;
          break;
        case r'bridge_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bridgeFee = valueDes;
          break;
        case r'network_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.networkFee = valueDes;
          break;
        case r'total_fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalFee = valueDes;
          break;
        case r'estimated_receive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedReceive = valueDes;
          break;
        case r'estimated_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedTime = valueDes;
          break;
        case r'sufficient':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.sufficient = valueDes;
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(KeyValue)]),
          ) as BuiltList<KeyValue>?;
          if (valueDes == null) continue;
          result.details.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WithdrawalQuote deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalQuoteBuilder();
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

class WithdrawalQuoteAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const WithdrawalQuoteAssetEnum USDC = _$withdrawalQuoteAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WithdrawalQuoteAssetEnum unknownDefaultOpenApi =
      _$withdrawalQuoteAssetEnum_unknownDefaultOpenApi;

  static Serializer<WithdrawalQuoteAssetEnum> get serializer =>
      _$withdrawalQuoteAssetEnumSerializer;

  const WithdrawalQuoteAssetEnum._(String name) : super(name);

  static BuiltSet<WithdrawalQuoteAssetEnum> get values =>
      _$withdrawalQuoteAssetEnumValues;
  static WithdrawalQuoteAssetEnum valueOf(String name) =>
      _$withdrawalQuoteAssetEnumValueOf(name);
}
