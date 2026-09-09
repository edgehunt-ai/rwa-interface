//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/hip3_environment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_close_preview.g.dart';

/// side 是平仓委托方向，与当前仓位相反。数量为基础资产绝对数量且已按规则规范化。 PnL 为预计此次平仓价格差损益减预计此次平仓手续费，不重复计入历史资金费或历史手续费。 liquidation_price 是平仓前当前仓位强平价。所有估算依赖 observed_at 的行情/仓位快照。 无法可靠报价则返回 503，不伪造零值；不支持的委托方式返回 422。 
///
/// Properties:
/// * [previewId] 
/// * [positionId] 
/// * [positionVersion] 
/// * [environment] 
/// * [productId] 
/// * [side] 
/// * [type] 
/// * [timeInForce] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [remainingQuantity] - 十进制字符串，避免浮点误差
/// * [entryPrice] - 十进制字符串，避免浮点误差
/// * [markPrice] - 十进制字符串，避免浮点误差
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [estimatedPrice] - 十进制字符串，避免浮点误差
/// * [notionalUsdc] - 十进制字符串，避免浮点误差
/// * [estimatedFeeUsdc] - 十进制字符串，避免浮点误差
/// * [estimatedRealizedPnlUsdc] - 十进制字符串，避免浮点误差
/// * [liquidationPrice] - 十进制字符串，避免浮点误差
/// * [slippagePercent] - 十进制字符串，避免浮点误差
/// * [quoteExpiresAt] 
/// * [observedAt] 
@BuiltValue()
abstract class Hip3ClosePreview implements Built<Hip3ClosePreview, Hip3ClosePreviewBuilder> {
  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  @BuiltValueField(wireName: r'position_id')
  String get positionId;

  @BuiltValueField(wireName: r'position_version')
  String get positionVersion;

  @BuiltValueField(wireName: r'environment')
  Hip3Environment get environment;
  // enum environmentEnum {  mainnet,  testnet,  };

  @BuiltValueField(wireName: r'product_id')
  String get productId;

  @BuiltValueField(wireName: r'side')
  Hip3ClosePreviewSideEnum get side;
  // enum sideEnum {  long,  short,  };

  @BuiltValueField(wireName: r'type')
  Hip3ClosePreviewTypeEnum get type;
  // enum typeEnum {  market,  limit,  };

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'remaining_quantity')
  String get remainingQuantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'entry_price')
  String get entryPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'mark_price')
  String get markPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_price')
  String get estimatedPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'notional_usdc')
  String get notionalUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_fee_usdc')
  String get estimatedFeeUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'estimated_realized_pnl_usdc')
  String get estimatedRealizedPnlUsdc;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'liquidation_price')
  String? get liquidationPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'slippage_percent')
  String get slippagePercent;

  @BuiltValueField(wireName: r'quote_expires_at')
  DateTime get quoteExpiresAt;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  Hip3ClosePreview._();

  factory Hip3ClosePreview([void updates(Hip3ClosePreviewBuilder b)]) = _$Hip3ClosePreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ClosePreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ClosePreview> get serializer => _$Hip3ClosePreviewSerializer();
}

class _$Hip3ClosePreviewSerializer implements PrimitiveSerializer<Hip3ClosePreview> {
  @override
  final Iterable<Type> types = const [Hip3ClosePreview, _$Hip3ClosePreview];

  @override
  final String wireName = r'Hip3ClosePreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ClosePreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    yield r'position_id';
    yield serializers.serialize(
      object.positionId,
      specifiedType: const FullType(String),
    );
    yield r'position_version';
    yield serializers.serialize(
      object.positionVersion,
      specifiedType: const FullType(String),
    );
    yield r'environment';
    yield serializers.serialize(
      object.environment,
      specifiedType: const FullType(Hip3Environment),
    );
    yield r'product_id';
    yield serializers.serialize(
      object.productId,
      specifiedType: const FullType(String),
    );
    yield r'side';
    yield serializers.serialize(
      object.side,
      specifiedType: const FullType(Hip3ClosePreviewSideEnum),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(Hip3ClosePreviewTypeEnum),
    );
    yield r'time_in_force';
    yield serializers.serialize(
      object.timeInForce,
      specifiedType: const FullType(Hip3TimeInForce),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(String),
    );
    yield r'remaining_quantity';
    yield serializers.serialize(
      object.remainingQuantity,
      specifiedType: const FullType(String),
    );
    yield r'entry_price';
    yield serializers.serialize(
      object.entryPrice,
      specifiedType: const FullType(String),
    );
    yield r'mark_price';
    yield serializers.serialize(
      object.markPrice,
      specifiedType: const FullType(String),
    );
    yield r'limit_price';
    yield object.limitPrice == null ? null : serializers.serialize(
      object.limitPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'estimated_price';
    yield serializers.serialize(
      object.estimatedPrice,
      specifiedType: const FullType(String),
    );
    yield r'notional_usdc';
    yield serializers.serialize(
      object.notionalUsdc,
      specifiedType: const FullType(String),
    );
    yield r'estimated_fee_usdc';
    yield serializers.serialize(
      object.estimatedFeeUsdc,
      specifiedType: const FullType(String),
    );
    yield r'estimated_realized_pnl_usdc';
    yield serializers.serialize(
      object.estimatedRealizedPnlUsdc,
      specifiedType: const FullType(String),
    );
    yield r'liquidation_price';
    yield object.liquidationPrice == null ? null : serializers.serialize(
      object.liquidationPrice,
      specifiedType: const FullType.nullable(String),
    );
    yield r'slippage_percent';
    yield serializers.serialize(
      object.slippagePercent,
      specifiedType: const FullType(String),
    );
    yield r'quote_expires_at';
    yield serializers.serialize(
      object.quoteExpiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'observed_at';
    yield serializers.serialize(
      object.observedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ClosePreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ClosePreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        case r'position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionId = valueDes;
          break;
        case r'position_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.positionVersion = valueDes;
          break;
        case r'environment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3Environment),
          ) as Hip3Environment;
          result.environment = valueDes;
          break;
        case r'product_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'side':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ClosePreviewSideEnum),
          ) as Hip3ClosePreviewSideEnum;
          result.side = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ClosePreviewTypeEnum),
          ) as Hip3ClosePreviewTypeEnum;
          result.type = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3TimeInForce),
          ) as Hip3TimeInForce;
          result.timeInForce = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quantity = valueDes;
          break;
        case r'remaining_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.remainingQuantity = valueDes;
          break;
        case r'entry_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.entryPrice = valueDes;
          break;
        case r'mark_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.markPrice = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'estimated_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedPrice = valueDes;
          break;
        case r'notional_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notionalUsdc = valueDes;
          break;
        case r'estimated_fee_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedFeeUsdc = valueDes;
          break;
        case r'estimated_realized_pnl_usdc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.estimatedRealizedPnlUsdc = valueDes;
          break;
        case r'liquidation_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.liquidationPrice = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.slippagePercent = valueDes;
          break;
        case r'quote_expires_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.quoteExpiresAt = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.observedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ClosePreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ClosePreviewBuilder();
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

class Hip3ClosePreviewSideEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'long')
  static const Hip3ClosePreviewSideEnum long = _$hip3ClosePreviewSideEnum_long;
  @BuiltValueEnumConst(wireName: r'short')
  static const Hip3ClosePreviewSideEnum short = _$hip3ClosePreviewSideEnum_short;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ClosePreviewSideEnum unknownDefaultOpenApi = _$hip3ClosePreviewSideEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ClosePreviewSideEnum> get serializer => _$hip3ClosePreviewSideEnumSerializer;

  const Hip3ClosePreviewSideEnum._(String name): super(name);

  static BuiltSet<Hip3ClosePreviewSideEnum> get values => _$hip3ClosePreviewSideEnumValues;
  static Hip3ClosePreviewSideEnum valueOf(String name) => _$hip3ClosePreviewSideEnumValueOf(name);
}

class Hip3ClosePreviewTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3ClosePreviewTypeEnum market = _$hip3ClosePreviewTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3ClosePreviewTypeEnum limit = _$hip3ClosePreviewTypeEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ClosePreviewTypeEnum unknownDefaultOpenApi = _$hip3ClosePreviewTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ClosePreviewTypeEnum> get serializer => _$hip3ClosePreviewTypeEnumSerializer;

  const Hip3ClosePreviewTypeEnum._(String name): super(name);

  static BuiltSet<Hip3ClosePreviewTypeEnum> get values => _$hip3ClosePreviewTypeEnumValues;
  static Hip3ClosePreviewTypeEnum valueOf(String name) => _$hip3ClosePreviewTypeEnumValueOf(name);
}

