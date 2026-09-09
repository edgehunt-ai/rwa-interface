//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstock_funding_target_asset.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_funding_target_credit_observation.g.dart';

/// BstockFundingTargetCreditObservation
///
/// Properties:
/// * [accountRef] 
/// * [asset] 
/// * [availableBefore] - 十进制字符串，避免浮点误差
/// * [availableAfter] - 十进制字符串，避免浮点误差
/// * [creditedAmount] - 十进制字符串，避免浮点误差
/// * [source_] 
/// * [observedAt] 
@BuiltValue()
abstract class BstockFundingTargetCreditObservation implements Built<BstockFundingTargetCreditObservation, BstockFundingTargetCreditObservationBuilder> {
  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  BstockFundingTargetAsset get asset;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_before')
  String get availableBefore;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'available_after')
  String get availableAfter;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'credited_amount')
  String get creditedAmount;

  @BuiltValueField(wireName: r'source')
  BstockFundingTargetCreditObservationSource_Enum get source_;
  // enum source_Enum {  bsc_rpc,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  BstockFundingTargetCreditObservation._();

  factory BstockFundingTargetCreditObservation([void updates(BstockFundingTargetCreditObservationBuilder b)]) = _$BstockFundingTargetCreditObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockFundingTargetCreditObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockFundingTargetCreditObservation> get serializer => _$BstockFundingTargetCreditObservationSerializer();
}

class _$BstockFundingTargetCreditObservationSerializer implements PrimitiveSerializer<BstockFundingTargetCreditObservation> {
  @override
  final Iterable<Type> types = const [BstockFundingTargetCreditObservation, _$BstockFundingTargetCreditObservation];

  @override
  final String wireName = r'BstockFundingTargetCreditObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockFundingTargetCreditObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'account_ref';
    yield serializers.serialize(
      object.accountRef,
      specifiedType: const FullType(String),
    );
    yield r'asset';
    yield serializers.serialize(
      object.asset,
      specifiedType: const FullType(BstockFundingTargetAsset),
    );
    yield r'available_before';
    yield serializers.serialize(
      object.availableBefore,
      specifiedType: const FullType(String),
    );
    yield r'available_after';
    yield serializers.serialize(
      object.availableAfter,
      specifiedType: const FullType(String),
    );
    yield r'credited_amount';
    yield serializers.serialize(
      object.creditedAmount,
      specifiedType: const FullType(String),
    );
    yield r'source';
    yield serializers.serialize(
      object.source_,
      specifiedType: const FullType(BstockFundingTargetCreditObservationSource_Enum),
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
    BstockFundingTargetCreditObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockFundingTargetCreditObservationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'account_ref':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountRef = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetAsset),
          ) as BstockFundingTargetAsset;
          result.asset.replace(valueDes);
          break;
        case r'available_before':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableBefore = valueDes;
          break;
        case r'available_after':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableAfter = valueDes;
          break;
        case r'credited_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.creditedAmount = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockFundingTargetCreditObservationSource_Enum),
          ) as BstockFundingTargetCreditObservationSource_Enum;
          result.source_ = valueDes;
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
  BstockFundingTargetCreditObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockFundingTargetCreditObservationBuilder();
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

class BstockFundingTargetCreditObservationSource_Enum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bsc_rpc')
  static const BstockFundingTargetCreditObservationSource_Enum bscRpc = _$bstockFundingTargetCreditObservationSourceEnum_bscRpc;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockFundingTargetCreditObservationSource_Enum unknownDefaultOpenApi = _$bstockFundingTargetCreditObservationSourceEnum_unknownDefaultOpenApi;

  static Serializer<BstockFundingTargetCreditObservationSource_Enum> get serializer => _$bstockFundingTargetCreditObservationSourceEnumSerializer;

  const BstockFundingTargetCreditObservationSource_Enum._(String name): super(name);

  static BuiltSet<BstockFundingTargetCreditObservationSource_Enum> get values => _$bstockFundingTargetCreditObservationSourceEnumValues;
  static BstockFundingTargetCreditObservationSource_Enum valueOf(String name) => _$bstockFundingTargetCreditObservationSourceEnumValueOf(name);
}

