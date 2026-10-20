//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_asset_identity.dart';
import 'package:rwa_api_client/src/model/transfer_refund_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_refund_observation.g.dart';

/// Actual uniquely attributed refund observation. amount is net received in asset units, never expected gross refund. A partial actual receipt remains pending until the owning transfer proves full refund settlement; pending is not refunded. Null/omitted fee evidence never means zero fee.
///
/// Properties:
/// * [status] 
/// * [asset] 
/// * [address] 
/// * [amount] - 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
/// * [logIndex] - Exact immutable refund Transfer-log coordinate bound to tx_hash and asset.
/// * [actualFeeAmount] - Actual independently evidenced fee in refund-asset units; null/omitted when unavailable, never inferred by subtracting the refund from the original quote.
/// * [txHash] 
/// * [observedAt] 
@BuiltValue()
abstract class FundingRefundObservation implements Built<FundingRefundObservation, FundingRefundObservationBuilder> {
  @BuiltValueField(wireName: r'status')
  TransferRefundStatus get status;
  // enum statusEnum {  not_applicable,  eligible,  pending,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'asset')
  FundingAssetIdentity? get asset;

  @BuiltValueField(wireName: r'address')
  String? get address;

  /// 十进制字符串，避免浮点误差。请求最多60位整数和18位小数，不接受整数部分多余前导零； 各操作另行校验正负、范围及资产精度，不以此通用响应标量代替业务准入。 
  @BuiltValueField(wireName: r'amount')
  String? get amount;

  /// Exact immutable refund Transfer-log coordinate bound to tx_hash and asset.
  @BuiltValueField(wireName: r'log_index')
  int? get logIndex;

  /// Actual independently evidenced fee in refund-asset units; null/omitted when unavailable, never inferred by subtracting the refund from the original quote.
  @BuiltValueField(wireName: r'actual_fee_amount')
  String? get actualFeeAmount;

  @BuiltValueField(wireName: r'tx_hash')
  String? get txHash;

  @BuiltValueField(wireName: r'observed_at')
  DateTime? get observedAt;

  FundingRefundObservation._();

  factory FundingRefundObservation([void updates(FundingRefundObservationBuilder b)]) = _$FundingRefundObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRefundObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRefundObservation> get serializer => _$FundingRefundObservationSerializer();
}

class _$FundingRefundObservationSerializer implements PrimitiveSerializer<FundingRefundObservation> {
  @override
  final Iterable<Type> types = const [FundingRefundObservation, _$FundingRefundObservation];

  @override
  final String wireName = r'FundingRefundObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRefundObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferRefundStatus),
    );
    yield r'asset';
    yield object.asset == null ? null : serializers.serialize(
      object.asset,
      specifiedType: const FullType.nullable(FundingAssetIdentity),
    );
    yield r'address';
    yield object.address == null ? null : serializers.serialize(
      object.address,
      specifiedType: const FullType.nullable(String),
    );
    yield r'amount';
    yield object.amount == null ? null : serializers.serialize(
      object.amount,
      specifiedType: const FullType.nullable(String),
    );
    if (object.logIndex != null) {
      yield r'log_index';
      yield serializers.serialize(
        object.logIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.actualFeeAmount != null) {
      yield r'actual_fee_amount';
      yield serializers.serialize(
        object.actualFeeAmount,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'tx_hash';
    yield object.txHash == null ? null : serializers.serialize(
      object.txHash,
      specifiedType: const FullType.nullable(String),
    );
    yield r'observed_at';
    yield object.observedAt == null ? null : serializers.serialize(
      object.observedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRefundObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRefundObservationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferRefundStatus),
          ) as TransferRefundStatus;
          result.status = valueDes;
          break;
        case r'asset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingAssetIdentity),
          ) as FundingAssetIdentity?;
          if (valueDes == null) continue;
          result.asset.replace(valueDes);
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.address = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amount = valueDes;
          break;
        case r'log_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.logIndex = valueDes;
          break;
        case r'actual_fee_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualFeeAmount = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.txHash = valueDes;
          break;
        case r'observed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
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
  FundingRefundObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRefundObservationBuilder();
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

