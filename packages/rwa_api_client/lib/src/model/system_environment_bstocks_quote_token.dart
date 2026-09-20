//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_environment_bstocks_quote_token.g.dart';

/// SystemEnvironmentBstocksQuoteToken
///
/// Properties:
/// * [symbol] - 结算资产符号（主网 USDT / 测试网 TUSDT）
/// * [contract] - 结算资产 ERC-20 合约地址
/// * [decimals] - 结算资产小数位
@BuiltValue()
abstract class SystemEnvironmentBstocksQuoteToken implements Built<SystemEnvironmentBstocksQuoteToken, SystemEnvironmentBstocksQuoteTokenBuilder> {
  /// 结算资产符号（主网 USDT / 测试网 TUSDT）
  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  /// 结算资产 ERC-20 合约地址
  @BuiltValueField(wireName: r'contract')
  String get contract;

  /// 结算资产小数位
  @BuiltValueField(wireName: r'decimals')
  int get decimals;

  SystemEnvironmentBstocksQuoteToken._();

  factory SystemEnvironmentBstocksQuoteToken([void updates(SystemEnvironmentBstocksQuoteTokenBuilder b)]) = _$SystemEnvironmentBstocksQuoteToken;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemEnvironmentBstocksQuoteTokenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemEnvironmentBstocksQuoteToken> get serializer => _$SystemEnvironmentBstocksQuoteTokenSerializer();
}

class _$SystemEnvironmentBstocksQuoteTokenSerializer implements PrimitiveSerializer<SystemEnvironmentBstocksQuoteToken> {
  @override
  final Iterable<Type> types = const [SystemEnvironmentBstocksQuoteToken, _$SystemEnvironmentBstocksQuoteToken];

  @override
  final String wireName = r'SystemEnvironmentBstocksQuoteToken';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemEnvironmentBstocksQuoteToken object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'contract';
    yield serializers.serialize(
      object.contract,
      specifiedType: const FullType(String),
    );
    yield r'decimals';
    yield serializers.serialize(
      object.decimals,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemEnvironmentBstocksQuoteToken object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SystemEnvironmentBstocksQuoteTokenBuilder result,
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
        case r'contract':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contract = valueDes;
          break;
        case r'decimals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.decimals = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemEnvironmentBstocksQuoteToken deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemEnvironmentBstocksQuoteTokenBuilder();
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

