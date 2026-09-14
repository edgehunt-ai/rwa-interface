//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/hip3_candle_provenance.dart';
import 'package:rwa_api_client/src/model/chart_range.dart';
import 'package:rwa_api_client/src/model/candle_point.dart';
import 'package:rwa_api_client/src/model/session_segment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'candle_series.g.dart';

/// CandleSeries
///
/// Properties:
/// * [hip3Provenance] 
/// * [symbol] 
/// * [kind] 
/// * [range] 
/// * [interval] 
/// * [from] 
/// * [to] 
/// * [changeAbsolute] - 区间涨跌额，用于图表标题 `+$4.12 (+2.31%) 24h`
/// * [changePercent] - 十进制字符串，避免浮点误差
/// * [points] - 链上产品价格序列
/// * [referencePoints] - 美股参考价序列。仅在美股有报价的时段有值 —— 隔夜与休市时段为空洞， 前端应断开连线或画虚线。 
/// * [sessions] - 该区间内的时段分段，用于绘制底部色带
@BuiltValue()
abstract class CandleSeries implements Built<CandleSeries, CandleSeriesBuilder> {
  @BuiltValueField(wireName: r'hip3_provenance')
  Hip3CandleProvenance? get hip3Provenance;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'range')
  ChartRange get range;
  // enum rangeEnum {  15m,  1h,  4h,  24h,  1w,  };

  @BuiltValueField(wireName: r'interval')
  String? get interval;

  @BuiltValueField(wireName: r'from')
  DateTime? get from;

  @BuiltValueField(wireName: r'to')
  DateTime? get to;

  /// 区间涨跌额，用于图表标题 `+$4.12 (+2.31%) 24h`
  @BuiltValueField(wireName: r'change_absolute')
  String? get changeAbsolute;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'change_percent')
  String? get changePercent;

  /// 链上产品价格序列
  @BuiltValueField(wireName: r'points')
  BuiltList<CandlePoint> get points;

  /// 美股参考价序列。仅在美股有报价的时段有值 —— 隔夜与休市时段为空洞， 前端应断开连线或画虚线。 
  @BuiltValueField(wireName: r'reference_points')
  BuiltList<CandlePoint>? get referencePoints;

  /// 该区间内的时段分段，用于绘制底部色带
  @BuiltValueField(wireName: r'sessions')
  BuiltList<SessionSegment>? get sessions;

  CandleSeries._();

  factory CandleSeries([void updates(CandleSeriesBuilder b)]) = _$CandleSeries;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CandleSeriesBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CandleSeries> get serializer => _$CandleSeriesSerializer();
}

class _$CandleSeriesSerializer implements PrimitiveSerializer<CandleSeries> {
  @override
  final Iterable<Type> types = const [CandleSeries, _$CandleSeries];

  @override
  final String wireName = r'CandleSeries';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CandleSeries object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.hip3Provenance != null) {
      yield r'hip3_provenance';
      yield serializers.serialize(
        object.hip3Provenance,
        specifiedType: const FullType(Hip3CandleProvenance),
      );
    }
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    yield r'range';
    yield serializers.serialize(
      object.range,
      specifiedType: const FullType(ChartRange),
    );
    if (object.interval != null) {
      yield r'interval';
      yield serializers.serialize(
        object.interval,
        specifiedType: const FullType(String),
      );
    }
    if (object.from != null) {
      yield r'from';
      yield serializers.serialize(
        object.from,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.to != null) {
      yield r'to';
      yield serializers.serialize(
        object.to,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.changeAbsolute != null) {
      yield r'change_absolute';
      yield serializers.serialize(
        object.changeAbsolute,
        specifiedType: const FullType(String),
      );
    }
    if (object.changePercent != null) {
      yield r'change_percent';
      yield serializers.serialize(
        object.changePercent,
        specifiedType: const FullType(String),
      );
    }
    yield r'points';
    yield serializers.serialize(
      object.points,
      specifiedType: const FullType(BuiltList, [FullType(CandlePoint)]),
    );
    if (object.referencePoints != null) {
      yield r'reference_points';
      yield serializers.serialize(
        object.referencePoints,
        specifiedType: const FullType(BuiltList, [FullType(CandlePoint)]),
      );
    }
    if (object.sessions != null) {
      yield r'sessions';
      yield serializers.serialize(
        object.sessions,
        specifiedType: const FullType(BuiltList, [FullType(SessionSegment)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CandleSeries object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CandleSeriesBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hip3_provenance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3CandleProvenance),
          ) as Hip3CandleProvenance?;
          if (valueDes == null) continue;
          result.hip3Provenance.replace(valueDes);
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'range':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChartRange),
          ) as ChartRange;
          result.range = valueDes;
          break;
        case r'interval':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.interval = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.to = valueDes;
          break;
        case r'change_absolute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.changeAbsolute = valueDes;
          break;
        case r'change_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.changePercent = valueDes;
          break;
        case r'points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(CandlePoint)]),
          ) as BuiltList<CandlePoint>;
          result.points.replace(valueDes);
          break;
        case r'reference_points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(CandlePoint)]),
          ) as BuiltList<CandlePoint>?;
          if (valueDes == null) continue;
          result.referencePoints.replace(valueDes);
          break;
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SessionSegment)]),
          ) as BuiltList<SessionSegment>?;
          if (valueDes == null) continue;
          result.sessions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CandleSeries deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CandleSeriesBuilder();
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

