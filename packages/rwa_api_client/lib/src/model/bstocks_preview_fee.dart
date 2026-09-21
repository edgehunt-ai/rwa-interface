//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_fee_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_fee.g.dart';

/// BstocksPreviewFee
///
/// Properties:
/// * [status] 
/// * [asset] 
/// * [amount] - 十进制字符串，避免浮点误差
/// * [ratePercent] - 百分比，1000 millionths 为 0.1，不是倍率0.001。
/// * [includedInTotalInput] 
@BuiltValue()
abstract class BstocksPreviewFee implements Built<BstocksPreviewFee, BstocksPreviewFeeBuilder> {
  @BuiltValueField(wireName: r'status')
  BstocksPreviewFeeStatusEnum get status;
  // enum statusEnum {  quoted,  unavailable,  not_estimated,  };

  @BuiltValueField(wireName: r'asset')
  BstocksFeeAsset get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// 百分比，1000 millionths 为 0.1，不是倍率0.001。
  @BuiltValueField(wireName: r'rate_percent')
  String? get ratePercent;

  @BuiltValueField(wireName: r'included_in_total_input')
  bool? get includedInTotalInput;

  BstocksPreviewFee._();

  factory BstocksPreviewFee([void updates(BstocksPreviewFeeBuilder b)]) = _$BstocksPreviewFee;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewFeeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewFee> get serializer => _$BstocksPreviewFeeSerializer();
}

class _$BstocksPreviewFeeSerializer implements PrimitiveSerializer<BstocksPreviewFee> {
  @override
  final Iterable<Type> types = const [BstocksPreviewFee, _$BstocksPreviewFee];

  @override
  final String wireName = r'BstocksPreviewFee';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewFee object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(BstocksPreviewFeeStatusEnum),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstocksFeeAsset),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    yield r'rate_percent';
    yield object.ratePercent == null ? null : serializers.serialize(
      object.ratePercent,
      specifiedType: const FullType.nullable(String),
    );
    yield r'included_in_total_input';
    yield object.includedInTotalInput == null ? null : serializers.serialize(
      object.includedInTotalInput,
      specifiedType: const FullType.nullable(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksPreviewFee object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewFeeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewFeeStatusEnum),
          ) as BstocksPreviewFeeStatusEnum;
          result.status = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksFeeAsset),
          ) as BstocksFeeAsset;
          result.asset.replace(valueDes);
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'rate_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ratePercent = valueDes;
          break;
        case r'included_in_total_input':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.includedInTotalInput = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksPreviewFee deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewFeeBuilder();
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

class BstocksPreviewFeeStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'quoted')
  static const BstocksPreviewFeeStatusEnum quoted = _$bstocksPreviewFeeStatusEnum_quoted;
  @BuiltValueEnumConst(wireName: r'unavailable')
  static const BstocksPreviewFeeStatusEnum unavailable = _$bstocksPreviewFeeStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'not_estimated')
  static const BstocksPreviewFeeStatusEnum notEstimated = _$bstocksPreviewFeeStatusEnum_notEstimated;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksPreviewFeeStatusEnum unknownDefaultOpenApi = _$bstocksPreviewFeeStatusEnum_unknownDefaultOpenApi;

  static Serializer<BstocksPreviewFeeStatusEnum> get serializer => _$bstocksPreviewFeeStatusEnumSerializer;

  const BstocksPreviewFeeStatusEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewFeeStatusEnum> get values => _$bstocksPreviewFeeStatusEnumValues;
  static BstocksPreviewFeeStatusEnum valueOf(String name) => _$bstocksPreviewFeeStatusEnumValueOf(name);
}

