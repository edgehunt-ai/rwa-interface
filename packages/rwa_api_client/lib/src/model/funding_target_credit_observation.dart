//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_target_balance_source.dart';
import 'package:rwa_api_client/src/model/funding_asset_identity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_target_credit_observation.g.dart';

/// FundingTargetCreditObservation
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
abstract class FundingTargetCreditObservation
    implements
        Built<FundingTargetCreditObservation,
            FundingTargetCreditObservationBuilder> {
  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  FundingAssetIdentity get asset;

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
  FundingTargetBalanceSource get source_;
  // enum source_Enum {  bsc_rpc,  hyperliquid_info,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  FundingTargetCreditObservation._();

  factory FundingTargetCreditObservation(
          [void updates(FundingTargetCreditObservationBuilder b)]) =
      _$FundingTargetCreditObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingTargetCreditObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingTargetCreditObservation> get serializer =>
      _$FundingTargetCreditObservationSerializer();
}

class _$FundingTargetCreditObservationSerializer
    implements PrimitiveSerializer<FundingTargetCreditObservation> {
  @override
  final Iterable<Type> types = const [
    FundingTargetCreditObservation,
    _$FundingTargetCreditObservation
  ];

  @override
  final String wireName = r'FundingTargetCreditObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingTargetCreditObservation object, {
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
      specifiedType: const FullType(FundingAssetIdentity),
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
      specifiedType: const FullType(FundingTargetBalanceSource),
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
    FundingTargetCreditObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingTargetCreditObservationBuilder result,
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
            specifiedType: const FullType(FundingAssetIdentity),
          ) as FundingAssetIdentity;
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
            specifiedType: const FullType(FundingTargetBalanceSource),
          ) as FundingTargetBalanceSource;
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
  FundingTargetCreditObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingTargetCreditObservationBuilder();
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
