//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/realtime_candle_update.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/hip3_public_market.dart';
import 'package:rwa_api_client/src/model/candle_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_realtime_candle.g.dart';

/// 近期两根已结束窗口和当前窗口的OHLCV更新，历史补齐使用candles查询。 closed仅表示时间窗口结束，上游后续修正仍可更新同一根K线，不代表不可变最终成交。 
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
/// * [interval] 
/// * [point] 
/// * [closed] 
/// * [source_] 
/// * [updatedAt] 
/// * [freshUntil] 
@BuiltValue()
abstract class Hip3RealtimeCandle implements Hip3PublicMarket, RealtimeCandleUpdate, Built<Hip3RealtimeCandle, Hip3RealtimeCandleBuilder> {
  @BuiltValueField(wireName: r'source')
  String get source_;

  @BuiltValueField(wireName: r'closed')
  bool get closed;

  @BuiltValueField(wireName: r'fresh_until')
  DateTime get freshUntil;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  Hip3RealtimeCandle._();

  factory Hip3RealtimeCandle([void updates(Hip3RealtimeCandleBuilder b)]) = _$Hip3RealtimeCandle;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3RealtimeCandleBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3RealtimeCandle> get serializer => _$Hip3RealtimeCandleSerializer();
}

class _$Hip3RealtimeCandleSerializer implements PrimitiveSerializer<Hip3RealtimeCandle> {
  @override
  final Iterable<Type> types = const [Hip3RealtimeCandle, _$Hip3RealtimeCandle];

  @override
  final String wireName = r'Hip3RealtimeCandle';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3RealtimeCandle object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'settlement_asset';
    yield serializers.serialize(
      object.settlementAsset,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'venue';
    yield serializers.serialize(
      object.venue,
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
    yield r'point';
    yield serializers.serialize(
      object.point,
      specifiedType: const FullType(CandlePoint),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
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
    yield r'closed';
    yield serializers.serialize(
      object.closed,
      specifiedType: const FullType(bool),
    );
    yield r'interval';
    yield serializers.serialize(
      object.interval,
      specifiedType: const FullType(RealtimeCandleUpdateIntervalEnum),
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
    Hip3RealtimeCandle object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3RealtimeCandleBuilder result,
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
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'venue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.venue = valueDes;
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
        case r'point':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CandlePoint),
          ) as CandlePoint;
          result.point.replace(valueDes);
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PublicMarketEnvironmentEnum),
          ) as Hip3PublicMarketEnvironmentEnum;
          result.environment = valueDes;
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
        case r'closed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.closed = valueDes;
          break;
        case r'interval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RealtimeCandleUpdateIntervalEnum),
          ) as RealtimeCandleUpdateIntervalEnum;
          result.interval = valueDes;
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
  Hip3RealtimeCandle deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3RealtimeCandleBuilder();
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

class Hip3RealtimeCandleEnvironmentEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'mainnet')
  static const Hip3RealtimeCandleEnvironmentEnum mainnet = _$hip3RealtimeCandleEnvironmentEnum_mainnet;
  @BuiltValueEnumConst(wireName: r'testnet')
  static const Hip3RealtimeCandleEnvironmentEnum testnet = _$hip3RealtimeCandleEnvironmentEnum_testnet;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeCandleEnvironmentEnum unknownDefaultOpenApi = _$hip3RealtimeCandleEnvironmentEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeCandleEnvironmentEnum> get serializer => _$hip3RealtimeCandleEnvironmentEnumSerializer;

  const Hip3RealtimeCandleEnvironmentEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeCandleEnvironmentEnum> get values => _$hip3RealtimeCandleEnvironmentEnumValues;
  static Hip3RealtimeCandleEnvironmentEnum valueOf(String name) => _$hip3RealtimeCandleEnvironmentEnumValueOf(name);
}

class Hip3RealtimeCandleIntervalEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'1m')
  static const Hip3RealtimeCandleIntervalEnum n1m = _$hip3RealtimeCandleIntervalEnum_n1m;
  @BuiltValueEnumConst(wireName: r'5m')
  static const Hip3RealtimeCandleIntervalEnum n5m = _$hip3RealtimeCandleIntervalEnum_n5m;
  @BuiltValueEnumConst(wireName: r'15m')
  static const Hip3RealtimeCandleIntervalEnum n15m = _$hip3RealtimeCandleIntervalEnum_n15m;
  @BuiltValueEnumConst(wireName: r'1h')
  static const Hip3RealtimeCandleIntervalEnum n1h = _$hip3RealtimeCandleIntervalEnum_n1h;
  @BuiltValueEnumConst(wireName: r'4h')
  static const Hip3RealtimeCandleIntervalEnum n4h = _$hip3RealtimeCandleIntervalEnum_n4h;
  @BuiltValueEnumConst(wireName: r'1d')
  static const Hip3RealtimeCandleIntervalEnum n1d = _$hip3RealtimeCandleIntervalEnum_n1d;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3RealtimeCandleIntervalEnum unknownDefaultOpenApi = _$hip3RealtimeCandleIntervalEnum_unknownDefaultOpenApi;

  static Serializer<Hip3RealtimeCandleIntervalEnum> get serializer => _$hip3RealtimeCandleIntervalEnumSerializer;

  const Hip3RealtimeCandleIntervalEnum._(String name): super(name);

  static BuiltSet<Hip3RealtimeCandleIntervalEnum> get values => _$hip3RealtimeCandleIntervalEnumValues;
  static Hip3RealtimeCandleIntervalEnum valueOf(String name) => _$hip3RealtimeCandleIntervalEnumValueOf(name);
}

