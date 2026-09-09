//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'completed_funding_source_transaction_observation.g.dart';

/// CompletedFundingSourceTransactionObservation
///
/// Properties:
/// * [chainId] 
/// * [txHash] 
/// * [status] 
/// * [receiptSuccess] 
/// * [confirmations] 
/// * [observedAt] 
@BuiltValue()
abstract class CompletedFundingSourceTransactionObservation implements Built<CompletedFundingSourceTransactionObservation, CompletedFundingSourceTransactionObservationBuilder> {
  @BuiltValueField(wireName: r'chain_id')
  int get chainId;

  @BuiltValueField(wireName: r'tx_hash')
  String get txHash;

  @BuiltValueField(wireName: r'status')
  CompletedFundingSourceTransactionObservationStatusEnum get status;
  // enum statusEnum {  confirmed,  };

  @BuiltValueField(wireName: r'receipt_success')
  bool get receiptSuccess;

  @BuiltValueField(wireName: r'confirmations')
  int get confirmations;

  @BuiltValueField(wireName: r'observed_at')
  DateTime get observedAt;

  CompletedFundingSourceTransactionObservation._();

  factory CompletedFundingSourceTransactionObservation([void updates(CompletedFundingSourceTransactionObservationBuilder b)]) = _$CompletedFundingSourceTransactionObservation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompletedFundingSourceTransactionObservationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompletedFundingSourceTransactionObservation> get serializer => _$CompletedFundingSourceTransactionObservationSerializer();
}

class _$CompletedFundingSourceTransactionObservationSerializer implements PrimitiveSerializer<CompletedFundingSourceTransactionObservation> {
  @override
  final Iterable<Type> types = const [CompletedFundingSourceTransactionObservation, _$CompletedFundingSourceTransactionObservation];

  @override
  final String wireName = r'CompletedFundingSourceTransactionObservation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompletedFundingSourceTransactionObservation object, {
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
      specifiedType: const FullType(CompletedFundingSourceTransactionObservationStatusEnum),
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
    CompletedFundingSourceTransactionObservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompletedFundingSourceTransactionObservationBuilder result,
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
            specifiedType: const FullType(CompletedFundingSourceTransactionObservationStatusEnum),
          ) as CompletedFundingSourceTransactionObservationStatusEnum;
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
  CompletedFundingSourceTransactionObservation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompletedFundingSourceTransactionObservationBuilder();
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

class CompletedFundingSourceTransactionObservationStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'confirmed')
  static const CompletedFundingSourceTransactionObservationStatusEnum confirmed = _$completedFundingSourceTransactionObservationStatusEnum_confirmed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingSourceTransactionObservationStatusEnum unknownDefaultOpenApi = _$completedFundingSourceTransactionObservationStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingSourceTransactionObservationStatusEnum> get serializer => _$completedFundingSourceTransactionObservationStatusEnumSerializer;

  const CompletedFundingSourceTransactionObservationStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingSourceTransactionObservationStatusEnum> get values => _$completedFundingSourceTransactionObservationStatusEnumValues;
  static CompletedFundingSourceTransactionObservationStatusEnum valueOf(String name) => _$completedFundingSourceTransactionObservationStatusEnumValueOf(name);
}

