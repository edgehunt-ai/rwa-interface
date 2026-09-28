//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'no_executable_action_transfer_state.g.dart';

/// NoExecutableActionTransferState
///
/// Properties:
/// * [status] 
/// * [nextAction] 
@BuiltValue()
abstract class NoExecutableActionTransferState implements Built<NoExecutableActionTransferState, NoExecutableActionTransferStateBuilder> {
  @BuiltValueField(wireName: r'status')
  NoExecutableActionTransferStateStatusEnum get status;
  // enum statusEnum {  awaiting_authorization,  origin_submitted,  origin_confirmed,  filling,  completed,  refund_pending,  refunded,  failed,  ambiguous,  manual_review,  };

  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  NoExecutableActionTransferState._();

  factory NoExecutableActionTransferState([void updates(NoExecutableActionTransferStateBuilder b)]) = _$NoExecutableActionTransferState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NoExecutableActionTransferStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NoExecutableActionTransferState> get serializer => _$NoExecutableActionTransferStateSerializer();
}

class _$NoExecutableActionTransferStateSerializer implements PrimitiveSerializer<NoExecutableActionTransferState> {
  @override
  final Iterable<Type> types = const [NoExecutableActionTransferState, _$NoExecutableActionTransferState];

  @override
  final String wireName = r'NoExecutableActionTransferState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NoExecutableActionTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(NoExecutableActionTransferStateStatusEnum),
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
    NoExecutableActionTransferState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NoExecutableActionTransferStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NoExecutableActionTransferStateStatusEnum),
          ) as NoExecutableActionTransferStateStatusEnum;
          result.status = valueDes;
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
  NoExecutableActionTransferState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NoExecutableActionTransferStateBuilder();
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

class NoExecutableActionTransferStateStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'awaiting_authorization')
  static const NoExecutableActionTransferStateStatusEnum awaitingAuthorization = _$noExecutableActionTransferStateStatusEnum_awaitingAuthorization;
  @BuiltValueEnumConst(wireName: r'origin_submitted')
  static const NoExecutableActionTransferStateStatusEnum originSubmitted = _$noExecutableActionTransferStateStatusEnum_originSubmitted;
  @BuiltValueEnumConst(wireName: r'origin_confirmed')
  static const NoExecutableActionTransferStateStatusEnum originConfirmed = _$noExecutableActionTransferStateStatusEnum_originConfirmed;
  @BuiltValueEnumConst(wireName: r'filling')
  static const NoExecutableActionTransferStateStatusEnum filling = _$noExecutableActionTransferStateStatusEnum_filling;
  @BuiltValueEnumConst(wireName: r'completed')
  static const NoExecutableActionTransferStateStatusEnum completed = _$noExecutableActionTransferStateStatusEnum_completed;
  @BuiltValueEnumConst(wireName: r'refund_pending')
  static const NoExecutableActionTransferStateStatusEnum refundPending = _$noExecutableActionTransferStateStatusEnum_refundPending;
  @BuiltValueEnumConst(wireName: r'refunded')
  static const NoExecutableActionTransferStateStatusEnum refunded = _$noExecutableActionTransferStateStatusEnum_refunded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const NoExecutableActionTransferStateStatusEnum failed = _$noExecutableActionTransferStateStatusEnum_failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const NoExecutableActionTransferStateStatusEnum ambiguous = _$noExecutableActionTransferStateStatusEnum_ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const NoExecutableActionTransferStateStatusEnum manualReview = _$noExecutableActionTransferStateStatusEnum_manualReview;

  static Serializer<NoExecutableActionTransferStateStatusEnum> get serializer => _$noExecutableActionTransferStateStatusEnumSerializer;

  const NoExecutableActionTransferStateStatusEnum._(String name): super(name);

  static BuiltSet<NoExecutableActionTransferStateStatusEnum> get values => _$noExecutableActionTransferStateStatusEnumValues;
  static NoExecutableActionTransferStateStatusEnum valueOf(String name) => _$noExecutableActionTransferStateStatusEnumValueOf(name);
}

