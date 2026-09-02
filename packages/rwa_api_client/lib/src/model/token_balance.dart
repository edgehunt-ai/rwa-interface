//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token_balance.g.dart';

/// TokenBalance
///
/// Properties:
/// * [symbol] 
/// * [balance] - 十进制字符串，避免浮点误差
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [decimals] 
/// * [chain] 
@BuiltValue()
abstract class TokenBalance implements Built<TokenBalance, TokenBalanceBuilder> {
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'balance')
  String get balance;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  @BuiltValueField(wireName: r'decimals')
  int? get decimals;

  @BuiltValueField(wireName: r'chain')
  Chain? get chain;
  // enum chainEnum {  BSC,  Arbitrum,  Base,  Ethereum,  Hyperliquid,  Polygon,  Solana,  };

  TokenBalance._();

  factory TokenBalance([void updates(TokenBalanceBuilder b)]) = _$TokenBalance;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TokenBalanceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TokenBalance> get serializer => _$TokenBalanceSerializer();
}

class _$TokenBalanceSerializer implements PrimitiveSerializer<TokenBalance> {
  @override
  final Iterable<Type> types = const [TokenBalance, _$TokenBalance];

  @override
  final String wireName = r'TokenBalance';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TokenBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'balance';
    yield serializers.serialize(
      object.balance,
      specifiedType: const FullType(String),
    );
    if (object.valueUsd != null) {
      yield r'value_usd';
      yield serializers.serialize(
        object.valueUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.decimals != null) {
      yield r'decimals';
      yield serializers.serialize(
        object.decimals,
        specifiedType: const FullType(int),
      );
    }
    if (object.chain != null) {
      yield r'chain';
      yield serializers.serialize(
        object.chain,
        specifiedType: const FullType(Chain),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TokenBalance object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TokenBalanceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.balance = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.decimals = valueDes;
          break;
        case r'chain':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Chain),
          ) as Chain?;
          if (valueDes == null) continue;
          result.chain = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TokenBalance deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TokenBalanceBuilder();
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

