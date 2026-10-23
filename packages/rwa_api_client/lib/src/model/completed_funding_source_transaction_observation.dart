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
/// * [requiredConfirmations] - Frozen source-chain confirmation threshold applied before accepting canonical source evidence.
/// * [blockNumber] 
/// * [blockHash] 
/// * [transactionIndex] 
/// * [canonical] - Canonical block identity verified at observed_at; not a fresh GET-time revalidation.
/// * [finalitySatisfied] - At observed_at, canonical was true and confirmations met required_confirmations. This is the frozen confirmation policy, not a consensus irreversible-finalized tag or a guarantee against later reorgs.
/// * [actualDebitedAmount] - Net source-asset decimal debit within the exact receipt or UserOp scope, including measured same-scope token returns; not the frozen quote maximum. Null/omitted is unknown and must not be rendered as zero. Refund records already included in this net must not be subtracted a second time.
/// * [debitBasis] - Completed source evidence cannot claim finalized_revert; transfer_logs measures the successful debit and null/omitted retains unknown historical evidence.
/// * [debitLogIndices] - Exact source receipt Transfer-log coordinates supporting actual_debited_amount, or null/omitted when unknown.
/// * [userOperationHash] - Exact frozen ERC-4337 operation identity when applicable, independently bound inside the enclosing transaction.
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

  /// Frozen source-chain confirmation threshold applied before accepting canonical source evidence.
  @BuiltValueField(wireName: r'required_confirmations')
  int? get requiredConfirmations;

  @BuiltValueField(wireName: r'block_number')
  int? get blockNumber;

  @BuiltValueField(wireName: r'block_hash')
  String? get blockHash;

  @BuiltValueField(wireName: r'transaction_index')
  int? get transactionIndex;

  /// Canonical block identity verified at observed_at; not a fresh GET-time revalidation.
  @BuiltValueField(wireName: r'canonical')
  bool? get canonical;

  /// At observed_at, canonical was true and confirmations met required_confirmations. This is the frozen confirmation policy, not a consensus irreversible-finalized tag or a guarantee against later reorgs.
  @BuiltValueField(wireName: r'finality_satisfied')
  bool? get finalitySatisfied;

  /// Net source-asset decimal debit within the exact receipt or UserOp scope, including measured same-scope token returns; not the frozen quote maximum. Null/omitted is unknown and must not be rendered as zero. Refund records already included in this net must not be subtracted a second time.
  @BuiltValueField(wireName: r'actual_debited_amount')
  String? get actualDebitedAmount;

  /// Completed source evidence cannot claim finalized_revert; transfer_logs measures the successful debit and null/omitted retains unknown historical evidence.
  @BuiltValueField(wireName: r'debit_basis')
  CompletedFundingSourceTransactionObservationDebitBasisEnum? get debitBasis;
  // enum debitBasisEnum {  transfer_logs,  ,  };

  /// Exact source receipt Transfer-log coordinates supporting actual_debited_amount, or null/omitted when unknown.
  @BuiltValueField(wireName: r'debit_log_indices')
  BuiltSet<int>? get debitLogIndices;

  /// Exact frozen ERC-4337 operation identity when applicable, independently bound inside the enclosing transaction.
  @BuiltValueField(wireName: r'user_operation_hash')
  String? get userOperationHash;

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
    if (object.requiredConfirmations != null) {
      yield r'required_confirmations';
      yield serializers.serialize(
        object.requiredConfirmations,
        specifiedType: const FullType(int),
      );
    }
    if (object.blockNumber != null) {
      yield r'block_number';
      yield serializers.serialize(
        object.blockNumber,
        specifiedType: const FullType(int),
      );
    }
    if (object.blockHash != null) {
      yield r'block_hash';
      yield serializers.serialize(
        object.blockHash,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionIndex != null) {
      yield r'transaction_index';
      yield serializers.serialize(
        object.transactionIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.canonical != null) {
      yield r'canonical';
      yield serializers.serialize(
        object.canonical,
        specifiedType: const FullType(bool),
      );
    }
    if (object.finalitySatisfied != null) {
      yield r'finality_satisfied';
      yield serializers.serialize(
        object.finalitySatisfied,
        specifiedType: const FullType(bool),
      );
    }
    if (object.actualDebitedAmount != null) {
      yield r'actual_debited_amount';
      yield serializers.serialize(
        object.actualDebitedAmount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.debitBasis != null) {
      yield r'debit_basis';
      yield serializers.serialize(
        object.debitBasis,
        specifiedType: const FullType.nullable(CompletedFundingSourceTransactionObservationDebitBasisEnum),
      );
    }
    if (object.debitLogIndices != null) {
      yield r'debit_log_indices';
      yield serializers.serialize(
        object.debitLogIndices,
        specifiedType: const FullType.nullable(BuiltSet, [FullType(int)]),
      );
    }
    if (object.userOperationHash != null) {
      yield r'user_operation_hash';
      yield serializers.serialize(
        object.userOperationHash,
        specifiedType: const FullType.nullable(String),
      );
    }
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
        case r'required_confirmations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.requiredConfirmations = valueDes;
          break;
        case r'block_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.blockNumber = valueDes;
          break;
        case r'block_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.blockHash = valueDes;
          break;
        case r'transaction_index':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.transactionIndex = valueDes;
          break;
        case r'canonical':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.canonical = valueDes;
          break;
        case r'finality_satisfied':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.finalitySatisfied = valueDes;
          break;
        case r'actual_debited_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.actualDebitedAmount = valueDes;
          break;
        case r'debit_basis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(CompletedFundingSourceTransactionObservationDebitBasisEnum),
          ) as CompletedFundingSourceTransactionObservationDebitBasisEnum?;
          if (valueDes == null) continue;
          result.debitBasis = valueDes;
          break;
        case r'debit_log_indices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(int)]),
          ) as BuiltSet<int>?;
          if (valueDes == null) continue;
          result.debitLogIndices.replace(valueDes);
          break;
        case r'user_operation_hash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userOperationHash = valueDes;
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

  static Serializer<CompletedFundingSourceTransactionObservationStatusEnum> get serializer => _$completedFundingSourceTransactionObservationStatusEnumSerializer;

  const CompletedFundingSourceTransactionObservationStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingSourceTransactionObservationStatusEnum> get values => _$completedFundingSourceTransactionObservationStatusEnumValues;
  static CompletedFundingSourceTransactionObservationStatusEnum valueOf(String name) => _$completedFundingSourceTransactionObservationStatusEnumValueOf(name);
}

class CompletedFundingSourceTransactionObservationDebitBasisEnum extends EnumClass {

  /// Completed source evidence cannot claim finalized_revert; transfer_logs measures the successful debit and null/omitted retains unknown historical evidence.
  @BuiltValueEnumConst(wireName: r'transfer_logs')
  static const CompletedFundingSourceTransactionObservationDebitBasisEnum transferLogs = _$completedFundingSourceTransactionObservationDebitBasisEnum_transferLogs;

  static Serializer<CompletedFundingSourceTransactionObservationDebitBasisEnum> get serializer => _$completedFundingSourceTransactionObservationDebitBasisEnumSerializer;

  const CompletedFundingSourceTransactionObservationDebitBasisEnum._(String name): super(name);

  static BuiltSet<CompletedFundingSourceTransactionObservationDebitBasisEnum> get values => _$completedFundingSourceTransactionObservationDebitBasisEnumValues;
  static CompletedFundingSourceTransactionObservationDebitBasisEnum valueOf(String name) => _$completedFundingSourceTransactionObservationDebitBasisEnumValueOf(name);
}

