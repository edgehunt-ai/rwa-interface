//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'position.g.dart';

/// Position
///
/// Properties:
/// * [productId] - HIP3 完整 venue:coin。
/// * [positionVersion] - HIP3 变更保护和 close preview 使用的业务仓位版本；数量、方向及影响操作的状态变化时更新，不因单纯行情刷新而变化。
/// * [hip3ActionId] - 当前 HIP3 修改工作流；待签名阶段不改变已生效仓位字段。
/// * [protectionOrderIds] - 当前有效的独立 TP/SL Order ID，可查询和分别取消。
/// * [positionId] 
/// * [symbol] 
/// * [name] 
/// * [kind] 
/// * [side] - 仅 HIP-3
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [quantityUnit] 
/// * [valueUsd] - 现货为持仓市值，合约为仓位权益
/// * [entryPrice] - 十进制字符串，避免浮点误差
/// * [markPrice] - 十进制字符串，避免浮点误差
/// * [unrealizedPnl] - 十进制字符串，避免浮点误差
/// * [unrealizedPnlPercent] - 十进制字符串，避免浮点误差
/// * [realizedPnl] - 十进制字符串，避免浮点误差
/// * [costBasis] - 十进制字符串，避免浮点误差
/// * [leverage] - Decimal string leverage; allowed range is 1 to 50.
/// * [marginMode] 
/// * [margin] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 十进制字符串，避免浮点误差
/// * [fundingPaid] - 累计资金费；负数为支付，正数为收取
/// * [takeProfitPrice] - 十进制字符串，避免浮点误差
/// * [stopLossPrice] - 十进制字符串，避免浮点误差
/// * [stopLimitPrice] - 已设置的止损限价；与 `stop_loss_price` 一起用于完整回显 TP / SL
/// * [openedAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class Position implements Built<Position, PositionBuilder> {
  /// HIP3 完整 venue:coin。
  @BuiltValueField(wireName: r'product_id')
  String? get productId;

  /// HIP3 变更保护和 close preview 使用的业务仓位版本；数量、方向及影响操作的状态变化时更新，不因单纯行情刷新而变化。
  @BuiltValueField(wireName: r'position_version')
  String? get positionVersion;

  /// 当前 HIP3 修改工作流；待签名阶段不改变已生效仓位字段。
  @BuiltValueField(wireName: r'hip3_action_id')
  String? get hip3ActionId;

  /// 当前有效的独立 TP/SL Order ID，可查询和分别取消。
  @BuiltValueField(wireName: r'protection_order_ids')
  BuiltList<String>? get protectionOrderIds;

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'symbol')
  String get symbol;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'kind')
  ProductKind get kind;
  // enum kindEnum {  bstock,  perp,  };

  /// 仅 HIP-3
  @BuiltValueField(wireName: r'side')
  PositionSideEnum? get side;
  // enum sideEnum {  long,  short,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  @BuiltValueField(wireName: r'quantity_unit')
  String? get quantityUnit;

  /// 现货为持仓市值，合约为仓位权益
  @BuiltValueField(wireName: r'value_usd')
  String get valueUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'entry_price')
  String? get entryPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'mark_price')
  String? get markPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'unrealized_pnl')
  String? get unrealizedPnl;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'unrealized_pnl_percent')
  String? get unrealizedPnlPercent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'realized_pnl')
  String? get realizedPnl;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'cost_basis')
  String? get costBasis;

  /// Decimal string leverage; allowed range is 1 to 50.
  @BuiltValueField(wireName: r'leverage')
  String? get leverage;

  @BuiltValueField(wireName: r'margin_mode')
  MarginMode? get marginMode;
  // enum marginModeEnum {  isolated,  cross,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'margin')
  String? get margin;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'liquidation_price')
  String? get liquidationPrice;

  /// 累计资金费；负数为支付，正数为收取
  @BuiltValueField(wireName: r'funding_paid')
  String? get fundingPaid;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'take_profit_price')
  String? get takeProfitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stop_loss_price')
  String? get stopLossPrice;

  /// 已设置的止损限价；与 `stop_loss_price` 一起用于完整回显 TP / SL
  @BuiltValueField(wireName: r'stop_limit_price')
  String? get stopLimitPrice;

  @BuiltValueField(wireName: r'opened_at')
  DateTime? get openedAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  Position._();

  factory Position([void updates(PositionBuilder b)]) = _$Position;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PositionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Position> get serializer => _$PositionSerializer();
}

class _$PositionSerializer implements PrimitiveSerializer<Position> {
  @override
  final Iterable<Type> types = const [Position, _$Position];

  @override
  final String wireName = r'Position';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Position object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.productId != null) {
      yield r'product_id';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.positionVersion != null) {
      yield r'position_version';
      yield serializers.serialize(
        object.positionVersion,
        specifiedType: const FullType(String),
      );
    }
    if (object.hip3ActionId != null) {
      yield r'hip3_action_id';
      yield serializers.serialize(
        object.hip3ActionId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.protectionOrderIds != null) {
      yield r'protection_order_ids';
      yield serializers.serialize(
        object.protectionOrderIds,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'symbol';
    yield serializers.serialize(
      object.symbol,
      specifiedType: const FullType(String),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(ProductKind),
    );
    if (object.side != null) {
      yield r'side';
      yield serializers.serialize(
        object.side,
        specifiedType: const FullType.nullable(PositionSideEnum),
      );
    }
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    if (object.quantityUnit != null) {
      yield r'quantity_unit';
      yield serializers.serialize(
        object.quantityUnit,
        specifiedType: const FullType(String),
      );
    }
    yield r'value_usd';
    yield serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType(String),
    );
    if (object.entryPrice != null) {
      yield r'entry_price';
      yield serializers.serialize(
        object.entryPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.markPrice != null) {
      yield r'mark_price';
      yield serializers.serialize(
        object.markPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.unrealizedPnl != null) {
      yield r'unrealized_pnl';
      yield serializers.serialize(
        object.unrealizedPnl,
        specifiedType: const FullType(String),
      );
    }
    if (object.unrealizedPnlPercent != null) {
      yield r'unrealized_pnl_percent';
      yield serializers.serialize(
        object.unrealizedPnlPercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.realizedPnl != null) {
      yield r'realized_pnl';
      yield serializers.serialize(
        object.realizedPnl,
        specifiedType: const FullType(String),
      );
    }
    if (object.costBasis != null) {
      yield r'cost_basis';
      yield serializers.serialize(
        object.costBasis,
        specifiedType: const FullType(String),
      );
    }
    if (object.leverage != null) {
      yield r'leverage';
      yield serializers.serialize(
        object.leverage,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.marginMode != null) {
      yield r'margin_mode';
      yield serializers.serialize(
        object.marginMode,
        specifiedType: const FullType(MarginMode),
      );
    }
    if (object.margin != null) {
      yield r'margin';
      yield serializers.serialize(
        object.margin,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.liquidationPrice != null) {
      yield r'liquidation_price';
      yield serializers.serialize(
        object.liquidationPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fundingPaid != null) {
      yield r'funding_paid';
      yield serializers.serialize(
        object.fundingPaid,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.takeProfitPrice != null) {
      yield r'take_profit_price';
      yield serializers.serialize(
        object.takeProfitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLossPrice != null) {
      yield r'stop_loss_price';
      yield serializers.serialize(
        object.stopLossPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLimitPrice != null) {
      yield r'stop_limit_price';
      yield serializers.serialize(
        object.stopLimitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.openedAt != null) {
      yield r'opened_at';
      yield serializers.serialize(
        object.openedAt,
        specifiedType: const FullType(DateTime),
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
    Position object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PositionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productId = valueDes;
          break;
        case r'position_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.positionVersion = valueDes;
          break;
        case r'hip3_action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.hip3ActionId = valueDes;
          break;
        case r'protection_order_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.protectionOrderIds.replace(valueDes);
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'symbol':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.symbol = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.kind = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PositionSideEnum),
          ) as PositionSideEnum?;
          if (valueDes == null) continue;
          result.side = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'quantity_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantityUnit = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valueUsd = valueDes;
          break;
        case r'entry_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.entryPrice = valueDes;
          break;
        case r'mark_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.markPrice = valueDes;
          break;
        case r'unrealized_pnl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unrealizedPnl = valueDes;
          break;
        case r'unrealized_pnl_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unrealizedPnlPercent = valueDes;
          break;
        case r'realized_pnl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.realizedPnl = valueDes;
          break;
        case r'cost_basis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.costBasis = valueDes;
          break;
        case r'leverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.leverage = valueDes;
          break;
        case r'margin_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(MarginMode),
          ) as MarginMode?;
          if (valueDes == null) continue;
          result.marginMode = valueDes;
          break;
        case r'margin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.margin = valueDes;
          break;
        case r'liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPrice = valueDes;
          break;
        case r'funding_paid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingPaid = valueDes;
          break;
        case r'take_profit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.takeProfitPrice = valueDes;
          break;
        case r'stop_loss_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLossPrice = valueDes;
          break;
        case r'stop_limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLimitPrice = valueDes;
          break;
        case r'opened_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.openedAt = valueDes;
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
  Position deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PositionBuilder();
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

class PositionSideEnum extends EnumClass {

  /// 仅 HIP-3
  @BuiltValueEnumConst(wireName: r'long')
  static const PositionSideEnum long = _$positionSideEnum_long;
  /// 仅 HIP-3
  @BuiltValueEnumConst(wireName: r'short')
  static const PositionSideEnum short = _$positionSideEnum_short;
  /// 仅 HIP-3
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PositionSideEnum unknownDefaultOpenApi = _$positionSideEnum_unknownDefaultOpenApi;

  static Serializer<PositionSideEnum> get serializer => _$positionSideEnumSerializer;

  const PositionSideEnum._(String name): super(name);

  static BuiltSet<PositionSideEnum> get values => _$positionSideEnumValues;
  static PositionSideEnum valueOf(String name) => _$positionSideEnumValueOf(name);
}

