//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'legacy_funding_plan_request.g.dart';

/// LegacyFundingPlanRequest
///
/// Properties:
/// * [rail] 
/// * [asset] 
/// * [amount] - 十进制字符串，避免浮点误差
@Deprecated('LegacyFundingPlanRequest has been deprecated')
@BuiltValue()
abstract class LegacyFundingPlanRequest implements Built<LegacyFundingPlanRequest, LegacyFundingPlanRequestBuilder> {
  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'asset')
  LegacyFundingPlanRequestAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  LegacyFundingPlanRequest._();

  factory LegacyFundingPlanRequest([void updates(LegacyFundingPlanRequestBuilder b)]) = _$LegacyFundingPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LegacyFundingPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LegacyFundingPlanRequest> get serializer => _$LegacyFundingPlanRequestSerializer();
}

class _$LegacyFundingPlanRequestSerializer implements PrimitiveSerializer<LegacyFundingPlanRequest> {
  @override
  final Iterable<Type> types = const [LegacyFundingPlanRequest, _$LegacyFundingPlanRequest];

  @override
  final String wireName = r'LegacyFundingPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LegacyFundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rail';
    yield serializers.serialize(
      object.rail,
      specifiedType: const FullType(ProductKind),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(LegacyFundingPlanRequestAssetEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LegacyFundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LegacyFundingPlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProductKind),
          ) as ProductKind;
          result.rail = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LegacyFundingPlanRequestAssetEnum),
          ) as LegacyFundingPlanRequestAssetEnum;
          result.asset = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LegacyFundingPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LegacyFundingPlanRequestBuilder();
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

@Deprecated('LegacyFundingPlanRequestAssetEnum has been deprecated')
class LegacyFundingPlanRequestAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const LegacyFundingPlanRequestAssetEnum USDC = _$legacyFundingPlanRequestAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const LegacyFundingPlanRequestAssetEnum unknownDefaultOpenApi = _$legacyFundingPlanRequestAssetEnum_unknownDefaultOpenApi;

  static Serializer<LegacyFundingPlanRequestAssetEnum> get serializer => _$legacyFundingPlanRequestAssetEnumSerializer;

  const LegacyFundingPlanRequestAssetEnum._(String name): super(name);

  static BuiltSet<LegacyFundingPlanRequestAssetEnum> get values => _$legacyFundingPlanRequestAssetEnumValues;
  static LegacyFundingPlanRequestAssetEnum valueOf(String name) => _$legacyFundingPlanRequestAssetEnumValueOf(name);
}

