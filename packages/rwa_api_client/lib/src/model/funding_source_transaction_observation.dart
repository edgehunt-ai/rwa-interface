//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/transfer_source_execution_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_source_transaction_observation.g.dart';

/// FundingSourceTransactionObservation
///
/// Properties:
/// * [chainId]
/// * [txHash]
/// * [status]
/// * [receiptSuccess]
/// * [confirmations]
/// * [observedAt]
@BuiltValue()
abstract class FundingSourceTransactionObservation
    implements
        Built<FundingSourceTransactionObservation,
            FundingSourceTransactionObservationBuilder> {
  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'status')
  TransferSourceExecutionStatus get status;
  // enum statusEnum {  awaiting_wallet,  submitted,  confirmed,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'receipt_success')
  bool get receiptSuccess;

  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  FundingSourceTransactionObservation._();

  factory FundingSourceTransactionObservation(
          [void updates(FundingSourceTransactionObservationBuilder b)]) =
      _$FundingSourceTransactionObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingSourceTransactionObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingSourceTransactionObservation> get serializer =>
      _$FundingSourceTransactionObservationSerializer();
}

class _$FundingSourceTransactionObservationSerializer
    implements PrimitiveSerializer<FundingSourceTransactionObservation> {
  @override
  final Iterable<Type> types = const [
    FundingSourceTransactionObservation,
    _$FundingSourceTransactionObservation
  ];

  @override
  final String wireName = r'FundingSourceTransactionObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingSourceTransactionObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chain_id';
    yield serializers.serialize(
      object.chainId,
      specifiedType: const FullType(int),
    );
    yield r'tx_hash';
    yield serializers.serialize(
      object.txHash,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TransferSourceExecutionStatus),
    );
    yield r'receipt_success';
    yield serializers.serialize(
      object.receiptSuccess,
      specifiedType: const FullType(bool),
    );
    yield r'confirmations';
    yield serializers.serialize(
      object.confirmations,
      specifiedType: const FullType(int),
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
    FundingSourceTransactionObservation object, {
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
    required FundingSourceTransactionObservationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chain_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chainId = valueDes;
          break;
        case r'tx_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.txHash = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransferSourceExecutionStatus),
          ) as TransferSourceExecutionStatus;
          result.status = valueDes;
          break;
        case r'receipt_success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.receiptSuccess = valueDes;
          break;
        case r'confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.confirmations = valueDes;
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
  FundingSourceTransactionObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingSourceTransactionObservationBuilder();
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
