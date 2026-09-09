//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/completed_funding_provider_observation.dart';
import 'package:rwa_api_client/src/model/completed_funding_source_transaction_observation.dart';
import 'package:rwa_api_client/src/model/funding_target_credit_observation.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'completed_funding_transfer_state.g.dart';

/// CompletedFundingTransferState
///
/// Properties:
/// * [status] 
/// * [sourceExecutionStatus] 
/// * [providerStatus] 
/// * [providerObservation] 
/// * [targetCreditStatus] 
/// * [sourceTransaction] 
/// * [targetCredit] 
/// * [recoveryStatus] 
/// * [completedAt] 
/// * [nextAction] 
@BuiltValue()
abstract class CompletedFundingTransferState implements Built<CompletedFundingTransferState, CompletedFundingTransferStateBuilder> {
  @BuiltValueField(wireName: r'status')
  CompletedFundingTransferStateStatusEnum get status;
  // enum statusEnum {  completed,  };

  @BuiltValueField(wireName: r'source_execution_status')
  CompletedFundingTransferStateSourceExecutionStatusEnum get sourceExecutionStatus;
  // enum sourceExecutionStatusEnum {  confirmed,  };

  @BuiltValueField(wireName: r'provider_status')
  CompletedFundingTransferStateProviderStatusEnum get providerStatus;
  // enum providerStatusEnum {  succeeded,  };

  @BuiltValueField(wireName: r'provider_observation')
  CompletedFundingProviderObservation get providerObservation;

  @BuiltValueField(wireName: r'target_credit_status')
  CompletedFundingTransferStateTargetCreditStatusEnum get targetCreditStatus;
  // enum targetCreditStatusEnum {  confirmed,  };

  @BuiltValueField(wireName: r'source_transaction')
  CompletedFundingSourceTransactionObservation get sourceTransaction;

  @BuiltValueField(wireName: r'target_credit')
  FundingTargetCreditObservation get targetCredit;

  @BuiltValueField(wireName: r'recovery_status')
  CompletedFundingTransferStateRecoveryStatusEnum get recoveryStatus;
  // enum recoveryStatusEnum {  none,  };

  @BuiltValueField(wireName: r'completed_at')
  DateTime get completedAt;

  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  CompletedFundingTransferState._();

  factory CompletedFundingTransferState([void updates(CompletedFundingTransferStateBuilder b)]) = _$CompletedFundingTransferState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompletedFundingTransferStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompletedFundingTransferState> get serializer => _$CompletedFundingTransferStateSerializer();
}

class _$CompletedFundingTransferStateSerializer implements PrimitiveSerializer<CompletedFundingTransferState> {
  @override
  final Iterable<Type> types = const [CompletedFundingTransferState, _$CompletedFundingTransferState];

  @override
  final String wireName = r'CompletedFundingTransferState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompletedFundingTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(CompletedFundingTransferStateStatusEnum),
    );
    yield r'source_execution_status';
    yield serializers.serialize(
      object.sourceExecutionStatus,
      specifiedType: const FullType(CompletedFundingTransferStateSourceExecutionStatusEnum),
    );
    yield r'provider_status';
    yield serializers.serialize(
      object.providerStatus,
      specifiedType: const FullType(CompletedFundingTransferStateProviderStatusEnum),
    );
    yield r'provider_observation';
    yield serializers.serialize(
      object.providerObservation,
      specifiedType: const FullType(CompletedFundingProviderObservation),
    );
    yield r'target_credit_status';
    yield serializers.serialize(
      object.targetCreditStatus,
      specifiedType: const FullType(CompletedFundingTransferStateTargetCreditStatusEnum),
    );
    yield r'source_transaction';
    yield serializers.serialize(
      object.sourceTransaction,
      specifiedType: const FullType(CompletedFundingSourceTransactionObservation),
    );
    yield r'target_credit';
    yield serializers.serialize(
      object.targetCredit,
      specifiedType: const FullType(FundingTargetCreditObservation),
    );
    yield r'recovery_status';
    yield serializers.serialize(
      object.recoveryStatus,
      specifiedType: const FullType(CompletedFundingTransferStateRecoveryStatusEnum),
    );
    yield r'completed_at';
    yield serializers.serialize(
      object.completedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompletedFundingTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompletedFundingTransferStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingTransferStateStatusEnum),
          ) as CompletedFundingTransferStateStatusEnum;
          result.status = valueDes;
          break;
        case r'source_execution_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingTransferStateSourceExecutionStatusEnum),
          ) as CompletedFundingTransferStateSourceExecutionStatusEnum;
          result.sourceExecutionStatus = valueDes;
          break;
        case r'provider_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingTransferStateProviderStatusEnum),
          ) as CompletedFundingTransferStateProviderStatusEnum;
          result.providerStatus = valueDes;
          break;
        case r'provider_observation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingProviderObservation),
          ) as CompletedFundingProviderObservation;
          result.providerObservation.replace(valueDes);
          break;
        case r'target_credit_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingTransferStateTargetCreditStatusEnum),
          ) as CompletedFundingTransferStateTargetCreditStatusEnum;
          result.targetCreditStatus = valueDes;
          break;
        case r'source_transaction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingSourceTransactionObservation),
          ) as CompletedFundingSourceTransactionObservation;
          result.sourceTransaction.replace(valueDes);
          break;
        case r'target_credit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingTargetCreditObservation),
          ) as FundingTargetCreditObservation;
          result.targetCredit.replace(valueDes);
          break;
        case r'recovery_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CompletedFundingTransferStateRecoveryStatusEnum),
          ) as CompletedFundingTransferStateRecoveryStatusEnum;
          result.recoveryStatus = valueDes;
          break;
        case r'completed_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.completedAt = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.nextAction = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompletedFundingTransferState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompletedFundingTransferStateBuilder();
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

class CompletedFundingTransferStateStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'completed')
  static const CompletedFundingTransferStateStatusEnum completed = _$completedFundingTransferStateStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingTransferStateStatusEnum unknownDefaultOpenApi = _$completedFundingTransferStateStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingTransferStateStatusEnum> get serializer => _$completedFundingTransferStateStatusEnumSerializer;

  const CompletedFundingTransferStateStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingTransferStateStatusEnum> get values => _$completedFundingTransferStateStatusEnumValues;
  static CompletedFundingTransferStateStatusEnum valueOf(String name) => _$completedFundingTransferStateStatusEnumValueOf(name);
}

class CompletedFundingTransferStateSourceExecutionStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'confirmed')
  static const CompletedFundingTransferStateSourceExecutionStatusEnum confirmed = _$completedFundingTransferStateSourceExecutionStatusEnum_confirmed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingTransferStateSourceExecutionStatusEnum unknownDefaultOpenApi = _$completedFundingTransferStateSourceExecutionStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingTransferStateSourceExecutionStatusEnum> get serializer => _$completedFundingTransferStateSourceExecutionStatusEnumSerializer;

  const CompletedFundingTransferStateSourceExecutionStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingTransferStateSourceExecutionStatusEnum> get values => _$completedFundingTransferStateSourceExecutionStatusEnumValues;
  static CompletedFundingTransferStateSourceExecutionStatusEnum valueOf(String name) => _$completedFundingTransferStateSourceExecutionStatusEnumValueOf(name);
}

class CompletedFundingTransferStateProviderStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'succeeded')
  static const CompletedFundingTransferStateProviderStatusEnum succeeded = _$completedFundingTransferStateProviderStatusEnum_succeeded;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingTransferStateProviderStatusEnum unknownDefaultOpenApi = _$completedFundingTransferStateProviderStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingTransferStateProviderStatusEnum> get serializer => _$completedFundingTransferStateProviderStatusEnumSerializer;

  const CompletedFundingTransferStateProviderStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingTransferStateProviderStatusEnum> get values => _$completedFundingTransferStateProviderStatusEnumValues;
  static CompletedFundingTransferStateProviderStatusEnum valueOf(String name) => _$completedFundingTransferStateProviderStatusEnumValueOf(name);
}

class CompletedFundingTransferStateTargetCreditStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'confirmed')
  static const CompletedFundingTransferStateTargetCreditStatusEnum confirmed = _$completedFundingTransferStateTargetCreditStatusEnum_confirmed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingTransferStateTargetCreditStatusEnum unknownDefaultOpenApi = _$completedFundingTransferStateTargetCreditStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingTransferStateTargetCreditStatusEnum> get serializer => _$completedFundingTransferStateTargetCreditStatusEnumSerializer;

  const CompletedFundingTransferStateTargetCreditStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingTransferStateTargetCreditStatusEnum> get values => _$completedFundingTransferStateTargetCreditStatusEnumValues;
  static CompletedFundingTransferStateTargetCreditStatusEnum valueOf(String name) => _$completedFundingTransferStateTargetCreditStatusEnumValueOf(name);
}

class CompletedFundingTransferStateRecoveryStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'none')
  static const CompletedFundingTransferStateRecoveryStatusEnum none = _$completedFundingTransferStateRecoveryStatusEnum_none;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CompletedFundingTransferStateRecoveryStatusEnum unknownDefaultOpenApi = _$completedFundingTransferStateRecoveryStatusEnum_unknownDefaultOpenApi;

  static Serializer<CompletedFundingTransferStateRecoveryStatusEnum> get serializer => _$completedFundingTransferStateRecoveryStatusEnumSerializer;

  const CompletedFundingTransferStateRecoveryStatusEnum._(String name): super(name);

  static BuiltSet<CompletedFundingTransferStateRecoveryStatusEnum> get values => _$completedFundingTransferStateRecoveryStatusEnumValues;
  static CompletedFundingTransferStateRecoveryStatusEnum valueOf(String name) => _$completedFundingTransferStateRecoveryStatusEnumValueOf(name);
}

