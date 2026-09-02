//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_plan_request.g.dart';

/// FundingPlanRequest
///
/// Properties:
/// * [rail] 
/// * [asset] 
/// * [amount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingPlanRequest implements Built<FundingPlanRequest, FundingPlanRequestBuilder> {
  @BuiltValueField(wireName: r'rail')
  ProductKind get rail;
  // enum railEnum {  bstock,  perp,  };

  @BuiltValueField(wireName: r'asset')
  FundingPlanRequestAssetEnum get asset;
  // enum assetEnum {  USDC,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String get amount;

  FundingPlanRequest._();

  factory FundingPlanRequest([void updates(FundingPlanRequestBuilder b)]) = _$FundingPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingPlanRequest> get serializer => _$FundingPlanRequestSerializer();
}

class _$FundingPlanRequestSerializer implements PrimitiveSerializer<FundingPlanRequest> {
  @override
  final Iterable<Type> types = const [FundingPlanRequest, _$FundingPlanRequest];

  @override
  final String wireName = r'FundingPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingPlanRequest object, {
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
      specifiedType: const FullType(FundingPlanRequestAssetEnum),
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
    FundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingPlanRequestBuilder result,
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
            specifiedType: const FullType(FundingPlanRequestAssetEnum),
          ) as FundingPlanRequestAssetEnum;
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
  FundingPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingPlanRequestBuilder();
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

class FundingPlanRequestAssetEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USDC')
  static const FundingPlanRequestAssetEnum USDC = _$fundingPlanRequestAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanRequestAssetEnum unknownDefaultOpenApi = _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanRequestAssetEnum> get serializer => _$fundingPlanRequestAssetEnumSerializer;

  const FundingPlanRequestAssetEnum._(String name): super(name);

  static BuiltSet<FundingPlanRequestAssetEnum> get values => _$fundingPlanRequestAssetEnumValues;
  static FundingPlanRequestAssetEnum valueOf(String name) => _$fundingPlanRequestAssetEnumValueOf(name);
}

