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
/// * [availableBefore] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [availableAfter] - Legacy frozen before-plus-credit projection, not observed spendable balance. New observations return null; credited_amount is an attributed event, not wallet availability.
/// * [creditedAmount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [evidenceReference] - Immutable event/venue observation uniquely attributed to this transfer; balance change alone is not credit proof.
/// * [transactionHash] 
/// * [logIndex] 
/// * [venueReference] - Exact attributed venue ledger/fill reference when the credit is not an EVM Transfer event.
/// * [source_] 
/// * [observedAt] 
@BuiltValue()
abstract class FundingTargetCreditObservation implements Built<FundingTargetCreditObservation, FundingTargetCreditObservationBuilder> {
  @BuiltValueField(wireName: r'account_ref')
  String get accountRef;

  @BuiltValueField(wireName: r'asset')
  FundingAssetIdentity get asset;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'available_before')
  String get availableBefore;

  /// Legacy frozen before-plus-credit projection, not observed spendable balance. New observations return null; credited_amount is an attributed event, not wallet availability.
  @BuiltValueField(wireName: r'available_after')
  String? get availableAfter;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'credited_amount')
  String get creditedAmount;

  /// Immutable event/venue observation uniquely attributed to this transfer; balance change alone is not credit proof.
  @BuiltValueField(wireName: r'evidence_reference')
  String? get evidenceReference;

  @BuiltValueField(wireName: r'transaction_hash')
  String? get transactionHash;

  @BuiltValueField(wireName: r'log_index')
  int? get logIndex;

  /// Exact attributed venue ledger/fill reference when the credit is not an EVM Transfer event.
  @BuiltValueField(wireName: r'venue_reference')
  String? get venueReference;

  @BuiltValueField(wireName: r'source')
  FundingTargetBalanceSource get source_;
  // enum source_Enum {  bsc_rpc,  hyperliquid_info,  };

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  FundingTargetCreditObservation._();

  factory FundingTargetCreditObservation([void updates(FundingTargetCreditObservationBuilder b)]) = _$FundingTargetCreditObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingTargetCreditObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingTargetCreditObservation> get serializer => _$FundingTargetCreditObservationSerializer();
}

class _$FundingTargetCreditObservationSerializer implements PrimitiveSerializer<FundingTargetCreditObservation> {
  @override
  final Iterable<Type> types = const [FundingTargetCreditObservation, _$FundingTargetCreditObservation];

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
    yield object.availableAfter == null ? null : serializers.serialize(
      object.availableAfter,
      specifiedType: const FullType.nullable(String),
    );
    yield r'credited_amount';
    yield serializers.serialize(
      object.creditedAmount,
      specifiedType: const FullType(String),
    );
    if (object.evidenceReference != null) {
      yield r'evidence_reference';
      yield serializers.serialize(
        object.evidenceReference,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionHash != null) {
      yield r'transaction_hash';
      yield serializers.serialize(
        object.transactionHash,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.logIndex != null) {
      yield r'log_index';
      yield serializers.serialize(
        object.logIndex,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.venueReference != null) {
      yield r'venue_reference';
      yield serializers.serialize(
        object.venueReference,
        specifiedType: const FullType.nullable(String),
      );
    }
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
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
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
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.availableAfter = valueDes;
          break;
        case r'credited_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.creditedAmount = valueDes;
          break;
        case r'evidence_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.evidenceReference = valueDes;
          break;
        case r'transaction_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transactionHash = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.logIndex = valueDes;
          break;
        case r'venue_reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.venueReference = valueDes;
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

