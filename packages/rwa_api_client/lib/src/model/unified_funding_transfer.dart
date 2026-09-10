//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/transfer_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_funding_transfer.g.dart';

/// Compact read-model entry for one funding transfer sourced from exactly one account position.
///
/// Properties:
/// * [transferId] 
/// * [status] 
/// * [sourcePositionId] - The one account-scoped source position consumed by this Transfer.
/// * [allocatedOutputAmount] - 十进制字符串，避免浮点误差
/// * [valueUsd] - 十进制字符串，避免浮点误差
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class UnifiedFundingTransfer implements Built<UnifiedFundingTransfer, UnifiedFundingTransferBuilder> {
  @BuiltValueField(wireName: r'transfer_id')
  String get transferId;

  @BuiltValueField(wireName: r'status')
  TransferStatus get status;
  // enum statusEnum {  awaiting_authorization,  awaiting_wallet,  origin_submitted,  origin_confirmed,  filling,  completed,  refund_pending,  refunded,  failed,  ambiguous,  manual_review,  };

  /// The one account-scoped source position consumed by this Transfer.
  @BuiltValueField(wireName: r'source_position_id')
  String get sourcePositionId;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'allocated_output_amount')
  String get allocatedOutputAmount;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'value_usd')
  String? get valueUsd;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime get updatedAt;

  UnifiedFundingTransfer._();

  factory UnifiedFundingTransfer([void updates(UnifiedFundingTransferBuilder b)]) = _$UnifiedFundingTransfer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnifiedFundingTransferBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnifiedFundingTransfer> get serializer => _$UnifiedFundingTransferSerializer();
}

class _$UnifiedFundingTransferSerializer implements PrimitiveSerializer<UnifiedFundingTransfer> {
  @override
  final Iterable<Type> types = const [UnifiedFundingTransfer, _$UnifiedFundingTransfer];

  @override
  final String wireName = r'UnifiedFundingTransfer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnifiedFundingTransfer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'transfer_id';
    yield serializers.serialize(
      object.transferId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferStatus),
    );
    yield r'source_position_id';
    yield serializers.serialize(
      object.sourcePositionId,
      specifiedType: const FullType(String),
    );
    yield r'allocated_output_amount';
    yield serializers.serialize(
      object.allocatedOutputAmount,
      specifiedType: const FullType(String),
    );
    yield r'value_usd';
    yield object.valueUsd == null ? null : serializers.serialize(
      object.valueUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updated_at';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnifiedFundingTransfer object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnifiedFundingTransferBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transfer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transferId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferStatus),
          ) as TransferStatus;
          result.status = valueDes;
          break;
        case r'source_position_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourcePositionId = valueDes;
          break;
        case r'allocated_output_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allocatedOutputAmount = valueDes;
          break;
        case r'value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.valueUsd = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
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
  UnifiedFundingTransfer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnifiedFundingTransferBuilder();
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

