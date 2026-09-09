//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'non_completed_funding_transfer_state.g.dart';

/// NonCompletedFundingTransferState
///
/// Properties:
/// * [status] 
@BuiltValue()
abstract class NonCompletedFundingTransferState implements Built<NonCompletedFundingTransferState, NonCompletedFundingTransferStateBuilder> {
  @BuiltValueField(wireName: r'status')
  NonCompletedFundingTransferStateStatusEnum get status;
  // enum statusEnum {  awaiting_authorization,  awaiting_wallet,  origin_submitted,  origin_confirmed,  filling,  refund_pending,  refunded,  failed,  ambiguous,  manual_review,  };

  NonCompletedFundingTransferState._();

  factory NonCompletedFundingTransferState([void updates(NonCompletedFundingTransferStateBuilder b)]) = _$NonCompletedFundingTransferState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NonCompletedFundingTransferStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NonCompletedFundingTransferState> get serializer => _$NonCompletedFundingTransferStateSerializer();
}

class _$NonCompletedFundingTransferStateSerializer implements PrimitiveSerializer<NonCompletedFundingTransferState> {
  @override
  final Iterable<Type> types = const [NonCompletedFundingTransferState, _$NonCompletedFundingTransferState];

  @override
  final String wireName = r'NonCompletedFundingTransferState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NonCompletedFundingTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(NonCompletedFundingTransferStateStatusEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NonCompletedFundingTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NonCompletedFundingTransferStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NonCompletedFundingTransferStateStatusEnum),
          ) as NonCompletedFundingTransferStateStatusEnum;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NonCompletedFundingTransferState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NonCompletedFundingTransferStateBuilder();
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

class NonCompletedFundingTransferStateStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_authorization')
  static const NonCompletedFundingTransferStateStatusEnum awaitingAuthorization = _$nonCompletedFundingTransferStateStatusEnum_awaitingAuthorization;
  @BuiltValueEnumConst(wireName: r'awaiting_wallet')
  static const NonCompletedFundingTransferStateStatusEnum awaitingWallet = _$nonCompletedFundingTransferStateStatusEnum_awaitingWallet;
  @BuiltValueEnumConst(wireName: r'origin_submitted')
  static const NonCompletedFundingTransferStateStatusEnum originSubmitted = _$nonCompletedFundingTransferStateStatusEnum_originSubmitted;
  @BuiltValueEnumConst(wireName: r'origin_confirmed')
  static const NonCompletedFundingTransferStateStatusEnum originConfirmed = _$nonCompletedFundingTransferStateStatusEnum_originConfirmed;
  @BuiltValueEnumConst(wireName: r'filling')
  static const NonCompletedFundingTransferStateStatusEnum filling = _$nonCompletedFundingTransferStateStatusEnum_filling;
  @BuiltValueEnumConst(wireName: r'refund_pending')
  static const NonCompletedFundingTransferStateStatusEnum refundPending = _$nonCompletedFundingTransferStateStatusEnum_refundPending;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const NonCompletedFundingTransferStateStatusEnum refunded = _$nonCompletedFundingTransferStateStatusEnum_refunded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const NonCompletedFundingTransferStateStatusEnum failed = _$nonCompletedFundingTransferStateStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const NonCompletedFundingTransferStateStatusEnum ambiguous = _$nonCompletedFundingTransferStateStatusEnum_ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const NonCompletedFundingTransferStateStatusEnum manualReview = _$nonCompletedFundingTransferStateStatusEnum_manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const NonCompletedFundingTransferStateStatusEnum unknownDefaultOpenApi = _$nonCompletedFundingTransferStateStatusEnum_unknownDefaultOpenApi;

  static Serializer<NonCompletedFundingTransferStateStatusEnum> get serializer => _$nonCompletedFundingTransferStateStatusEnumSerializer;

  const NonCompletedFundingTransferStateStatusEnum._(String name): super(name);

  static BuiltSet<NonCompletedFundingTransferStateStatusEnum> get values => _$nonCompletedFundingTransferStateStatusEnumValues;
  static NonCompletedFundingTransferStateStatusEnum valueOf(String name) => _$nonCompletedFundingTransferStateStatusEnumValueOf(name);
}

