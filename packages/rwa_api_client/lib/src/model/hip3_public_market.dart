//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_public_market.g.dart';

/// 服务端确认的公开 HIP3 行情身份。environment 指行情来源环境，不是钱包充值网络。 tradable 仅表示该公开产品在当前客户端签名执行通道的产品级可用性，不授予账户交易权限。 开仓前必须加载同 product_id、venue、environment 的最新 context，并使用其中最大杠杆及其他动态限制； 身份不一致必须拒绝下单，不能按 symbol 偷换产品或网络。主网只读行情不代表已开放主网执行。 
///
/// Properties:
/// * [productId] 
/// * [venue] 
/// * [environment] 
/// * [settlementAsset] - 来源于该场所权威产品元数据的结算资产，不从 symbol 猜测。
/// * [tradable] 
/// * [unavailableReason] - 不可交易的产品级原因；tradable=true 时为 null。账户级限制仍由 context 返回。
@BuiltValue()
abstract class Hip3PublicMarket implements Built<Hip3PublicMarket, Hip3PublicMarketBuilder> {
  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'venue')
  String get venue;

  @BuiltValueField(wireName: r'environment')
  Hip3PublicMarketEnvironmentEnum get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  /// 来源于该场所权威产品元数据的结算资产，不从 symbol 猜测。
  @BuiltValueField(wireName: r'settlement_asset')
  String get settlementAsset;

  @BuiltValueField(wireName: r'tradable')
  bool get tradable;

  /// 不可交易的产品级原因；tradable=true 时为 null。账户级限制仍由 context 返回。
  @BuiltValueField(wireName: r'unavailable_reason')
  String? get unavailableReason;

  Hip3PublicMarket._();

  factory Hip3PublicMarket([void updates(Hip3PublicMarketBuilder b)]) = _$Hip3PublicMarket;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3PublicMarketBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3PublicMarket> get serializer => _$Hip3PublicMarketSerializer();
}

class _$Hip3PublicMarketSerializer implements PrimitiveSerializer<Hip3PublicMarket> {
  @override
  final Iterable<Type> types = const [Hip3PublicMarket, _$Hip3PublicMarket];

  @override
  final String wireName = r'Hip3PublicMarket';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3PublicMarket object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'venue';
    yield serializers.serialize(
      object.venue,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
    );
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(String),
    );
    yield r'tradable';
    yield serializers.serialize(
      object.tradable,
      specifiedType: const FullType(bool),
    );
    yield r'unavailable_reason';
    yield object.unavailableReason == null ? null : serializers.serialize(
      object.unavailableReason,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3PublicMarket object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3PublicMarketBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'venue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.venue = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
          ) as Hip3PublicMarketEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.settlementAsset = valueDes;
          break;
        case r'tradable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.tradable = valueDes;
          break;
        case r'unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unavailableReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3PublicMarket deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3PublicMarketBuilder();
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

class Hip3PublicMarketEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3PublicMarketEnvironmentEnum mainnet = _$hip3PublicMarketEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const Hip3PublicMarketEnvironmentEnum testnet = _$hip3PublicMarketEnvironmentEnum_testnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3PublicMarketEnvironmentEnum unknownDefaultOpenApi = _$hip3PublicMarketEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3PublicMarketEnvironmentEnum> get serializer => _$hip3PublicMarketEnvironmentEnumSerializer;

  const Hip3PublicMarketEnvironmentEnum._(String name): super(name);

  static BuiltSet<Hip3PublicMarketEnvironmentEnum> get values => _$hip3PublicMarketEnvironmentEnumValues;
  static Hip3PublicMarketEnvironmentEnum valueOf(String name) => _$hip3PublicMarketEnvironmentEnumValueOf(name);
}

