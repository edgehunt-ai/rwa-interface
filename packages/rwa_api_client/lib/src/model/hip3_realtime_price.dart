//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/hip3_public_market.dart';
import 'package:rwa_api_client/src/model/realtime_price_update.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_price.g.dart';

/// HIP3 Mark 行情，不是成交报价、Oracle 或独立美股参考报价。
///
/// Properties:
/// * [productId] 
/// * [venue] 
/// * [environment] 
/// * [settlementAsset] - 来源于该场所权威产品元数据的结算资产，不从 symbol 猜测。
/// * [tradable] 
/// * [unavailableReason] - 不可交易的产品级原因；tradable=true 时为 null。账户级限制仍由 context 返回。
/// * [symbol] 
/// * [kind] 
/// * [price] - 十进制字符串，避免浮点误差
/// * [change24hPercent] - 十进制字符串，避免浮点误差
/// * [updatedAt] 
/// * [priceLabel] 
/// * [source_] 
/// * [freshUntil] 
@BuiltValue()
abstract class Hip3RealtimePrice implements Hip3PublicMarket, RealtimePriceUpdate, Built<Hip3RealtimePrice, Hip3RealtimePriceBuilder> {
  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'fresh_until')
  DateTime get freshUntil;

  @BuiltValueField(wireName: r'price_label')
  Hip3RealtimePricePriceLabelEnum get priceLabel;
  // enum priceLabelEnum {  Mark price,  };

  Hip3RealtimePrice._();

  factory Hip3RealtimePrice([void updates(Hip3RealtimePriceBuilder b)]) = _$Hip3RealtimePrice;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimePriceBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimePrice> get serializer => _$Hip3RealtimePriceSerializer();
}

class _$Hip3RealtimePriceSerializer implements PrimitiveSerializer<Hip3RealtimePrice> {
  @override
  final Iterable<Type> types = const [Hip3RealtimePrice, _$Hip3RealtimePrice];

  @override
  final String wireName = r'Hip3RealtimePrice';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimePrice object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(String),
    );
    yield r'venue';
    yield serializers.serialize(
      object.venue,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'unavailable_reason';
    yield object.unavailableReason == null ? null : serializers.serialize(
      object.unavailableReason,
      specifiedType: const FullType.nullable(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    yield r'fresh_until';
    yield serializers.serialize(
      object.freshUntil,
      specifiedType: const FullType(DateTime),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
    );
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(String),
    );
    yield r'tradable';
    yield serializers.serialize(
      object.tradable,
      specifiedType: const FullType(bool),
    );
    yield r'price_label';
    yield serializers.serialize(
      object.priceLabel,
      specifiedType: const FullType(Hip3RealtimePricePriceLabelEnum),
    );
    yield r'change_24h_percent';
    yield serializers.serialize(
      object.change24hPercent,
      specifiedType: const FullType(String),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3RealtimePrice object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimePriceBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'settlement_asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.settlementAsset = valueDes;
          break;
        case r'venue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.venue = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'unavailable_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unavailableReason = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'fresh_until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.freshUntil = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
          ) as Hip3PublicMarketEnvironmentEnum;
          result.environment = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.price = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.source_ = valueDes;
          break;
        case r'tradable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.tradable = valueDes;
          break;
        case r'price_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3RealtimePricePriceLabelEnum),
          ) as Hip3RealtimePricePriceLabelEnum;
          result.priceLabel = valueDes;
          break;
        case r'change_24h_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.change24hPercent = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3RealtimePrice deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimePriceBuilder();
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

class Hip3RealtimePriceEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3RealtimePriceEnvironmentEnum mainnet = _$hip3RealtimePriceEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const Hip3RealtimePriceEnvironmentEnum testnet = _$hip3RealtimePriceEnvironmentEnum_testnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePriceEnvironmentEnum unknownDefaultOpenApi = _$hip3RealtimePriceEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePriceEnvironmentEnum> get serializer => _$hip3RealtimePriceEnvironmentEnumSerializer;

  const Hip3RealtimePriceEnvironmentEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePriceEnvironmentEnum> get values => _$hip3RealtimePriceEnvironmentEnumValues;
  static Hip3RealtimePriceEnvironmentEnum valueOf(String name) => _$hip3RealtimePriceEnvironmentEnumValueOf(name);
}

class Hip3RealtimePricePriceLabelEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Mark price')
  static const Hip3RealtimePricePriceLabelEnum markPrice = _$hip3RealtimePricePriceLabelEnum_markPrice;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimePricePriceLabelEnum unknownDefaultOpenApi = _$hip3RealtimePricePriceLabelEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimePricePriceLabelEnum> get serializer => _$hip3RealtimePricePriceLabelEnumSerializer;

  const Hip3RealtimePricePriceLabelEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimePricePriceLabelEnum> get values => _$hip3RealtimePricePriceLabelEnumValues;
  static Hip3RealtimePricePriceLabelEnum valueOf(String name) => _$hip3RealtimePricePriceLabelEnumValueOf(name);
}

