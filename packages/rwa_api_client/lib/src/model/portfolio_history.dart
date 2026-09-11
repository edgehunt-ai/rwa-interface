//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:rwa_api_client/src/model/portfolio_history_point.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_history.g.dart';

/// 证据感知的精确 decimal-string 资产历史；缺失区间不会用零值补点。The first returned point is the immutable baseline for every point-level PnL in this response; changing range or interval creates a different baseline and clients must not merge PnL values across responses. 
///
/// Properties:
/// * [range] 
/// * [interval] 
/// * [points] 
/// * [dataStatus] 
/// * [freshness] 
/// * [calculatedAt] - 最新已持久化估值或现金流证据的时间，不是处理本次 HTTP 请求的墙上时钟。
/// * [warnings] 
/// * [sources] 
@BuiltValue()
abstract class PortfolioHistory implements Built<PortfolioHistory, PortfolioHistoryBuilder> {
  @BuiltValueField(wireName: r'range')
  PortfolioHistoryRangeEnum get range;
  // enum rangeEnum {  1d,  1w,  1m,  1y,  };

  @BuiltValueField(wireName: r'interval')
  PortfolioHistoryIntervalEnum get interval;
  // enum intervalEnum {  5m,  1h,  1d,  1w,  };

  @BuiltValueField(wireName: r'points')
  BuiltList<PortfolioHistoryPoint> get points;

  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  /// 最新已持久化估值或现金流证据的时间，不是处理本次 HTTP 请求的墙上时钟。
  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  PortfolioHistory._();

  factory PortfolioHistory([void updates(PortfolioHistoryBuilder b)]) = _$PortfolioHistory;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioHistoryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioHistory> get serializer => _$PortfolioHistorySerializer();
}

class _$PortfolioHistorySerializer implements PrimitiveSerializer<PortfolioHistory> {
  @override
  final Iterable<Type> types = const [PortfolioHistory, _$PortfolioHistory];

  @override
  final String wireName = r'PortfolioHistory';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'range';
    yield serializers.serialize(
      object.range,
      specifiedType: const FullType(PortfolioHistoryRangeEnum),
    );
    yield r'interval';
    yield serializers.serialize(
      object.interval,
      specifiedType: const FullType(PortfolioHistoryIntervalEnum),
    );
    yield r'points';
    yield serializers.serialize(
      object.points,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioHistoryPoint)]),
    );
    yield r'data_status';
    yield serializers.serialize(
      object.dataStatus,
      specifiedType: const FullType(PortfolioDataStatus),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioHistory object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioHistoryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'range':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioHistoryRangeEnum),
          ) as PortfolioHistoryRangeEnum;
          result.range = valueDes;
          break;
        case r'interval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioHistoryIntervalEnum),
          ) as PortfolioHistoryIntervalEnum;
          result.interval = valueDes;
          break;
        case r'points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioHistoryPoint)]),
          ) as BuiltList<PortfolioHistoryPoint>;
          result.points.replace(valueDes);
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioDataStatus),
          ) as PortfolioDataStatus;
          result.dataStatus = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
          ) as BuiltList<PortfolioNotice>;
          result.warnings.replace(valueDes);
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
          ) as BuiltList<PortfolioSourceSummary>;
          result.sources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioHistory deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioHistoryBuilder();
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

class PortfolioHistoryRangeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'1d')
  static const PortfolioHistoryRangeEnum n1d = _$portfolioHistoryRangeEnum_n1d;
  @BuiltValueEnumConst(wireName: r'1w')
  static const PortfolioHistoryRangeEnum n1w = _$portfolioHistoryRangeEnum_n1w;
  @BuiltValueEnumConst(wireName: r'1m')
  static const PortfolioHistoryRangeEnum n1m = _$portfolioHistoryRangeEnum_n1m;
  @BuiltValueEnumConst(wireName: r'1y')
  static const PortfolioHistoryRangeEnum n1y = _$portfolioHistoryRangeEnum_n1y;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioHistoryRangeEnum unknownDefaultOpenApi = _$portfolioHistoryRangeEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioHistoryRangeEnum> get serializer => _$portfolioHistoryRangeEnumSerializer;

  const PortfolioHistoryRangeEnum._(String name): super(name);

  static BuiltSet<PortfolioHistoryRangeEnum> get values => _$portfolioHistoryRangeEnumValues;
  static PortfolioHistoryRangeEnum valueOf(String name) => _$portfolioHistoryRangeEnumValueOf(name);
}

class PortfolioHistoryIntervalEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'5m')
  static const PortfolioHistoryIntervalEnum n5m = _$portfolioHistoryIntervalEnum_n5m;
  @BuiltValueEnumConst(wireName: r'1h')
  static const PortfolioHistoryIntervalEnum n1h = _$portfolioHistoryIntervalEnum_n1h;
  @BuiltValueEnumConst(wireName: r'1d')
  static const PortfolioHistoryIntervalEnum n1d = _$portfolioHistoryIntervalEnum_n1d;
  @BuiltValueEnumConst(wireName: r'1w')
  static const PortfolioHistoryIntervalEnum n1w = _$portfolioHistoryIntervalEnum_n1w;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioHistoryIntervalEnum unknownDefaultOpenApi = _$portfolioHistoryIntervalEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioHistoryIntervalEnum> get serializer => _$portfolioHistoryIntervalEnumSerializer;

  const PortfolioHistoryIntervalEnum._(String name): super(name);

  static BuiltSet<PortfolioHistoryIntervalEnum> get values => _$portfolioHistoryIntervalEnumValues;
  static PortfolioHistoryIntervalEnum valueOf(String name) => _$portfolioHistoryIntervalEnumValueOf(name);
}

