//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_instruction_availability.g.dart';

/// Read-only readiness for a directory item. Values are intentionally open strings so that clients can render future server-supported statuses and blockers without a client release. 
///
/// Properties:
/// * [status] - available permits display when qr_payload is also present; other values are explanatory only.
/// * [blockers] 
@BuiltValue()
abstract class DepositInstructionAvailability implements Built<DepositInstructionAvailability, DepositInstructionAvailabilityBuilder> {
  /// available permits display when qr_payload is also present; other values are explanatory only.
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'blockers')
  BuiltList<String> get blockers;

  DepositInstructionAvailability._();

  factory DepositInstructionAvailability([void updates(DepositInstructionAvailabilityBuilder b)]) = _$DepositInstructionAvailability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositInstructionAvailabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositInstructionAvailability> get serializer => _$DepositInstructionAvailabilitySerializer();
}

class _$DepositInstructionAvailabilitySerializer implements PrimitiveSerializer<DepositInstructionAvailability> {
  @override
  final Iterable<Type> types = const [DepositInstructionAvailability, _$DepositInstructionAvailability];

  @override
  final String wireName = r'DepositInstructionAvailability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositInstructionAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositInstructionAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositInstructionAvailabilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.blockers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositInstructionAvailability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositInstructionAvailabilityBuilder();
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

