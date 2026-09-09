//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_quote_request.g.dart';

/// WithdrawalQuoteRequest
///
/// Properties:
/// * [asset] 
/// * [chain] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [address] 
@BuiltValue()
abstract class WithdrawalQuoteRequest implements Built<WithdrawalQuoteRequest, WithdrawalQuoteRequestBuilder> {
  @BuiltValueField(wireName: r'asset')
  WithdrawalQuoteRequestAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  @BuiltValueField(wireName: r'chain')
  Chain get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'address')
  String get address;

  WithdrawalQuoteRequest._();

  factory WithdrawalQuoteRequest([void updates(WithdrawalQuoteRequestBuilder b)]) = _$WithdrawalQuoteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalQuoteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WithdrawalQuoteRequest> get serializer => _$WithdrawalQuoteRequestSerializer();
}

class _$WithdrawalQuoteRequestSerializer implements PrimitiveSerializer<WithdrawalQuoteRequest> {
  @override
  final Iterable<Type> types = const [WithdrawalQuoteRequest, _$WithdrawalQuoteRequest];

  @override
  final String wireName = r'WithdrawalQuoteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WithdrawalQuoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(WithdrawalQuoteRequestAssetEnum),
    );
    yield r'chain';
    yield serializers.serialize(
      object.chain,
      specifiedType: const FullType(Chain),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    WithdrawalQuoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalQuoteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WithdrawalQuoteRequestAssetEnum),
          ) as WithdrawalQuoteRequestAssetEnum;
          result.asset = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Chain),
          ) as Chain;
          result.chain = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WithdrawalQuoteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalQuoteRequestBuilder();
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

class WithdrawalQuoteRequestAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const WithdrawalQuoteRequestAssetEnum USDC = _$withdrawalQuoteRequestAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const WithdrawalQuoteRequestAssetEnum unknownDefaultOpenApi = _$withdrawalQuoteRequestAssetEnum_unknownDefaultOpenApi;

  static Serializer<WithdrawalQuoteRequestAssetEnum> get serializer => _$withdrawalQuoteRequestAssetEnumSerializer;

  const WithdrawalQuoteRequestAssetEnum._(String name): super(name);

  static BuiltSet<WithdrawalQuoteRequestAssetEnum> get values => _$withdrawalQuoteRequestAssetEnumValues;
  static WithdrawalQuoteRequestAssetEnum valueOf(String name) => _$withdrawalQuoteRequestAssetEnumValueOf(name);
}

