//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_close_preview_request.g.dart';

/// quantity/percent 互斥；均不传表示全平；quantity>0，percent 在 (0,100]。market 仅支持 ioc；limit 缺省 gtc 且必须有 limit_price。
///
/// Properties:
/// * [type] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [slippagePercent] - 十进制字符串，避免浮点误差
/// * [timeInForce] 
@BuiltValue()
abstract class Hip3ClosePreviewRequest implements Built<Hip3ClosePreviewRequest, Hip3ClosePreviewRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  Hip3ClosePreviewRequestTypeEnum? get type;
  // enum typeEnum {  market,  limit,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  Hip3ClosePreviewRequest._();

  factory Hip3ClosePreviewRequest([void updates(Hip3ClosePreviewRequestBuilder b)]) = _$Hip3ClosePreviewRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3ClosePreviewRequestBuilder b) => b
      ..type = Hip3ClosePreviewRequestTypeEnum.valueOf('market');

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3ClosePreviewRequest> get serializer => _$Hip3ClosePreviewRequestSerializer();
}

class _$Hip3ClosePreviewRequestSerializer implements PrimitiveSerializer<Hip3ClosePreviewRequest> {
  @override
  final Iterable<Type> types = const [Hip3ClosePreviewRequest, _$Hip3ClosePreviewRequest];

  @override
  final String wireName = r'Hip3ClosePreviewRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3ClosePreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(Hip3ClosePreviewRequestTypeEnum),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
    if (object.percent != null) {
      yield r'percent';
      yield serializers.serialize(
        object.percent,
        specifiedType: const FullType(String),
      );
    }
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3ClosePreviewRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3ClosePreviewRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3ClosePreviewRequestTypeEnum),
          ) as Hip3ClosePreviewRequestTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percent = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3ClosePreviewRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3ClosePreviewRequestBuilder();
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

class Hip3ClosePreviewRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'market')
  static const Hip3ClosePreviewRequestTypeEnum market = _$hip3ClosePreviewRequestTypeEnum_market;
  @BuiltValueEnumConst(wireName: r'limit')
  static const Hip3ClosePreviewRequestTypeEnum limit = _$hip3ClosePreviewRequestTypeEnum_limit;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3ClosePreviewRequestTypeEnum unknownDefaultOpenApi = _$hip3ClosePreviewRequestTypeEnum_unknownDefaultOpenApi;

  static Serializer<Hip3ClosePreviewRequestTypeEnum> get serializer => _$hip3ClosePreviewRequestTypeEnumSerializer;

  const Hip3ClosePreviewRequestTypeEnum._(String name): super(name);

  static BuiltSet<Hip3ClosePreviewRequestTypeEnum> get values => _$hip3ClosePreviewRequestTypeEnumValues;
  static Hip3ClosePreviewRequestTypeEnum valueOf(String name) => _$hip3ClosePreviewRequestTypeEnumValueOf(name);
}

