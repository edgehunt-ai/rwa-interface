//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_summary.g.dart';

/// PortfolioSummary
///
/// Properties:
/// * [totalValueUsd] - 十进制字符串，避免浮点误差
/// * [todayPnlUsd] - 十进制字符串，避免浮点误差
/// * [todayPnlPercent] - 十进制字符串，避免浮点误差
/// * [availableToTradeUsd] - 各交易账户中可直接下单的现金合计
/// * [marginInUseUsd] - 十进制字符串，避免浮点误差
/// * [stocksValueUsd] - 十进制字符串，避免浮点误差
/// * [updatedAt] 
@BuiltValue()
abstract class PortfolioSummary implements Built<PortfolioSummary, PortfolioSummaryBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'total_value_usd')
  String get totalValueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'today_pnl_usd')
  String? get todayPnlUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'today_pnl_percent')
  String? get todayPnlPercent;

  /// 各交易账户中可直接下单的现金合计
  @BuiltValueField(wireName: r'available_to_trade_usd')
  String get availableToTradeUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'margin_in_use_usd')
  String? get marginInUseUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stocks_value_usd')
  String? get stocksValueUsd;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  PortfolioSummary._();

  factory PortfolioSummary([void updates(PortfolioSummaryBuilder b)]) = _$PortfolioSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioSummary> get serializer => _$PortfolioSummarySerializer();
}

class _$PortfolioSummarySerializer implements PrimitiveSerializer<PortfolioSummary> {
  @override
  final Iterable<Type> types = const [PortfolioSummary, _$PortfolioSummary];

  @override
  final String wireName = r'PortfolioSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_value_usd';
    yield serializers.serialize(
      object.totalValueUsd,
      specifiedType: const FullType(String),
    );
    if (object.todayPnlUsd != null) {
      yield r'today_pnl_usd';
      yield serializers.serialize(
        object.todayPnlUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.todayPnlPercent != null) {
      yield r'today_pnl_percent';
      yield serializers.serialize(
        object.todayPnlPercent,
        specifiedType: const FullType(String),
      );
    }
    yield r'available_to_trade_usd';
    yield serializers.serialize(
      object.availableToTradeUsd,
      specifiedType: const FullType(String),
    );
    if (object.marginInUseUsd != null) {
      yield r'margin_in_use_usd';
      yield serializers.serialize(
        object.marginInUseUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.stocksValueUsd != null) {
      yield r'stocks_value_usd';
      yield serializers.serialize(
        object.stocksValueUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalValueUsd = valueDes;
          break;
        case r'today_pnl_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.todayPnlUsd = valueDes;
          break;
        case r'today_pnl_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.todayPnlPercent = valueDes;
          break;
        case r'available_to_trade_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableToTradeUsd = valueDes;
          break;
        case r'margin_in_use_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.marginInUseUsd = valueDes;
          break;
        case r'stocks_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stocksValueUsd = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
  PortfolioSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioSummaryBuilder();
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

