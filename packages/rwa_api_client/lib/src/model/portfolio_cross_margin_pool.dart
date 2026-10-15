//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_cross_margin_pool.g.dart';

/// 资产页全仓资金池的父级展示口径（A/C），不是已用保证金，也不是可转出金额。 对每个 Unified Account 的 USDC 总量扣除单独展示的逐仓保证金及 Perps 开仓挂单保证金估算，最低为0，再跨账户合计。 挂单扣除沿用 open_order_margin_estimate 的估算口径；不扣除 Cross 初始/维持保证金，不用已用保证金加可转出金额反推。 quantity 和 value_usd 来自同一账户快照和抵押资产，美元值使用该快照的组合估值价格；前端不得混用 accounts 中的余额。 A 的百分数使用 value_usd / allocation.valued_total_usd × 100；总额为0时为0，整个资产分配不完整时不展示占比。 当前仅支持有完整 USDC 抵押数据的 Unified Account；Classic、Portfolio Margin 或必要来源缺失/过期时不可用。 这是 USDC 资金池口径，不包含其他抵押币种；spot hold 属于资金池内部限制，不作为独立分组再次扣除。 
///
/// Properties:
/// * [status] 
/// * [asset] 
/// * [quantity] - USDC 数量；必要账户/挂单来源不可用时为 null，已确认空账户为0。
/// * [valueUsd] - 上述 USDC 数量对应的美元估值；不可用时为 null，不保证与数量数值相同。
@BuiltValue()
abstract class PortfolioCrossMarginPool implements Built<PortfolioCrossMarginPool, PortfolioCrossMarginPoolBuilder> {
  @BuiltValueField(wireName: r'status')
  PortfolioCrossMarginPoolStatusEnum get status;
  // enum statusEnum {  available,  unavailable,  };

  @BuiltValueField(wireName: r'asset')
  PortfolioCrossMarginPoolAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// USDC 数量；必要账户/挂单来源不可用时为 null，已确认空账户为0。
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 上述 USDC 数量对应的美元估值；不可用时为 null，不保证与数量数值相同。
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  PortfolioCrossMarginPool._();

  factory PortfolioCrossMarginPool([void updates(PortfolioCrossMarginPoolBuilder b)]) = _$PortfolioCrossMarginPool;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioCrossMarginPoolBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioCrossMarginPool> get serializer => _$PortfolioCrossMarginPoolSerializer();
}

class _$PortfolioCrossMarginPoolSerializer implements PrimitiveSerializer<PortfolioCrossMarginPool> {
  @override
  final Iterable<Type> types = const [PortfolioCrossMarginPool, _$PortfolioCrossMarginPool];

  @override
  final String wireName = r'PortfolioCrossMarginPool';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioCrossMarginPool object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(PortfolioCrossMarginPoolStatusEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(PortfolioCrossMarginPoolAssetEnum),
    );
    yield r'quantity';
    yield object.quantity == null ? null : serializers.serialize(
      object.quantity,
      specifiedType: const FullType.nullable(String),
    );
    yield r'value_usd';
    yield object.valueUsd == null ? null : serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioCrossMarginPool object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioCrossMarginPoolBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioCrossMarginPoolStatusEnum),
          ) as PortfolioCrossMarginPoolStatusEnum;
          result.status = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioCrossMarginPoolAssetEnum),
          ) as PortfolioCrossMarginPoolAssetEnum;
          result.asset = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioCrossMarginPool deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioCrossMarginPoolBuilder();
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

class PortfolioCrossMarginPoolStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const PortfolioCrossMarginPoolStatusEnum available = _$portfolioCrossMarginPoolStatusEnum_available;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const PortfolioCrossMarginPoolStatusEnum unavailable = _$portfolioCrossMarginPoolStatusEnum_unavailable;

  static Serializer<PortfolioCrossMarginPoolStatusEnum> get serializer => _$portfolioCrossMarginPoolStatusEnumSerializer;

  const PortfolioCrossMarginPoolStatusEnum._(String name): super(name);

  static BuiltSet<PortfolioCrossMarginPoolStatusEnum> get values => _$portfolioCrossMarginPoolStatusEnumValues;
  static PortfolioCrossMarginPoolStatusEnum valueOf(String name) => _$portfolioCrossMarginPoolStatusEnumValueOf(name);
}

class PortfolioCrossMarginPoolAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const PortfolioCrossMarginPoolAssetEnum USDC = _$portfolioCrossMarginPoolAssetEnum_USDC;

  static Serializer<PortfolioCrossMarginPoolAssetEnum> get serializer => _$portfolioCrossMarginPoolAssetEnumSerializer;

  const PortfolioCrossMarginPoolAssetEnum._(String name): super(name);

  static BuiltSet<PortfolioCrossMarginPoolAssetEnum> get values => _$portfolioCrossMarginPoolAssetEnumValues;
  static PortfolioCrossMarginPoolAssetEnum valueOf(String name) => _$portfolioCrossMarginPoolAssetEnumValueOf(name);
}

