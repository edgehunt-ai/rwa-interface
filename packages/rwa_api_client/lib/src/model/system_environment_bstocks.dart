//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/system_environment_bstocks_quote_token.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'system_environment_bstocks.g.dart';

/// SystemEnvironmentBstocks
///
/// Properties:
/// * [configured] - bStocks 执行链路（admission manifest + quoter）是否已挂载
/// * [environment] - admission manifest 声明的环境标识；未配置时缺省
/// * [chainId] - bStocks 结算链 ID（主网 56 / 测试网 97）；未配置时缺省
/// * [quoteToken] 
@BuiltValue()
abstract class SystemEnvironmentBstocks implements Built<SystemEnvironmentBstocks, SystemEnvironmentBstocksBuilder> {
  /// bStocks 执行链路（admission manifest + quoter）是否已挂载
  @BuiltValueField(wireName: r'configured')
  bool get configured;

  /// admission manifest 声明的环境标识；未配置时缺省
  @BuiltValueField(wireName: r'environment')
  String? get environment;

  /// bStocks 结算链 ID（主网 56 / 测试网 97）；未配置时缺省
  @BuiltValueField(wireName: r'chain_id')
  int? get chainId;

  @BuiltValueField(wireName: r'quote_token')
  SystemEnvironmentBstocksQuoteToken? get quoteToken;

  SystemEnvironmentBstocks._();

  factory SystemEnvironmentBstocks([void updates(SystemEnvironmentBstocksBuilder b)]) = _$SystemEnvironmentBstocks;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SystemEnvironmentBstocksBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SystemEnvironmentBstocks> get serializer => _$SystemEnvironmentBstocksSerializer();
}

class _$SystemEnvironmentBstocksSerializer implements PrimitiveSerializer<SystemEnvironmentBstocks> {
  @override
  final Iterable<Type> types = const [SystemEnvironmentBstocks, _$SystemEnvironmentBstocks];

  @override
  final String wireName = r'SystemEnvironmentBstocks';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SystemEnvironmentBstocks object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'configured';
    yield serializers.serialize(
      object.configured,
      specifiedType: const FullType(bool),
    );
    if (object.environment != null) {
      yield r'environment';
      yield serializers.serialize(
        object.environment,
        specifiedType: const FullType(String),
      );
    }
    if (object.chainId != null) {
      yield r'chain_id';
      yield serializers.serialize(
        object.chainId,
        specifiedType: const FullType(int),
      );
    }
    if (object.quoteToken != null) {
      yield r'quote_token';
      yield serializers.serialize(
        object.quoteToken,
        specifiedType: const FullType(SystemEnvironmentBstocksQuoteToken),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SystemEnvironmentBstocks object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SystemEnvironmentBstocksBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'configured':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.configured = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.environment = valueDes;
          break;
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.chainId = valueDes;
          break;
        case r'quote_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SystemEnvironmentBstocksQuoteToken),
          ) as SystemEnvironmentBstocksQuoteToken?;
          if (valueDes == null) continue;
          result.quoteToken.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SystemEnvironmentBstocks deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SystemEnvironmentBstocksBuilder();
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

